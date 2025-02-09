import java.io.*;
import java.util.*;
class LibraryManager extends LibrarySystem {
    public void addBook(Book book) {
        books.add(book);
    }

    public void addUser(User user) {
        users.add(user);
    }
    public void borrowBook(String ISBN, String userID) {
        for (Book book : books) {
            if (book.getISBN().equals(ISBN) && !book.isBorrowed()) {
                for (User user : users) {
                    if (user.getUserID().equals(userID)) {
                        book.borrowBook();
                        user.getBorrowedBooks().add(book);
                        System.out.println(user.getName() + " borrowed " + book.getTitle());
                        return;
                    }
                }
            }
        }
        System.out.println("Book or User not found, or Book is already borrowed.");
    }

    public void returnBook(String ISBN, String userID) {
        for (User user : users) {
            if (user.getUserID().equals(userID)) {
                for (Book book : user.getBorrowedBooks()) {
                    if (book.getISBN().equals(ISBN)) {
                        book.returnBook();
                        user.getBorrowedBooks().remove(book);
                        System.out.println(user.getName() + " returned " + book.getTitle());
                        return;
                    }
                }
            }
        }
        System.out.println("Book or User not found.");
    }
    public void reserveBook(String ISBN, String userID) {
        System.out.println("Book reservation feature is under development.");
    }
    public Book searchBook(String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null;
    }
}