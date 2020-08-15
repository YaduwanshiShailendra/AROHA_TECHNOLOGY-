public class Multithread1 extends Thread  
{  
   public void run()  
    {  
      try {  
          System.out.println("thread is executing now........");  
      } catch(Exception e) {  
      }   
    }  
    public static void main (String[] args) {  
        Multithread1 m1= new Multithread1();  
        m1.start();  
        m1.start();  
    }  
}