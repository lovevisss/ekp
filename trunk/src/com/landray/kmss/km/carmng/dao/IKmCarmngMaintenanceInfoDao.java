package com.landray.kmss.km.carmng.dao;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.dao.IBaseDao;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 车辆保养数据访问接口
 */
public interface IKmCarmngMaintenanceInfoDao extends IBaseDao {

	List count(HttpServletRequest request) throws Exception;

}
