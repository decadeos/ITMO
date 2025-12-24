"""
AUTOTESTS
"""

import pytest
import pandas as pd
import numpy as np
import sys
import os
from unittest.mock import patch, MagicMock
import warnings

try:
    import exercises
except ImportError:
    pass


class TestDatasetLoading:
    """Test Task 1: Data loading"""
    
    def test_student_id_set(self):
        """Test that Student_ID is properly set"""
        assert hasattr(exercises, 'Student_ID'), "Student_ID variable not found"
        assert exercises.Student_ID is not None, "Student_ID should not be None"
        assert isinstance(exercises.Student_ID, int), "Student_ID should be an integer"
        assert exercises.Student_ID > 0, "Student_ID should be positive"
    
    def test_dataset_id_calculated(self):
        """Test that dataset_id is properly calculated"""
        assert hasattr(exercises, 'dataset_id'), "dataset_id variable not found"
        assert exercises.dataset_id is not None, "dataset_id should not be None"
    
    def test_dataframe_loaded(self):
        """Test that DataFrame df is loaded"""
        assert hasattr(exercises, 'df'), "df variable not found"
        assert isinstance(exercises.df, pd.DataFrame), "df should be a pandas DataFrame"
        assert not exercises.df.empty, "DataFrame should not be empty"
        assert len(exercises.df) > 0, "DataFrame should have rows"
        assert len(exercises.df.columns) > 0, "DataFrame should have columns"
        
        # All columns are lowercase
        for col in exercises.columns:
            assert col == col.lower(), f"Column '{col}' is not in lowercase"
    
    def test_df_dropna_created(self):
        """Test that df_dropna is created and has no missing values"""
        assert hasattr(exercises, 'df_dropna'), "df_dropna variable not found"
        assert isinstance(exercises.df_dropna, pd.DataFrame), "df_dropna should be a DataFrame"
        
        # Check missing values
        assert exercises.df_dropna.isnull().sum().sum() == 0, "df_dropna should have no missing values"
        assert exercises.df_dropna is not exercises.df, "df_dropna should be a new DataFrame, not the same as df"
        assert len(exercises.df_dropna) <= len(exercises.df), "df_dropna should have <= rows than original df"


class TestNumericFeatures:
    """Test Task 2: Numeric features"""
    
    def test_numeric_features_identified(self):
        """Test that numeric features are properly identified"""
        assert hasattr(exercises, 'numeric_features'), "numeric_features variable not found"
        
        if len(exercises.numeric_features) > 0:
            for feature in exercises.numeric_features:
                assert feature in exercises.df_dropna.columns, f"Feature '{feature}' not in DataFrame columns"
    
    def test_df_numeric_created(self):
        """Test that df_numeric is properly created"""
        assert hasattr(exercises, 'df_numeric'), "df_numeric variable not found"
        
        if hasattr(exercises, 'numeric_features') and len(exercises.numeric_features) > 0:
            assert isinstance(exercises.df_numeric, pd.DataFrame), "df_numeric should be a DataFrame"
            
            for col in exercises.df_numeric.columns:
                assert pd.api.types.is_numeric_dtype(exercises.df_numeric[col]), \
                    f"Column '{col}' in df_numeric is not numeric. Check type of this col using df_numeric.info()"
            
            assert len(exercises.df_numeric) == len(exercises.df_dropna), \
                "df_numeric should have same number of rows as df_dropna"
    
    def test_correlations_computed(self):
        """Test that correlations are computed"""
        if hasattr(exercises, 'df_numeric') and len(exercises.df_numeric.columns) > 1:
            assert hasattr(exercises, 'corrs'), "corrs variable not found"
            
    
    def test_statistics_computed(self):
        """Test that statistics are properly computed"""
        assert hasattr(exercises, 'means'), "means dictionary not found"
        assert hasattr(exercises, 'medians'), "medians dictionary not found"
        assert hasattr(exercises, 'stds'), "stds dictionary not found"
        
        assert isinstance(exercises.means, dict), "means should be a dictionary"
        assert isinstance(exercises.medians, dict), "medians should be a dictionary"
        assert isinstance(exercises.stds, dict), "stds should be a dictionary"
        
        if hasattr(exercises, 'numeric_features') and len(exercises.numeric_features) > 0:
            for feature in exercises.numeric_features:
                assert feature in exercises.means, f"Mean not computed for feature '{feature}'"
                assert feature in exercises.medians, f"Median not computed for feature '{feature}'"
                assert feature in exercises.stds, f"Std not computed for feature '{feature}'"
                
                assert isinstance(exercises.means[feature], (int, float, np.number)), \
                    f"Mean for '{feature}' should be numeric"
                assert isinstance(exercises.medians[feature], (int, float, np.number)), \
                    f"Median for '{feature}' should be numeric"
                assert isinstance(exercises.stds[feature], (int, float, np.number)), \
                    f"Std for '{feature}' should be numeric"
                
                assert exercises.stds[feature] >= 0, f"Std for '{feature}' should be non-negative"
    
    def test_standardization(self):
        """Test that standardization is properly performed"""
        assert hasattr(exercises, 'df_standart'), "df_standart variable not found"
        
        if hasattr(exercises, 'df_numeric') and len(exercises.df_numeric.columns) > 0:
            assert isinstance(exercises.df_standart, pd.DataFrame), "df_standart should be a DataFrame"
            
            assert exercises.df_standart.shape == exercises.df_numeric.shape, \
                "df_standart should have same shape as df_numeric"
            
            for col in exercises.df_standart.columns:
                mean_val = exercises.df_standart[col].mean()
                std_val = exercises.df_standart[col].std()
                
                assert abs(mean_val) < 1e-10, \
                    f"Mean of standardized column '{col}' should be approximately 0, got {mean_val}"
                assert abs(std_val - 1.0) < 1e-10, \
                    f"Std of standardized column '{col}' should be approximately 1, got {std_val}"


