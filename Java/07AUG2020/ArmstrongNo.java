/*
 2:-Write a java program for the Armstrong number. A number is called Armstrong number if it is equal to the sum of the cube of each digit.for example 371 is an Armstrong number because
371 = 27+343+1 which is equal to 3^3+7^3+1^3.

 */

class ArmstrongNo
{  
	public static void main(String[] args)  
	{  
		int c=0,a,temp;  
		int n=371; //It is the number to check armstrong  
		temp=n;  
		while(n>0)  
		{  
			a=n%10;  
			n=n/10;  
			c=c+(a*a*a);  
		}  
		if(temp==c)  
			System.out.println("Armstrong number");   
		else  
			System.out.println("Not armstrong number");   
	}  
}  