package com.zero2ipo.eeh.course.bo;

/**
 * Created by Administrator on 2016/2/24.
 */
public class CourseBo implements  java.io.Serializable {
    public int id;//主键
    public String kemu;//科目名称
    public String cengci;//层次
    public String peopleMax;//上线人数
    public String grade;//年级
    public String banji;//班级
    public String teacher;//授课老师
    public String startTime;//开始时间
    public String endTime;//结束时间
    public String schoolTime;//上课时间
    public String classRoom;//授课教室

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKemu() {
        return kemu;
    }

    public void setKemu(String kemu) {
        this.kemu = kemu;
    }

    public String getCengci() {
        return cengci;
    }

    public void setCengci(String cengci) {
        this.cengci = cengci;
    }

    public String getPeopleMax() {
        return peopleMax;
    }

    public void setPeopleMax(String peopleMax) {
        this.peopleMax = peopleMax;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getBanji() {
        return banji;
    }

    public void setBanji(String banji) {
        this.banji = banji;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getSchoolTime() {
        return schoolTime;
    }

    public void setSchoolTime(String schoolTime) {
        this.schoolTime = schoolTime;
    }

    public String getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }
}
