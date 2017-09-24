import java.util.*;
import java.io.*;

class parser{

    public static int periods = 0;
    public static int colons = 0;
    public static int semicolons = 0;
    public static int questions = 0;
    public static int exclamations = 0;

    public static boolean isNum(String s){
        // checks that string is 100% numeric
        for(int i = 0; i < s.length(); i++){
            if(!Character.isDigit(s.charAt(i)))
                return false;
        }
            return true;
    }

    public static boolean isVowel(char c){
        // checks that char is vowel
        if(c == 'a' | c == 'e' | c ==  'i' | c == 'o' | c == 'u' | c =='y' )
			return true;
	    return false;
    }

	public static int countSyllables(String nextStr){

        //counts syllables in string

        // base cases
		if(nextStr.length() == 0)
			return 0;
		else if(nextStr.length() == 1){
			if(isVowel(nextStr.charAt(0)))
				return 1;		
		}
		else{
			int syllableCount = 0;
			char prev = nextStr.charAt(0);
			if(isVowel(prev)){
				syllableCount++;
			}
			for(int i = 1; i < nextStr.length(); i++){
				char c = nextStr.charAt(i);
                // counts syllables excluding silent e
				if(isVowel(c) && !isVowel(prev) && !(i  == nextStr.length()-1 && c == 'e')){
					syllableCount++;
				}
                // count special case non-silent e
				else if(i  == nextStr.length()-1 && c == 'e'){
					if(syllableCount == 0)
						syllableCount++;
				}
				prev = c;			
			}
			return syllableCount;
		}
		return 0;
    }

	public static int countSentenceMarkers(String nextStr){
	
        // counts sentence punctuation

    	int sentenceMarkCount = 0;
		for(int i = 0; i < nextStr.length(); i++){
			char c = nextStr.charAt(i);
			if(c == '.' || c == ':' || c == ';' || c == '?' || c == '!'){
             /*                   if(c == '.')
                                        periods++;
                                if(c == ':')
                                        colons++;
                                if(c == ';')
                                        semicolons++;
                                if(c == '?')
                                        questions++;
                                if(c == '!')
                                        exclamations++;
*/
                sentenceMarkCount++;
             }
		}
		return sentenceMarkCount;
        }

	public static double getFleschIndex(int wordCount, int syllableCount, int sentenceCount){
	
        // calculates Flesch Index    
	
		double alpha = (double)(syllableCount)/(double)(wordCount);
		double beta = (double)wordCount / (double)(sentenceCount);
		double index = 206.835 - alpha*84.6 - beta*1.015;
	
		return index;
	}

	public static double getFleschKincaidIndex(int wordCount, int syllableCount, int sentenceCount){

        // calculates Flesch Kincaid Index

        double alpha = (double)(syllableCount)/(double)(wordCount);
        double beta = (double)wordCount / (double)(sentenceCount);
		double index = alpha*11.8 + beta*0.39 - 15.59;
		return index;
    }


	public static void main(String[] args) throws FileNotFoundException{
		Scanner lineScanner = null;
				
		try {
        	lineScanner = new Scanner(new File(args[0]));
    	} catch (FileNotFoundException e) {
        	e.printStackTrace();  
    	}
				
		int wordCount = 0;    
		int syllableCount = 0;
		int sentenceCount = 0;

    	while (lineScanner.hasNextLine()) {
        	String line = lineScanner.nextLine();
			String[] splitLine = line.split("\\s+");
			for(String item: splitLine){
				if(!isNum(item) && !(item).equals("")){
					item = item.toLowerCase();
					wordCount++;
					syllableCount += countSyllables(item.replaceAll("[^a-zA-Z ]", ""));
					sentenceCount += countSentenceMarkers(item);
				}
			}
    
		}
		//sentenceCount = periods + colons + semicolons + questions + exclamations;
		System.out.println("Flesch Readability Index: " + getFleschIndex(wordCount, syllableCount, sentenceCount));
		System.out.println("Flesch-Kincaid Grade Level Index: " + getFleschKincaidIndex(wordCount, syllableCount, sentenceCount));
		
	}
}
