#include <iostream>
#include "FlatHash.h"

using namespace std;

class HierarchyHash
{

private:

	unsigned int** sub_hash;
	unsigned int* hash_table;
	enum overflow_handle flag;
	unsigned int table_size;
	unsigned int sub_table_size;
	unsigned int num_keys;
	unsigned int num_sub;
	unsigned int num_prob;
    unsigned int tombstone;
	unsigned int sub_index;
	unsigned int nth_sub_index;
	double load_factor;
	double num_keys_load;
	double table_size_load;

public:

	HierarchyHash(enum overflow_handle _flag);
	~HierarchyHash();

	unsigned int hashFunction(const int key) 
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

	unsigned int getAllocatedSize();
	int insert(const unsigned int key);
	int remove(const unsigned int key);
	int search(const unsigned int key);
	void clearTombstones();
	void rehash();

	void print();
};

HierarchyHash::HierarchyHash(enum overflow_handle _flag)
{
	table_size = 1000;
	sub_table_size = 100;
	num_sub = 10;
	num_prob = 0;
	num_keys = 0;
	num_keys_load = 0;
	tombstone = 99999999;
	flag = _flag;

    sub_hash = new unsigned int* [num_sub];
    hash_table = new unsigned int [table_size]; 
	
	for(int i = 0; i < num_sub; i++)
	{
		sub_hash[i] = new unsigned int [sub_table_size];
	}

	for(int i = 0; i < num_sub; i++) //sub_table as 'NULL'
	{
		for(int j = 0; j < sub_table_size; j++)
		{
			sub_hash[i][j] = 0;
		}
	}	

	for(int i = 0; i < table_size; i++) //Make hash_table '0' 
	{
		hash_table[i] = 0;
	}
}	

HierarchyHash::~HierarchyHash()
{
	for(int i = 0; i < num_sub; i++)
	{
		delete[] sub_hash[i];
	}

	delete[] sub_hash;
	delete[] hash_table;
}

unsigned int HierarchyHash::getAllocatedSize()
{
	int count = 0;

	for(int i = 0; i < num_sub; i++)
	{
		for(int j = 0; j < sub_table_size; j++)
		{
			if(sub_hash[i][j] != 0)
			{
				if(sub_hash[i][j] == tombstone)
				continue;

				count++;
				break;
			} 
		}
	}

	return (count * 100);
}

int HierarchyHash::insert(const unsigned int key)
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
			
			nth_sub_index = index / 100;
			sub_index = index % 100;

			sub_hash[nth_sub_index][sub_index] = key;

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

					nth_sub_index = new_index / 100;
					sub_index = new_index % 100;

					sub_hash[nth_sub_index][sub_index] = key;

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
 
			nth_sub_index = index / 100;
			sub_index = index % 100;

			sub_hash[nth_sub_index][sub_index] = key;

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

					nth_sub_index = new_index / 100;
					sub_index = new_index % 100;

					sub_hash[nth_sub_index][sub_index] = key;

					return num_prob;
				}
            }

			for(int j = 0; j <= table_size; j++) //Convert to 'Linear Probing'
			{
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

					nth_sub_index = new_index / 100;
					sub_index = new_index % 100;

					sub_hash[nth_sub_index][sub_index] = key;

					return num_prob;
				}
				num_prob++;
			}
        }
    }	
}

