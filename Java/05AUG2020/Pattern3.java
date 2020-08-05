/*
Display these patterns

15 14 13 12
11 10 9
8 7
6
*/

public class Pattern3 
{
	public static void main(String[] args) 
	{
		int count=15;
		for (int i = 5; i >= 1; i--) 
		{
			for (int j = 1; j <=i-1 ; j++) 
			{
				System.out.print(count + " ");
				count--;
			}
			System.out.println();
		}
	}
}



/*
Output-
15 14 13 12
11 10 9
8 7
6
*/