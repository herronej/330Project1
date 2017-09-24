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
    //checks that lowercase letters are vowels		
		c = tolower(c);
		
                if(c == 'a' | c == 'e' | c ==  'i' | c == 'o' | c == 'u' | c =='y' )
                        return true;
                return false;
        }

int countSyllables(string s){
    // counts syllables given a word
    for (int i = 0, len = s.size(); i < len; i++)
    {
	    s[i] = tolower(s[i]);

        // removes non-letters from words
        if (ispunct(s[i]))
        {
            s.erase(i--, 1);
            len = s.size();
        }	
    }

    // base cases
    if(s.length() == 0)
        return 0;
    else if(s.length() == 1){
        if(isVowel(s[0]))
        return 1;
    }
    else{
        // count sylables
        int syllableCount = 0;
        char prev = tolower(s[0]);
        if(isVowel(prev)){
            syllableCount++;
        }
        for(int i = 1; i < s.length(); i++){
            char c = tolower(s[i]);
            // count syllables excluding silent e
            if(isVowel(c) && !isVowel(prev) && !(i  == s.length()-1 && c == 'e')){
                syllableCount++;
            }
            //include non-silent e's
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
    // counts periods, colons, semicolons, question and exclamation marks in string
    int sentenceMarkCount = 0;
    for(int i = 0; i < s.length(); i++){
        char c = s[i];
        if(c == '.' || c == ':' || c == ';' || c == '?' || c == '!'){
	        sentenceMarkCount++;
		}
    }
    return sentenceMarkCount;
}


double getFleschIndex(int wordCount, int syllableCount, int sentenceCount){
    
    // returns Flesch Index

	double syd = double(syllableCount);
	double wrd = double(wordCount);

    double alpha = syd/wrd;
    double beta = double(wordCount) / double(sentenceCount);
    double index = 206.835 - alpha*84.6 - beta*1.015;
                
    return index;
}

double getFleschKincaidIndex(int wordCount, int syllableCount, int sentenceCount){
    
    // returns Flesch Kincaid Index
                    
    double alpha = double(syllableCount)/double(wordCount);
    double beta = double(wordCount) / double(sentenceCount);
    double index = alpha*11.8 + beta*0.39 - 15.59;
    return index;
}

bool isNum(string s){

    // checks whether string is 100% numeric

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
    	while (getline(file, line)){
            // reads file line by line
			std::istringstream buf(line);
    		std::istream_iterator<std::string> beg(buf), end;
			std::vector<std::string> tokens(beg, end);
			
            // counts syllables, sentence markers, and non-numeric words in each line
			for(auto& word: tokens){
			    if(!isNum(word)&& word != ""){
				    wordCount++;
				    syllableCount+=countSyllables(word);
				    sentenceCount+=sentencePunctuation(word);
			    }
			}
        }
		
		//cout << wordCount << endl;
		//cout << syllableCount << endl;
		//cout << sentenceCount << endl;

		cout << "Flesch Readability Index: " << getFleschIndex(wordCount, syllableCount, sentenceCount) << endl;
		cout << "Flesch-Kincaid Grade Level Index: " << getFleschKincaidIndex(wordCount, syllableCount, sentenceCount) << endl;

	}
}
