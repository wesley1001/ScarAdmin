package com.zero2ipo.eeh.seat.bo;

/**
 * Created by Administrator on 2016/2/24.
 */
public class SeatBo implements  java.io.Serializable {
   public int id;//主键
   public int line;//行数
   public int column;//列数

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLine() {
        return line;
    }

    public void setLine(int line) {
        this.line = line;
    }

    public int getColumn() {
        return column;
    }

    public void setColumn(int column) {
        this.column = column;
    }
}
