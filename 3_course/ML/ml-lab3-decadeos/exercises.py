RANDOM_STATE = 42
import os
import math
import json
import numpy as np
import pandas as pd
from typing import List, Iterable, Tuple
import matplotlib.pyplot as plt
def set_global_seed(seed: int = RANDOM_STATE) -> None:
    np.random.seed(seed)
set_global_seed(RANDOM_STATE)
Student_ID = 31
datasets = [
    (
        'Give Me Some Credit',
        'https://www.kaggle.com/competitions/GiveMeSomeCredit/overview',
        'SeriousDlqin2yrs'
    ),
    (
        'Porto Seguro’s Safe Driver Prediction',
        'https://www.kaggle.com/competitions/porto-seguro-safe-driver-prediction/overview',
        'target'
    ),
    (
        'Statlog (Shuttle)',
        'https://archive.ics.uci.edu/dataset/148/statlog+shuttle',
        'class'
    ),
    (
        'HTRU2',
        'https://archive.ics.uci.edu/dataset/372/htru2',
        'class'
    ),
    (
        'Bank Marketing',
        'https://archive.ics.uci.edu/dataset/222/bank%2Bmarketing',
        'y'
    ),
]
dataset_id = None if Student_ID is None else Student_ID % len(datasets)
if dataset_id is None:
    print("ОШИБКА! Не указан порядковый номер студента в списке группы.")
else:
    print(f"Информация о датасете '{datasets[dataset_id][0]}' доступна по следующей ссылке: {datasets[dataset_id][1]}")
    print(f"Целевая переменная: {datasets[dataset_id][2]}")
df = pd.read_csv('data/train.zip', compression='zip')
size_mb = df.memory_usage(deep=True).sum() / (1024 ** 2)
print(f"{size_mb:.2f} MB")
df = df.sample(frac=0.03, random_state=42)
df.head()
size_mb = df.memory_usage(deep=True).sum() / (1024 ** 2)
print(f"{size_mb:.2f} MB")
df_base = df.copy().dropna()
df_base.head()
df_processed = df_base.copy().drop_duplicates()
feature_columns = df_processed.columns.drop(['id', 'target'])
for feature in feature_columns:
    df_processed[feature] = (df_processed[feature] - df_processed[feature].mean()) / df_processed[feature].std()
df_processed.head()
X_base, y_base = df_base.iloc[:, 2:], df_base['target']
X_processed, y_processed = df_processed.iloc[:, 2:], df_processed['target']
from sklearn.model_selection import train_test_split
X_train_base, X_test_base, y_train_base, y_test_base = train_test_split(
    X_base, y_base, test_size=0.2, random_state=42, stratify=y_base
)
X_train_processed, X_test_processed, y_train_processed, y_test_processed = train_test_split(
    X_processed, y_processed, test_size=0.2, random_state=42, stratify=y_processed
)
X_train_processed, X_val_processed, y_train_processed, y_val_processed = train_test_split(
    X_train_processed, y_train_processed, test_size=0.25, random_state=42, stratify=y_train_processed
)
df_balanced = ...
def accuracy_manual(y_true: Iterable[int], y_pred: Iterable[int]) -> float:
    """
    Реализовать accuracy = correct / total.
    """
    y_true = np.array(y_true)
    y_pred = np.array(y_pred)
    return np.mean(y_true == y_pred)
def precision_manual(y_true: Iterable[int], y_pred: Iterable[int]) -> float:
    """
    Реализовать precision = TP / (TP + FP).
    """
    y_true = np.array(y_true)
    y_pred = np.array(y_pred)
    TP = np.sum((y_true == 1) & (y_pred == 1))
    FP = np.sum((y_true == 0) & (y_pred == 1))
    if TP + FP == 0:
        return 0.0
    return TP / (TP + FP)
