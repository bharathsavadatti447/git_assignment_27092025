package org.jacoco.examples.maven.java;

public class HelloWorld {

    /**
     * Returns a greeting message.
     *
     * @param bigger if true, returns "Hello Universe!", else "Hello World!"
     * @return the greeting message
     */
    public String getMessage(boolean bigger) {
        return bigger ? "Hello Universe!" : "Hello World!";
    }

    // Optional: simple main method to test the class
    public static void main(String[] args) {
        HelloWorld hello = new HelloWorld();
        System.out.println(hello.getMessage(false)); // prints "Hello World!"
        System.out.println(hello.getMessage(true));  // prints "Hello Universe!"
    }
}
