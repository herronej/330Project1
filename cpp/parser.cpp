#include <iostream>
#include <fstream>
using namespace std;


int main(int argc, char *argv[]){
	ifstream file;
    	file.open (argv[1]);
    	if (file.is_open()){

    	string word;
    	while (file >> word)
    	{
        	cout<< word << '\n';
    	}
	}
}
