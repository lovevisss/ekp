package com.landray.kmss.km.carmng.dao;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.IBaseDao;
import com.sunbor.web.tag.Page;


/**
 * 创建日期 2010-三月-24
 * @author 叶中奇
 * 部门用车费用表数据访问接口
 */
public interface IKmCarmngUserFeeInfoDao extends IBaseDao {

	List count(HttpServletRequest request) throws Exception;

	/**
	 * <p>车辆使用统计</p>
	 * @param request
	 * @return
	 * @author 孙佳
	 * @param page 
	 */
	List carUseCount(Page page, HQLInfo hqlInfo, HttpServletRequest request);
	
	/**
	 * <p>车辆使用统计,统计所有不分页</p>
	 * @param request
	 * @return
	 * @author 林剑文
	 * @param  
	 */
	List usedCarStatistic(HQLInfo hqlInfo, HttpServletRequest request);

	/**
	 * <p>车辆使用统计详细记录</p>
	 * @param page
	 * @param hqlInfo
	 * @param isExcel 是否是Excel导出
	 * @return
	 * @author 孙佳
	 */
	List carUseDetail(Page page, HQLInfo hqlInfo, HttpServletRequest request, boolean isExcel);

	/**
	 * <p>部门/个人用车费用统计</p>
	 * @param page
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	List queryOrgCount(Page page, HQLInfo hqlInfo, HttpServletRequest request);

	/**
	 * <p>部门/个人用车费用详细记录</p>
	 * @param page
	 * @param hqlInfo
	 * @return
	 * @author 孙佳
	 */
	List queryOrgDetail(Page page, HQLInfo hqlInfo, HttpServletRequest request);

	/**
	 * <p>驾驶员出车统计</p>
	 * @param page
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	List queryDriverCount(Page page, HQLInfo hqlInfo, HttpServletRequest request);

	/**
	 * <p>车辆费用汇总统计</p>
	 * @param page
	 * @param hqlInfo
	 * @param request
	 * @return
	 * @author 孙佳
	 */
	List queryCarFeeCount(Page page, HQLInfo hqlInfo, HttpServletRequest request);

}
