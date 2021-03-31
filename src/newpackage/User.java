package newpackage;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.Part;
import java.io.File;
import java.io.InputStream;

//user class-container

public class User {
    int id;
    String first_name;
    String last_name;
    String mobile;
    String studentID;
    String email;
    String password;
    String gender;
    InputStream image;
    int user_status;
    String description;


    public User() {
    }

    public User(int id, InputStream image)
    {
        this.id=id;
        this.image=image;
    }

    public User(int id, String first_name, String last_name, String mobile, String studentID, String email, String password, String gender, String description) {
        this.id = id;
        this.first_name = first_name;
        this.last_name=last_name;
        this.mobile=mobile;
        this.studentID=studentID;
        this.email = email;
        this.password = password;
        this.gender=gender;
        this.description=description;


    }

    public User(String first_name, String last_name, String email, String mobile, String studentID, String password, String gender,InputStream image,String description) {
        this.first_name = first_name;
        this.last_name=last_name;
        this.email = email;
        this.mobile=mobile;
        this.studentID=studentID;
        this.password = password;
        this.gender=gender;
        this.image=image;
        this.description=description;


    }

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public User(String password) {

        this.password = password;
    }

    //getter and setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender= gender;
    }

    public InputStream getImage() {
        return image;
    }

    public void setImage(InputStream image) {
        this.image= image;
    }


    public int getUser_status() {
        return user_status;
    }
    public void setUser_status(int user_status){
        this.user_status = user_status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
