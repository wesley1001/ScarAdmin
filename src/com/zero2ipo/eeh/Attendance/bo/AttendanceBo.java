package com.zero2ipo.eeh.Attendance.bo;

/**
 * 教师
 * Created by Administrator on 2016/2/24.
 */
public class AttendanceBo implements  java.io.Serializable {
    public int id;//主键
    public String className;//班级
    public String name;//姓名
    public String xuehao;//学号
    public String sex;//性别
    public String xuanxiuCourse;//选修课程
    public String classRoom;//上课教师
    public String seatNum;//座位号
    public String schoolTime;//上课时间
    public String type;//类型 迟到，请假，早退，缺勤

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getXuehao() {
        return xuehao;
    }

    public void setXuehao(String xuehao) {
        this.xuehao = xuehao;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getXuanxiuCourse() {
        return xuanxiuCourse;
    }

    public void setXuanxiuCourse(String xuanxiuCourse) {
        this.xuanxiuCourse = xuanxiuCourse;
    }

    public String getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }

    public String getSeatNum() {
        return seatNum;
    }

    public void setSeatNum(String seatNum) {
        this.seatNum = seatNum;
    }

    public String getSchoolTime() {
        return schoolTime;
    }

    public void setSchoolTime(String schoolTime) {
        this.schoolTime = schoolTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
