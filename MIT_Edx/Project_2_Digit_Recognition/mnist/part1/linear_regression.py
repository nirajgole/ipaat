import numpy as np

def closed_form(X, Y, lambda_factor):
    """
    Computes the closed form solution of linear regression with L2 regularization

    Args:
        X - (n, d + 1) NumPy array (n datapoints each with d features plus the bias feature in the first dimension)
        Y - (n, ) NumPy array containing the labels (a number from 0-9) for each
            data point
        lambda_factor - the regularization constant (scalar)
    Returns:
        theta - (d + 1, ) NumPy array containing the weights of linear regression. Note that theta[0]
        represents the y-axis intercept of the model and therefore X[0] = 1
    """
    # Get the number of data points (n) and the number of features (d + 1)
    n, d_plus_1 = X.shape

    # 1. Compute X^T X
    # np.dot(X.T, X) or X.T @ X
    XTX = X.T @ X

    # 2. Compute lambda * I
    # I is the identity matrix of size (d + 1) x (d + 1)
    lambda_I = lambda_factor * np.eye(d_plus_1)

    # 3. Compute (X^T X + lambda * I)
    inverted_matrix = XTX + lambda_I

    # 4. Compute the inverse of the matrix: (X^T X + lambda * I)^-1
    # Use np.linalg.inv for matrix inversion
    inv_of_term = np.linalg.inv(inverted_matrix)

    # 5. Compute X^T Y
    # Note: Y is (n,), so we transpose it temporarily or use proper broadcasting for matrix multiplication
    # X.T is (d + 1, n) and Y is (n,) - the result is (d + 1,)
    XTY = X.T @ Y

    # 6. Compute theta = (X^T X + lambda I)^-1 * X^T Y
    # inv_of_term is (d + 1, d + 1) and XTY is (d + 1,) - the result is (d + 1,)
    theta = inv_of_term @ XTY

    # Return the weights (theta)
    return theta

### Functions which are already complete, for you to use ###

def compute_test_error_linear(test_x, Y, theta):
    test_y_predict = np.round(np.dot(test_x, theta))
    test_y_predict[test_y_predict < 0] = 0
    test_y_predict[test_y_predict > 9] = 9
    return 1 - np.mean(test_y_predict == Y)