#include <iostream>

using namespace std;

template <typename Type> 

class LinkedList
{
    private:
        
	class node
	{
	  public:
          Type data;
	  node* next;
	}; 
        
	int count;
	node* head;

    public:

          LinkedList();
	  ~LinkedList();
	  void AddatHead(const Type& val);
	  Type Get(const int index);
	  void AddAtIndex(const int index, const Type& val);
	  void DeleteAtIndex(const int index);
	  void DeleteValue(const Type& val);
	  void MoveToHead(const Type& val);
	  void Rotate(const int steps);
	  void Reverse();
	  void Reduce();
	  void K_Reverse(const int k);
	  void ZigZagRearrange();
	  int size();
	  void cleanup();
	  void print();
};

template <typename Type>
LinkedList<Type>::LinkedList()
{
    head = new node;
    head -> next = NULL;
    count = 0;
}

template <typename Type>
LinkedList<Type>::~LinkedList()
{
    node *temp; 
    while(head != NULL)
    {
	temp = head;
	head = head -> next;
	delete temp;
    }
}

template <typename Type>
void LinkedList<Type>::AddatHead(const Type& val)
{
    node* new_node = new node;
    new_node->data = val;
    new_node->next = head->next;
    head->next = new_node;
    count++;
}

template <typename Type>
Type LinkedList<Type>::Get(const int index)
{
    node* cur = head->next;
    if(index<1)
    {
	return -1;
    }

    for(int i=0;i<index;i++)
	{
	    cur=cur->next;
	    if(cur == NULL)
	    {
		return -1;
	    }
	}

	return cur->data;
}

template <typename Type>
void LinkedList<Type>::AddAtIndex(const int index, const Type& val)
{
    node* cur = head->next;
    node* new_node = new node;
    new_node -> data = val;

    if(index==0)
    {
	new_node->next = head->next;
	head->next = new_node;
	count++;
    }
    
    if(index >= 1)
    {
	for(int i=1; i<index; i++)
	{
	    cur = cur->next;
	}
	node* temp = cur;
	cur = cur->next;
	temp->next = new_node;
	new_node->next = cur;
	count++;
    }
}

template <typename Type>
void LinkedList<Type>::DeleteAtIndex(const int index)
{
    node* cur = head->next;
    node* bef_cur = head; 
    for(int i=1; i<index; i++)
    {
	bef_cur = bef_cur->next; 
	cur = cur->next;
    }
    bef_cur->next = cur->next;
    delete cur;
    count--; 
}

template <typename Type>
void LinkedList<Type>::DeleteValue(const Type& val)
{
    node* cur = head->next;
    node* bef_cur = head;
    while(cur != NULL)
    {
	if(cur->data==val)
	{
	    bef_cur -> next = cur->next;
	    delete cur;
	    count--;
	    return;
	}

	else 
	{
	    bef_cur = bef_cur -> next;
	    cur = cur->next;
	}
    }
}

template <typename Type>
void LinkedList<Type>::MoveToHead(const Type& val)
{
    node* cur = head->next;
    node* bef_cur = head;
    while(cur != NULL)
    {
	if(cur->data == val)
	{
	    node* temp = cur;
	    bef_cur->next = cur->next;
	    temp->next = head->next;
	    head->next = temp;
	    return;
	}
	
	else
	{
	    bef_cur = bef_cur->next;
	    cur = cur->next;
	}
    }
}

template <typename Type>
void LinkedList<Type>::Rotate(const int steps)
{
    for(int i=0;i<steps;i++)
    {
	node* cur = head->next;
        node* bef_cur = head;
        
	for(int j=0;j<count-1;j++)
	{
	    bef_cur = bef_cur->next;
	    cur = cur->next;
	}

	node* temp = cur;
	bef_cur->next = cur->next;
	temp->next = head->next;
	head->next = temp;
    }

    if(steps < 0)
    {
	return;
    }
}

template <typename Type>
void LinkedList<Type>::Reduce()
{
    node* cur1 = head->next;
    node* cur2;
    node* bef_cur2;

    while(cur1 != NULL)
    {
	cur2 = cur1;
	bef_cur2 = cur1;
	cur2 = cur2->next;

	while(cur2 != NULL)
	{
	    if(cur1->data == cur2->data)
	    {
		node* temp;
                temp  = cur2->next;
		bef_cur2->next=temp;
		delete cur2;
		count--;
		cur2 = temp;
            }

	    else
	    {
		bef_cur2 = bef_cur2->next;
		cur2 = cur2->next;
	    }
	}
	cur1 = cur1->next;
    }
}

template <typename Type>
void LinkedList<Type>::K_Reverse(const int k) 
{
    node* cur = head->next;
    node* nex_cur = NULL;
    node* bef_cur = head;
    node* temp = NULL;

    if(k>count)
	return;

    while(cur != NULL)
    {
	temp = cur;
        bef_cur = bef_cur->next;
	cur = cur->next;
	nex_cur = cur->next;

	for(int i=0;i<k-1;i++)
	{
	    nex_cur = cur->next;
	    cur->next = bef_cur;
	    bef_cur = cur;
	    cur = nex_cur;
	}

	head->next = bef_cur;
        count -= k;
        
	if(count<k)
	    break;
	else
	{
	    for(int i=0;i<k-1;i++)
	    {
		nex_cur;  
	    }
	}
    }

    while(cur != NULL)
    {
	cur->next = bef_cur;
	cur = cur->next;
	bef_cur = bef_cur->next;
    }

    head->next = bef_cur;
}

template <typename Type>
void LinkedList<Type>::Reverse()
{
    node* cur = head->next;
    node* nex_cur = NULL;
    node* bef_cur = NULL;
    
    while(cur != NULL)
    {
	nex_cur = cur->next;
	cur->next = bef_cur;
	bef_cur = cur;
	cur = nex_cur;
    }
    
    head->next = bef_cur;
}

template <typename Type>
void LinkedList<Type>::ZigZagRearrange()
{
    cout << "Sorry...I didn't make it." << endl;
}

template <typename Type>
void LinkedList<Type>::print()
{
    node* cur = head->next;
    cout << "("; 
    while(cur != NULL)
    {
	cout << cur->data;
	if(cur->next != NULL)
	{
	    cout << ",";
	}
	cur = cur->next;
    }
    cout  << ")";
}

template <typename Type>
int LinkedList<Type>::size()
{
    return count;
}

template <typename Type>
void LinkedList<Type>::cleanup()
{
    node* temp;
    while(head->next != NULL)
    {
	temp = head;
	head = head->next;
	delete temp;
    }
    count = 0;
}

int main()
{

    LinkedList<int> list;

    list.AddatHead(0);
    list.AddatHead(1);
    list.AddatHead(2);
    list.AddatHead(3);
    list.AddatHead(4);
    list.AddatHead(5);
    list.AddatHead(6);
    list.AddatHead(7);
    list.AddatHead(8);
    list.AddatHead(9);

    list.print();
    cout << endl;

    cout << list.Get(2);
  


    return 0;
}
