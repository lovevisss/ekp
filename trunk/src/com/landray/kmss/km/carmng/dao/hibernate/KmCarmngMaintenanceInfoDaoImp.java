package com.landray.kmss.km.carmng.dao.hibernate;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.CacheMode;
import org.hibernate.query.Query;
import org.hibernate.Session;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.km.carmng.context.KmCarmngContext;
import com.landray.kmss.km.carmng.dao.IKmCarmngMaintenanceInfoDao;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 车辆保养数据访问接口实现
 */
public class KmCarmngMaintenanceInfoDaoImp extends BaseDaoImp implements
		IKmCarmngMaintenanceInfoDao {

	@Override
    public List count(HttpServletRequest request) throws Exception {
		String whereBlock = "1 < 2";
		List rtnList = new ArrayList();
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		String fdCarInfoNo = request.getParameter("fdCarInfoNo");
		String fdCarCategoryId = request.getParameter("fdCarCategoryId");

		if (StringUtil.isNotNull(fdStartTime)) {
			whereBlock = StringUtil
					.linkString(whereBlock, " and ",
							" kmCarmngMaintenanceInfo.fdMaintenanceTime >= :fdStartTime ");
			request.setAttribute("fdStartTime", fdStartTime);
		}
		if (StringUtil.isNotNull(fdEndTime)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"kmCarmngMaintenanceInfo.fdMaintenanceTime <= :fdEndTime ");
			request.setAttribute("fdEndTime", fdEndTime);
		}
		if (StringUtil.isNotNull(fdCarInfoNo)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"kmCarmngMaintenanceInfo.fdVehiclesInfo.fdNo like :fdCarInfoNo");
			request.setAttribute("fdCarInfoNo", fdCarInfoNo);
		}
		if (StringUtil.isNotNull(fdCarCategoryId)) {
			fdCarCategoryId = fdCarCategoryId.replace(";", "','");
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"kmCarmngMaintenanceInfo.fdVehiclesInfo.fdVehichesType.fdId in (:fdCarCategoryId)");
			request.setAttribute("fdCarCategoryId", fdCarCategoryId);
			request.setAttribute("fdCarCategoryName", request
					.getParameter("fdCarCategoryName"));
		}
		String sql = "select kmCarmngMaintenanceInfo.fdVehiclesInfo.fdId,"
				+ "kmCarmngMaintenanceInfo.fdVehiclesInfo.fdNo,"
				+ "kmCarmngMaintenanceInfo.fdVehiclesInfo.docSubject,"
				+ "kmCarmngMaintenanceInfo.fdVehiclesInfo.fdVehichesType.fdId,"
				+ "kmCarmngMaintenanceInfo.fdVehiclesInfo.fdVehichesType.fdName,"
				+ "sum(kmCarmngMaintenanceInfo.fdMaintenanceFee),"
				+ "sum(kmCarmngMaintenanceInfo.fdRepairFee) from KmCarmngMaintenanceInfo kmCarmngMaintenanceInfo where "
				+ whereBlock
				+ " group by kmCarmngMaintenanceInfo.fdVehiclesInfo.fdId "
				+ ",kmCarmngMaintenanceInfo.fdVehiclesInfo.fdNo,kmCarmngMaintenanceInfo.fdVehiclesInfo.docSubject,kmCarmngMaintenanceInfo.fdVehiclesInfo.fdVehichesType.fdId,"
				+ "kmCarmngMaintenanceInfo.fdVehiclesInfo.fdVehichesType.fdName ";
		Session session = getHibernateSession();
		Query query = session.createQuery(sql);
		query.setCacheable(true);
		query.setCacheMode(CacheMode.NORMAL);
		query.setCacheRegion("km-carmng");
		if (StringUtil.isNotNull(fdCarInfoNo)) {
			query.setParameter("fdCarInfoNo", "%"+fdCarInfoNo+"%"); 
		}
		if (StringUtil.isNotNull(fdCarCategoryId)) {
			query.setParameterList("fdCarCategoryId", fdCarCategoryId.split("','"));
		}
		if (StringUtil.isNotNull(fdStartTime)) {
			query.setParameter("fdStartTime", com.landray.kmss.util.DateUtil
					.convertStringToDate(fdStartTime + " 00:00",
							com.landray.kmss.util.DateUtil.TYPE_DATETIME,
							Locale.getDefault()));
		}
		if (StringUtil.isNotNull(fdEndTime)) {
			query.setParameter("fdEndTime", DateUtil.convertStringToDate(
					fdEndTime + " 23:59", DateUtil.TYPE_DATETIME, Locale
							.getDefault()));
		}
		List valueList = query.list();
		for (int i = 0; i < valueList.size(); i++) {
			KmCarmngContext context = new KmCarmngContext();
			Object[] objs = (Object[]) valueList.get(i);
			context.setFdCarId((String) objs[0]);
			context.setFdCarNo((String) objs[1]);
			context.setFdCarName((String) objs[2]);
			context.setFdCarCategoryId((String) objs[3]);
			context.setFdCarCategoryName((String) objs[4]);
			context.setFdMaintenanceFee((Double) objs[5]);
			context.setFdRepairFee((Double) objs[6]);
			context.setFdTotalFee((Double) objs[5] + (Double) objs[6]);
			rtnList.add(context);
		}
		return rtnList;
	}

}
