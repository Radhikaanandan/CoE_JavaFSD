import java.io.*;
import java.util.*;
interface ILibrary {
    void borrowBook(String ISBN, String userID);
    void returnBook(String ISBN, String userID);
    void reserveBook(String ISBN, String userID);
    Book searchBook(String title);
}
