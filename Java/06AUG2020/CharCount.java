import java.util.HashMap;
import java.util.Scanner;

public class CharCount
{
	public static void main(String[] args)
	{
		Scanner sc= new Scanner(System.in);
		System.out.print("Enter a string: ");
		String s= sc.nextLine();
//		String s = "Aroha Technology";

		HashMap<Character, Integer> charCountMap = new HashMap<Character, Integer>();

		//string to char array conversion
		char[] strArray = s.toCharArray();
		for (char c : strArray)
		{
			if(charCountMap.containsKey(c))
			{
				//if present charcountmap increment it by 1
				charCountMap.put(c, charCountMap.get(c)+1);
			}
			else
			{
				charCountMap.put(c, 1);
			}
		}
		System.out.println(s+" : ");
		System.out.println(charCountMap);
	}
}