def recall_manual(y_true: Iterable[int], y_pred: Iterable[int]) -> float:
    """
    Реализовать recall = TP / (TP + FN).
    """
    y_true = np.array(y_true)
    y_pred = np.array(y_pred)
    TP = np.sum((y_true == 1) & (y_pred == 1))
    FN = np.sum((y_true == 1) & (y_pred == 0))
    if TP + FN == 0:
        return 0.0
    return TP / (TP + FN)
def f1_manual(y_true: Iterable[int], y_pred: Iterable[int]) -> float:
    """
    Реализовать F1 = 2 * P * R / (P + R).
    """
    P = precision_manual(y_true, y_pred)
    R = recall_manual(y_true, y_pred)
    if P + R == 0:
        return 0.0
    return (2 * P * R) / (P + R)
def precision_recall_curve_manual(y_true: Iterable[int], y_score: Iterable[float]) -> Tuple[np.ndarray, np.ndarray, np.ndarray]:
    """
    Реализовать подсчет PR-кривой.
    Возвращать (precision_list, recall_list, thresholds) при варьировании порога.
    """
    y_true = np.array(y_true)
    y_score = np.array(y_score)
    thresholds = np.sort(np.unique(y_score))
    precision_list = []
    recall_list = []
    for t in thresholds:
        y_pred = (y_score >= t).astype(int)
        p = precision_manual(y_true, y_pred)
        r = recall_manual(y_true, y_pred)
        precision_list.append(p)
        recall_list.append(r)
    return np.array(precision_list), np.array(recall_list), thresholds
def roc_curve_manual(y_true: Iterable[int], y_score: Iterable[float]) -> Tuple[np.ndarray, np.ndarray, np.ndarray]:
    """
    Реализовать подсчет ROC-кривой.
    Возвращать (fpr_list, tpr_list, thresholds).
    """
    thresholds = np.sort(np.unique(y_score))
    fpr_list = []
    tpr_list = []
    for t in thresholds:
        y_pred = (y_score >= t).astype(int)
        tpr = recall_manual(y_true, y_pred)
        FP = np.sum((y_true == 0) & (y_pred == 1))
        TN = np.sum((y_true == 0) & (y_pred == 0))
        fpr = FP / (FP + TN) if (FP + TN) != 0 else 0.0
        fpr_list.append(fpr)
        tpr_list.append(tpr)
    return np.array(fpr_list), np.array(tpr_list), thresholds
def roc_auc_manual(fpr: Iterable[float], tpr: Iterable[float]) -> float:
    """
    Реализовать численную интеграцию по FPR (например, трапеции).
    """
    fpr = np.array(fpr)
    tpr = np.array(tpr)
    order = np.argsort(fpr)
    fpr_sorted = fpr[order]
    tpr_sorted = tpr[order]
    auc = np.trapezoid(tpr_sorted, fpr_sorted)
    return float(auc)
