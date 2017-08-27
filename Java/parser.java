import java.util.*;
import java.io.*;


class parser{
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
    
    				while (lineScanner.hasNextLine()) {
            				Scanner wordScanner = new Scanner(lineScanner.nextLine());
        				while (wordScanner.hasNext()) {
            					String s = wordScanner.next();
            					System.out.println(s);
        				}
    
				}
			//}
		//}
	}
}
