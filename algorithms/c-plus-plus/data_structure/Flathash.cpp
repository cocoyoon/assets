#include <iostream>

using namespace std;

enum overflow_handle 
{
	LINEAR_PROBING, 
	QUADRATIC_PROBING
};

class FlatHash
{

private:
	unsigned int* hash_table;
	enum overflow_handle flag;
    unsigned int num_prob;
    unsigned int tombstone;
	unsigned int table_size;
	unsigned int num_keys;
    double load_factor;
	double num_keys_load;
	double table_size_load;

public:
	FlatHash(enum overflow_handle _flag);
    ~FlatHash();
	int insert(const unsigned int key);
	int remove(const unsigned int key);
	int search(const unsigned int key);
	void rehash();
	void clearTombstones();
    void print();

	unsigned int hashFunction(const unsigned int key) 
    { 
		return key % table_size;
	}

	unsigned int getTableSize() 
	{ 
		return table_size; 
	}

	unsigned int getNumofKeys() 
	{ 
		return num_keys; 
	}
};

FlatHash::FlatHash(enum overflow_handle _flag)
{
	hash_table = new unsigned int [table_size];
    flag = _flag;

	tombstone = 99999999;
	table_size = 1000;
	num_keys = 0;
	num_keys_load = 0;
	num_prob = 0; //for 'time cost'

    for(int i=0;i<table_size;i++)
	{
		hash_table[i] = 0;
	}
}

FlatHash::~FlatHash()
{
    delete[] hash_table;
}

int FlatHash::insert(const unsigned int key)
{
	table_size_load = table_size;
	load_factor = (num_keys_load) / (table_size_load);
    num_prob = 0;
	int index = hashFunction(key);

	if (load_factor >= 0.8)
	{
		rehash();
	}


	if (flag == 0) //Linear Probing  
	{
		if(hash_table[index] == 0) //if hash_table is empty which is '0'
		{
			hash_table[index] = key;
			num_keys++;
			num_keys_load++;
			num_prob++;

			return num_prob;
		}

 		else // Linear Probing Overflow Handling : move to other address!
		{
			for(int j = 0; j <= table_size; j++)
			{
				num_prob++;
				int new_index = index + j;
				new_index = hashFunction(new_index);
				
				if (hash_table[new_index] == key)
				{
					return -(num_prob);
				}

				else if (hash_table[new_index] == 0)
				{
					hash_table[new_index] = key;
					num_keys++;
					num_keys_load++;

					return num_prob; //time cost 
				}
			}
	    }
	}

	else if (flag == 1) //Quadratic Probing
    {
        if(hash_table[index] == 0 || hash_table[index] == tombstone) //if hash_table is empty which is '0'
		{
			hash_table[index] = key;
			num_keys++;
			num_keys_load++;
			num_prob++;
 
			return num_prob;
		}

        else // Overflow_Handling
        {
            for(int j = 0; j <= table_size; j++)
            {
				num_prob++;
                int new_index = index + (j*j);
				new_index = hashFunction(new_index);
                
				if(hash_table[new_index] == key) //Handling Duplicate Cases
                {
					return -(num_prob); 
				}

                else if(hash_table[new_index] == 0 || hash_table[new_index] == tombstone)
				{
					hash_table[new_index] = key;
					num_keys++;
					num_keys_load++;

					return num_prob;
				}
            }

			for(int j = 0; j <= table_size; j++) //Convert to 'Linear Probing'
			{
				num_prob++;
				int new_index = index + j;
				new_index = hashFunction(new_index);

				if(hash_table[new_index] == key)
				{
					return -(num_prob);
				}

				else if(hash_table[new_index] == 0 || hash_table[new_index] == tombstone)
				{
					hash_table[new_index] = key;
					num_keys++;
					num_keys_load++;

					return num_prob;
				}
			}
        }
    }

}

