#include <iostream>
#include <string>
#include <sstream>

using namespace std;

template <typename type>
class Stack {
    
private:     
    
    type* stack;
    int stack_top;
    int stack_size;

public:

    explicit Stack();
    ~Stack();
    void push(const type& item);
    type& top() const;
    void pop();
    int size() const;
    bool empty() const;
    void copy_stack();
    void print();

};

template <typename type>
Stack<type>::Stack() {
    
    stack_top = -1;
    stack_size = 0;
}

template <typename type>
Stack<type>::~Stack() {

    delete[] stack;
}

template <typename type>
void Stack<type>::push(const type &item) {

    stack_size++;

    if(stack_top == -1)
    {
	stack = new type[stack_size];
        stack_top++;
	stack[stack_top] = item;
	return;
    }

    else
    {
		stack_top++;
		int current_size = stack_top-1;
		type* temp_stack = new type[stack_size];
		for(int i=0; i <= current_size; i++)
			{
	    		temp_stack[i] = stack[i];
			}

	temp_stack[stack_top] = item;
	stack = new type[stack_size];

	for(int i=0;i <= stack_top; i++)
	{
	    stack[i] = temp_stack[i];
	}
	
	return;
    }
}

template <typename type>
type& Stack<type>::top() const {

    
    return stack[stack_top];
}

template <typename type>
void Stack<type>::pop() {
    
        if(stack_top == -1)
	{
	    cout << "There is no element to pop in the stack";
	    return;
	}
        else
	{
	    stack_top--;
            stack_size--;
	}

	return;
}

template <typename type>
int Stack<type>::size() const {

    return stack_size;
}

template <typename type>
bool Stack<type>::empty() const {

    if(stack_top == -1)
    {
	return true;
    }
    else 
	return false;
}

template <typename type>
void Stack<type>::print() {

    for(int i=0;i<stack_size;i++)
    {
	cout << stack[i] << " ";
    }
}

/*template <typename type>
class Queue {

private:
   
    type* queue;
    int queue_size;
    int queue_curr;
    int queue_end;

public:
    
    explicit Queue();
    ~Queue();
    void push(const type& item);
    type& front() const;
    void pop();
    int size() const;
    bool empty() const;
    void print();
 
};

template <typename type>
Queue<type>::Queue() {

    queue_size = 0;
    queue_end = -1;
    queue_curr = 0;
} 

template <typename type>
Queue<type>::~Queue() {

    delete[] queue;
}

template <typename type>
void Queue<type>::push(const type &item){

    queue_size++;
    if(queue_end == -1)
    {
	queue_end++;
	queue = new type[queue_size];
	queue[queue_end] = item;
	return;
    }

    else
    {
	queue_end++;
	int current_size = queue_end-1;
	type* temp_queue = new type[queue_size];
	for(int i = 0;i <= current_size; i++)
	{
	    temp_queue[i] = queue[i];
	}
        
	temp_queue[queue_end] = item;
	queue = new type[queue_size];
	for(int i = 0; i <= queue_end; i++)
	{
	    queue[i] = temp_queue[i];
	}
	
	return;
    }
    
}

template <typename type>
type& Queue<type>::front() const {

    return queue[queue_curr];
}

template <typename type>
void Queue<type>::pop(){

    queue_curr++;
    queue_size--;

    return;
}

template <typename type> 
int Queue<type>::size() const {

    return queue_size;
}

template <typename type>
bool Queue<type>::empty() const {

    if(queue_curr > queue_end)
	return true;
    
    else
	return false;
}

template <typename type>
void Queue<type>::print() {

    for(int i=0;i<queue_size;i++)
    {
	cout << queue[i] << " "; 
    }
}
*/

bool eval_isnum(char );
bool eval_priority(char ,char );
string to_postfix(const string& );
double Eval(const string&);

int main()
{
    Stack<int> s;
    for(int i=0;i<1000000;i++)
    {
	s.push(i);
    }

    s.print();
    
    /*string infix("2+3");
    cout << to_postfix(infix) << endl;

    cout  << Eval(infix) << endl;*/

    return 0;
}

