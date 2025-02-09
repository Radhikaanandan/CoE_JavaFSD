import java.io.*;
import java.util.*;
class User {
    private String name;
    private String userID;
    private List<Book> borrowedBooks;
    public User(String name, String userID) {
        this.name = name;
        this.userID = userID;
        this.borrowedBooks = new ArrayList<>();
    }
    public String getName() { 
        return name; 
    }
    public String getUserID() { 
        return userID; 
    }
    public List<Book> getBorrowedBooks() { 
        return borrowedBooks; 
    }
}