import java.util.Scanner;

public class PrimeNoRange 
{
	public static void main(String[] args) 
	{
		Scanner sc= new Scanner(System.in);
		System.out.println("Please give the range for prime no.");
		System.out.println("Enter first no.: ");
		Integer a= sc.nextInt();
		System.out.println("Enter second no.: ");
		Integer b= sc.nextInt();
//		int a = 10 , b = 100;
		while (a < b) 
		{
			boolean flag = false;
			for(int i = 2; i <= a/2; ++i) 
			{
				// condition for non-prime number
				if(a % i == 0) 
				{
					flag = true;
					break;
				}
			}
			if (!flag)
				System.out.print(a + " ");
			++a;
		}
	}
}