from sklearn.linear_model import LogisticRegression
logreg = LogisticRegression()
logreg.fit(X_train_base, y_train_base)
from sklearn.neighbors import KNeighborsClassifier
neigh = KNeighborsClassifier(
    n_neighbors=7,
    weights='uniform',
    metric='euclidean'
)
neigh.fit(X_train_processed, y_train_processed)
from sklearn.tree import DecisionTreeClassifier
tree = DecisionTreeClassifier(
    class_weight='balanced',
    max_depth=8,
    min_samples_split=20,
    min_samples_leaf=10,
    random_state=42
)
tree.fit(X_train_processed, y_train_processed)
from sklearn.ensemble import RandomForestClassifier
clf = RandomForestClassifier(
    class_weight='balanced',
    n_estimators=200,
    max_depth=12,
    min_samples_split=15,
    min_samples_leaf=7,
    max_features='sqrt',
    random_state=42,
    n_jobs=-1
)
clf.fit(X_train_processed, y_train_processed)
from sklearn.svm import SVC
svm = SVC(
    class_weight='balanced',
    C=0.5,
    kernel='rbf',
    gamma='scale',
    probability=True,
    cache_size=1000,
    random_state=42
)
svm.fit(X_train_processed, y_train_processed)
from sklearn.ensemble import VotingClassifier
from sklearn.metrics import accuracy_score, f1_score
import numpy as np
voting_clf = VotingClassifier(
    estimators=[
        ('logreg', logreg),
        ('tree', tree),
        ('svm', svm)
    ],
    voting='soft',
    n_jobs=-1,
    verbose=1
)
voting_clf.fit(X_train_processed, y_train_processed)
y_pred_voting = voting_clf.predict(X_test_processed)
y_pred_baseline = logreg.predict(X_test_base)
models = []
models.append(("LogReg", logreg, X_test_base, y_test_base))
models.append(("KNN", neigh, X_test_processed, y_test_processed))
models.append(("Tree", tree, X_test_processed, y_test_processed))
models.append(("Forest", clf, X_test_processed, y_test_processed))
models.append(("SVM", svm, X_test_processed, y_test_processed))
models.append(("Voting", voting_clf, X_test_processed, y_test_processed))
accuracy, precision, recall, f1 = [0]*6, [0]*6, [0]*6, [0]*6,
cou = 0
for name, model, X_test, y_test in models:
    y_pred = model.predict(X_test)
    accuracy[cou] = accuracy_manual(y_test, y_pred)
    precision[cou] = precision_manual(y_test, y_pred)
    recall[cou] = recall_manual(y_test, y_pred)
    f1[cou] = f1_manual(y_test, y_pred)
    cou += 1
labels = [name for name, model, X, y in models]
def bar_manual(array, name, lab=labels):
    plt.figure(figsize=(10,5))
    colors = ['red'] + ['blue'] * 5
    plt.bar(labels, array, color=colors)
    plt.ylabel(name)
    plt.title(name.capitalize())
    plt.xticks(rotation=20)
    plt.show()
bar_manual(accuracy, "accuracy")
bar_manual(precision, "precision")
bar_manual(recall, "recall")
bar_manual(f1, "f1")
pr_precision, pr_recall, pr_thresholds, scores_dict = {}, {}, {}, {}
roc_fpr, roc_tpr, roc_thresholds, roc_scores = {}, {}, {}, {}
roc_auc_scores, pr_auc_scores = {}, {}
for name, model, X_test, y_test in models:
    y_score = model.predict_proba(X_test)[:, 1]
    scores_dict[name] = y_score
    precs, recs, ths = precision_recall_curve_manual(y_test, y_score)
    pr_precision[name] = precs
    pr_recall[name] = recs
    pr_thresholds[name] = ths
    roc_scores[name] = y_score
    fpr, tpr, ths = roc_curve_manual(y_test, y_score)
    roc_fpr[name] = fpr
    roc_tpr[name] = tpr
    roc_thresholds[name] = ths
    roc_auc_scores[name] = float(roc_auc_manual(roc_fpr[name], roc_tpr[name]))
plt.figure(figsize=(20,6))
for name in pr_precision:
    precs = pr_precision[name]
    recs = pr_recall[name]
    order = np.argsort(recs)
    plt.plot(recs[order], precs[order], label=name)
plt.xlabel("Recall")
plt.ylabel("Precision")
plt.title("Precision-Recall curves")
plt.legend()
plt.grid(True)
plt.show()
plt.figure(figsize=(20, 6))
for name in roc_fpr:
    fpr = roc_fpr[name]
    tpr = roc_tpr[name]
    order = np.argsort(fpr)
    auc = roc_auc_scores.get(name, float('nan'))
    plt.plot(fpr[order], tpr[order], label=f"{name} (AUC={auc:.4f})")
plt.plot([0, 1], [0, 1], 'k--', label="Chance")
plt.xlabel("False Positive Rate (FPR)")
plt.ylabel("True Positive Rate (TPR)")
plt.title("ROC Curves")
plt.legend()
plt.grid(True)
plt.show()
