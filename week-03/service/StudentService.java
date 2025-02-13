import java.util.List;

public class StudentService {
    public static void addStudent(Student student) {
        StudentDao.addStudent(student);
    }

    public static List<Student> getAllStudents() {
        return StudentDao.getAllStudents();
    }

    public static void updateStudent(Student student) {
        StudentDao.updateStudent(student);
    }

    public static void deleteStudent(int id) {
        StudentDao.deleteStudent(id);
    }
}