void HierarchyHash::rehash()
{
	unsigned int* temp_hash = new unsigned int [table_size]; 
	unsigned int og_size = table_size;
	
	for(int i = 0; i < og_size; i++)
	{
		temp_hash[i] = hash_table[i];
	}

	table_size = 2 * (table_size);
	num_sub = table_size / sub_table_size; 
	
	hash_table = new unsigned int [table_size]; //Reallocate 'hash_table' 
	sub_hash = new unsigned int* [num_sub]; //Reallocate 'sub_hash'

	for(int i = 0; i < num_sub; i++)
	{
		sub_hash[i] = new unsigned int [sub_table_size]; //Reallocate 'sub_hash
	}

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

int HierarchyHash::remove(const unsigned int key)
{
	int empty_count = 0;
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

					nth_sub_index = remove_index / 100;
					sub_index = remove_index % 100;

					sub_hash[nth_sub_index][sub_index] = 0;

					for(int i = 0; i < sub_table_size; i++)
					{
						if(sub_hash[nth_sub_index][i] == 0)
						{
							empty_count++;
						}
					}

					if(empty_count == 100) //if there is no value in sub_table. free memory & nullify the pointer!
					{
						delete[] sub_hash[nth_sub_index];

						for(int i = 0; i < sub_table_size; i++)
						{
							sub_hash[nth_sub_index][i] = 0;
						}
					}

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

							nth_sub_index = new_index / 100;
							sub_index = new_index % 100;

							sub_hash[nth_sub_index][sub_index] = 0;

							for(int i = 0; i < sub_table_size; i++)
							{
								if(sub_hash[nth_sub_index][i] == 0)
								{
									empty_count++;
								}
							}

							if(empty_count == 100) //if there is no value in sub_table. free memory & nullify the pointer!
							{
								delete[] sub_hash[nth_sub_index];

								for(int i = 0; i < sub_table_size; i++)
								{
									sub_hash[nth_sub_index][i] = 0;
								}
							}

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
							nth_sub_index = current_index / 100;
							sub_index = current_index % 100;

							sub_hash[nth_sub_index][sub_index] = 0;

							hash_table[j] = new_val;

							nth_sub_index = j / 100;
							sub_index = j % 100;

							sub_hash[nth_sub_index][sub_index] = new_val;

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
							nth_sub_index = current_index / 100;
							sub_index = current_index % 100;

							sub_hash[nth_sub_index][sub_index] = 0;

							hash_table[j] = new_val;

							nth_sub_index = j / 100;
							sub_index = j % 100;

							sub_hash[nth_sub_index][sub_index] = new_val;

							break;
						}
					}

					for(int j = table_size - 1; j >= original_index; j--)
					{
						if(hash_table[j] == 0)
						{
							hash_table[current_index] = 0;
							nth_sub_index = current_index / 100;
							sub_index = current_index % 100;

							sub_hash[nth_sub_index][sub_index] = 0;

							hash_table[j] = new_val;

							nth_sub_index = j / 100;
							sub_index = j % 100;

							sub_hash[nth_sub_index][sub_index] = new_val;

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

					nth_sub_index = remove_index / 100;
					sub_index = remove_index % 100;

					sub_hash[nth_sub_index][sub_index] = tombstone;

					for(int i = 0; i < sub_table_size; i++)
					{
						if(sub_hash[nth_sub_index][i] == 0)
						{
							empty_count++;
						}
					}

					if(empty_count == 100) //if there is no value in sub_table. free memory & nullify the pointer!
					{
						delete[] sub_hash[nth_sub_index];

						for(int i = 0; i < sub_table_size; i++)
						{
							sub_hash[nth_sub_index][i] = 0;
						}
					}

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

							nth_sub_index = new_index / 100;
							sub_index = new_index % 100;

							sub_hash[nth_sub_index][sub_index] = tombstone;

							for(int i = 0; i < sub_table_size; i++)
							{
								if(sub_hash[nth_sub_index][i] == 0)
								{
									empty_count++;
								}
							}

							if(empty_count == 100) //if there is no value in sub_table. free memory & nullify the pointer!
							{
								delete[] sub_hash[nth_sub_index];

								for(int i = 0; i < sub_table_size; i++)
								{
									sub_hash[nth_sub_index][i] = 0;
								}
							}

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

							nth_sub_index = new_index / 100;
							sub_index = new_index % 100;

							sub_hash[nth_sub_index][sub_index] = tombstone;

							for(int i = 0; i < sub_table_size; i++)
							{
								if(sub_hash[nth_sub_index][i] == 0)
								{
									empty_count++;
								}
							}

							if(empty_count == 100) //if there is no value in sub_table. free memory & nullify the pointer!
							{
								delete[] sub_hash[nth_sub_index];

								for(int i = 0; i < sub_table_size; i++)
								{
									sub_hash[nth_sub_index][i] = 0;
								}
							}

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

int HierarchyHash::search(const unsigned int key)
{
	num_prob = 0;
	int empty_det = 0;
	int hash_count = 1;
	int index = hashFunction(key);
	int search_index;

	for(int i = 0; i< table_size; i++)
	{
		if(index == hashFunction(hash_table[i]))
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

void HierarchyHash::clearTombstones()
{
	if(flag == 1)
	{
		int empty_count = 0;
		unsigned int* temp_hash = new unsigned int [table_size];

		for(int i = 0; i < table_size; i++)
		{
			if(hash_table[i] == tombstone)
			{
				hash_table[i] = 0;

				nth_sub_index = i / 100;
				sub_index = i % 100;

				sub_hash[nth_sub_index][sub_index] = 0;

				for(int i = 0; i < sub_table_size; i++)
				{
					if(sub_hash[nth_sub_index][i] == 0)
						{
							empty_count++;
						}
				}

				if(empty_count == 100) //if there is no value in sub_table. free memory & nullify the pointer!
				{
					delete[] sub_hash[nth_sub_index];

					for(int i = 0; i < sub_table_size; i++)
					{
						sub_hash[nth_sub_index][i] = 0;
					}
				}
			}
		}
	
		for(int i = 0; i < table_size; i++)
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

void HierarchyHash::print()
{
	if( getNumofKeys() == 0)
	{
		std::cout << "[]" << std::endl;
		return;
	}

    else
	{
		unsigned int size_of_count_arr = table_size / sub_table_size;
		unsigned int* count_arr = new unsigned int [size_of_count_arr];
		unsigned int count_arr_index = 0;
		unsigned int val_count = 0;
		unsigned int sub_count = 0;

		for(int i = 0; i < size_of_count_arr; i++)
		{
			for(int j = 0; j < 100; j++)
			{
				count_arr_index = (i*100) + j;
				if(hash_table[count_arr_index] != 0)
				{
					if(hash_table[count_arr_index] == tombstone)
					{
						continue;
					}

					val_count++;
				}
			}
		
			count_arr[i] = val_count;
			val_count = 0;
		}

		if(flag == 0)
		{
			for(int i = 0; i < num_sub; i++)
			{
				for(int j = 0; j < sub_table_size; j++)
				{
					if(sub_hash[i][j] != 0)
					{
						sub_count++;

						if(sub_count == 1)
						{
							cout << i << ":[";
						}

						cout << (i*100) + j << ":" << sub_hash[i][j];

						if(sub_count < count_arr[i])
						{
							cout << ",";
						}
					}	
				}

				sub_count = 0;

				if(count_arr[i] != 0)
				{
					cout << "]" << endl;
				}
			}
		}

		else if(flag == 1)
		{
			for(int i = 0; i < num_sub; i++)
			{
				for(int j = 0; j < sub_table_size; j++)
				{
					if(sub_hash[i][j] != 0)
					{
						if(sub_hash[i][j] == tombstone)
						{
							continue;
						}

						sub_count++;

						if(sub_count == 1) //first element
						{
							cout << i << ":[";
						}

						cout << ":[" << (i*100) + j << ":" << sub_hash[i][j];

						if(sub_count < count_arr[i])
						{
							cout << ",";
						}
					}	
				}

				sub_count = 0;

				if(count_arr[i] != 0)
				{
					cout << "]" << endl;
				}
			}
		}
		
		delete[] count_arr; 
	}
}

int main()
{
    HierarchyHash hh(LINEAR_PROBING);

    std::cout << hh.insert(98)   << std::endl;
    cout << hh.insert(103) << endl; 
	cout << hh.insert(1099) << endl;
	cout << hh.insert(1098) << endl;
	cout << hh.insert(200) << endl;
	cout << hh.insert(300) << endl;

	cout << hh.getAllocatedSize() << endl;

    hh.print();

	return 0;
}