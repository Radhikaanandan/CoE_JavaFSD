import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.PriorityBlockingQueue;
class InventoryManager {
    private ConcurrentHashMap<String, Product> products;
    private PriorityBlockingQueue<Order> orderQueue;

    public InventoryManager() {
        products = new ConcurrentHashMap<>();
        orderQueue = new PriorityBlockingQueue<>(10, new OrderComparator());
    }
    public synchronized void addProduct(Product product) {
        products.put(product.getProductID(), product);
        System.out.println("Product added: " + product.getName());
    }
    public synchronized void updateStock(String productID, int quantity) throws OutOfStockException, InvalidLocationException {
        Product product = products.get(productID);
        if (product == null) {
            throw new InvalidLocationException("Product not found: " + productID);
        }
        if (product.getQuantity() + quantity < 0) {
            throw new OutOfStockException("Insufficient stock for product: " + productID);
        }
        product.setQuantity(product.getQuantity() + quantity);
        System.out.println("Stock updated for product: " + productID + ", New quantity: " + product.getQuantity());
    }
    public void addOrder(Order order) {
        orderQueue.add(order);
        System.out.println("Order added: " + order.getOrderID());
    }
    public void processOrders() {
        while (!orderQueue.isEmpty()) {
            Order order = orderQueue.poll();
            new Thread(() -> fulfillOrder(order)).start();
        }
    }
    private void fulfillOrder(Order order) {
        try {
            for (String productID : order.getProductIDs()) {
                updateStock(productID, -1); // Deduct one unit per product
            }
            System.out.println("Order fulfilled: " + order.getOrderID());
        } catch (OutOfStockException | InvalidLocationException e) {
            System.err.println("Error processing order " + order.getOrderID() + ": " + e.getMessage());
        }
    }
    public void viewInventory() {
        System.out.println("\n--- Current Inventory ---");
        for (Product product : products.values()) {
            System.out.println("Product ID: " + product.getProductID() +
                    ", Name: " + product.getName() +
                    ", Quantity: " + product.getQuantity() +
                    ", Location: " + product.getLocation());
        }
    }
}