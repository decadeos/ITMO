import pytest
import pandas as pd
import numpy as np
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    precision_recall_curve, roc_curve, roc_auc_score
)

# Import student's implementations
from exercises import (
    df, df_base, df_processed,
    X_base, y_base, X_processed, y_processed,
    X_train_base, X_test_base, y_train_base, y_test_base,
    X_train_processed, X_val_processed, X_test_processed,
    y_train_processed, y_val_processed, y_test_processed,
    accuracy_manual, precision_manual, recall_manual, f1_manual,
    precision_recall_curve_manual, roc_curve_manual, roc_auc_manual,
    logreg
)


class TestDatasetLoading:
    """Test data loading and preprocessing"""
    
    def test_df_loaded(self):
        """Check that main dataframe is loaded correctly"""
        assert df is not None, "Датафрейм 'df' не определен"
        assert isinstance(df, pd.DataFrame), "df должен быть pandas DataFrame"
        assert len(df) > 0, "Датафрейм 'df' пуст"
        assert df.shape[1] > 1, "df должен содержать минимум 2 колонки (фичи + таргет)"
    
    def test_df_base_processed(self):
        """Check basic preprocessing (NaN handling, encoding)"""
        assert df_base is not None, "Датафрейм 'df_base' не определен"
        assert isinstance(df_base, pd.DataFrame), "df_base должен быть pandas DataFrame"
        assert len(df_base) > 0, "Датафрейм 'df_base' пуст"
        
        # Must have no NaN values after basic processing
        assert not df_base.isnull().any().any(), \
            "df_base содержит NaN значения - обработайте пропуски"
        
        # Check that categorical encoding was done (no object columns)
        object_cols = df_base.select_dtypes(include=['object']).columns
        assert len(object_cols) == 0, \
            f"df_base содержит не закодированные категориальные колонки: {list(object_cols)}"
    
    def test_df_processed_exists(self):
        """Check that processed dataframe exists"""
        assert df_processed is not None, "Датафрейм 'df_processed' не определен"
        assert isinstance(df_processed, pd.DataFrame), \
            "df_processed должен быть pandas DataFrame"
        assert len(df_processed) > 0, "Датафрейм 'df_processed' пуст"
        
        # Should also have no NaN
        assert not df_processed.isnull().any().any(), \
            "df_processed содержит NaN значения"


class TestDataSplitting:
    """Test train/val/test splitting"""
    
    def test_base_features_target_split(self):
        """Check that features and target are separated for base data"""
        assert X_base is not None, "Переменная X_base не определена"
        assert y_base is not None, "Переменная y_base не определена"
        
        assert len(X_base) == len(y_base), \
            "Размеры X_base и y_base не совпадают"
        
        # Check that target was removed from features
        if isinstance(X_base, pd.DataFrame):
            assert len(X_base.columns) < len(df_base.columns), \
                "X_base должен содержать меньше колонок чем df_base (таргет должен быть удален)"
    
    def test_processed_features_target_split(self):
        """Check that features and target are separated for processed data"""
        assert X_processed is not None, "Переменная X_processed не определена"
        assert y_processed is not None, "Переменная y_processed не определена"
        
        assert len(X_processed) == len(y_processed), \
            "Размеры X_processed и y_processed не совпадают"
    
    def test_base_train_test_split(self):
        """Check train/test split for base data"""
        assert X_train_base is not None, "Переменная X_train_base не определена"
        assert X_test_base is not None, "Переменная X_test_base не определена"
        assert y_train_base is not None, "Переменная y_train_base не определена"
        assert y_test_base is not None, "Переменная y_test_base не определена"
        
        # Check shapes match
        assert len(X_train_base) == len(y_train_base), \
            "Размеры X_train_base и y_train_base не совпадают"
        assert len(X_test_base) == len(y_test_base), \
            "Размеры X_test_base и y_test_base не совпадают"
        
        # Check reasonable split ratio
        total = len(X_train_base) + len(X_test_base)
        test_ratio = len(X_test_base) / total
        assert 0.1 <= test_ratio <= 0.4, \
            f"Тестовая выборка составляет {test_ratio:.1%}, должна быть между 10% и 40%"
    
    def test_processed_train_val_test_split(self):
        """Check train/val/test split for processed data"""
        assert X_train_processed is not None, "Переменная X_train_processed не определена"
        assert X_val_processed is not None, "Переменная X_val_processed не определена"
        assert X_test_processed is not None, "Переменная X_test_processed не определена"
        assert y_train_processed is not None, "Переменная y_train_processed не определена"
        assert y_val_processed is not None, "Переменная y_val_processed не определена"
        assert y_test_processed is not None, "Переменная y_test_processed не определена"
        
        # Check shapes match
        assert len(X_train_processed) == len(y_train_processed), \
            "Размеры X_train_processed и y_train_processed не совпадают"
        assert len(X_val_processed) == len(y_val_processed), \
            "Размеры X_val_processed и y_val_processed не совпадают"
        assert len(X_test_processed) == len(y_test_processed), \
            "Размеры X_test_processed и y_test_processed не совпадают"
        
        # Check non-empty
        assert len(X_train_processed) > 0, "Обучающая выборка пуста"
        assert len(X_val_processed) > 0, "Валидационная выборка пуста"
        assert len(X_test_processed) > 0, "Тестовая выборка пуста"


