import pytest
import pandas as pd
import numpy as np
import sys
import os
from sklearn.metrics import mean_absolute_percentage_error
from unittest.mock import patch, MagicMock

from exercises import df, df_base, df_processed, datasets, dataset_id
from exercises import X_train_processed, X_val_processed, X_test_processed
from exercises import y_train_processed, y_val_processed, y_test_processed
from exercises import y_test_base, y_pred_base, y_pred_processed, y_pred_custom
from exercises import CustomLinearRegression, CustomSGD


class TestDatasetLoading:
    def test_dataset_loading(self):
        """Проверка загрузки и предобработки данных"""
        # Check if dataframe exists and is not empty
        assert df is not None, "Датафрейм 'df' не определен"
        assert len(df) > 0, "Датафрейм 'df' пуст"

        # Check if base dataframe exists and is processed according to requirements
        assert df_base is not None, "Датафрейм 'df_base' не определен"
        assert len(df_base) > 0, "Датафрейм 'df_base' пуст"

        # Check if processed dataframe exists
        assert df_processed is not None, "Датафрейм 'df_processed' не определен"
        assert len(df_processed) > 0, "Датафрейм 'df_processed' пуст"

        # Check that no NaN values exist in processed dataframes
        assert not df_base.isnull().any().any(), "df_base содержит NaN значения"
        assert not df_processed.isnull().any().any(), "df_processed содержит NaN значения"


class TestLinearRegressionSklearn:
    def test_dataset_split(self):
        """Проверка корректности разбиения датасета с правильным размером тестовой выборки"""
        test_size = datasets[dataset_id][4] / 100
        total_samples = len(df_processed)
        expected_test_samples = int(total_samples * test_size)

        assert len(X_test_processed) >= expected_test_samples * 0.98 and len(X_test_processed) <= expected_test_samples * 1.02, \
            f"Размер тестовой выборки не соответствует требуемому {datasets[dataset_id][4]}%"

        assert X_train_processed is not None, "Переменная X_train_processed не определена"
        assert X_val_processed is not None, "Переменная X_val_processed не определена"
        assert y_train_processed is not None, "Переменная y_train_processed не определена"
        assert y_val_processed is not None, "Переменная y_val_processed не определена"

    def test_model_performance(self):
        """Проверка, что модель студента работает лучше, чем базовая"""
        mape_baseline = mean_absolute_percentage_error(y_test_base, y_pred_base)
        mape_processed = mean_absolute_percentage_error(y_test_processed, y_pred_processed)
        
        assert mape_processed < mape_baseline, \
            f"Метрика модели (MAPE={mape_processed:.4f}) хуже, чем базовая (MAPE={mape_baseline:.4f})"


class TestCustomLinearRegression:
    def test_custom_implementation(self):
        """Проверка, что кастомная реализация работает и показывает хорошие результаты"""
        assert y_pred_custom is not None, "Переменная y_pred_custom не определена"

        mape_custom = mean_absolute_percentage_error(y_test_processed, y_pred_custom)
        mape_baseline = mean_absolute_percentage_error(y_test_base, y_pred_base)
        
        assert mape_custom <= mape_baseline * 1.1, \
            f"Метрика кастомной реализации (MAPE={mape_custom:.4f}) значительно хуже, чем базовая (MAPE={mape_baseline:.4f})"


class TestCustomSGD:
    def test_sgd_implementation(self):
        """Тест на работу SGD"""
        params = [np.zeros((2, 1)), np.zeros(1)] 
        sgd = CustomSGD(params, lr=0.01)
        
        x_batch = np.array([[1.0, 2.0], [3.0, 4.0]])
        y_batch = np.array([2.0, 4.0])
        
        try:
            sgd.step(x_batch, y_batch)
        except Exception as e:
            pytest.fail(f"Шаг SGD упал с ошибкой: {str(e)}")

        assert hasattr(sgd, 'lr'), "SGD не имеет learning rate атрибута"
        assert sgd.lr > 0, "Скорость обучения (learning rate) должна быть положительной"
