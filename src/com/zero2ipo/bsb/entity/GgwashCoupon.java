package com.zero2ipo.bsb.entity;

   /**
    * ggwashCoupon 实体类
    * Sat Oct 17 22:03:23 CST 2015 郑云飞
    */ 


public class GgwashCoupon{
	private int id;
	private String name;
	private float price;
	private float oprice;
	private String status;
	private String number;
	private String info;
	private String createTime;
	private String pic;

	   public String getPic() {
		   return pic;
	   }

	   public void setPic(String pic) {
		   this.pic = pic;
	   }

	   public String getInfo() {
		   return info;
	   }

	   public void setInfo(String info) {
		   this.info = info;
	   }

	   public String getCreateTime() {
		   return createTime;
	   }

	   public void setCreateTime(String createTime) {
		   this.createTime = createTime;
	   }

	   public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public void setId(int id){
	this.id=id;
	}
	public int getId(){
		return id;
	}
	public void setName(String name){
	this.name=name;
	}
	public String getName(){
		return name;
	}
	public void setPrice(float price){
	this.price=price;
	}
	public float getPrice(){
		return price;
	}
	public void setOprice(float oprice){
	this.oprice=oprice;
	}
	public float getOprice(){
		return oprice;
	}
	public void setStatus(String status){
	this.status=status;
	}
	public String getStatus(){
		return status;
	}
	
}

