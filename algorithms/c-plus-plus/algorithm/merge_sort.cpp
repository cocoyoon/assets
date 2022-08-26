
#include <iostream> 
#define SIZE 10
int tempArray[SIZE];

using namespace std;

void merge_sort(int Array[],int fistIndex, int lastIndex);
void merge(int Array[], int firstIndex, int middleIndex, int lastIndex);

int main() {
    
    //make dynamacally allocated array
    int* needToBeSorted = new int[SIZE];
    for(int i = 0; i < SIZE; i++) {

        cin >> needToBeSorted[i]; 
    }

    merge_sort(needToBeSorted,0,SIZE-1);

    for(int i = 0; i < SIZE; i++){

        cout << needToBeSorted[i] << " ";
    }
    
    delete[] needToBeSorted;
    return 0;
}

void merge_sort(int Array[], int firstIndex, int lastIndex) {

    //divide with the middle of array which is lower bound of (sizeOfArray/2)
    if(firstIndex < lastIndex) {

        int m = (firstIndex + lastIndex)/2;
        merge_sort(Array, firstIndex, m);
        merge_sort(Array, m+1, lastIndex);
        merge(Array, firstIndex ,m, lastIndex);
    }
}

void merge(int Array[], int firstIndex, int middleIndex, int lastIndex) {

    int left = firstIndex;
    int right = middleIndex+1;
    int newIndex = firstIndex;

    while(left <= middleIndex && right <= lastIndex) {

        tempArray[newIndex++] = Array[left] <= Array[right] ? Array[left++] : Array[right++]; 
    }

    int tempIndex = left > middleIndex ? right : left;

    while(newIndex <= right) {

        tempArray[newIndex++] = Array[tempIndex++];
    }

    for(int i = firstIndex; i <= lastIndex; i++) {

        Array[i] = tempArray[i];
    }
    
}