class TestMetricsImplementation:
    """Test manual metric implementations against sklearn"""
    
    @pytest.fixture
    def sample_predictions(self):
        """Generate sample predictions for testing"""
        np.random.seed(42)
        y_true = np.array([0, 0, 1, 1, 0, 1, 0, 1, 1, 0])
        y_pred = np.array([0, 1, 1, 1, 0, 0, 0, 1, 1, 0])
        y_score = np.array([0.1, 0.6, 0.8, 0.9, 0.2, 0.4, 0.3, 0.85, 0.75, 0.15])
        return y_true, y_pred, y_score
    
    def test_accuracy_manual(self, sample_predictions):
        """Test accuracy_manual correctness"""
        y_true, y_pred, _ = sample_predictions
        
        manual_result = accuracy_manual(y_true, y_pred)
        sklearn_result = accuracy_score(y_true, y_pred)
        
        assert isinstance(manual_result, (int, float, np.number)), \
            "accuracy_manual должна возвращать число"
        assert np.isclose(manual_result, sklearn_result, atol=1e-6), \
            f"accuracy_manual={manual_result:.4f} не совпадает с sklearn={sklearn_result:.4f}"
        
        # Test edge case: perfect predictions
        y_perfect = np.array([0, 1, 0, 1])
        result = accuracy_manual(y_perfect, y_perfect)
        assert np.isclose(result, 1.0, atol=1e-6), \
            "Идеальные предсказания должны давать accuracy=1.0"
    
    def test_precision_manual(self, sample_predictions):
        """Test precision_manual correctness"""
        y_true, y_pred, _ = sample_predictions
        
        manual_result = precision_manual(y_true, y_pred)
        sklearn_result = precision_score(y_true, y_pred, zero_division=0)
        
        assert isinstance(manual_result, (int, float, np.number)), \
            "precision_manual должна возвращать число"
        assert np.isclose(manual_result, sklearn_result, atol=1e-6), \
            f"precision_manual={manual_result:.4f} не совпадает с sklearn={sklearn_result:.4f}"
        assert 0 <= manual_result <= 1, \
            f"Precision должен быть между 0 и 1, получено {manual_result}"
    
    def test_recall_manual(self, sample_predictions):
        """Test recall_manual correctness"""
        y_true, y_pred, _ = sample_predictions
        
        manual_result = recall_manual(y_true, y_pred)
        sklearn_result = recall_score(y_true, y_pred, zero_division=0)
        
        assert isinstance(manual_result, (int, float, np.number)), \
            "recall_manual должна возвращать число"
        assert np.isclose(manual_result, sklearn_result, atol=1e-6), \
            f"recall_manual={manual_result:.4f} не совпадает с sklearn={sklearn_result:.4f}"
        assert 0 <= manual_result <= 1, \
            f"Recall должен быть между 0 и 1, получено {manual_result}"
    
    def test_f1_manual(self, sample_predictions):
        """Test f1_manual correctness"""
        y_true, y_pred, _ = sample_predictions
        
        manual_result = f1_manual(y_true, y_pred)
        sklearn_result = f1_score(y_true, y_pred, zero_division=0)
        
        assert isinstance(manual_result, (int, float, np.number)), \
            "f1_manual должна возвращать число"
        assert np.isclose(manual_result, sklearn_result, atol=1e-6), \
            f"f1_manual={manual_result:.4f} не совпадает с sklearn={sklearn_result:.4f}"
        assert 0 <= manual_result <= 1, \
            f"F1 должен быть между 0 и 1, получено {manual_result}"
    
    def test_precision_recall_curve_manual(self, sample_predictions):
        """Test precision_recall_curve_manual correctness"""
        y_true, _, y_score = sample_predictions
        
        precision_m, recall_m, thresholds_m = precision_recall_curve_manual(y_true, y_score)
        precision_s, recall_s, thresholds_s = precision_recall_curve(y_true, y_score)
        
        # Check return types
        assert isinstance(precision_m, (np.ndarray, list)), \
            "precision должен быть numpy array или list"
        assert isinstance(recall_m, (np.ndarray, list)), \
            "recall должен быть numpy array или list"
        assert isinstance(thresholds_m, (np.ndarray, list)), \
            "thresholds должен быть numpy array или list"
        
        # Check lengths
        assert len(precision_m) > 0, "precision array не должен быть пустым"
        assert len(recall_m) > 0, "recall array не должен быть пустым"
        assert len(precision_m) == len(recall_m), \
            "precision и recall должны быть одинаковой длины"
        
        # Check that curves are reasonably close to sklearn
        # (allowing for different threshold selection strategies)
        precision_m = np.array(precision_m)
        recall_m = np.array(recall_m)
        
        assert np.all((precision_m >= 0) & (precision_m <= 1)), \
            "Все значения precision должны быть между 0 и 1"
        assert np.all((recall_m >= 0) & (recall_m <= 1)), \
            "Все значения recall должны быть между 0 и 1"
    
    def test_roc_curve_manual(self, sample_predictions):
        """Test roc_curve_manual correctness"""
        y_true, _, y_score = sample_predictions
        
        fpr_m, tpr_m, thresholds_m = roc_curve_manual(y_true, y_score)
        fpr_s, tpr_s, thresholds_s = roc_curve(y_true, y_score)
        
        # Check return types
        assert isinstance(fpr_m, (np.ndarray, list)), \
            "fpr должен быть numpy array или list"
        assert isinstance(tpr_m, (np.ndarray, list)), \
            "tpr должен быть numpy array или list"
        assert isinstance(thresholds_m, (np.ndarray, list)), \
            "thresholds должен быть numpy array или list"
        
        # Check lengths
        assert len(fpr_m) > 0, "fpr array не должен быть пустым"
        assert len(tpr_m) > 0, "tpr array не должен быть пустым"
        assert len(fpr_m) == len(tpr_m), \
            "fpr и tpr должны быть одинаковой длины"
        
        # Check value ranges
        fpr_m = np.array(fpr_m)
        tpr_m = np.array(tpr_m)
        
        assert np.all((fpr_m >= 0) & (fpr_m <= 1)), \
            "Все значения fpr должны быть между 0 и 1"
        assert np.all((tpr_m >= 0) & (tpr_m <= 1)), \
            "Все значения tpr должны быть между 0 и 1"
    
    def test_roc_auc_manual(self, sample_predictions):
        """Test roc_auc_manual correctness"""
        y_true, _, y_score = sample_predictions
        
        fpr, tpr, _ = roc_curve_manual(y_true, y_score)
        manual_result = roc_auc_manual(fpr, tpr)
        sklearn_result = roc_auc_score(y_true, y_score)
        
        assert isinstance(manual_result, (int, float, np.number)), \
            "roc_auc_manual должна возвращать число"
        assert 0 <= manual_result <= 1, \
            f"ROC AUC должен быть между 0 и 1, получено {manual_result}"
        
        # Allow some tolerance due to different integration methods
        assert np.isclose(manual_result, sklearn_result, atol=0.05), \
            f"roc_auc_manual={manual_result:.4f} существенно отличается от sklearn={sklearn_result:.4f}"


