import java.util.*;
public class WarehouseApp {
    public static void main(String[] args) {
        InventoryManager inventoryManager = new InventoryManager();
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("\n--- Warehouse Inventory Management System ---");
            System.out.println("1. Add Product");
            System.out.println("2. Place Order");
            System.out.println("3. Process Orders");
            System.out.println("4. View Inventory");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            int choice = sc.nextInt();
            switch (choice) {
                case 1:
                    addProductFromUserInput(inventoryManager, scanner);
                    break;
                case 2:
                    placeOrderFromUserInput(inventoryManager, scanner);
                    break;
                case 3:
                    inventoryManager.processOrders();
                    break;
                case 4:
                    inventoryManager.viewInventory();
                    break;
                case 5:
                    System.out.println("Exiting the system. Goodbye!");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
    private static void addProductFromUserInput(InventoryManager inventoryManager, Scanner scanner) {
        System.out.print("Enter Product ID: ");
        String productID = sc.next();
        System.out.print("Enter Product Name: ");
        String name = sc.next();
        System.out.print("Enter Quantity: ");
        int quantity = sc.nextInt();
        System.out.print("Enter Aisle: ");
        int aisle = sc.nextInt();
        System.out.print("Enter Shelf: ");
        int shelf = sc.nextInt();
        System.out.print("Enter Bin: ");
        int bin = scanner.nextInt();
        scanner.next(); // Consume newline

        Location location = new Location(aisle, shelf, bin);
        Product product = new Product(productID, name, quantity, location);
        inventoryManager.addProduct(product);
    }

    private static void placeOrderFromUserInput(InventoryManager inventoryManager, Scanner scanner) {
        System.out.print("Enter Order ID: ");
        String orderID = sc.next();
        System.out.print("Enter Product IDs (comma-separated): ");
        String productIDsInput = sc.next();
        List<String> productIDs = Arrays.asList(productIDsInput.split(","));
        System.out.print("Enter Priority (1 for STANDARD, 2 for EXPEDITED): ");
        int priorityChoice = sc.nextInt();
        scanner.next(); 

        Order.Priority priority = (priorityChoice == 2) ? Order.Priority.EXPEDITED : Order.Priority.STANDARD;
        Order order = new Order(orderID, productIDs, priority);
        inventoryManager.addOrder(order);
    }
}