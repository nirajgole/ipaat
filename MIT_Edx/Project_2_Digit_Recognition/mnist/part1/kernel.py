import numpy as np

### Functions for you to fill in ###



def polynomial_kernel(X, Y, c, p):
    """
    Compute the polynomial kernel between two matrices X and Y::
        K(x, y) = (<x, y> + c)^p
    for each pair of rows x in X and y in Y.

    Args:
        X - (n, d) NumPy array (n datapoints each with d features)
        Y - (m, d) NumPy array (m datapoints each with d features)
        c - a coefficient to trade off high-order and low-order terms (scalar)
        p - the degree of the polynomial kernel

    Returns:
        kernel_matrix - (n, m) Numpy array containing the kernel matrix
    """
    # 1. Compute the inner product matrix: <X, Y^T>
    # Shape: (n, d) @ (d, m) -> (n, m)
    # The (i, j) element of this matrix is <X[i], Y[j]>
    inner_products = X @ Y.T

    # 2. Add the coefficient c
    # Shape: (n, m)
    sum_c = inner_products + c

    # 3. Raise the result to the power p
    # NumPy's power function performs element-wise exponentiation
    # Shape: (n, m)
    kernel_matrix = np.power(sum_c, p)

    return kernel_matrix



def rbf_kernel(X, Y, gamma):
    """
    Compute the Gaussian RBF kernel between two matrices X and Y::
        K(x, y) = exp(-gamma ||x-y||^2)
    for each pair of rows x in X and y in Y.

    Args:
        X - (n, d) NumPy array (n datapoints each with d features)
        Y - (m, d) NumPy array (m datapoints each with d features)
        gamma - the gamma parameter of gaussian function (scalar)

    Returns:
        kernel_matrix - (n, m) Numpy array containing the kernel matrix
    """
    n, d = X.shape
    m, d_y = Y.shape

    # 1. Compute ||x||^2 for every vector in X (n x 1 vector)
    # The sum along axis=1 computes the squared L2 norm for each row.
    # The result is a column vector (n, 1).
    X_squared_norms = np.sum(X**2, axis=1, keepdims=True)

    # 2. Compute ||y||^2 for every vector in Y (m x 1 vector)
    # Transposing makes it a row vector (1, m).
    Y_squared_norms = np.sum(Y**2, axis=1, keepdims=True).T

    # 3. Compute 2 * x^T y for all pairs (n x m matrix)
    # X @ Y.T is the matrix of inner products.
    two_inner_products = 2 * (X @ Y.T)

    # 4. Compute the squared Euclidean distance ||x-y||^2 (n x m matrix)
    # This uses NumPy broadcasting: (n, 1) + (1, m) - (n, m) -> (n, m)
    # dist_sq[i, j] = ||X[i]||^2 + ||Y[j]||^2 - 2 * <X[i], Y[j]>
    dist_sq = X_squared_norms + Y_squared_norms - two_inner_products

    # Due to floating point errors, sometimes dist_sq can be slightly negative
    # (e.g., -1e-15 for the case X==Y). We clip at 0.
    dist_sq = np.maximum(dist_sq, 0)

    # 5. Compute the RBF kernel: K(x, y) = exp(-gamma * ||x-y||^2)
    kernel_matrix = np.exp(-gamma * dist_sq)

    return kernel_matrix