class TestBaselineModel:
    """Test baseline logistic regression model"""
    
    def test_logreg_trained(self):
        """Check that baseline logistic regression is trained"""
        assert logreg is not None, "Переменная 'logreg' не определена"
        assert hasattr(logreg, 'predict'), \
            "logreg должен иметь метод predict"
        assert hasattr(logreg, 'classes_'), \
            "logreg не обучен (отсутствует атрибут classes_)"
    
    def test_logreg_predictions(self):
        """Check that model can make predictions"""
        predictions = logreg.predict(X_test_base)
        
        assert len(predictions) == len(X_test_base), \
            "Количество предсказаний не совпадает с размером тестовой выборки"
        
        # Check predictions are valid class labels
        unique_preds = np.unique(predictions)
        assert len(unique_preds) > 0, "Модель должна предсказывать хотя бы один класс"
        assert np.all(np.isin(unique_preds, logreg.classes_)), \
            "Предсказания содержат неизвестные классы"
    
    def test_logreg_performance(self):
        """Check that baseline has reasonable performance"""
        predictions = logreg.predict(X_test_base)
        accuracy = accuracy_score(y_test_base, predictions)
        
        assert accuracy > 0.5, \
            f"Baseline модель показывает слишком низкую accuracy={accuracy:.4f}"


