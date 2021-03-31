package newpackage;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;

public class UserDatabase {
    Connection con ;

    public UserDatabase(Connection con) {
        this.con = con;
    }

    //for register user
    public boolean saveUser(User user){
        boolean set = false;




        try{
            //Insert register data to database
            String query = "insert into users(first_name, last_name, email, mobile, student_id,password,gender, image, user_status, description) values(?,?,?,?,?,?,?,?,2,?)";

            FileInputStream fis=null;
            PreparedStatement pt = this.con.prepareStatement(query);
            pt.setString(1, user.getFirst_name());
            pt.setString(2, user.getLast_name());
            pt.setString(3, user.getEmail());
            pt.setString(4, user.getMobile());
            pt.setString(5, user.getStudentID());
            pt.setString(6, user.getPassword());
            pt.setString(7, user.getGender());
            pt.setBlob(8,user.getImage());
            pt.setString(9,user.getDescription());


            pt.executeUpdate();

            set = true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return set;
    }

    //user login with email and password
    public User login(String email, String pass){
        User usr=null;
        try{
            String query ="select * from users where email=? and password=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            if(rs.next()){ //set user attribute upon login
                usr = new User();
                usr.setId(rs.getInt("id"));
                usr.setFirst_name(rs.getString("first_name"));
                usr.setLast_name(rs.getString("last_name"));
                usr.setMobile(rs.getString("mobile"));
                usr.setStudentID(rs.getString("student_id"));
                usr.setGender(rs.getString("gender"));
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));
                usr.setUser_status(rs.getInt("user_status"));

            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return usr;
    }


    public User checkps(String pass){ //check password
        User usr=null;
        try{
            String query ="select * from users where password=?";
            PreparedStatement pst = this.con.prepareStatement(query);

            pst.setString(1, pass);

            ResultSet rs = pst.executeQuery();

            if(rs.next()){
                usr = new User();
                usr.setId(rs.getInt("id"));
                usr.setFirst_name(rs.getString("first_name"));
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));
                usr.setUser_status(rs.getInt("user_status"));

            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return usr;
    }

    public boolean edit_profile(User user){ //edit user profile
        boolean set = false;

        try{
            //Update user with new information input
            String query = "update users set first_name = ?,last_name= ?, email =?, mobile=?, student_id=?, password=?, gender=?, description=? where id = ?;";

            PreparedStatement pt = this.con.prepareStatement(query);
            pt.setString(1, user.getFirst_name());
            pt.setString(2, user.getLast_name());
            pt.setString(3, user.getEmail());
            pt.setString(4, user.getMobile());
            pt.setString(5, user.getStudentID());
            pt.setString(6, user.getPassword());
            pt.setString(7, user.getGender());
            pt.setString(8,user.getDescription());
            pt.setInt(9,user.getId());


            pt.executeUpdate();
            set = true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return set;
    }

    public boolean edit_profile_pic(User user){ //edit profile picture
        boolean set = false;

        try{
            //Update user-SQL
            String query = "update users set image=? where id = ?;";

            PreparedStatement pt = this.con.prepareStatement(query);
            pt.setBlob(1,user.getImage());
            pt.setInt(2,user.getId());


            pt.executeUpdate();
            set = true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return set;
    }

    public User login_ady(int uid){ //check user login
        User usr=null;
        try{
            String query ="select * from users where id=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, uid);

            ResultSet rs = pst.executeQuery();

            if(rs.next()){
                usr = new User();
                usr.setId(rs.getInt("id"));
                usr.setFirst_name(rs.getString("first_name"));
                usr.setLast_name(rs.getString("last_name"));
                usr.setMobile(rs.getString("mobile"));
                usr.setStudentID(rs.getString("student_id"));
                usr.setGender(rs.getString("gender"));
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));
                usr.setUser_status(rs.getInt("user_status"));

            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return usr;
    }



}
