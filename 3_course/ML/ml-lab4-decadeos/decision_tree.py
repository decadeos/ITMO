import numpy as np


class DecisionTreeNode:
    def __init__(self, feature_idx=None, threshold=None, left=None, right=None, value=None):
        self.feature_idx = feature_idx
        self.threshold = threshold
        self.left = left
        self.right = right
        self.value = value


class CustomDecisionTreeClassifier:
    def __init__(self, max_depth=None, min_samples_split=2, min_samples_leaf=1, random_state=None):
        self.max_depth = max_depth
        self.min_samples_split = min_samples_split
        self.min_samples_leaf = min_samples_leaf
        self.root = None
        if random_state:
            np.random.seed(random_state)
    
    def _gini(self, y):
        _, counts = np.unique(y, return_counts=True) # Шаг 1: Подсчитываем, сколько объектов каждого класса
        p = counts / counts.sum() # Шаг 2: Вычисляем доли каждого класса
        return 1 - np.sum(p ** 2) # Шаг 3: Вычисляем коэффициент Джини
    
    def _best_split(self, X, y):
        best = (-1, None, None)
        current_gini = self._gini(y)
        
        for f in range(X.shape[1]):
            sorted_idx = np.argsort(X[:, f])
            X_sorted = X[sorted_idx, f]
            
            for i in range(1, len(X_sorted)):
                if X_sorted[i] == X_sorted[i-1]:
                    continue
                    
                t = (X_sorted[i] + X_sorted[i-1]) / 2
                left_mask = X[:, f] <= t
                y_l, y_r = y[left_mask], y[~left_mask]
                
                if len(y_l) < self.min_samples_leaf or len(y_r) < self.min_samples_leaf:
                    continue
                
                # Gain показывает, насколько уменьшилась "нечистота" (Gini) после разделения данных на две группы
                gain = current_gini - (len(y_l)/len(y)*self._gini(y_l) + len(y_r)/len(y)*self._gini(y_r))
                
                if gain > best[0]:
                    best = (gain, f, t)
        
        return best
    
    def _build(self, X, y, depth=0):
        if (self.max_depth and depth == self.max_depth) or \
           len(X) < self.min_samples_split or \
           len(np.unique(y)) == 1:
            return DecisionTreeNode(value=np.bincount(y).argmax())
        
        gain, f, t = self._best_split(X, y)
        if f is None or gain <= 0:
            return DecisionTreeNode(value=np.bincount(y).argmax())
        
        mask = X[:, f] <= t
        left = self._build(X[mask], y[mask], depth + 1)
        right = self._build(X[~mask], y[~mask], depth + 1)
        
        return DecisionTreeNode(feature_idx=f, threshold=t, left=left, right=right)
    
    def fit(self, X, y):
        self.root = self._build(np.asarray(X), np.asarray(y))
        return self
    
    def _predict_one(self, x, node):
        while node.value is None:
            node = node.left if x[node.feature_idx] <= node.threshold else node.right
        return node.value
    
    def predict(self, X):
        X = np.asarray(X)
        return np.array([self._predict_one(x, self.root) for x in X])