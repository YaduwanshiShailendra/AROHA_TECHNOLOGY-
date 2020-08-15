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
import java.util.LinkedList;
import java.util.ListIterator;

public class LinkListProgram {

	public static void main(String[] args) {
		
		LinkedList<Integer> list = new LinkedList<Integer>();
		
		for (int i = 1; i <= 500; i++) 
		{
			list.add((int) (Math.random() * 10000));		
		}

		/*		
		Method 1 (by using iterator)
		ListIterator<Integer> litr = list.listIterator();		
		while(litr.hasNext())
		{
			Integer lst = litr.next();
			System.out.println(lst);
		}
 		
 		*/
		
		System.out.println("Befor sorting");

		//		Method 2 
		for(Integer I:list)
		{
			System.out.print(I + " ");
		}

		
		System.out.println();
		System.out.println();
		System.out.println("After sorting");
		Collections.sort(list);
		for(Integer I:list)
		{
			System.out.print(I + " ");
		}

		System.out.println();
		System.out.println();
		System.out.println("Highest value is '" + Collections.max(list) + "'");

		System.out.println();
		System.out.println("Lowest value is '" + Collections.min(list) + "'");
		
		System.out.println();
		System.out.println("Divisible by '10' and '12'");
		// checking divisible by 10 and 12
		for(Integer I:list)
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
		for(Integer I:list)
		{
			if (I%8!=0 && I%9!=0) 
			{
				System.out.print(I + " ");
			}
		}
		
		
	}

}

