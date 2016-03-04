package com.zero2ipo.bsb.webc;

import com.zero2ipo.bsb.bizc.ICarService;
import com.zero2ipo.bsb.bizc.IOrderService;
import com.zero2ipo.bsb.entity.Car;
import com.zero2ipo.bsb.entity.Order;
import com.zero2ipo.cfj.user.bizc.IVipManage;
import com.zero2ipo.cfj.user.bo.Users;
import com.zero2ipo.framework.log.BaseLog;
import com.zero2ipo.framework.util.DateUtil;
import com.zero2ipo.framework.util.StringUtil;
import com.zero2ipo.plugins.CodeCommon;
import com.zero2ipo.plugins.code.biz.ICodeManage;
import com.zero2ipo.plugins.code.bo.CodeInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bsborder")
public class OrderController {
	@Autowired
	@Qualifier("orderService")
	private IOrderService orderService ;
	@Autowired
	@Qualifier("codeManage")
	private ICodeManage codeManage;
	@Autowired
	@Qualifier("vipManage")
	private IVipManage vipManage;
	@Autowired
	@Qualifier("carService")
	private ICarService carService;
    @RequestMapping("forInit.shtml")
    public ModelAndView forInit(){
		ModelAndView mv=new ModelAndView("/s9/order/order_init.jsp");
		//登陆成功，查询是否开启消息提醒机制
		Map<String,Object> queryMap=new HashMap<String,Object>();
		queryMap.put("codeValue", CodeCommon.MESSAGE_PUSH);
		//查询字典表里轮询时间的间隔
		CodeInfo code=null;
		String flg="0";
		try {
			code=codeManage.findCodeInfo(queryMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if(!StringUtil.isNullOrEmpty(code)){
			flg=code.getValidFlag();//是否开启消息轮询的标志
		}
		mv.addObject("messageFush", flg);
		return mv;
    }

    @RequestMapping("orderInfoList.shtml")
    @ResponseBody
    public Map<String,Object>  orderInfoList(String curNo, String curSize,String status,String orderNo,String sendOrderStatus){
    	 Map<String,Object> jsonMap = new HashMap<String, Object>();
    	 try {
    		 /************* 分页处理 ************/
 			int skip;
 			int max;
 			if (StringUtil.isNullOrEmpty(curNo))
 				curNo = "0";
 			if (StringUtil.isNullOrEmpty(curSize))
 				curSize = "20";
 			skip = Integer.parseInt(curNo);
 			max = Integer.parseInt(curSize);
 			/************  分页处理结束 ***********/
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("orderStatus", status);
			map.put("orderNo", orderNo); // 订单编号
			map.put("sendOrderStatus", sendOrderStatus); // 派单状态
			int total=0;
        	total=orderService.findAllListCount(map);
        	List<Order> inatitutionsInfo= null;
        	if(total>0){
        		inatitutionsInfo = orderService.findAllListPage(map, (skip-1)*max, max);
        	}
        	jsonMap.put("Rows", inatitutionsInfo);
    		jsonMap.put("Total", total);
		} catch (Exception e) {
			BaseLog.e(this.getClass(), "forLinkTypeinitAjax.shtml:管理人分类信息初始化有误", e);
		}
		return jsonMap;
    }
	/*********************************************添加订单*************************************************************/
	@RequestMapping("forAddInit.shtml")
	public ModelAndView forAddInit() {
		ModelAndView mv = new ModelAndView("/s9/order/order_add.jsp");
		return mv;
	}

	/**
	 * 保存手动添加的订单信息
	 * @param bo
	 * @param order
	 * @return
	 */
	@RequestMapping("addOrder.shtml")
	@ResponseBody
	public  Map<String,Object> addOrder(Users bo,Order order,Car car){
		Map<String,Object> map=new HashMap<String, Object>();
		boolean flg=false;
		try {
			String userId=vipManage.addUser(bo);//创建新用户

			order.setUserId(bo.getPhoneNum());
			//获取当前时间
			String createTime= DateUtil.getCurrentTime();
			car.setCreateTime(createTime);
			car.setUserCarId(bo.getPhoneNum());
			car.setCarNo(bo.getAccount());
			car.setWashAddr(order.getAddress());
			car.setWashInfo(order.getDiscription());
			car.setPreTime(order.getWashTime());
			/**保存车辆信息***/
			String carId=carService.add(car);
			order.setCarId(carId);
			order.setCreateTime(createTime);
			order.setCarNum(bo.getAccount());
			order.setMobile(bo.getPhoneNum());
			orderService.addOrder(order);//创建新订单
			flg=true;
		}catch (Exception e){
			e.printStackTrace();
		}
		map.put("success",flg);
		return map;
	}
 }