void FlatHash::rehash()
{
	unsigned int* temp_hash = new unsigned int [table_size]; 
	unsigned int og_size = table_size;
	
	for(int i = 0; i < og_size; i++)
	{
		temp_hash[i] = hash_table[i];
	}

	table_size = 2 * (table_size);
	hash_table = new unsigned int [table_size]; //Reallocate 'hash_table'

	for(int i = 0; i < table_size; i++)
	{
		hash_table[i] = 0;
	}
    num_keys = 0;
	num_keys_load = 0;

	for(int i = 0; i < og_size; i++)
	{
		if(temp_hash[i] != 0)
		{
			if(temp_hash[i] == tombstone)
			{
				continue; 
			}

			insert(temp_hash[i]);  //rehash
		} 
	}

	delete[] temp_hash;
}

int FlatHash::remove(const unsigned int key)
{
	int empty_det = 0;
	int count = 1;
	num_prob = 0;

	for(int i = 0; i < table_size; i++) //Counting Same Address 
	{
		if(hashFunction(key) == hashFunction(hash_table[i]))
		{
			empty_det++;
		}
	}

	if(flag == 0) //Linear_Probling_Handling
	{
		int remove_index;
        int new_index;

		for(int i = 0; i < table_size; i++)
		{
			if(hashFunction(key) == i)
			{
				remove_index = i;

				if(hash_table[remove_index] == key)
				{
					num_prob++;
					new_index = remove_index;
					hash_table[remove_index] = 0;
					num_keys--;

					break;
				}

				else
				{
					for(int j = 0; j <= table_size; j++)
				    {
					    num_prob++;
			            new_index = remove_index + j;
						new_index = hashFunction(new_index);

						if(hash_table[new_index] == key)
			        	{
				        	hash_table[new_index] = 0; //Delete 'key'
							num_keys--;

				        	break;
			        	}

						else if(hashFunction(hash_table[new_index]) == hashFunction(key))
						{
							count++;
						}

						else if(empty_det < count)
						{
							return -(num_prob++);
						}
					}
				}
			}
		}
		
		for(int i = 1; i <= table_size; i++) //shifting process
		{
			int current_index = new_index + i;
            current_index = hashFunction(current_index);
			int original_index = hashFunction(hash_table[current_index]);
			int new_val = hash_table[current_index];

			if(original_index != current_index && hash_table[current_index] != 0) //if index is not match
			{
				int distance = (current_index - original_index);

				if(distance > 0)
				{
					for(int j = current_index - 1; j >= original_index; j--)
					{
						if(hash_table[j] == 0) //if slot is empty
						{
							hash_table[current_index] = 0;
							hash_table[j] = new_val;

							break;
						}
					}
				}

				else if(distance < 0)
				{
					for(int j = current_index - 1; j >= 0; j--)
					{
						if(hash_table[j] == 0)
						{
							hash_table[current_index] = 0;
							hash_table[j] = new_val;

							break;
						}
					}

					for(int j = table_size - 1; j >= original_index; j--)
					{
						if(hash_table[j] == 0)
						{
							hash_table[current_index] = 0;
							hash_table[j] = new_val;

							break;
						}
					}
				}
			}
		}

		return num_prob; //Lastly, return 'time cost'
	}

	else if(flag == 1) //Quadratic_Probing_Handling
	{
		int remove_index;
        int new_index;

		for(int i = 0; i < table_size; i++)
		{
			if(hashFunction(key) == i) 
			{
				remove_index = i;

				if(hash_table[remove_index] == key)
				{
					num_prob++;
					new_index = remove_index;
					hash_table[remove_index] = tombstone; //Remain it as Tombstone
					num_keys--;

					return num_prob;
				}

				else
				{
					for(int j = 0; j <= table_size; j++)
				    {
					    num_prob++;
			            new_index = remove_index + j*j;
						new_index = hashFunction(new_index);

						if(hash_table[new_index] == key)
			        	{
				        	hash_table[new_index] = tombstone; //Remain it as 'Tombstone'
							num_keys--;

				        	return num_prob;
			        	}

						else if(hashFunction(hash_table[new_index]) == hashFunction(key))
						{
							count++;
						}

						else if(empty_det < count)
						{
							return -(num_prob++);
						}
					}

					for(int j = 0; j <= table_size; j++) //Convert to 'Linear Probing'
					{
						num_prob++;
						new_index = remove_index + j;
						new_index = hashFunction(new_index);

						if(hash_table[new_index] == key)
						{
							hash_table[new_index] = tombstone;
							num_keys--;

							return num_prob;
						}

						else if(hash_table[new_index] == hashFunction(key))
						{
							count++;
						}

						else if(empty_det < count)
						{
							return -(num_prob++);
						}
					} 
				}
			}
		}
    }
}

