/*
 Using collection and Math.random() * 10000 , multiply by 10000 so that the number decimal is shifted by 5 decimal place.
Generate about 500 numbers store it in LinkedList

Sort the linked list

Find the highest , lowest

Find how many are divisible by 10 and 12

Find how many are not divisible by 8 as well as 9

Do the same program using the HashSet
 
 */

import java.util.Collections;
import java.util.HashSet;
import java.util.TreeSet;

public class HashSetProgram {

	public static void main(String[] args) {
		HashSet<Integer> set = new HashSet<Integer>();
		for (int i = 1; i <= 500; i++) 
		{
			set.add((int) (Math.random() * 10000));		
		}

		System.out.println("Befor sorting");

		//		iterating elements of sets 
		for(Integer I:set)
		{
			System.out.print(I + " ");
		}
		
		System.out.println();
		System.out.println();
		System.out.println("After sorting");
		
		// sorting by using treeset
		TreeSet<Integer> treeset = new TreeSet<Integer>(set);
		
		
		for(Integer I:treeset)
		{
			System.out.print(I + " ");
		}
		

		System.out.println();
		System.out.println();
		System.out.println("Highest value is '" + Collections.max(treeset) + "'");

		System.out.println();
		System.out.println("Lowest value is '" + Collections.min(treeset) + "'");
		
		System.out.println();
		System.out.println("Divisible by '10' and '12'");
		// checking divisible by 10 and 12
		for(Integer I:treeset)
		{
			if (I%10==0 && I%12==0) 
			{
				System.out.print(I + " ");
			}
		}

		System.out.println();
		System.out.println();
		System.out.println("Not divisible by '8' as well as '9'");
		// checking not divisible by 8 as well as 9
		for(Integer I:treeset)
		{
			if (I%8!=0 && I%9!=0) 
			{
				System.out.print(I + " ");
			}
		}
		
	}

}
