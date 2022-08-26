//20151487_SoYounJeong

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int maxWeight(int weightArray[],int size) {

   int n = (size/2)+1;
   int firstArray[n];
   int secondArray[n];
   int thirdArray[n];
   
   firstArray[0] = 0;
   secondArray[0] = 0;
   thirdArray[0] = 0;

   for(int i = 1; i < n; i++) {

      firstArray[i] = weightArray[2*i-1] + max(secondArray[i-1],thirdArray[i-1]);
      secondArray[i] = weightArray[2*i] + max(firstArray[i-1],thirdArray[i-1]);
      thirdArray[i] = max(firstArray[i-1],secondArray[i-1]);
   
   }

   return max(firstArray[n-1],secondArray[n-1]);
}

int max(int num1,int num2) {
   
   if(num1 >= num2) {
      
      return num1;
   } else {

      return num2;
   }
}

int main (int argc, char *argv[]) {
   
   ifstream input_file(argv[1]);

   int input;
   vector<int> w;

   while(!(input_file >> input).eof()) {

      w.push_back(input);
   }
   input_file.close();

   int *weight_array = new int[w.size()+1];
   int i = 1;

   vector<int>::iterator p;
   for(p = w.begin(); p != w.end(); p++) {

      weight_array[i] = *p;
      i++;
   }
   
   int arraySize = w.size();
   cout << maxWeight(weight_array,arraySize);

   delete[] weight_array;

   return 0;
}