int FlatHash::search(const unsigned int key)
{
	num_prob = 0;
	int empty_det = 0;
	int hash_count = 1;
	int index = hashFunction(key);
	int search_index;
    int new_index;

	for(int j = 1; j <= table_size; j++)
	{
		new_index = index + j;
		new_index = hashFunction(new_index);

		if(hash_table[new_index] != 0)
		{
			empty_det++;
		}
	}
	

	if(flag == 0)
	{
		for(int i = 0; i <= table_size; i++)
		{
			num_prob++;
			search_index = index + i;
			search_index = hashFunction(search_index);

			if(hashFunction(key) == hashFunction(hash_table[search_index]))
			{
				hash_count++;

				if(hash_table[search_index] == key)
				{
					return num_prob;
				}
			}

			else if(empty_det < hash_count)
			{
				return -(num_prob++);
			}
		}
	}

	else if(flag == 1) //Quadratic Probing
	{
		for(int i = 0; i <= table_size; i++)
		{
			num_prob++;
			search_index = index + (i*i);
			search_index = hashFunction(search_index);

			if(hashFunction(key) == hashFunction(hash_table[search_index]))
			{
				hash_count ++;

				if(hash_table[search_index] == key)
				{
					return num_prob;
				}
			}

			else if(empty_det < hash_count)
			{
				return -(num_prob++);
			}
		}

		for(int i = 0; i <= table_size; i++) //search with linear_probing
		{
			num_prob++;
			search_index = index + i;
			search_index = hashFunction(search_index);

			if(hashFunction(key) == hashFunction(hash_table[search_index]))
			{
				hash_count ++;

				if(hash_table[search_index] == key)
				{
					return num_prob;
				}
			}

			else if(empty_det < hash_count)
			{
				return -(num_prob++);
			}
		}
	}

}

void FlatHash::clearTombstones()
{
	if(flag == 1)
	{
		unsigned int* temp_hash = new unsigned int [table_size];

		for(int i = 0; i < table_size; i++)
		{
			if(hash_table[i] == tombstone)
			{
				hash_table[i] = 0;
			}
		}
	
		for(int i = 0; i< table_size; i++)
		{
			temp_hash[i] = hash_table[i];
		}
	
		for(int i = 0; i < table_size; i++)
		{
			hash_table[i] = 0; //make Hash_Table value as zero
		}
        num_keys = 0;

		for(int i = 0; i < table_size; i++)
		{
			if(temp_hash[i] != 0)
			{
				insert(temp_hash[i]); //rehash
			}
		}

		delete[] temp_hash;
	}
}

void FlatHash::print()
{
	cout << "[";
	int val_count = 0;

    if(flag == 0)
	{
		for(int i = 0; i < table_size; i++)
		{
			if(hash_table[i] != 0)
			{
				cout << i << ":" << hash_table[i];
				val_count++;

				if(val_count < num_keys)
				{
					cout << ",";
				}
        	}
		}
	}

	if(flag == 1)	
	{
		for(int i = 0; i < table_size; i++)
		{
			if(hash_table[i] != 0)
			{
				if(hash_table[i] == tombstone)
				{
					continue;
				}

				cout << i << ":" << hash_table[i];
				val_count++;

				if(val_count < num_keys)
				{
					cout << ",";
				}
        	}
		}
	}	

	cout << "]" << std::endl;
}

int main()
{
    FlatHash hh(LINEAR_PROBING);

	std::cout << hh.insert(3)    << std::endl;    
	std::cout << hh.insert(7)    << std::endl;    
	std::cout << hh.insert(103)  << std::endl;   
	std::cout << hh.insert(903)  << std::endl;
	std::cout << hh.insert(99)   << std::endl;    
	std::cout << hh.insert(1099) << std::endl;  
	std::cout << hh.insert(98)   << std::endl;    
	std::cout << hh.insert(1098) << std::endl;    
	std::cout << hh.search(100)  << std::endl;  
	std::cout << hh.insert(1903) << std::endl;

	cout << endl;

    hh.print();
	
    return 0;
}
