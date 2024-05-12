# 3) Given an array arr of n elements, Find the element which is not smaller than its neighbours.
# Note: If the array is increasing then just print the last element.
# Input: array[]= {5, 10, 20, 15} Output: 20 Explanation: The element 20 has neighbors 10 and 15, both of them are less than 20.
# NOTE: Prepare a Google Colab notebook, include code and results, and share the notebook link with proper access permissions for evaluation.
# Failing to do so will result in zero marks.


def get_biggest_neighbor(array: list) -> int:
    biggest_neighbor = array[-1]
    for i, v in enumerate(array):
        if i == 0 and v > array[i + 1]:
            biggest_neighbor = v
        elif i == (len(array) - 1) and v > array[-2]:
            biggest_neighbor = v
        else:
            if v > array[i - 1] and v > array[i + 1]:
                biggest_neighbor = v
    return biggest_neighbor


array = [5, 10, 20, 15]
res = get_biggest_neighbor(array)
print(res)
