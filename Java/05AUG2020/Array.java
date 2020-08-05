/*
 * Use this array int a[] = {89,56,155,6,125,900,4501,22,188,200,2,275,500,520,999};  // If you want you can put more numbers
 * Process the array and find out the highest , lowest number, sum all the numbers and find the avg.
 * Using the built in method in Java sort the array
 */

import java.util.Arrays;

public class Array {
	public static void main (String [] args) {
		int [] array = {89,56,155,6,125,900,4501,22,188,200,2,275,500,520,999};

		System.out.print("Entered Array: ");
		// calling disp() method
		disp(array);		
		System.out.println();		

		Arrays.sort(array); // sorting array in increasing order
		System.out.print("After sorting array: ");
		// calling disp() method
		disp(array);		
		
		// calling disp() method
		disp(array);		
		System.out.println("");
		System.out.println("Highest No. : "+ array[array.length-1]);
		System.out.println("Lowest No. : "+ array[0]);
		System.out.println("Sum of No. : "+ sum(array)); 	// calling sum() method
		System.out.println("Avg of No. : "+ sum(array)/(array.length));
		
	}

	
	// method for display elements in an array
	static void disp(int[] array) {
		// condition for iterate array
		for (int i = 0; i < array.length; i++) {
			System.out.print(array[i] + " ");
		}
	}


	// method for sum of elements in an array  
    static int sum(int array[]) 
    { 
        int sum = 0; // initialize sum 
        int i; 
       
        // Iterate through all elements and add them to sum 
        for (i = 0; i < array.length; i++) 
           sum +=  array[i]; 
       
        return sum; 
    } 
}