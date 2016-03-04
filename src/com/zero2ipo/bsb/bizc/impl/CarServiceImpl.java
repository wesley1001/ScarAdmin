package com.zero2ipo.bsb.bizc.impl;

import com.zero2ipo.bsb.bizc.ICarService;
import com.zero2ipo.bsb.entity.Car;
import com.zero2ipo.framework.FwConstant;
import com.zero2ipo.framework.db.bizc.IBaseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("carService")
public class CarServiceImpl implements ICarService {
	@Autowired @Qualifier("baseDao")
	private IBaseDao baseDao;
	public String add(Car car){
		String id="";
		try{
			baseDao.setDbType(FwConstant.DBTYPE_GLOBAL);
			id=baseDao.updObject("addCar", car)+"";
		}catch(Exception e){
			e.printStackTrace();
		}
		return id;
	}
}
