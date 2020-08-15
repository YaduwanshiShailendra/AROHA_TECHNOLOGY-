import java.util.Collections;
import java.util.*;

public class CopyListDemo {

	public static void main(String[] args) {
		List <Integer>myFirstList = new ArrayList<Integer>();
		List <Integer> mySecondList = new ArrayList<Integer>();
		myFirstList.add(10);
		myFirstList.add(20);
		myFirstList.add(20);
		myFirstList.add(50);
		myFirstList.add(70);
	
		
		mySecondList.add(11);
		mySecondList.add(120);
		mySecondList.add(120);
		mySecondList.add(150);
		mySecondList.add(170);
		
		System.out.println("First List-"+ myFirstList);
		System.out.println("Second List-"+ mySecondList);
		Collections.copy(mySecondList, myFirstList );
		System.out.println("Second List After Copy-"+ mySecondList);
	}
}
