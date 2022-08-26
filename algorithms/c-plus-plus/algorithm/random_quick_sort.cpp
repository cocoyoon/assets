
//No matter what the array status, time complexity : O(nlogn)

#include <iostream>
#include <cstdlib>

#define SIZE 10

int Partition(int part_array[], int index_first, int index_last);
void QuickSort(int array[], int firstIndex, int lastIndex);
int RandomizedPivot(int low, int high);
void Swap(int swap_array[], int num1, int num2);

using namespace std;

int main() {

    int* array = new int[SIZE];
    
    cout << "Input number into array" << endl;
    for(int i = 0; i < SIZE; i++) {

        cin >> array[i];
    }

    cout << "Current Array: [ ";
    for(int i = 0; i < SIZE; i++) {

        cout << array[i] << " ";
    }
    cout << "]" << endl;

    QuickSort(array, 0, SIZE-1);

    cout << "Sorted Array with Randomized QuickSort: [ ";
    for(int i = 0; i < SIZE; i++) {

        cout << array[i] << " ";
    }
    cout << "]";

    delete[] array;
    return 0;
}

void QuickSort(int array[], int firstIndex, int lastIndex) {

    if(firstIndex < lastIndex) {

        int pivot = Partition(array,firstIndex,lastIndex);
        QuickSort(array, firstIndex, pivot-1);
        QuickSort(array, pivot+1, lastIndex);
    }
}

void Swap(int swap_array[], int num1, int num2) {

    int temp = swap_array[num1];
    swap_array[num1] = swap_array[num2];
    swap_array[num2] = temp;
}

int Partition(int part_array[], int index_first, int index_last) {

    int q = RandomizedPivot(index_first, index_last);
    Swap(part_array, q, index_last);

    int indicator = index_first - 1;

    for(int currentIndex = index_first; currentIndex < index_last; currentIndex++) {

        if (part_array[currentIndex] <= part_array[index_last]) {

            indicator += 1;
            Swap(part_array, indicator, currentIndex);
        }
    }

    Swap(part_array, indicator+1, index_last);

    return indicator+1; 
}

int RandomizedPivot(int low, int high) {

    srand(time(NULL));
    int random_pivot = low + rand() % (high-low);
    cout << "Random Pivot is: " << random_pivot << endl;

    return random_pivot;
}
