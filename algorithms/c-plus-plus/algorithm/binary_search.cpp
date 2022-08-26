
#include <iostream>
#define SIZE 7

int binarySearch(int array[],int firstIndex, int lastIndex, int searchValue);

using namespace std;

int main() {

    int* arr = new int[SIZE];
    cout << "please input number with increasing order" << endl;

    for(int i = 0; i < SIZE; i++) {

        cin >> arr[i];
    }

    cout << "Current Array: ";
    cout << "[ ";
    for(int i = 0; i < SIZE; i++) {

        cout << arr[i] << " ";
    }
    cout << "]";

    cout << endl;
    cout << "What would you want to find?: ";
    
    int x;
    cin >> x;

    int valueIndex = binarySearch(arr,0,SIZE-1,x);
    
    if (valueIndex == SIZE) {

        cout << "That element is not in given array.";

    } else {
        
        cout << "It is at " << valueIndex << ".";
    }

    delete[] arr;
    return 0;
}

int binarySearch(int array[],int firstIndex, int lastIndex, int searchValue) {

    int middleIndex = (firstIndex + lastIndex)/2;

    if(array[middleIndex] == searchValue) {

        return middleIndex;
    }

    if(firstIndex == lastIndex) {
        
        return SIZE;
    }

    if(searchValue < array[middleIndex]) {

        return binarySearch(array, firstIndex, (middleIndex-1), searchValue);

    } else {
        
        return binarySearch(array, (middleIndex+1), lastIndex, searchValue);
    }
}