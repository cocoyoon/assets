//queue
//implemented with 'doubly linked list'

#include <iostream> 

using namespace std; 
template <typename Type> 

class doublylinkedList {

    private: 

        class Node {

            public:
                
                Type data;
                Node *next;
                Node *prev;
        };

        Node *head = new Node;
        Node *tail = new Node;
        int count = 0;

    public:

        doublylinkedList();
        ~doublylinkedList();
        void push_at_head(const Type &val);
        void print();
        Type pop_at_tail();
        Type size();
};

template <typename Type>
doublylinkedList<Type>::doublylinkedList() {

    head -> prev = NULL;
    head -> next = tail;
    tail -> prev = head;
    tail -> next = NULL;
}

template <typename Type>
doublylinkedList<Type>::~doublylinkedList() {

    while(head != NULL) {

        Node *temp = head;
        head = head -> next;

        delete temp;
    }
}

template <typename Type>
void doublylinkedList<Type>::push_at_head(const Type &val) {

    Node *newNode = new Node;
    Node *node_at_head = head -> next;

    newNode -> data = val;

    if(head -> next == tail) {

        newNode -> next = head -> next;
        tail -> prev = newNode;
        newNode -> prev = head;
        head -> next = newNode;

        count ++;
    } else {

        newNode -> next = node_at_head;
        node_at_head -> prev = newNode;
        newNode -> prev = head;
        head -> next = newNode;

        count++;
    }
}

template <typename Type>
void doublylinkedList<Type>::print() {

    Node *cur = head -> next;

    cout << "[ ";
    while(cur != NULL) {

        cout << cur -> data << " ";
        if(cur -> next == tail) {
            break;
        }
        cur = cur -> next;
    }
    cout << "]" << endl;
}

template <typename Type>
Type doublylinkedList<Type>::pop_at_tail() {

    Node *temp_tail_node = tail -> prev;
    Node *before_tail_node = temp_tail_node -> prev;
    int pop_data = temp_tail_node -> data;

    tail -> prev = before_tail_node;
    before_tail_node -> next = tail;

    return pop_data;
}

template <typename Type>
Type doublylinkedList<Type>::size() {

    return count;
}


int main() {

    doublylinkedList<int> queue;

    queue.push_at_head(1);
    queue.push_at_head(2);
    queue.push_at_head(3);
    queue.push_at_head(4);

    queue.print();

    cout << queue.pop_at_tail() << " ";
    cout << queue.pop_at_tail() << " ";
    cout << queue.pop_at_tail() << " ";

    return 0;
}