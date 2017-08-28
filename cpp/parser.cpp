#include <iostream>
#include <fstream>
#include <cctype>
using namespace std;

public static boolean isVowel(char c){
                if(c == 'a' | c == 'e' | c ==  'i' | c == 'o' | c == 'u' | c =='y' )
                        return true;
                return false;
        }

int countSyllables(string s){
                if(s.length() == 0)
                        return 0;
                else if(s.length() == 1){
                        if(isVowel(s[i]))
                                return 1;
                }
                else{
                        int syllableCount = 0;
                        char prev = s[0];
                        if(isVowel(prev)){
                                syllableCount++;
                        }
                        for(int i = 1; i < s.length(); i++){
                                char c = s[i];
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
                for(int i = 0; i < s.length(); i++){
                        char c = s[i];
                        if(c == '.' || c == ':' || c == ';' || c == '?' || c == '!')
                                sentenceMarkCount++;
                }
                return sentenceMarkCount;
}

double getFleschIndex(int wordCount, int syllableCount, int sentenceCount){
                double alpha = (double)(syllableCount)/(double)(wordCount);
                double beta = (double)wordCount / (double)(sentenceCount);
                double index = 206.835 - alpha*84.6 - beta*1.015;

                return index;
        }

double getFleschKincaidIndex(int wordCount, int syllableCount, int sentenceCount){
                double alpha = (double)(syllableCount)/(double)(wordCount);
                double beta = (double)wordCount / (double)(sentenceCount);
                double index = alpha*11.8 + beta*0.39 - 15.59;

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

	    	string word;
    		while (file >> word)
    		{
        		cout<< word << '\n';
			if(!isNum(word)){
				wordCount++;
				syllableCount+=countSyllables(word);
				sentenceCount+=sentencePunctuation(word);
			}
    		}
		
		cout << "Flesch Readability Index: " << getFleschIndex(syllableCount, wordCount, sentenceCount) << endl;
		cout << "Flesch-Kincaid Grade Level Index: " << getFleschKincaidIndex(syllableCount, wordCount, sentenceCount) << endl;

	}
}