class TestCategoricalFeatures:
    """Test Task 3: Categorical features analysis"""
    
    def test_categorical_features_identified(self):
        """Test that categorical features are properly identified"""
        assert hasattr(exercises, 'cat_features'), "cat_features variable not found"
        assert isinstance(exercises.cat_features, list), "cat_features should be a list"
        
        if len(exercises.cat_features) > 0:
            for feature in exercises.cat_features:
                assert feature in exercises.df_dropna.columns, \
                    f"Feature '{feature}' not in DataFrame columns"
    
    def test_df_cat_created(self):
        """Test that df_cat is properly created"""
        assert hasattr(exercises, 'df_cat'), "df_cat variable not found"
        
        if hasattr(exercises, 'cat_features') and len(exercises.cat_features) > 0:
            assert isinstance(exercises.df_cat, pd.DataFrame), "df_cat should be a DataFrame"
            
            for col in exercises.cat_features:
                assert col in exercises.df_cat.columns, f"Column '{col}' not in df_cat"
            
            assert len(exercises.df_cat) == len(exercises.df_dropna), \
                "df_cat should have same number of rows as df_dropna"
    
    def test_one_hot_encoding(self):
        """Test that one-hot encoding is properly performed"""
        assert hasattr(exercises, 'df_ohe'), "df_ohe variable not found"
        
        if hasattr(exercises, 'df_cat') and len(exercises.df_cat.columns) > 0:
            assert isinstance(exercises.df_ohe, pd.DataFrame), "df_ohe should be a DataFrame"
            
            # Check that number of columns increased (due to one-hot encoding)
            assert len(exercises.df_ohe.columns) >= len(exercises.df_cat.columns), \
                "df_ohe should have at least as many columns as df_cat"
            
            # Check that number of rows is preserved
            assert len(exercises.df_ohe) == len(exercises.df_cat), \
                "df_ohe should have same number of rows as df_cat"
            
            # Check that values are binary (0 or 1) for one-hot encoded columns
            for col in exercises.df_ohe.columns:
                unique_vals = exercises.df_ohe[col].unique()
                assert set(unique_vals).issubset({0, 1, 0.0, 1.0}), \
                    f"One-hot encoded column '{col}' should contain only 0 and 1"


class TestOutlierDetection:
    """Test Task 4: Outlier detection"""
    
    def test_df_filtered_created(self):
        """Test that df_filtered is properly created"""
        assert hasattr(exercises, 'df_filtered'), "df_filtered variable not found"
        assert isinstance(exercises.df_filtered, pd.DataFrame), "df_filtered should be a DataFrame"
        
        if hasattr(exercises, 'df_standart') and hasattr(exercises, 'df_ohe'):
            assert len(exercises.df_filtered) <= len(exercises.df_dropna), \
                "df_filtered should have <= rows than df_dropna (outliers removed)"
            
            expected_cols = len(exercises.df_standart.columns) + len(exercises.df_ohe.columns)
            assert len(exercises.df_filtered.columns) == expected_cols, \
                f"df_filtered should have {expected_cols} columns (numeric + one-hot encoded)"
    
    def test_no_extreme_outliers(self):
        """Test that no extreme outliers remain in standardized numeric features"""
        if hasattr(exercises, 'df_filtered'):
            numeric_cols = [col for col in exercises.df_filtered.columns 
                          if col in exercises.df_standart.columns]
            
            for col in numeric_cols:
                max_abs_val = exercises.df_filtered[col].abs().max()
                assert max_abs_val <= 3.0, \
                    f"Column '{col}' has values with |z| > 3 (found {max_abs_val})"
    
    def test_original_dataframes_unchanged(self):
        """Test that original dataframes were not modified"""
        if hasattr(exercises, 'df_standart') and hasattr(exercises, 'df_ohe'):
            assert hasattr(exercises, 'df_standart'), "df_standart should still exist"
            assert hasattr(exercises, 'df_ohe'), "df_ohe should still exist"
            
            assert exercises.df_filtered is not exercises.df_standart, \
                "df_filtered should be a new DataFrame, not df_standart"
            assert exercises.df_filtered is not exercises.df_ohe, \
                "df_filtered should be a new DataFrame, not df_ohe"


class TestDataIntegrity:
    """General data integrity tests"""
    
    def test_no_infinite_values(self):
        """Test that there are no infinite values in any DataFrame"""
        dataframes = ['df', 'df_dropna', 'df_numeric', 'df_standart', 'df_cat', 'df_ohe', 'df_filtered']
        
        for df_name in dataframes:
            if hasattr(exercises, df_name):
                df = getattr(exercises, df_name)
                if isinstance(df, pd.DataFrame):
                    numeric_cols = df.select_dtypes(include=[np.number]).columns
                    for col in numeric_cols:
                        assert not df[col].isin([np.inf, -np.inf]).any(), \
                            f"DataFrame '{df_name}' column '{col}' contains infinite values"
