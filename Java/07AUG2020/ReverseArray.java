/*
4:-Reverse an int array in java
Input    : {3, 8, 5, 7, 4}
Output : {4, 7, 5, 8, 3}

Input     : {10, 54, 23, 89, 97, 2}
Output  : {2, 97, 89, 23, 54, 10}
*/

public class ReverseArray
{
    public static void main(String[] args) 
    {
        //Initialize array  
    	int [] array1 = new int [] {3, 8, 5, 7, 4};  
    	int [] array2 = new int [] {10, 54, 23, 89, 97, 2};  
        
    	revArray(array1);
    	revArray(array2);
    }

	private static void revArray(int array[]) 
	{
		System.out.println("Original array: ");  
        for (int i = 0; i < array.length; i++) 
        {
            System.out.print(array[i] + " ");  
        }
        System.out.println();  
        System.out.println("Array in reverse order: ");
        
        //logic for reverse array  
        for (int i = array.length-1; i >= 0; i--) 
        {  
            System.out.print(array[i] + " ");  
        }  
        System.out.println(); 		
	} 
    
}