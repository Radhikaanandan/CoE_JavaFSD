import java.io.*;
import java.util.*;
class Main {
    public static void main(String[] args) {
        LibraryManager libManager = new LibraryManager();
        Scanner scanner = new Scanner(System.in);
        libManager.addBook(new Book("Java Programming", "Author A", "12345"));
        libManager.addBook(new Book("Data Structures", "Author B", "67890"));
        libManager.addUser(new User("Alice", "U1"));
        libManager.addUser(new User("Bob", "U2"));
        while (true) {
            System.out.println("\nLibrary System Menu:");
            System.out.println("1. Borrow Book");
            System.out.println("2. Return Book");
            System.out.println("3. Search Book");
            System.out.println("4. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            if (choice == 1) {
                System.out.print("Enter ISBN of the book: ");
                String isbn = scanner.nextLine();
                System.out.print("Enter User ID: ");
                String userId = scanner.nextLine();
                libManager.borrowBook(isbn, userId);
            } else if (choice == 2) {
                System.out.print("Enter ISBN of the book: ");
                String isbn = scanner.nextLine();
                System.out.print("Enter User ID: ");
                String userId = scanner.nextLine();
                libManager.returnBook(isbn, userId);
            } else if (choice == 3) {
                System.out.print("Enter book title: ");
                String title = scanner.nextLine();
                Book book = libManager.searchBook(title);
                if (book != null) {
                    System.out.println("Book found: " + book);
                } else {
                    System.out.println("Book not found.");
                }
            } else if (choice == 4) {
                System.out.println("Exiting... Goodbye!");
                break;
            } else {
                System.out.println("Invalid choice. Try again.");
            }
        }
        scanner.close();
    }
}