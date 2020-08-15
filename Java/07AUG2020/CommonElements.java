
/*
 1:-Write a java program to find common elements between the two given arrays.
 Suppose given two arrays array1= {1,4,7, 9, 2} arrray2 = {1,7,3,4,5} the answer should be {1,4,7}

 */

import java.util.HashSet;

class CommonElements
{
    public static void main(String[] args)
    {
        Integer[] array1 = {1,4,7, 9, 2};
 
        Integer[] array2 = {1,7,3,4,5};
 
        HashSet<Integer> set = new HashSet<Integer>();
 
        for (int i = 0; i < array1.length; i++)
        {
            for (int j = 0; j < array2.length; j++)
            {
                if(array1[i].equals(array2[j]))
                {
                    set.add(array1[i]);
                }
            }
        }
 
        System.out.println(set);     //OUTPUT : [1, 4, 7]
    }
}