
//insertion sort 
//running time O(n^2)

#include <iostream>

using namespace std;

void insertion_sort(int* array ,int num);

int main() {

    int needToBeSorted[] = {6,4,3,2,1,5,7};
    int arrayCount = sizeof(needToBeSorted)/sizeof(int);

    insertion_sort(needToBeSorted,arrayCount);

    for(int i = 0; i < arrayCount; i++) {

        cout << needToBeSorted[i] << " ";
    }
    
    return 0;
}

void insertion_sort(int* array ,int num) {

    for(int j = 1; j < num; j++) {

        int key = *(array+j);
        int i = j-1;

        while (i > -1 && *(array+i) > key) {

            *(array+(i+1)) = *(array+i);
            i = i-1;
        }

        *(array+(i+1)) = key;
    }
}