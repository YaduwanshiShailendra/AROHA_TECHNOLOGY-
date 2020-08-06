import java.util.Scanner;

public class CountVowel 
{    
    public static void main(String[] args) 
    {   
    	Scanner sc= new Scanner(System.in);
		System.out.print("Enter a string: ");
		String str= sc.nextLine();
//        String str = "Aroha Technology";    
        int Count = 0;    
        str = str.toLowerCase();    
        for(int i = 0; i < str.length(); i++) {    
            //logic for vowel    
            if(str.charAt(i) == 'a' || str.charAt(i) == 'e' || str.charAt(i) == 'i' || str.charAt(i) == 'o' || str.charAt(i) == 'u') 
            {    
                Count++;    
            }    
        }    
        System.out.println("Number of vowels are '" + Count +"'.");    
    }    
}  