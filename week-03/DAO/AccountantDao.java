
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountantDao {
	public static void addAccountant(Accountant accountant) {
        String query = "INSERT INTO accountant (name, email, phone, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, accountant.getName());
            ps.setString(2, accountant.getEmail());
            ps.setString(3, accountant.getPhone());
            ps.setString(4, accountant.getPassword());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Accountant> getAllAccountants() {
        List<Accountant> accountants = new ArrayList<>();
        String query = "SELECT * FROM accountant";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accountant accountant = new Accountant();
                accountant.setId(rs.getInt("id"));
                accountant.setName(rs.getString("name"));
                accountant.setEmail(rs.getString("email"));
                accountant.setPhone(rs.getString("phone"));
                accountant.setPassword(rs.getString("password"));
                accountants.add(accountant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accountants;
    }
    public static void updateAccountant(Accountant accountant) {
        String query = "UPDATE accountant SET name = ?, email = ?, phone = ?, password = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, accountant.getName());
            ps.setString(2, accountant.getEmail());
            ps.setString(3, accountant.getPhone());
            ps.setString(4, accountant.getPassword());
            ps.setInt(5, accountant.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteAccountant(int id) {
        String query = "DELETE FROM accountant WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}



