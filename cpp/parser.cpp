#include <iostream>
#include <fstream>
#include <cctype>
#include <algorithm>
#include <string>
#include <vector>
#include <sstream>
#include <iterator>
using namespace std;

int periods = 0;
int colons = 0;
int semicolons = 0;
int questions = 0;
int exclamations = 0;


bool isVowel(char c){
		
		c = tolower(c);
		
                if(c == 'a' | c == 'e' | c ==  'i' | c == 'o' | c == 'u' | c =='y' )
                        return true;
                return false;
        }

int countSyllables(string s){

		//cout << s << endl;
    for (int i = 0, len = s.size(); i < len; i++)
    {
	    s[i] = tolower(s[i]);

        if (ispunct(s[i]))
        {
            s.erase(i--, 1);
            len = s.size();
        }	
    }
                if(s.length() == 0)
                        return 0;
                else if(s.length() == 1){
                        if(isVowel(s[0]))
                                return 1;
                }
                else{
                        int syllableCount = 0;
                        char prev = tolower(s[0]);
                        if(isVowel(prev)){
                                syllableCount++;
                        }
                        for(int i = 1; i < s.length(); i++){
                                char c = tolower(s[i]);
                                if(isVowel(c) && !isVowel(prev) && !(i  == s.length()-1 && c == 'e')){
                                        syllableCount++;
                                }
                                else if(i  == s.length()-1 && c == 'e'){
                                        if(syllableCount == 0)
                                                syllableCount++;
                                }
                                prev = c;
                        }
                        return syllableCount;
                }
                return 0;
        }

int sentencePunctuation(string s){
                int sentenceMarkCount = 0;
 		//cout << s << endl;
                for(int i = 0; i < s.length(); i++){
                        char c = s[i];
                        if(c == '.' || c == ':' || c == ';' || c == '?' || c == '!'){
                        	if(c == '.') 
					periods++;
				if(c == ':')
                                        colons++;
				if(c == ';')
                                        semicolons++;
				if(c == '?')
                                        questions++;
				if(c == '!')
                                        exclamations++;
 
			       sentenceMarkCount++;
			}
                }
		//cout << sentenceMarkCount << endl;
                return sentenceMarkCount;
}
/*
float getFleschIndex(int wordCount, int syllableCount, int sentenceCount){
                cout << float(wordCount) << endl;
                cout << float(syllableCount) << endl;
                cout << float(sentenceCount) << endl;

		float alpha = (float(syllableCount)/float(wordCount));
		cout << alpha << endl;
                float beta = (float(wordCount)) / (float(sentenceCount));
		cout << beta << endl;
                float index = 206.835 - alpha*84.6 - beta*1.015;

                return index;
        }

double getFleschKincaidIndex(int wordCount, int syllableCount, int sentenceCount){
		cout << double(wordCount) << endl;
                cout << syllableCount << endl;
                cout << sentenceCount << endl;

                double alpha = (double)(syllableCount)/(double)(wordCount);
		cout << alpha << endl;
                double beta = (double)wordCount / (double)(sentenceCount);
		cout << beta << endl;
                double index = alpha*11.8 + beta*0.39 - 15.59;

                return index;
}*/

double getFleschIndex(int wordCount, int syllableCount, int sentenceCount){
                cout << (wordCount) << endl;
                cout << (syllableCount) << endl;
                cout << (sentenceCount) << endl;

		double syd = double(syllableCount);
		double wrd = double(wordCount);

                double alpha = syd/wrd;//double(syllableCount)/double(wordCount);
                double beta = double(wordCount) / double(sentenceCount);
                double index = 206.835 - alpha*84.6 - beta*1.015;
                //System.out.println(alpha);
                //System.out.println(beta);
		cout << (alpha) << endl;
                cout << (beta) << endl;
                return index;
        }

double getFleschKincaidIndex(int wordCount, int syllableCount, int sentenceCount){
                //System.out.println(wordCount);
                        //System.out.println(syllableCount);
                        //System.out.println(sentenceCount);

		cout << (wordCount) << endl;
                cout << (syllableCount) << endl;
                cout << (sentenceCount) << endl;

                double alpha = double(syllableCount)/double(wordCount);
                double beta = double(wordCount) / double(sentenceCount);
                double index = alpha*11.8 + beta*0.39 - 15.59;
                //System.out.println(alpha);
                //System.out.println(beta);
        	cout << (alpha) << endl;
                cout << (beta) << endl;
 
	       return index;
        }

bool isNum(string s){
	for(int i = 0; i < s.length(); i++){
		if(!isdigit(s[i]))
			return false;
	}
	return true;
}


int main(int argc, char *argv[]){
	ifstream file;
    	file.open (argv[1]);
    	if (file.is_open()){

		int syllableCount = 0;
		int wordCount = 0;
		int sentenceCount = 0;

		string line;
	    	string word;
    		while (getline(file, line))//(file >> word)
    		{
			//cout <<  line << endl;
			std::istringstream buf(line);
    			std::istream_iterator<std::string> beg(buf), end;
			std::vector<std::string> tokens(beg, end);
			
			for(auto& word: tokens){
        		//cout<< word << '\n';
			if(!isNum(word)&& word != ""){
				//transform(word.begin(), word.end(), word.begin(), tolower);
				cout << word << endl;
				wordCount++;
				cout << wordCount << endl;
				syllableCount+=countSyllables(word);
				sentenceCount+=sentencePunctuation(word);
			}
			}
    		}
		
		cout << wordCount << endl;
		cout << syllableCount << endl;
		cout << sentenceCount << endl;
		sentenceCount = periods + colons + semicolons + questions + exclamations;
		cout << sentenceCount << endl;

		//syllableCount = 960339;
		cout << "periods: " << periods << endl;
		cout << "colons: " << colons << endl;
		cout << "semicolons: " << semicolons << endl;
		cout << "questions: " << questions << endl;
		cout << "exclamations: " << exclamations << endl;

		cout << "Flesch Readability Index: " << getFleschIndex(wordCount, syllableCount, sentenceCount) << endl;
		cout << "Flesch-Kincaid Grade Level Index: " << getFleschKincaidIndex(wordCount, syllableCount, sentenceCount) << endl;

	}
}
