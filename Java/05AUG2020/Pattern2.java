/*
 Display these patterns

A
B C
D E F
G H I J
K L M N O
 */

public class Pattern2 
{
	public static void main(String[] args) 
	{
		char count='A';
		for (char i = 'A'; i <= 'E'; i++) 
		{
			for (char j = 'A'; j <=i ; j++) 
			{
				System.out.print(count + " ");
				count++;
			}
			System.out.println();
		}
	}
}



/*
Output-
A
B C
D E F
G H I J
K L M N O
*/