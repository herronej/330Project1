import java.util.*;
import java.io.*;


class parser{

	public static boolean isNum(String nextStr){
		try{
			double d = Double.parseDouble(nextStr);
		}
		catch(NumberFormatException e){
			return false;
		}
	
		return true;
	}

	public static boolean isVowel(char c){
		if(c == 'a' | c == 'e' | c ==  'i' | c == 'o' | c == 'u' | c =='y' )
			return true;
		return false;
	}

	public static int countSyllables(String nextStr){
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
				if(isVowel(c) && !isVowel(prev) && !(i  == nextStr.length()-1 && c == 'e')){
					syllableCount++;
				}
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
		int sentenceMarkCount = 0;
		for(int i = 0; i < nextStr.length(); i++){
			char c = nextStr.charAt(i);
			if(c == '.' || c == ':' || c == ';' || c == '?' || c == '!')
				sentenceMarkCount++;
		}
		return sentenceMarkCount;
        }

	public static double getFleschIndex(int wordCount, int syllableCount, int sentenceCount){
		double alpha = (double)(syllableCount)/(double)(wordCount);
		double beta = (double)wordCount / (double)(sentenceCount);
		double index = 206.835 - alpha*84.6 - beta*1.015;
		
		return index;
	}

	public static double getFleschKincaidIndex(int wordCount, int syllableCount, int sentenceCount){
                double alpha = (double)(syllableCount)/(double)(wordCount);
                double beta = (double)wordCount / (double)(sentenceCount);
		double index = alpha*11.8 + beta*0.39 - 15.59;
		
		return index;
        }


	public static void main(String[] args) throws FileNotFoundException{
		//File translationDir = new File("../translations");
		//File[] translations = translationDir.listFiles();
		
		//for(File translation : translations){
			//if(translation.isFile()){
				//System.out.println(translation.getName());
				Scanner lineScanner = null;
				System.out.println(args[0]);
				try {
					System.out.println(args[0]);
        				lineScanner = new Scanner(new File(args[0]));
    				} catch (FileNotFoundException e) {
        				e.printStackTrace();  
    				}
				//Scanner lineScanner = new Scanner(translation);
				
				int wordCount = 0;    
				int syllableCount = 0;
				int sentenceCount = 0;

    				while (lineScanner.hasNextLine()) {
            				//Scanner wordScanner = new Scanner(lineScanner.nextLine());
        				String line = lineScanner.nextLine();
					String[] splitLine = line.split("\\s+");
					for(String item: splitLine){
						item = item.toLowerCase();
						if(!isNum(item) && !(item).equals("")){
							System.out.println(item);
							wordCount++;		
							syllableCount += countSyllables(item);
							System.out.println(countSyllables(item));
							sentenceCount += countSentenceMarkers(item);
						}
							//System.out.println(item);
					}
    
				}
			
			System.out.println(wordCount);
			System.out.println(syllableCount);
			System.out.println(sentenceCount);
			System.out.println("Flesch Readability Index: " + getFleschIndex(wordCount, syllableCount, sentenceCount));
			System.out.println("Flesch-Kincaid Grade Level Index: " + getFleschKincaidIndex(wordCount, syllableCount, sentenceCount));
		
	}
}
