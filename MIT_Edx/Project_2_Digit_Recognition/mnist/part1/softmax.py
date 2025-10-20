import sys
sys.path.append("..")
from utils import *
import numpy as np
import matplotlib.pyplot as plt
import scipy.sparse as sparse


def augment_feature_vector(X):
    """
    Adds the x[i][0] = 1 feature for each data point x[i].

    Args:
        X - a NumPy matrix of n data points, each with d - 1 features

    Returns: X_augment, an (n, d) NumPy array with the added feature for each datapoint
    """
    column_of_ones = np.zeros([len(X), 1]) + 1
    return np.hstack((column_of_ones, X))

def compute_probabilities(X, theta, temp_parameter):
    """
    Computes, for each datapoint X[i], the probability that X[i] is labeled as j
    for j = 0, 1, ..., k-1

    Args:
        X - (n, d) NumPy array (n datapoints each with d features)
        theta - (k, d) NumPy array, where row j represents the parameters of our model for label j
        temp_parameter - the temperature parameter of softmax function (scalar)
    Returns:
        H - (k, n) NumPy array, where each entry H[j][i] is the probability that X[i] is labeled as j
    """
    # X has shape (n, d) (data points, features)
    # theta has shape (k, d) (classes, features)

    # 1. Compute the unnormalized scores (logits): S = X @ theta.T
    # S will have shape (n, k), where S[i, j] is the score for datapoint i belonging to class j.
    scores = X @ theta.T

    # 2. Apply temperature scaling
    scaled_scores = scores / temp_parameter

    # 3. Stabilize computation: Subtract the maximum score for each row (datapoint)
    # to prevent overflow when computing the exponential, a standard practice
    # in numerically stable softmax implementation.
    max_scores = np.max(scaled_scores, axis=1, keepdims=True)
    stabilized_scores = scaled_scores - max_scores

    # 4. Compute exponentiated scores: E = exp(stabilized_scores)
    E = np.exp(stabilized_scores)

    # 5. Compute the sum of exponents for normalization (denominator)
    Z = np.sum(E, axis=1, keepdims=True)

    # 6. Compute the probability matrix P (n, k)
    P = E / Z

    # 7. The required output H is the transpose of P: (k, n)
    H = P.T

    return H

def compute_cost_function(X, Y, theta, lambda_factor, temp_parameter):
    """
    Computes the total cost over every datapoint.

    Args:
        X - (n, d) NumPy array (n datapoints each with d features)
        Y - (n, ) NumPy array containing the labels (a number from 0-9) for each
            data point
        theta - (k, d) NumPy array, where row j represents the parameters of our
                model for label j
        lambda_factor - the regularization constant (scalar)
        temp_parameter - the temperature parameter of softmax function (scalar)

    Returns
        c - the cost value (scalar)
    """
    n = X.shape[0]
    k = theta.shape[0]

    # 1. Compute the probability matrix H: (k, n)
    # H[j, i] is P(y=j | x_i)
    H = compute_probabilities(X, theta, temp_parameter)

    # 2. Create a one-hot encoding matrix Y_one_hot: (k, n)
    # Y_one_hot[j, i] is 1 if x_i belongs to class j, 0 otherwise
    Y_one_hot = np.zeros((n, k))
    Y_one_hot[np.arange(n), Y] = 1
    Y_one_hot = Y_one_hot.T # Transpose to (k, n) to match H

    # 3. Compute Negative Log-Likelihood (Cross-Entropy Loss)
    # We only care about the log probability of the correct class.
    # Clip H to prevent log(0) errors (though compute_probabilities is stable,
    # an explicit clip adds robustness against floating point errors).
    H_clipped = np.clip(H, 1e-10, 1.0)

    # Element-wise multiplication selects the log-probability of the true class
    log_likelihood = Y_one_hot * np.log(H_clipped)

    # Sum all terms and negate. Divide by n for the average NLL loss.
    NLL_loss = -np.sum(log_likelihood) / n

    # 4. Compute L2 Regularization Loss
    # J_reg = (lambda / 2) * ||theta||^2_F
    L2_reg_term = (lambda_factor / 2.0) * np.sum(theta**2)

    # 5. Total Cost
    c = NLL_loss + L2_reg_term

    return c

def run_gradient_descent_iteration(X, Y, theta, alpha, lambda_factor, temp_parameter):
    """
    Runs one step of batch gradient descent

    Args:
        X - (n, d) NumPy array (n datapoints each with d features)
        Y - (n, ) NumPy array containing the labels (a number from 0-9) for each
            data point
        theta - (k, d) NumPy array, where row j represents the parameters of our
                model for label j
        alpha - the learning rate (scalar)
        lambda_factor - the regularization constant (scalar)
        temp_parameter - the temperature parameter of softmax function (scalar)

    Returns:
        theta - (k, d) NumPy array that is the final value of parameters theta
    """
    n = X.shape[0]
    k = theta.shape[0]

    # 1. Compute probability matrix H: (k, n)
    # H[j, i] is P(y=j | x_i)
    H = compute_probabilities(X, theta, temp_parameter)

    # 2. Create a one-hot encoding matrix Y_one_hot: (k, n)
    # Y_one_hot[j, i] is 1 if x_i belongs to class j, 0 otherwise
    Y_one_hot = np.zeros((n, k))
    Y_one_hot[np.arange(n), Y] = 1
    Y_one_hot = Y_one_hot.T # Transpose to (k, n) to match H

    # 3. Compute the error matrix D = H - Y_one_hot (k, n)
    # This matrix contains P(y=j|x_i) - 1_{y_i=j}
    D = H - Y_one_hot

    # 4. Compute the gradient of the loss term: Grad_Loss = (1/(n * tau)) * D @ X (k, d)
    # The temperature parameter (tau) must be included here based on the derivative.
    # (k, n) @ (n, d) -> (k, d)
    grad_loss = (1 / (n * temp_parameter)) * D @ X

    # 5. Compute the gradient of the regularization term: Grad_Reg = lambda * theta (k, d)
    grad_reg = lambda_factor * theta

    # 6. Total Gradient (k, d)
    total_gradient = grad_loss + grad_reg

    # 7. Update parameters: theta_new = theta_old - alpha * total_gradient
    theta_new = theta - alpha * total_gradient

    return theta_new

