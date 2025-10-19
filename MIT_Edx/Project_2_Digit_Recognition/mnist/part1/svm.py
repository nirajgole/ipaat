import numpy as np
from sklearn.svm import LinearSVC


### Functions for you to fill in ###

def one_vs_rest_svm(train_x, train_y, test_x):
    """
    Trains a linear SVM for binary classifciation (One-vs-Rest strategy for the binary case).

    Args:
        train_x - (n, d) NumPy array (n datapoints each with d features)
        train_y - (n, ) NumPy array containing the labels (0 or 1) for each training data point
        test_x - (m, d) NumPy array (m datapoints each with d features)
    Returns:
        pred_test_y - (m,) NumPy array containing the labels (0 or 1) for each test data point
    """
    # 1. Instantiate the LinearSVC model with required parameters
    # The problem specifies random_state = 0 and C = 0.1
    # We use dual=True (default) and max_iter=1000 (default) as they are standard defaults.
    # The 'hinge' loss is the standard for SVMs.
    model = LinearSVC(
        C=0.1,
        random_state=0,
        # Default loss is 'squared_hinge', which is suitable for LinearSVC.
        # We explicitly set a high max_iter for robustness, though 1000 is the default.
        max_iter=5000
    )

    # 2. Fit the model using the training data
    model.fit(train_x, train_y)

    # 3. Predict the labels for the test data
    pred_test_y = model.predict(test_x)

    # 4. Return the predictions
    return pred_test_y


def multi_class_svm(train_x, train_y, test_x):
    """
    Trains a linear SVM for multiclass classifciation using a one-vs-rest strategy

    In scikit-learn's LinearSVC, the one-vs-rest strategy is used by default
    when fitting to data with more than two unique classes.

    Args:
        train_x - (n, d) NumPy array (n datapoints each with d features)
        train_y - (n, ) NumPy array containing the labels (int) for each training data point
        test_x - (m, d) NumPy array (m datapoints each with d features)
    Returns:
        pred_test_y - (m,) NumPy array containing the labels (int) for each test data point
    """
    # 1. Instantiate the LinearSVC model with required parameters
    # Use the same C and random_state as specified in the previous problem.
    model = LinearSVC(
        C=0.1,
        random_state=0,
        # max_iter is increased for robustness with larger/multi-class datasets
        max_iter=5000
    )

    # 2. Fit the model using the training data
    # LinearSVC automatically handles multi-class classification via OvR strategy.
    model.fit(train_x, train_y)

    # 3. Predict the labels for the test data
    pred_test_y = model.predict(test_x)

    # 4. Return the predictions
    return pred_test_y


def compute_test_error_svm(test_y, pred_test_y):
    return 1 - np.mean(pred_test_y == test_y)

