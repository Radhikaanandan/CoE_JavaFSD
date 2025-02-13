import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("1. Admin Login\n2. Accountant Login\n3. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            if (choice == 1) {
                System.out.print("Enter username: ");
                String username = scanner.nextLine();
                System.out.print("Enter password: ");
                String password = scanner.nextLine();
                if (AdminService.login(username, password)) {
                    System.out.println("Admin logged in successfully!");
                    adminMenu(scanner);
                } else {
                    System.out.println("Invalid credentials!");
                }
            } else if (choice == 2) {
                System.out.print("Enter email: ");
                String email = scanner.nextLine();
                System.out.print("Enter password: ");
                String password = scanner.nextLine();
            
                System.out.println("Accountant logged in successfully!");
                accountantMenu(scanner);
            } else if (choice == 3) {
                System.out.println("Exiting...");
                break;
            } else {
                System.out.println("Invalid choice!");
            }
        }
        scanner.close();
    }

    private static void adminMenu(Scanner scanner) {
        while (true) {
            System.out.println("\nAdmin Menu:");
            System.out.println("1. Add Accountant");
            System.out.println("2. View Accountants");
            System.out.println("3. Edit Accountant");
            System.out.println("4. Delete Accountant");
            System.out.println("5. Logout");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); 

            if (choice == 1) {
                System.out.print("Enter name: ");
                String name = scanner.nextLine();
                System.out.print("Enter email: ");
                String email = scanner.nextLine();
                System.out.print("Enter phone: ");
                String phone = scanner.nextLine();
                System.out.print("Enter password: ");
                String password = scanner.nextLine();
                Accountant accountant = new Accountant();
                accountant.setName(name);
                accountant.setEmail(email);
                accountant.setPhone(phone);
                accountant.setPassword(password);
                AccountantService.addAccountant(accountant);
                System.out.println("Accountant added successfully!");
            } else if (choice == 2) {
                List<Accountant> accountants = AccountantService.getAllAccountants();
                for (Accountant accountant : accountants) {
                    System.out.println("ID: " + accountant.getId() + ", Name: " + accountant.getName() +
                            ", Email: " + accountant.getEmail() + ", Phone: " + accountant.getPhone());
                }
            } else if (choice == 3) {
                System.out.print("Enter accountant ID to edit: ");
                int id = scanner.nextInt();
                scanner.nextLine(); 
                System.out.print("Enter new name: ");
                String name = scanner.nextLine();
                System.out.print("Enter new email: ");
                String email = scanner.nextLine();
                System.out.print("Enter new phone: ");
                String phone = scanner.nextLine();
                System.out.print("Enter new password: ");
                String password = scanner.nextLine();
                Accountant accountant = new Accountant();
                accountant.setId(id);
                accountant.setName(name);
                accountant.setEmail(email);
                accountant.setPhone(phone);
                accountant.setPassword(password);
                AccountantService.updateAccountant(accountant);
                System.out.println("Accountant updated successfully!");
            } else if (choice == 4) {
                System.out.print("Enter accountant ID to delete: ");
                int id = scanner.nextInt();
                scanner.nextLine(); 
                AccountantService.deleteAccountant(id);
                System.out.println("Accountant deleted successfully!");
            } else if (choice == 5) {
                System.out.println("Logged out successfully!");
                break;
            } else {
                System.out.println("Invalid choice!");
            }
        }
    }

    private static void accountantMenu(Scanner scanner) {
        while (true) {
            System.out.println("\nAccountant Menu:");
            System.out.println("1. Add Student");
            System.out.println("2. View Students");
            System.out.println("3. Edit Student");
            System.out.println("4. Delete Student");
            System.out.println("5. Check Due Fees");
            System.out.println("6. Logout");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); 

            if (choice == 1) {
                System.out.print("Enter name: ");
                String name = scanner.nextLine();
                System.out.print("Enter email: ");
                String email = scanner.nextLine();
                System.out.print("Enter course: ");
                String course = scanner.nextLine();
                System.out.print("Enter fee: ");
                double fee = scanner.nextDouble();
                System.out.print("Enter paid amount: ");
                double paid = scanner.nextDouble();
                System.out.print("Enter due amount: ");
                double due = scanner.nextDouble();
                scanner.nextLine(); 
                System.out.print("Enter address: ");
                String address = scanner.nextLine();
                System.out.print("Enter phone: ");
                String phone = scanner.nextLine();
                Student student = new Student();
                student.setName(name);
                student.setEmail(email);
                student.setCourse(course);
                student.setFee(fee);
                student.setPaid(paid);
                student.setDue(due);
                student.setAddress(address);
                student.setPhone(phone);
                StudentService.addStudent(student);
                System.out.println("Student added successfully!");
            } else if (choice == 2) {
                List<Student> students = StudentService.getAllStudents();
                for (Student student : students) {
                    System.out.println("ID: " + student.getId() + ", Name: " + student.getName() +
                            ", Email: " + student.getEmail() + ", Course: " + student.getCourse() +
                            ", Fee: " + student.getFee() + ", Paid: " + student.getPaid() +
                            ", Due: " + student.getDue() + ", Address: " + student.getAddress() +
                            ", Phone: " + student.getPhone());
                }
            } else if (choice == 3) {
                System.out.print("Enter student ID to edit: ");
                int id = scanner.nextInt();
                scanner.nextLine(); 
                System.out.print("Enter new name: ");
                String name = scanner.nextLine();
                System.out.print("Enter new email: ");
                String email = scanner.nextLine();
                System.out.print("Enter new course: ");
                String course = scanner.nextLine();
                System.out.print("Enter new fee: ");
                double fee = scanner.nextDouble();
                System.out.print("Enter new paid amount: ");
                double paid = scanner.nextDouble();
                System.out.print("Enter new due amount: ");
                double due = scanner.nextDouble();
                scanner.nextLine(); 
                System.out.print("Enter new address: ");
                String address = scanner.nextLine();
                System.out.print("Enter new phone: ");
                String phone = scanner.nextLine();
                Student student = new Student();
                student.setId(id);
                student.setName(name);
                student.setEmail(email);
                student.setCourse(course);
                student.setFee(fee);
                student.setPaid(paid);
                student.setDue(due);
                student.setAddress(address);
                student.setPhone(phone);
                StudentService.updateStudent(student);
                System.out.println("Student updated successfully!");
            } else if (choice == 4) {
                System.out.print("Enter student ID to delete: ");
                int id = scanner.nextInt();
                scanner.nextLine(); 
                StudentService.deleteStudent(id);
                System.out.println("Student deleted successfully!");
            } else if (choice == 5) {
                List<Student> students = StudentService.getAllStudents();
                System.out.println("Students with Due Fees:");
                for (Student student : students) {
                    if (student.getDue() > 0) {
                        System.out.println("ID: " + student.getId() + ", Name: " + student.getName() +
                                ", Due: " + student.getDue());
                    }
                }
            } else if (choice == 6) {
                System.out.println("Logged out successfully!");
                break;
            } else {
                System.out.println("Invalid choice!");
            }
        }
    }
}