def update_y(train_y, test_y):
    """
    Changes the old digit labels for the training and test set for the new (mod 3)
    labels.

    Args:
        train_y - (n, ) NumPy array containing the labels (a number between 0-9)
                  for each datapoint in the training set
        test_y - (n, ) NumPy array containing the labels (a number between 0-9)
                 for each datapoint in the test set

    Returns:
        train_y_mod3 - (n, ) NumPy array containing the new labels (a number between 0-2)
                       for each datapoint in the training set
        test_y_mod3 - (n, ) NumPy array containing the new labels (a number between 0-2)
                      for each datapoint in the test set
    """
    train_y_mod3 = train_y % 3
    test_y_mod3 = test_y % 3

    return train_y_mod3, test_y_mod3

# def compute_test_error_mod3(X, Y, theta, temp_parameter):
#     """
#     Returns the error of these new labels when the classifier predicts the digit. (mod 3)

#     Args:
#         X - (n, d - 1) NumPy array (n datapoints each with d - 1 features)
#         Y - (n, ) NumPy array containing the labels (a number from 0-2) for each
#             data point
#         theta - (k, d) NumPy array, where row j represents the parameters of our
#                 model for label j
#         temp_parameter - the temperature parameter of softmax function (scalar)

#     Returns:
#         test_error - the error rate of the classifier (scalar)
#     """
#     #YOUR CODE HERE
#     raise NotImplementedError

def compute_test_error_mod3(X, Y, theta, temp_parameter):
    """
    Returns the error of these new labels when the classifier predicts the digit. (mod 3)

    Args:
        X - (n, d - 1) NumPy array (n data points each with d - 1 features)
        Y - (n, ) NumPy array containing the labels (a number from 0-2) for each
            data point
        theta - (k, d) NumPy array, where row j represents the parameters of our
                model for label j
        temp_parameter - the temperature parameter of softmax function (scalar)

    Returns:
        test_error - the error rate of the classifier (scalar)
    """
    # Get predicted labels (0-9), convert to mod 3 and compare with true labels mod 3
    assigned_labels = get_classification(X, theta, temp_parameter)
    assigned_labels_mod3 = assigned_labels % 3
    Y_mod3 = Y % 3
    test_error = 1 - np.mean(assigned_labels_mod3 == Y_mod3)
    return test_error

def softmax_regression(X, Y, temp_parameter, alpha, lambda_factor, k, num_iterations):
    """
    Runs batch gradient descent for a specified number of iterations on a dataset
    with theta initialized to the all-zeros array. Here, theta is a k by d NumPy array
    where row j represents the parameters of our model for label j for
    j = 0, 1, ..., k-1

    Args:
        X - (n, d - 1) NumPy array (n data points, each with d-1 features)
        Y - (n, ) NumPy array containing the labels (a number from 0-9) for each
            data point
        temp_parameter - the temperature parameter of softmax function (scalar)
        alpha - the learning rate (scalar)
        lambda_factor - the regularization constant (scalar)
        k - the number of labels (scalar)
        num_iterations - the number of iterations to run gradient descent (scalar)

    Returns:
        theta - (k, d) NumPy array that is the final value of parameters theta
        cost_function_progression - a Python list containing the cost calculated at each step of gradient descent
    """
    X = augment_feature_vector(X)
    theta = np.zeros([k, X.shape[1]])
    cost_function_progression = []
    for i in range(num_iterations):
        cost_function_progression.append(compute_cost_function(X, Y, theta, lambda_factor, temp_parameter))
        theta = run_gradient_descent_iteration(X, Y, theta, alpha, lambda_factor, temp_parameter)
    return theta, cost_function_progression

def get_classification(X, theta, temp_parameter):
    """
    Makes predictions by classifying a given dataset

    Args:
        X - (n, d - 1) NumPy array (n data points, each with d - 1 features)
        theta - (k, d) NumPy array where row j represents the parameters of our model for
                label j
        temp_parameter - the temperature parameter of softmax function (scalar)

    Returns:
        Y - (n, ) NumPy array, containing the predicted label (a number between 0-9) for
            each data point
    """
    X = augment_feature_vector(X)
    probabilities = compute_probabilities(X, theta, temp_parameter)
    return np.argmax(probabilities, axis = 0)

def plot_cost_function_over_time(cost_function_history):
    plt.plot(range(len(cost_function_history)), cost_function_history)
    plt.ylabel('Cost Function')
    plt.xlabel('Iteration number')
    plt.show()

def compute_test_error(X, Y, theta, temp_parameter):
    assigned_labels = get_classification(X, theta, temp_parameter)
    return 1 - np.mean(assigned_labels == Y)
