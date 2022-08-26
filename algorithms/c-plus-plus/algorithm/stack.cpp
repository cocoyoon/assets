//stack
//implemented with 'single linked list'

#include <iostream> 

using namespace std; 
template <typename Type> 

class linkedList {

    private:

        class Node {

            public: 

                Type data;
                Node *next;   
        };

        Node *head = new Node;
        int count = 0;

    public:

        linkedList();
        ~linkedList();
        void push_at_head(const Type &val);
        void print_stack();
        Type pop_at_head();
        Type size();
};

template<typename Type>
linkedList<Type>::linkedList(){

    head -> next = NULL;
}

template<typename Type>
linkedList<Type>::~linkedList(){
 
    while(head != NULL) {

        Node *temp = head;
        head = head -> next;
        
        delete temp;
    }
}

template <typename Type>
void linkedList<Type>::push_at_head(const Type &val) {

    Node *newNode = new Node;

    newNode -> data = val;
    newNode -> next = head -> next;
    head -> next = newNode;

    count++;
}

template <typename Type>
Type linkedList<Type>::pop_at_head() {

    Node *temp = new Node;

    temp = head -> next;
    if(temp == NULL) {

        return -1;
    }

    head -> next = temp -> next;
    count--;

    int pop_value = temp -> data;

    delete temp;

    return pop_value;
}

template <typename Type>
Type linkedList<Type>::size() {

    return count;
}

template <typename Type>
void linkedList<Type>::print_stack() {

    Node *cur = new Node;
    cur = head -> next;

    cout << "[ ";
    while(cur != NULL) {

        cout << cur -> data << " ";

        cur = cur -> next;
    }
    cout << "]" << endl;

    delete cur;
}

int main() {

    linkedList<int> stack;

    stack.push_at_head(1);
    stack.push_at_head(2); 
    stack.push_at_head(3);

    stack.print_stack();

    int stackSize = stack.size();

    for(int i = 0; i <= stackSize; i++) {

        int pop_at_head = stack.pop_at_head();
        
        if(pop_at_head == -1) {
            cout << "No value in Stack" << endl;
        } else {
            cout << pop_at_head << endl;
        }
    }

    return 0;
}
