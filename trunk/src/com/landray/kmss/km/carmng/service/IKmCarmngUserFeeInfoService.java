package com.landray.kmss.km.carmng.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.sunbor.web.tag.Page;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 部门用车费用表业务对象接口
 */
public interface IKmCarmngUserFeeInfoService extends IBaseService {

	List count(HttpServletRequest request) throws Exception;

	void saveExportExcel(List valueList, HttpServletResponse response,
			HttpServletRequest request) throws Exception;

	/**
	 * <p>车辆使用统计</p>
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	Page carUseCount(HQLInfo hqlInfo, HttpServletRequest request);
	
	/**
	 * <p>车辆使用统计,不需要公页</p>
	 * @param request
	 * @return
	 * @author 林剑文
	 */
	List usedCarStatistic(HQLInfo hqlInfo, HttpServletRequest request);

	/**
	 * <p>车辆使用统计详细记录</p>
	 * @param hqlInfo
	 * @return
	 * @author 孙佳
	 */
	Page carUseDetail(HQLInfo hqlInfo, HttpServletRequest request, boolean isExcel);

	/**
	 * <p>部门/个人用车费用统计</p>
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	Page queryOrgCount(HQLInfo hqlInfo, HttpServletRequest request) throws Exception;

	/**
	 * <p>部门/个人用车费用详细记录</p>
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	Page queryOrgDetail(HQLInfo hqlInfo, HttpServletRequest request) throws Exception;

	/**
	 * <p>驾驶员出车统计</p>
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	Page queryDriverCount(HQLInfo hqlInfo, HttpServletRequest request);

	/**
	 * <p>车辆费用汇总统计</p>
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	Page queryCarFeeCount(HQLInfo hqlInfo, HttpServletRequest request);

	void exportCarUseExcel(List list, HttpServletResponse response, HttpServletRequest request);

	void exportCarUseDetailExcel(List list, HttpServletResponse response, HttpServletRequest request);

	void exportQueryOrgExcel(List list, HttpServletResponse response, HttpServletRequest request);

	void exportQueryOrgDetailExcel(List list, HttpServletResponse response, HttpServletRequest request);

	void exportQueryDriverExcel(List list, HttpServletResponse response, HttpServletRequest request);

	void exportQueryCarFeeExcel(List list, HttpServletResponse response, HttpServletRequest request);
}
