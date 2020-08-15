/*
Q. Can we make the user thread as daemon thread if the thread is started?
No, if you do so, it will throw IllegalThreadStateException. Therefore, we can only create a daemon thread before starting the thread.

*/

class Testdaemon1 extends Thread{    
public void run()
{  
          System.out.println("Running thread is daemon...");  
}  
public static void main (String[] args) {  
      Testdaemon1 td= new Testdaemon1();  
      td.start();  
      td.setDaemon(true);// It will throw the exception: td.   
   }  
}  