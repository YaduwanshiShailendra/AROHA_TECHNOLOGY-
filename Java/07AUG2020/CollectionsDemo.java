import java.util.Collections;
import java.util.ArrayList;
import java.util.List;

public class CollectionsDemo {

	public static void main(String[] args) {
		List<String>studentList = new ArrayList();
		studentList.add("Neeraj");
		studentList.add("Mahesh");
		studentList.add("Armaan");
		studentList.add("Preeti");
		studentList.add("Sanjay");
		studentList.add("Neeraj");
		studentList.add("Zahir");

		System.out.println("Original List " + studentList);

		Collections.sort(studentList);
		System.out.println("Sorted alphabetically List " + studentList);

		Collections.reverse(studentList);
		System.out.println("Reverse List " + studentList);
		Collections.shuffle(studentList);
		System.out.println("Shuffled List " + studentList);
		System.out.println("Checking occurance of Neeraj: "
				+ Collections.frequency(studentList, "Neeraj"));
	}
}
