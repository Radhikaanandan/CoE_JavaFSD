import java.util.List;

public class AccountantService {
    public static void addAccountant(Accountant accountant) {
        AccountantDao.addAccountant(accountant);
    }

    public static List<Accountant> getAllAccountants() {
        return AccountantDao.getAllAccountants();
    }

    public static void updateAccountant(Accountant accountant) {
        AccountantDao.updateAccountant(accountant);
    }

    public static void deleteAccountant(int id) {
        AccountantDao.deleteAccountant(id);
    }
}