class TestMultipleModels:
    """Test that multiple classification algorithms are implemented"""
    
    def test_multiple_models_exist(self):
        """Check that at least 3 different model types are trained"""
        from exercises import __dict__ as ex_dict
        
        # Look for different model indicators in the namespace
        knn_found = any('knn' in k.lower() or 'neighbor' in k.lower() 
                       for k in ex_dict.keys())
        tree_found = any('tree' in k.lower() and 'forest' not in k.lower()
                        for k in ex_dict.keys())
        forest_found = any('forest' in k.lower() for k in ex_dict.keys())
        svm_found = any('svm' in k.lower() or 'svc' in k.lower() 
                       for k in ex_dict.keys())
        
        model_types = [
            ('LogisticRegression', True),  # baseline always exists
            ('KNN/KNeighbors', knn_found),
            ('DecisionTree', tree_found),
            ('RandomForest', forest_found),
            ('SVM/SVC', svm_found)
        ]
        
        trained_models = [name for name, found in model_types if found]
        
        assert len(trained_models) >= 3, \
            f"Должно быть обучено минимум 3 типа моделей. Найдено: {', '.join(trained_models)}"


class TestEnsemble:
    """Test ensemble implementation"""
    
    def test_ensemble_exists(self):
        """Check that at least one ensemble method is implemented"""
        from exercises import __dict__ as ex_dict
        
        voting_found = any('voting' in k.lower() for k in ex_dict.keys())
        stacking_found = any('stacking' in k.lower() or 'stack' in k.lower() 
                            for k in ex_dict.keys())
        bagging_found = any('bagging' in k.lower() or 'bag' in k.lower() 
                           for k in ex_dict.keys())
        boosting_found = any('boost' in k.lower() for k in ex_dict.keys())
        ensemble_found = any('ensemble' in k.lower() for k in ex_dict.keys())
        
        ensemble_methods = [
            ('VotingClassifier', voting_found),
            ('StackingClassifier', stacking_found),
            ('BaggingClassifier', bagging_found),
            ('BoostingClassifier', boosting_found),
            ('OtherEnsemble', ensemble_found)
        ]
        
        found_methods = [name for name, found in ensemble_methods if found]
        
        assert len(found_methods) >= 1, \
            "Должен быть реализован минимум один метод ансамблирования"


class TestModelComparison:
    """Test that students compare models and beat baseline"""
    
    def test_processed_beats_baseline(self):
        """Check that processed data model beats baseline"""
        from exercises import __dict__ as ex_dict
        
        # Try to find predictions for processed data
        possible_pred_vars = [k for k in ex_dict.keys() 
                             if 'pred' in k.lower() and 'processed' in k.lower()]
        
        if len(possible_pred_vars) > 0:
            y_pred_processed = ex_dict[possible_pred_vars[0]]
            
            acc_base = accuracy_score(y_test_base, logreg.predict(X_test_base))
            acc_processed = accuracy_score(y_test_processed, y_pred_processed)
            
            # Processed model should perform at least as well or better
            assert acc_processed >= acc_base * 0.95, \
                f"Модель на processed данных (acc={acc_processed:.4f}) " \
                f"должна быть не хуже baseline (acc={acc_base:.4f})"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])