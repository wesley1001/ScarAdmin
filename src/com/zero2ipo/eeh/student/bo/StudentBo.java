package com.zero2ipo.eeh.student.bo;

/**
 * 教学楼
 * Created by Administrator on 2016/2/24.
 */
public class StudentBo implements  java.io.Serializable {
   public int id;//主键
   public String gradeId;//所在年级
   public String classId;//班级主键
   public String name;//学生姓名
   public String xhnum;//学号
   public String sex;//性别
   public String password;//密码

    public String getGradeId() {
        return gradeId;
    }

    public void setGradeId(String gradeId) {
        this.gradeId = gradeId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getXhnum() {
        return xhnum;
    }

    public void setXhnum(String xhnum) {
        this.xhnum = xhnum;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
