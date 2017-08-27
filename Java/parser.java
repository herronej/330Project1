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
			for(int i = 1; i < nextStr.length(); i++){
						
			}
		}
	}

	public static int countSentenceMarkers(String nextStr){

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
						if(!isNum(item)){
							wordCount++;		
							syllableCount += countSyllables(item);
							sentenceCount += countSentenceMarkers(item);
						}
							//System.out.println(item);
					}

					//System.out.println(s);
					/*while (wordScanner.hasNext()) {
            					String s = wordScanner.next();
            					System.out.println(s);
        				}*/
    
				}
			//}
			System.out.println(wordCount);

			System.out.println("Flesch Readability Index: " + getFleschIndex(wordCount, syllableCount, sentenceCount));
			System.out.println("Flesch-Kincaid Grade Level Index: " + getFleschKincaidIndex(wordCount, syllableCount, sentenceCount));
		//}
	}
}
