package com.zero2ipo.eeh.classroom.bo;

/**
 * 教学楼
 * Created by Administrator on 2016/2/24.
 */
public class ClassRoomBo implements  java.io.Serializable {
   public int id;//主键
   public  String tbId;//所在教学楼id
   public  String  classId;//所在班级id
   public String name;//教室名称
   public int floors;//楼层

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTbId() {
        return tbId;
    }

    public void setTbId(String tbId) {
        this.tbId = tbId;
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

    public int getFloors() {
        return floors;
    }

    public void setFloors(int floors) {
        this.floors = floors;
    }
}
