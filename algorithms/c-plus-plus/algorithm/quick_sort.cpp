
#include <iostream>
#define SIZE 10

using namespace std;

int partition(int partitionArray[], int index_first, int index_last);
void quickSort(int sortedArray[], int firstIndex, int lastIndex);
void swap(int swapArray[], int num1, int num2);

int main() {

    int* mainArray = new int[SIZE];
    
    cout << "Input the data into array" << endl;
    for(int i = 0; i < SIZE; i++) {

        cin >> mainArray[i];
    }

    cout << "Current Array Status: [ ";
    for (int i = 0; i < SIZE; i++) {

        cout << mainArray[i] << " ";
    }
    cout << "]" << endl;

    quickSort(mainArray,0,SIZE-1);

    cout << "Array by QuickSort(): [ ";
    for(int i = 0; i < SIZE; i++) {

        cout << mainArray[i] << " "; 
    }
    cout << "]";

    delete[] mainArray;
    return 0;
}

void quickSort(int sortedArray[], int firstIndex, int lastIndex) {

    if (firstIndex < lastIndex) {

        int partitionIndex = partition(sortedArray,firstIndex,lastIndex);
        quickSort(sortedArray,firstIndex,partitionIndex-1);
        quickSort(sortedArray,partitionIndex+1,lastIndex);
    }

}

int partition(int partitionArray[], int index_first, int index_last) {

    int pivot = partitionArray[index_last];
    int indicator = index_first - 1;

    for (int currIndex = index_first; currIndex < index_last; currIndex ++) {

        if (partitionArray[currIndex] <= pivot) {

            indicator += 1;
            swap(partitionArray,indicator,currIndex);
        }
    }
    swap(partitionArray,indicator+1,index_last);
    
    int partIndex = indicator + 1;
    
    return partIndex;
}

void swap(int swapArray[], int num1, int num2) {

    int temp = swapArray[num1];
    swapArray[num1] = swapArray[num2];
    swapArray[num2] = temp;
}
