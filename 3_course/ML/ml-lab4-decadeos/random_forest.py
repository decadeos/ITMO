import numpy as np

from decision_tree import CustomDecisionTreeClassifier


class CustomRandomForestClassifier:
    def __init__(self, n_estimators=100, max_depth=None, 
                 max_features='sqrt', bootstrap=True,
                 min_samples_split=2, min_samples_leaf=1,
                 random_state=None):
        self.n_estimators = n_estimators
        self.max_depth = max_depth
        self.max_features = max_features
        self.bootstrap = bootstrap
        self.min_samples_split = min_samples_split
        self.min_samples_leaf = min_samples_leaf
        self.random_state = random_state
        self.trees = []
    
    def _get_max_features(self, n_features):
        if isinstance(self.max_features, str):
            return int(np.sqrt(n_features)) if self.max_features == 'sqrt' else int(np.log2(n_features))
        return min(self.max_features, n_features)
    
    def fit(self, X, y):
        X, y = np.asarray(X), np.asarray(y)
        n_samples = X.shape[0]
        
        for i in range(self.n_estimators):
            idx = np.random.choice(n_samples, n_samples, replace=self.bootstrap)
            tree = CustomDecisionTreeClassifier(
                max_depth=self.max_depth,
                min_samples_split=self.min_samples_split,
                min_samples_leaf=self.min_samples_leaf,
                random_state=self.random_state + i if self.random_state else None
            )
            tree.fit(X[idx], y[idx])
            self.trees.append(tree)
        return self
    
    def predict(self, X):
        X = np.asarray(X)
        votes = np.array([tree.predict(X) for tree in self.trees]).T
        return np.array([np.bincount(row).argmax() for row in votes])