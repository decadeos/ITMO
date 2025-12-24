import numpy as np
import pandas as pd
from sklearn.metrics import f1_score

from decision_tree import CustomDecisionTreeClassifier
from random_forest import CustomRandomForestClassifier


def _make_threshold_dataset(n_samples: int = 200, random_state: int = 0):
    rng = np.random.default_rng(random_state)
    base = rng.uniform(-1.5, 1.5, size=(n_samples, 2))
    labels = (base[:, 0] + 0.35 * base[:, 1] > 0).astype(int)
    return base, labels


def _accuracy(y_true, y_pred):
    y_true = np.asarray(y_true)
    y_pred = np.asarray(y_pred)
    assert y_true.shape == y_pred.shape
    return (y_true == y_pred).mean()


def _load_vector_from_csv(path: str):
    df = pd.read_csv(path)
    if 'target' in df.columns:
        target_col = 'target'
    else:
        raise ValueError(f"Unable to identify prediction column in {path}")
    return df[target_col].to_numpy()


def _f1_macro(y_true, y_pred):
    return f1_score(y_true, y_pred, average='macro')


def test_custom_decision_tree_learns_threshold():
    X, y = _make_threshold_dataset()
    split = int(0.6 * len(X))
    tree = CustomDecisionTreeClassifier()
    tree.fit(X[:split], y[:split])
    preds = np.asarray(tree.predict(X[split:]))
    assert preds.shape == y[split:].shape
    assert set(np.unique(preds)) <= {0, 1}
    assert _accuracy(y[split:], preds) >= 0.65


def test_custom_random_forest_vote_stability():
    X, y = _make_threshold_dataset()
    perm = np.arange(len(X))
    np.random.default_rng(1).shuffle(perm)
    X = X[perm]
    y = y[perm]
    split = int(0.7 * len(X))
    forest = CustomRandomForestClassifier()
    forest.fit(X[:split], y[:split])
    preds = np.asarray(forest.predict(X[split:]))
    assert preds.shape == y[split:].shape
    assert set(np.unique(preds)) <= {0, 1}
    assert _accuracy(y[split:], preds) >= 0.65


def test_solution_f1_exceeds_baseline():
    labels = _load_vector_from_csv('labels.csv')
    baseline = _load_vector_from_csv('baseline_solution.csv')
    solution = _load_vector_from_csv('solution.csv')
    assert baseline.shape == labels.shape
    assert solution.shape == labels.shape
    baseline_f1 = _f1_macro(labels, baseline)
    solution_f1 = _f1_macro(labels, solution)
    assert isinstance(baseline_f1, float)
    assert isinstance(solution_f1, float)
    assert solution_f1 >= baseline_f1 * 0.8
