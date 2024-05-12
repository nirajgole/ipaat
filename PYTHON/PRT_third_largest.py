# 2) Write a Python Program that takes a list as input given by the user containing numbers.
# Find out the 3rd Largest element from that list. NOTE: Prepare a Google Colab notebook,
# include code and results, and share the notebook link with proper access permissions for evaluation.
# Failing to do so will result in zero marks.

input_list = [1, 45, 23, 100, 8, 0.5, -89]


def get_third_largest(lst: list) -> int|str:
    if not len(lst):
        return "No numbers found"
    elif len(lst) < 3:
        return "List should have at least 3 numbers"
    return sorted(lst, reverse=True)[2]


result = get_third_largest(input_list)

print(result)
