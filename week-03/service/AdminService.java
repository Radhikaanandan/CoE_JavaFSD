
public class AdminService {
	public static boolean login(String username, String password) {
        return AdminDao.validate(username, password);
    }


}