double Eval(const string& in)
{
    Stack<double> cal;
    string eval_string = to_postfix(in);
    string eval_input;
    double eval_result;
    double final_result1;
    double final_result2;
    double final_result3;
    
    for(int i = 0;i < eval_string.length(); i++)
    {
        if(eval_isnum(eval_string[i]))
	{
	    while(eval_string[i] != ' ')
	    {
	       eval_input += eval_string[i];
	       i++;
	    }

            if(eval_string[i] == ' ')
	    {
	        eval_result = stod(eval_input);
	        cal.push(eval_result);
	        eval_input.clear();
	        continue;
	    }
        }

	else if(eval_string[i] == '+')
	{
	    double x,y;

	    x = cal.top();
	    cal.pop();
	    
	    y= cal.top();
	    cal.pop();
	    
	    cal.push(x+y);
	}

	else if(eval_string[i] == '*')
	{
	    double x,y;

	    x = cal.top();
	    cal.pop();

	    y= cal.top();
	    cal.pop();

	    cal.push(x*y);
	}

	else if(eval_string[i] == '/')
	{
	    double x,y;

	    x = cal.top();
	    cal.pop();

	    y = cal.top();
	    cal.pop();

	    cal.push(y/x);
	}

	else if(eval_string[i] == '-')
	{
	    if(eval_isnum(eval_string[i+1]))
	    {
		while(eval_string[i] != ' ')
		{
		    eval_input += eval_string[i];
		    i++;
		}
                
		eval_result = stod(eval_input);
		cal.push(eval_result);
                eval_input.clear();
		continue;
	     }

	    else
	    {
		double x,y;

		x = cal.top();
		cal.pop();

		y = cal.top();
		cal.pop();
                
		cal.push(y-x);
	    }
        }
    }

    final_result1 =  cal.top();
    cal.pop();
    if(!cal.empty())
    {
	final_result2 = cal.top();
	final_result3 = final_result1 + final_result2;
	return final_result3;
    }
    else
	return final_result1;
}
string to_postfix(const string& infix)
{
    Stack<char> op;
    string postfix;
    int eval_count;

    for(int i = 0; i < infix.length(); i++)
    {
	if (eval_isnum(infix[i]))
	{ 
	   postfix += infix[i];
	   eval_count = 0;

	   if(!eval_isnum(infix[i+1]))
	   {
	       postfix += ' ';
	   }
	   continue;
	}

	else if (infix[i] == '(')
	{
	    op.push(infix[i]);
	    eval_count++;
	}

	else if (infix[i] == '+' || infix[i] == '*' || infix[i] == '/')
	{
	    if(op.empty() || op.top() == '(')
	    {
		op.push(infix[i]);
		eval_count++;
	    }

	    else if(eval_priority(op.top(),infix[i]))
	    {
		op.push(infix[i]);
		eval_count++;
	    }

	    else
	    {
		while(!eval_priority(op.top(),infix[i]))
	        {
		    postfix += op.top();
		    postfix += ' ';
		    op.pop();
		}

		op.push(infix[i]);
		eval_count++;
	    }
        }

	else if(infix[i] == '-')
	{
	    if(op.empty())
            {
		if(infix[i+1] == '(')
		{
                    postfix += '-';
		    postfix += '1';
		    postfix += ' ';
		    op.push('*');
		    eval_count++; 
		}
                // (eg. -(2+3))

		else
		    postfix += infix[i];
		
	    }
                  //unary case (eg. -10 + 2)

	    else if(op.top() == '(')
	    {
	        if(eval_count==0)
	        {
		    op.push(infix[i]);
                }

		//binary case (eg. 10-2)

		else 
		    postfix += infix[i];

		//unary case
	    }
	    
	    else if(infix[i+1] == '(')
	    {
		postfix += '-';
		postfix += '1';
		postfix += ' ';
		op.push('*');
		eval_count++;
	    }
               //unary case (eg. -(3+5))

	    else if(eval_priority(op.top(),infix[i]))
	    {
		op.push(infix[i]);
		eval_count++;
	    }

	    else 
	    {
		postfix += op.top();
		postfix += ' ';
		op.pop();
		op.push(infix[i]);
		eval_count++;
	    }
	}

	else if (infix[i] == ')')
	{
	    while(op.top() != '(')
	    {
		postfix += op.top();
		postfix += ' ';
		op.pop();
	    }

	    if(op.top() == '(')
	    {
		op.pop();
	    }
	}

    }

    while(!op.empty())
    {
	postfix += op.top();
	postfix += ' ';
	op.pop();
    }

    return postfix;	
}

bool eval_isnum(char infix)
{
    int char_to_num = (int)infix;
    if(char_to_num == 46)
	return true;
    if(char_to_num >= 48 && char_to_num <= 57)
	return true;
    else 
	return false;
}

bool eval_priority(char top, char in_str)
{
    int priority_top;
    int priority_in; 

    if(in_str == '*')
	priority_in = 3;
    else if(in_str == '/')
	priority_in = 2;
    else
	priority_in = 1;
    
    if(top == '*')
	priority_top = 3;
    else if(top == '/')
	priority_top = 2;
    else
	priority_top =1;

    if(priority_in >= priority_top)
	return true;
    else
	return false;
}
