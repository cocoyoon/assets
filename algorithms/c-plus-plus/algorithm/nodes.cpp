//20151487_SoYounJeong

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int max(int num1,int num2) {
   
   if(num1 >= num2) {
      
      return num1;
   } else {

      return num2;
   }
}

void maxNodes(int weightArray[],int size) {

   int n = (size/2)+1;
   int firstArray[n]; //A array in hw4.pdf
   int secondArray[n]; //B array in hw4.pdf
   int thirdArray[n]; //C array in hw4.pdf

   int max_weightArray[size+1]; //this array contains '1', when the node is checked. Otherwise, contains '0'
   int max_value; //This variable contains sum of the maximum weight of independent set.
   char indicator; //This variable indicates which node to check. A or B
   
   firstArray[0] = 0;
   secondArray[0] = 0;
   thirdArray[0] = 0;

   for(int i = 0; i < size+1; i++) {

       max_weightArray[i] = 0; //initialiize max_weightArray to zeros.
   }

   for(int i = 1; i < n; i++) {

      firstArray[i] = weightArray[2*i-1] + max(secondArray[i-1],thirdArray[i-1]);
      secondArray[i] = weightArray[2*i] + max(firstArray[i-1],thirdArray[i-1]);
      thirdArray[i] = max(firstArray[i-1],secondArray[i-1]);
   } 
   
   //Process of problem 2

   max_value = max(firstArray[n-1],secondArray[n-1]);
   
   if(max_value == firstArray[n-1]){
      indicator = 'a'; //if independent set contain 2*i-1 node, make indicator 'a' 
   } else {
      indicator = 'b'; //if independent set contain 2*i node, make indicator 'b'
   }

   int index = n-1; 
   
   //I have used 'bottom-up' method
   while(max_value > 0 && index > 0) {
       
       //A array
       if(firstArray[index] == max_value && indicator == 'a') {
           
           max_weightArray[2*index-1] = 1; //change to 1, if the node is checked
           max_value = max_value - weightArray[2*index-1];

           if(secondArray[index-1] < thirdArray[index-1]) {
               
               index--; //decrease the index, when thirdArray is bigger than secondArray
           }

           indicator = 'b'; //to go to second Array for next step.
           index--; //decrease the index
       }
       
       //B array
       else if(secondArray[index] == max_value && indicator == 'b'){
           
           max_weightArray[2*index] = 1; //change to 1, if the node is checked
           max_value = max_value - weightArray[2*index];

           if(firstArray[index-1] < thirdArray[index-1]) {
               
               index--; //decrease the index, when thirdArray is bigger than firstArray
           }
           
           indicator = 'a'; //to go to first Array for next step
           index--; //decrease the index after the process
       }
   }

   for(int i = 1; i <= size; i++) {
       
       if(max_weightArray[i] == 0) {
          
         continue; //max_weightArray is 0 if the node has not been checked 
       }

       cout << i << " "; //print the checked index, which is solution.
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
   maxNodes(weight_array,arraySize);

   delete[] weight_array;

   return 0;
}