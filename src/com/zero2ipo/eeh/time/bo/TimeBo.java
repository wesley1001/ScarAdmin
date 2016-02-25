package com.zero2ipo.eeh.time.bo;

/**
 * 教师
 * Created by Administrator on 2016/2/24.
 */
public class TimeBo implements  java.io.Serializable {
    public int id;//主键
    public String name;//时段名称
    public String startTime;//时段区间开始时间
    public String endTime;//时段区间结束时间

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
}
