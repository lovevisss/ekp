package com.landray.kmss.km.carmng.dao.hibernate;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.PeriodTypeModel;
import com.landray.kmss.km.carmng.context.KmCarmngContext;
import com.landray.kmss.km.carmng.dao.IKmCarmngUserFeeInfoDao;
import com.landray.kmss.util.*;
import com.sunbor.web.tag.Page;
import org.apache.commons.collections.CollectionUtils;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.slf4j.Logger;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.*;

/**
 * 创建日期 2010-三月-24
 *
 * @author 叶中奇 部门用车费用表数据访问接口实现
 */
public class KmCarmngUserFeeInfoDaoImp extends BaseDaoImp implements
		IKmCarmngUserFeeInfoDao {

	private static final Logger logger = org.slf4j.LoggerFactory.getLogger(KmCarmngUserFeeInfoDaoImp.class);

	@Override
	public List count(HttpServletRequest request) throws Exception {
		int i = 0;
		List personIdList = (List) request.getAttribute("personIdList");
		String selectCondition1 = " fd_vehicles_id,fd_user_id, sum(fd_fee) as fd_fee,sum(fd_stop_fee) as fd_stop_fee,sum(fd_turnpike_fee) as fd_turnpike_fee,sum(fd_fuel_fee) as fd_fuel_fee,sum(fd_other_fee) as fd_other_fee,"
				+ "sum(fd_carwash_fee) as fd_carwash_fee,sum(fd_mileage_number) as fd_mileage_number ";
		String whereBlock1 = "";
		if (!ArrayUtil.isEmpty(personIdList)) {
			whereBlock1 = HQLUtil.buildLogicIN(" fd_user_id ", personIdList);
		}
		whereBlock1 = StringUtil.linkString(" 1 < 2 ", " and ", whereBlock1);
		String sql = "select e.fd_id,e.fd_no,e.doc_subject,f.fd_id as fd_category_id, f.fd_name,  g.* from km_carmng_infomation e left join km_carmng_category f "
				+ "on e.fd_vehiches_type = f.fd_id left join ( select a.fd_vehicles_id,a.fd_fee,a.fd_stop_fee,a.fd_turnpike_fee,a.fd_fuel_fee,a.fd_other_fee,a.fd_carwash_fee,a.fd_mileage_number,b.fd_insurance_price_1,c.fd_maintenance_fee_1,c.fd_repair_fee_1,d.fd_infringe_fee_1  from ("
				+ "select "
				+ selectCondition1
				+ " from km_carmng_user_fee_info where "
				+ whereBlock1
				+ " group by  fd_vehicles_id "
				+ ") a left join (select fd_vehicles_info_id ,sum(fd_insurance_price) fd_insurance_price_1 "
				+ "from km_carmng_insurance_info   group by fd_vehicles_info_id"
				+ ") b  on a.fd_vehicles_id = b.fd_vehicles_info_id left join (select fd_vehicles_info_id, sum(fd_maintenance_fee) fd_maintenance_fee_1,sum(fd_repair_fee) fd_repair_fee_1 from km_carmng_maintenance_info "
				+ "  group by fd_vehicles_info_id) c   "
				+ "on a.fd_vehicles_id = c.fd_vehicles_info_id left join (select fd_vehicles_info_id, sum(fd_infringe_fee)  fd_infringe_fee_1 from km_carmng_infringe_info "
				+ " group by fd_vehicles_info_id )d   on a.fd_vehicles_id = d.fd_vehicles_info_id "
				+ ") g on e.fd_id =  g.fd_vehicles_id";

		List rtnList = new ArrayList();
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		String fdStartTime = request.getParameter("fdStartTime");
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		request.setAttribute("fdStartTime", fdStartTime);
		String fdEndTime = request.getParameter("fdEndTime");
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		request.setAttribute("fdEndTime", fdEndTime);
		String fdCarInfoNo = request.getParameter("fdCarInfoNo");
		request.setAttribute("fdCarInfoNo", fdCarInfoNo);
		String fdCarCategoryId = request.getParameter("fdCarCategoryId");
		request.setAttribute("fdCarCategoryId", fdCarCategoryId);
		String fdCarCategoryName = request.getParameter("fdCarCategoryName");
		request.setAttribute("fdCarCategoryName", fdCarCategoryName);
		if (StringUtil.isNotNull(fdCarCategoryId)) {
			fdCarCategoryId = fdCarCategoryId.replace(";", "','");
		}

		if (StringUtil.isNotNull(fdStartTime) && StringUtil.isNull(fdEndTime)) {
			whereBlock1 = StringUtil.linkString(
					"where fd_use_start_time >= :fd_use_start_time", " and ",
					whereBlock1);
			sql = "select e.fd_id,e.fd_no,e.doc_subject,f.fd_id as fd_category_id, f.fd_name,  a.fd_fee, a.fd_stop_fee, a.fd_turnpike_fee, a.fd_fuel_fee, a.fd_other_fee, a.fd_carwash_fee, a.fd_mileage_number,b.fd_insurance_price_1,c.fd_maintenance_fee_1, c.fd_repair_fee_1,d.fd_infringe_fee_1  from km_carmng_infomation e left join km_carmng_category f "
					+ "on e.fd_vehiches_type = f.fd_id left join "
					+ "(select "
					+ selectCondition1
					+ " from km_carmng_user_fee_info  "
					+ whereBlock1
					+ " group by fd_vehicles_id, fd_user_id "
					+ ") a ON a.fd_vehicles_id = e.fd_id left join (select fd_vehicles_info_id ,sum(fd_insurance_price) fd_insurance_price_1 "
					+ "from km_carmng_insurance_info where fd_insurance_start_time >= :fd_insurance_start_time  group by fd_vehicles_info_id"
					+ ") b  on e.fd_id = b.fd_vehicles_info_id left join (select fd_vehicles_info_id, sum(fd_maintenance_fee) fd_maintenance_fee_1,sum(fd_repair_fee) fd_repair_fee_1 from km_carmng_maintenance_info "
					+ "where fd_maintenance_time >= :fd_maintenance_start_time  group by fd_vehicles_info_id) c   "
					+ "on e.fd_id = c.fd_vehicles_info_id left join (select fd_vehicles_info_id, sum(fd_infringe_fee)  fd_infringe_fee_1 from km_carmng_infringe_info "
					+ "where fd_infringe_time >= :fd_infringe_start_time group by fd_vehicles_info_id )d   on e.fd_id = d.fd_vehicles_info_id ";
		}
		if (StringUtil.isNotNull(fdEndTime) && StringUtil.isNull(fdStartTime)) {
			whereBlock1 = StringUtil.linkString(
					"where fd_use_end_time <= :fd_use_end_time ", " and ",
					whereBlock1);
			sql = "select e.fd_id,e.fd_no,e.doc_subject,f.fd_id as fd_category_id ,f.fd_name, a.fd_fee, a.fd_stop_fee, a.fd_turnpike_fee, a.fd_fuel_fee, a.fd_other_fee, a.fd_carwash_fee, a.fd_mileage_number,b.fd_insurance_price_1,c.fd_maintenance_fee_1, c.fd_repair_fee_1,d.fd_infringe_fee_1  from km_carmng_infomation e left join km_carmng_category f "
					+ "on e.fd_vehiches_type = f.fd_id left join "
					+ "(select "
					+ selectCondition1
					+ " from km_carmng_user_fee_info   "
					+ whereBlock1
					+ " group by fd_vehicles_id , fd_user_id "
					+ ") a ON a.fd_vehicles_id = e.fd_id left join (select fd_vehicles_info_id ,sum(fd_insurance_price) as fd_insurance_price_1 "
					+ "from km_carmng_insurance_info where fd_insurance_start_time <= :fd_insurance_end_time  group by fd_vehicles_info_id"
					+ ") b  on e.fd_id = b.fd_vehicles_info_id left join (select fd_vehicles_info_id, sum(fd_maintenance_fee) fd_maintenance_fee_1 ,sum(fd_repair_fee) fd_repair_fee_1 from km_carmng_maintenance_info "
					+ "where  fd_maintenance_time <= :fd_maintenance_end_time group by fd_vehicles_info_id) c   "
					+ "on e.fd_id = c.fd_vehicles_info_id left join (select fd_vehicles_info_id, sum(fd_infringe_fee) fd_infringe_fee_1 from km_carmng_infringe_info "
					+ "where  fd_infringe_time <= :fd_infringe_end_time group by fd_vehicles_info_id )d   on e.fd_id = d.fd_vehicles_info_id ";
		}
		if (StringUtil.isNotNull(fdStartTime)
				&& StringUtil.isNotNull(fdEndTime)) {
			// whereBlock1 = StringUtil.linkString(" 1 < 2 "," and ",
			// whereBlock1);
			whereBlock1 = StringUtil
					.linkString(
							"where fd_use_start_time >= :fd_use_start_time and fd_use_end_time <= :fd_use_end_time ",
							" and ", whereBlock1);
			sql = "select e.fd_id,e.fd_no,e.doc_subject,f.fd_id as fd_category_id,f.fd_name, a.fd_fee, a.fd_stop_fee, a.fd_turnpike_fee, a.fd_fuel_fee, a.fd_other_fee, a.fd_carwash_fee, a.fd_mileage_number,b.fd_insurance_price_1,c.fd_maintenance_fee_1, c.fd_repair_fee_1,d.fd_infringe_fee_1, a.fd_user_id"
					+ " from km_carmng_infomation e left join km_carmng_category f "
					+ "on e.fd_vehiches_type = f.fd_id left join "
					+ "(select "
					+ selectCondition1
					+ "from km_carmng_user_fee_info  "
					+ whereBlock1
					+ " group by fd_vehicles_id , fd_user_id ) a ON a.fd_vehicles_id = e.fd_id left join ("
					+ "select fd_vehicles_info_id ,sum(fd_insurance_price) as fd_insurance_price_1 from km_carmng_insurance_info "
					+ "where fd_insurance_start_time >= :fd_insurance_start_time and fd_insurance_start_time <= :fd_insurance_end_time group by fd_vehicles_info_id"
					+ ") b  on e.fd_id = b.fd_vehicles_info_id left join ("
					+ "select fd_vehicles_info_id, sum(fd_maintenance_fee) as fd_maintenance_fee_1,sum(fd_repair_fee) as fd_repair_fee_1 from km_carmng_maintenance_info "
					+ "where fd_maintenance_time >= :fd_maintenance_start_time and  fd_maintenance_time <= :fd_maintenance_end_time group by fd_vehicles_info_id) c  "
					+ "on e.fd_id = c.fd_vehicles_info_id left join ("
					+ "select fd_vehicles_info_id, sum(fd_infringe_fee) as fd_infringe_fee_1 from km_carmng_infringe_info "
					+ "where fd_infringe_time >= :fd_infringe_start_time and  fd_infringe_time <= :fd_infringe_end_time group by fd_vehicles_info_id ) d  on e.fd_id = d.fd_vehicles_info_id ";
		}
		if (StringUtil.isNotNull(fdCarInfoNo)) {
			i++;
			sql = "select * from (" + sql + ") h" + i + " where  h" + i
					+ ".fd_no = '" + fdCarInfoNo + "'";
		}
		if (StringUtil.isNotNull(fdCarCategoryId)) {
			i++;
			sql = "select * from (" + sql + ") h" + i + " where  h" + i
					+ ".fd_category_id in ('" + fdCarCategoryId + "' )";
		}
		if (!ArrayUtil.isEmpty(personIdList)) {
			i++;
			String sqlName = "h" + i;
			sql = "select * from (" + sql + ") " + sqlName + " where "
					+ HQLUtil.buildLogicIN(sqlName +".fd_user_id ", personIdList);
		}

		Session session = this.getHibernateSession();
		Query query = session.createNativeQuery(sql);
		if (StringUtil.isNotNull(fdStartTime)) {
			query.setParameter("fd_use_start_time", DateUtil
					.convertStringToDate(fdStartTime + " 00:00",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
			query.setParameter("fd_maintenance_start_time", DateUtil
					.convertStringToDate(fdStartTime + " 00:00",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
			query.setParameter("fd_insurance_start_time", DateUtil
					.convertStringToDate(fdStartTime + " 00:00",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
			query.setParameter("fd_infringe_start_time", DateUtil
					.convertStringToDate(fdStartTime + " 00:00",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
		}
		if (StringUtil.isNotNull(fdEndTime)) {
			query.setParameter("fd_use_end_time", DateUtil.convertStringToDate(
					fdEndTime + " 23:59", DateUtil.TYPE_DATETIME, Locale
							.getDefault()));
			query.setParameter("fd_maintenance_end_time", DateUtil
					.convertStringToDate(fdEndTime + " 23:59",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
			query.setParameter("fd_insurance_end_time", DateUtil
					.convertStringToDate(fdEndTime + " 23:59",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
			query.setParameter("fd_infringe_end_time", DateUtil
					.convertStringToDate(fdEndTime + " 23:59",
							DateUtil.TYPE_DATETIME, Locale.getDefault()));
		}
		List valueList = query.list();
		for (int j = 0; j < valueList.size(); j++) {
			KmCarmngContext context = new KmCarmngContext();
			Double fdTotalFee = 0.0;
			Object[] objs = (Object[]) valueList.get(j);
			int k = 0;
			context.setFdCarId((String) objs[k]);
			context.setFdCarNo((String) objs[++k]);
			context.setFdCarName((String) objs[++k]);
			context.setFdCarCategoryId((String) objs[++k]);
			context.setFdCarCategoryName((String) objs[++k]);
			if (objs[++k] != null) {
				context.setFdFee((Double) objs[k]);
			} else {
				context.setFdFee(new Double(0));
			}
			fdTotalFee += context.getFdFee();
			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdStopFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdStopFee((Double) objs[k]);
				}
			} else {
				context.setFdStopFee(new Double(0));
			}
			fdTotalFee += context.getFdStopFee();

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdTurnpikeFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdTurnpikeFee((Double) objs[k]);
				}
			} else {
				context.setFdTurnpikeFee(new Double(0));
			}
			fdTotalFee += context.getFdTurnpikeFee();

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdFuelFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdFuelFee((Double) objs[k]);
				}
			} else {
				context.setFdFuelFee(new Double(0));
			}
			fdTotalFee += context.getFdFuelFee();

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdOtherFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdOtherFee((Double) objs[k]);
				}
			} else {
				context.setFdOtherFee(new Double(0));
			}
			fdTotalFee += context.getFdOtherFee();

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdCarwashFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdCarwashFee((Double) objs[k]);
				}

			} else {
				context.setFdCarwashFee(new Double(0));
			}

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdMileageNumber(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdMileageNumber((Double) objs[k]);
				}
			} else {
				context.setFdMileageNumber(new Double(0));
			}
			fdTotalFee += context.getFdCarwashFee();

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdInsuranceInfoFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdInsuranceInfoFee((Double) objs[k]);
				}
			} else {
				context.setFdInsuranceInfoFee(new Double(0));
			}
			if (ArrayUtil.isEmpty(personIdList)) {
				fdTotalFee += context.getFdInsuranceInfoFee();
			}

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdMaintenanceFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdMaintenanceFee((Double) objs[k]);
				}
			} else {
				context.setFdMaintenanceFee(new Double(0));
			}
			if (ArrayUtil.isEmpty(personIdList)) {
				fdTotalFee += context.getFdMaintenanceFee();
			}

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdRepairFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdRepairFee((Double) objs[k]);
				}
			} else {
				context.setFdRepairFee(new Double(0));
			}
			if (ArrayUtil.isEmpty(personIdList)) {
				fdTotalFee += context.getFdRepairFee();
			}

			if (objs[++k] != null) {
				if (objs[k] instanceof java.math.BigDecimal) {
					context.setFdInfringeFee(((java.math.BigDecimal) objs[k])
							.doubleValue());
				} else {
					context.setFdInfringeFee((Double) objs[k]);
				}
			} else {
				context.setFdInfringeFee(new Double(0));
			}
			if (ArrayUtil.isEmpty(personIdList)) {
				fdTotalFee += context.getFdInfringeFee();
			}
			context.setFdTotalFee(fdTotalFee);
			rtnList.add(context);
		}
		return rtnList;
	}

	@Override
	public List carUseCount(Page page, HQLInfo hqlInfo, HttpServletRequest request) {
		try {
			String dateDiffFunction = getDateDiffFunction("register.fd_end_time", "register.fd_start_time");
			String sql = "SELECT car.fd_no as fd_no, doc_subject, motorcade.fd_name as fd_motorcade_name, category.fd_name as fd_category_name, carFee.*, car.fd_id as fd_id FROM km_carmng_infomation car left JOIN km_carmng_motorcade_set motorcade ON car.fd_motorcade_id =motorcade.fd_id"
					+ " LEFT JOIN km_carmng_category category ON car.fd_vehiches_type = category.fd_id LEFT JOIN ";

			String subquery = "SELECT infolist.fd_carinfo_id as car_id, COUNT(*) AS car_use_count, SUM(register.fd_mileage_number) as fd_mileage_number, sum("
					+ dateDiffFunction + ") as use_time,"
					+ " SUM(register.fd_turnpike_fee) AS fd_turnpike_fee, SUM(register.fd_fuel_fee) as fd_fuel_fee, SUM(register.fd_stop_fee) as fd_stop_fee, SUM(register.fd_carwash_fee) as fd_carwash_fee,"
					+ " sum(register.fd_other_fee) as fd_other_fee FROM km_carmng_dispatchers_infolist infolist LEFT JOIN km_carmng_infomation car ON car.fd_id = infolist.fd_carinfo_id "
					+ " LEFT JOIN km_carmng_register_info register ON register.fd_dispatchinfolist_id = infolist.fd_id where 1=1";
			String carId = request.getParameter("carId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			Date startDate = null, endDate = null;

			if (StringUtil.isNotNull(fdStartDate)) {
				subquery = StringUtil.linkString(subquery, " and ", "register.fd_start_time >=:fdStartDate");
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				subquery = StringUtil.linkString(subquery, " and ", "register.fd_end_time <=:fdEndDate");
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			sql = sql + "(" + subquery + " GROUP BY infolist.fd_carinfo_id ) carFee ON car.fd_id = carFee.car_id where 1=1";
			if (StringUtil.isNotNull(carId)) {
				sql = StringUtil.linkString(sql, " and ",
						HQLUtil.buildLogicIN("car.fd_id", Arrays.asList(carId.split(";"))));
			} else {
				sql = StringUtil.linkString(sql, " and ", "1=0");
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql);
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			List valueList = query.list();
			int total = valueList.size();
			if (total > 0) {
				page.setRowsize(hqlInfo.getRowSize());
				page.setPageno(hqlInfo.getPageNo());
				page.setTotalrows(total);
				page.setOrderby(hqlInfo.getOrderBy());
				page.excecute();
				query.setFirstResult(page.getStart());
				query.setMaxResults(page.getRowsize());
				List<Object[]> dlist = query.list();
				if ("-1".equals(dateDiffFunction)) {
					// 处理时间差
					Map<String, Long> diffSum = getDateDiffSum(subquery, startDate, endDate, "infolist.fd_carinfo_id, register.fd_end_time, register.fd_start_time");
					for (Object[] obj : dlist) {
						obj[7] = diffSum.get(obj[4]);
					}
				}
				return dlist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	@Override
	public List usedCarStatistic(HQLInfo hqlInfo, HttpServletRequest request) {
		try {
			String dateDiffFunction = getDateDiffFunction("register.fd_end_time", "register.fd_start_time");
			String sql = "SELECT car.fd_no as fd_no, doc_subject, motorcade.fd_name as fd_motorcade_name, category.fd_name as fd_category_name, carFee.*, car.fd_id as fd_id FROM km_carmng_infomation car left JOIN km_carmng_motorcade_set motorcade ON car.fd_motorcade_id =motorcade.fd_id"
					+ " LEFT JOIN km_carmng_category category ON car.fd_vehiches_type = category.fd_id LEFT JOIN ";

			String subquery = "SELECT infolist.fd_carinfo_id as car_id, COUNT(*) AS car_use_count, SUM(register.fd_mileage_number) as fd_mileage_number, sum("
					+ dateDiffFunction + ") as use_time,"
					+ " SUM(register.fd_turnpike_fee) AS fd_turnpike_fee, SUM(register.fd_fuel_fee) as fd_fuel_fee, SUM(register.fd_stop_fee) as fd_stop_fee, SUM(register.fd_carwash_fee) as fd_carwash_fee,"
					+ " sum(register.fd_other_fee) as fd_other_fee FROM km_carmng_dispatchers_infolist infolist LEFT JOIN km_carmng_infomation car ON car.fd_id = infolist.fd_carinfo_id "
					+ " LEFT JOIN km_carmng_register_info register ON register.fd_dispatchinfolist_id = infolist.fd_id where 1=1";
			String carId = request.getParameter("carId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			Date startDate = null, endDate = null;

			if (StringUtil.isNotNull(fdStartDate)) {
				subquery = StringUtil.linkString(subquery, " and ", "register.fd_start_time >=:fdStartDate");
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				subquery = StringUtil.linkString(subquery, " and ", "register.fd_end_time <=:fdEndDate");
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			sql = sql + "(" + subquery + " GROUP BY infolist.fd_carinfo_id ) carFee ON car.fd_id = carFee.car_id where 1=1";
			if (StringUtil.isNotNull(carId)) {
				sql = StringUtil.linkString(sql, " and ",
						HQLUtil.buildLogicIN("car.fd_id", Arrays.asList(carId.split(";"))));
			} else {
				sql = StringUtil.linkString(sql, " and ", "1=0");
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql).addScalar("fd_no").addScalar("doc_subject")
					.addScalar("fd_motorcade_name").addScalar("fd_category_name").addScalar("car_id")
					.addScalar("car_use_count").addScalar("fd_mileage_number").addScalar("use_time")
					.addScalar("fd_turnpike_fee").addScalar("fd_fuel_fee").addScalar("fd_stop_fee")
					.addScalar("fd_carwash_fee").addScalar("fd_other_fee").addScalar("fd_id");
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			List<Object[]> valueList = query.list();
			if ("-1".equals(dateDiffFunction)) {
				// 处理时间差
				Map<String, Long> diffSum = getDateDiffSum(subquery, startDate, endDate, "infolist.fd_carinfo_id, register.fd_end_time, register.fd_start_time");
				for (Object[] obj : valueList) {
					obj[7] = diffSum.get(obj[4]);
				}
			}
			return valueList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	@Override
	public List carUseDetail(Page page, HQLInfo hqlInfo, HttpServletRequest request, boolean isExcel) {
		try {
			String sql = "SELECT infolist.fd_carinfo_id , infolist.fd_carinfo_no, infolist.fd_carinfo_name, infolist.fd_motorcade_name, info.fd_application_ids, info.fd_application_Names, register.fd_mileage_number, register.fd_start_time, register.fd_end_time ,"
					+ " register.fd_turnpike_fee, register.fd_fuel_fee, register.fd_stop_fee,register.fd_carwash_fee,"
					+ " register.fd_other_fee, infolist.fd_dispatchers_id FROM km_carmng_dispatchers_infolist infolist LEFT JOIN km_carmng_infomation car ON car.fd_id = infolist.fd_carinfo_id"
					+ " LEFT JOIN km_carmng_register_info register ON register.fd_dispatchinfolist_id = infolist.fd_id LEFT JOIN km_carmng_dispatchers_info info ON infolist.fd_dispatchers_id = info.fd_id WHERE 1=1";
			String carId = request.getParameter("carId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			Date startDate = null, endDate = null;

			if (StringUtil.isNotNull(fdStartDate)) {
				sql = StringUtil.linkString(sql, " and ", "register.fd_start_time >=:fdStartDate");
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				sql = StringUtil.linkString(sql, " and ", "register.fd_end_time <=:fdEndDate");
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			if (StringUtil.isNotNull(carId)) {
				sql = StringUtil.linkString(sql, " and ", "infolist.fd_carinfo_id =:carId");
			} else {
				sql = StringUtil.linkString(sql, " and ", "1=0");
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql);
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			if (StringUtil.isNotNull(carId)) {
				query.setParameter("carId", carId);
			}
			List valueList = query.list();

			if(isExcel)  //Excel 导出不需要分页
			{
				return valueList;
			}

			int total = valueList.size();
			if (total > 0) {
				page.setRowsize(hqlInfo.getRowSize());
				page.setPageno(hqlInfo.getPageNo());
				page.setTotalrows(total);
				page.setOrderby(hqlInfo.getOrderBy());
				page.excecute();
				query.setFirstResult(page.getStart());
				query.setMaxResults(page.getRowsize());
				List dlist = query.list();
				return dlist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	@Override
	public List queryOrgCount(Page page, HQLInfo hqlInfo, HttpServletRequest request) {
		try {
			String dateDiffFunction = getDateDiffFunction("fd_use_end_time", "fd_use_start_time");
			String sql = " COUNT(DISTINCT fd_dispatchers_id) as total, SUM(fd_mileage_number) as fd_mileage_number, sum("
					+ dateDiffFunction + ") as use_time, "
					+ " SUM(fd_turnpike_fee) AS fd_turnpike_fee, SUM(fd_fuel_fee) as fd_fuel_fee, SUM(fd_stop_fee) as fd_stop_fee, SUM(fd_carwash_fee) as fd_carwash_fee, "
					+ " sum(fd_other_fee) as fd_other_fee FROM km_carmng_user_fee_info feeInfo WHERE 1=1";

			List personIdList = (List) request.getAttribute("personIdList");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			String type = request.getParameter("type");
			Date startDate = null, endDate = null;

			if (StringUtil.isNotNull(fdStartDate)) {
				sql = StringUtil.linkString(sql, " and ", "feeInfo.fd_use_start_time >=:fdStartDate");
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				sql = StringUtil.linkString(sql, " and ", "feeInfo.fd_use_end_time <=:fdEndDate");
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			if ("dept".equals(type)) {
				if (!ArrayUtil.isEmpty(personIdList)) {
					sql = StringUtil.linkString(sql, " and ",
							HQLUtil.buildLogicIN(" fd_application_dept ", personIdList));
				} else {
					sql += " and 1=0";
				}
				sql = "select fd_application_dept, " + sql + " GROUP BY fd_application_dept";
			} else if ("person".equals(type)) {
				if (!ArrayUtil.isEmpty(personIdList)) {
					sql = StringUtil.linkString(sql, " and ", HQLUtil.buildLogicIN(" fd_user_id ", personIdList));
				} else {
					sql += " and 1=0";
				}
				sql = "select fd_user_id, " + sql + " GROUP BY fd_user_id";
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql);
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			List valueList = query.list();
			int total = valueList.size();
			if (total > 0) {
				page.setRowsize(hqlInfo.getRowSize());
				page.setPageno(hqlInfo.getPageNo());
				page.setTotalrows(total);
				page.setOrderby(hqlInfo.getOrderBy());
				page.excecute();
				query.setFirstResult(page.getStart());
				query.setMaxResults(page.getRowsize());
				List<Object[]> dlist = query.list();
				if ("-1".equals(dateDiffFunction)) {
					String select = "fd_user_id, fd_use_end_time, fd_use_start_time";
					if ("dept".equals(type)) {
						select = "fd_application_dept, fd_use_end_time, fd_use_start_time";
					}
					// 处理时间差
					Map<String, Long> diffSum = getDateDiffSum(sql, startDate, endDate, select);
					for (Object[] obj : dlist) {
						obj[3] = diffSum.get(obj[0]);
					}
				}
				return dlist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	@Override
	public List queryOrgDetail(Page page, HQLInfo hqlInfo, HttpServletRequest request) {
		try {
			String sql = "SELECT b.fd_application_dept, b.fd_user_id, b.fd_application_Names, b.fd_use_start_time,b.fd_use_end_time, b.fd_dispatchers_id, a.fd_mileage_number,a.fd_turnpike_fee,a.fd_fuel_fee,"
					+ "a.fd_stop_fee,a.fd_carwash_fee,a.fd_other_fee,a.fd_id FROM";
			String sql1 = "SELECT (fd_mileage_number) as fd_mileage_number,  (fd_turnpike_fee) as fd_turnpike_fee, (fd_fuel_fee) as fd_fuel_fee, (fd_stop_fee) as fd_stop_fee, (fd_carwash_fee) as fd_carwash_fee, "
					+ " (fd_other_fee) as fd_other_fee,(feeInfo.fd_id) as fd_id  FROM km_carmng_user_fee_info  feeInfo LEFT JOIN km_carmng_dispatchers_info info "
					+ " ON feeInfo.fd_dispatchers_id = info.fd_id";
			String sql2 = "SELECT fd_application_dept,fd_user_id, info.fd_application_Names as fd_application_Names, fd_use_start_time, fd_use_end_time, feeInfo.fd_id as fd_id, feeInfo.fd_dispatchers_id FROM km_carmng_user_fee_info feeInfo, km_carmng_dispatchers_info info WHERE feeInfo.fd_dispatchers_id = info.fd_id";
			String orgId = request.getParameter("orgId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			String type = request.getParameter("type");
			Date startDate = null, endDate = null;
			sql = sql + "(" + sql1 + ") a left join (" + sql2 + ") b ON a.fd_id = b.fd_id where 1=1";
			if (StringUtil.isNotNull(fdStartDate)) {
				sql = StringUtil.linkString(sql, " and ", "b.fd_use_start_time >=:fdStartDate");
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				sql = StringUtil.linkString(sql, " and ", "b.fd_use_end_time <=:fdEndDate");
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			if ("dept".equals(type)) {

				sql = sql + " and b.fd_application_dept =:orgId";
			} else if ("person".equals(type)) {

				sql = sql + " and b.fd_user_id =:orgId";
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql);
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			query.setParameter("orgId", orgId);
			List valueList = query.list();
			int total = valueList.size();
			if (total > 0) {
				page.setRowsize(hqlInfo.getRowSize());
				page.setPageno(hqlInfo.getPageNo());
				page.setTotalrows(total);
				page.setOrderby(hqlInfo.getOrderBy());
				page.excecute();
				query.setFirstResult(page.getStart());
				query.setMaxResults(page.getRowsize());
				List dlist = query.list();
				return dlist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	@Override
	public List queryDriverCount(Page page, HQLInfo hqlInfo, HttpServletRequest request) {
		try {
			String dateDiffFunction = getDateDiffFunction("feeInfo.fd_use_end_time","feeInfo.fd_use_start_time");
			String sql1 = "SELECT infolist.fd_driver_id, SUM(feeInfo.fd_mileage_number) AS fd_mileage_number, sum(" + dateDiffFunction + ") as fdUseTime FROM  "
					+ " km_carmng_user_fee_info feeInfo LEFT JOIN km_carmng_dispatchers_infolist infolist ON feeInfo.fd_dispatchers_id = infolist.fd_dispatchers_id where 1=1";

			String sql2 = "SELECT fd_driver_id, COUNT(DISTINCT info.fd_dispatchinfolist_id) AS fdUseCount FROM  km_carmng_dispatchers_infolist infolist "
					+ " LEFT JOIN km_carmng_register_info info ON infolist.fd_id = info.fd_dispatchinfolist_id where 1=1";

			String sql3 = "SELECT drivers.fd_id, COUNT(infringe.fd_id) as infringeCount FROM km_carmng_drivers_info drivers LEFT JOIN km_carmng_infringe_info infringe ON drivers.fd_id = infringe.fd_infringe_person_id where 1=1";

			String fdDriverId = request.getParameter("fdDriverId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			Date startDate = null, endDate = null;

			if (StringUtil.isNotNull(fdStartDate)) {
				sql1 = sql1 + " and feeInfo.fd_use_start_time >=:fdStartDate";
				sql2 = sql2 + " and info.fd_start_time >=:fdStartDate";
				sql3 = sql3 + " and infringe.fd_infringe_time >=:fdStartDate";
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				sql1 = sql1 + " and feeInfo.fd_use_end_time <=:fdEndDate";
				sql2 = sql2 + " and info.fd_end_time <=:fdEndDate";
				sql3 = sql3 + " and infringe.fd_infringe_time <=:fdEndDate";
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			sql1 += " GROUP BY infolist.fd_driver_id";
			sql2 += " GROUP BY fd_driver_id";
			sql3 += " GROUP BY drivers.fd_id";
			String sql = "SELECT drivers.fd_id, drivers.fd_name, a.fd_mileage_number, a.fdUseTime , b.fdUseCount , c.infringeCount FROM km_carmng_drivers_info drivers LEFT JOIN "
					+ " (" + sql1 + ") a ON drivers.fd_id = a.fd_driver_id LEFT JOIN  "
					+ " (" + sql2 + ") b ON drivers.fd_id = b.fd_driver_id LEFT JOIN  "
					+ " (" + sql3 + ") c ON drivers.fd_id = c.fd_id where 1=1";
			if (StringUtil.isNotNull(fdDriverId)) {
				sql = StringUtil.linkString(sql, " and ",
						HQLUtil.buildLogicIN("drivers.fd_id", Arrays.asList(fdDriverId.split(";"))));
			} else {
				sql += " and 1=0";
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql);
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			List valueList = query.list();
			int total = valueList.size();
			if (total > 0) {
				page.setRowsize(hqlInfo.getRowSize());
				page.setPageno(hqlInfo.getPageNo());
				page.setTotalrows(total);
				page.setOrderby(hqlInfo.getOrderBy());
				page.excecute();
				query.setFirstResult(page.getStart());
				query.setMaxResults(page.getRowsize());
				List<Object[]> dlist = query.list();
				if ("-1".equals(dateDiffFunction)) {
					// 处理时间差
					Map<String, Long> diffSum = getDateDiffSum(sql1, startDate, endDate, "infolist.fd_driver_id, feeInfo.fd_use_end_time, feeInfo.fd_use_start_time");
					for (Object[] obj : dlist) {
						obj[3] = diffSum.get(obj[0]);
					}
				}
				return dlist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	@Override
	public List queryCarFeeCount(Page page, HQLInfo hqlInfo, HttpServletRequest request) {
		try {
			String sql1 = "SELECT car.fd_id as fd_car_Id, carFee.*, a.fd_infringe_fee as fd_infringe_fee, b.fd_maintenance_fee as fd_maintenance_fee, b.fd_repair_fee as fd_repair_fee, c.fd_insurance_price as fd_insurance_price FROM km_carmng_infomation car LEFT JOIN";

			String sql2 = "SELECT fee.fd_vehicles_id AS car_id, SUM(fee.fd_turnpike_fee) AS fd_turnpike_fee, SUM(fee.fd_fuel_fee) as fd_fuel_fee, SUM(fee.fd_stop_fee) as fd_stop_fee, "
					+ " SUM(fee.fd_carwash_fee) as fd_carwash_fee, sum(fee.fd_other_fee) as fd_other_fee from km_carmng_user_fee_info fee where 1=1";
			String sql3 = "SELECT fd_vehicles_info_id , SUM(fd_infringe_fee) as fd_infringe_fee FROM km_carmng_infringe_info where 1=1";
			String sql4 = "SELECT fd_vehicles_info_id , SUM(fd_maintenance_fee) as fd_maintenance_fee, sum(fd_repair_fee) as fd_repair_fee FROM km_carmng_maintenance_info where 1=1";
			String sql5 = "SELECT fd_vehicles_info_id , sum(fd_insurance_fee) as fd_insurance_price FROM km_carmng_insurance_info where 1=1";
			String fdCarInfoId = request.getParameter("fdCarInfoId");
			String fdStartDate = request.getParameter("fdStartDate");
			String fdEndDate = request.getParameter("fdEndDate");
			String timeType = request.getParameter("timeType");
			Date startDate = null, endDate = null;

			if (StringUtil.isNotNull(fdStartDate)) {
				sql2 = sql2 + " and fee.fd_use_start_time >=:fdStartDate";
				sql3 = sql3 + " and fd_infringe_time >=:fdStartDate";
				sql4 = sql4 + " and fd_maintenance_time >=:fdStartDate";
				sql5 = sql5 + " and fd_insurance_start_time >=:fdStartDate";
				startDate = convertDate(fdStartDate, timeType, "start");
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				sql2 = sql2 + " and fee.fd_use_end_time <=:fdEndDate";
				sql3 = sql3 + " and fd_infringe_time <=:fdEndDate";
				sql4 = sql4 + " and fd_maintenance_time<=:fdEndDate";
				sql5 = sql5 + " and fd_insurance_end_time<=:fdEndDate";
				endDate = convertDate(fdEndDate, timeType, "end");
			}
			sql2 += " GROUP BY fee.fd_vehicles_id";
			sql3 += " GROUP BY fd_vehicles_info_id";
			sql4 += " GROUP BY fd_vehicles_info_id";
			sql5 += " GROUP BY fd_vehicles_info_id";
			sql1 += "(" + sql2 + ") carFee ON car.fd_id = carFee.car_id LEFT JOIN(" + sql3
					+ ") a ON car.fd_id  = a.fd_vehicles_info_id LEFT JOIN(" + sql4
					+ ") b on car.fd_id  = b.fd_vehicles_info_id LEFT JOIN(" + sql5
					+ ") c on car.fd_id  = c.fd_vehicles_info_id";
			String sql = "SELECT car.fd_no as fd_no,car.doc_subject as doc_subject, motorcade.fd_name as fd_motorcade_name, category.fd_name as fd_category_name, a.* FROM km_carmng_infomation car LEFT JOIN km_carmng_motorcade_set motorcade ON car.fd_motorcade_id =motorcade.fd_id"
					+" LEFT JOIN km_carmng_category category ON car.fd_vehiches_type = category.fd_id LEFT JOIN (" + sql1 + ") a ON car.fd_id = a.fd_car_Id where 1=1";
			if (StringUtil.isNotNull(fdCarInfoId)) {
				sql = StringUtil.linkString(sql, " and ",
						HQLUtil.buildLogicIN("car.fd_id", Arrays.asList(fdCarInfoId.split(";"))));
			}else{
				sql = StringUtil.linkString(sql, " and ", "1=0");
			}
			Session session = this.getHibernateSession();
			Query query = session.createNativeQuery(sql).addScalar("fd_no").addScalar("doc_subject")
					.addScalar("fd_motorcade_name")
					.addScalar("fd_category_name").addScalar("fd_car_Id").addScalar("car_id")
					.addScalar("fd_turnpike_fee")
					.addScalar("fd_fuel_fee").addScalar("fd_stop_fee").addScalar("fd_carwash_fee")
					.addScalar("fd_other_fee").addScalar("fd_infringe_fee").addScalar("fd_maintenance_fee")
					.addScalar("fd_repair_fee").addScalar("fd_insurance_price");
			if (StringUtil.isNotNull(fdStartDate)) {
				query.setParameter("fdStartDate", startDate);
			}
			if (StringUtil.isNotNull(fdEndDate)) {
				query.setParameter("fdEndDate", endDate);
			}
			List valueList = query.list();
			int total = valueList.size();
			if (total > 0) {
				page.setRowsize(hqlInfo.getRowSize());
				page.setPageno(hqlInfo.getPageNo());
				page.setTotalrows(total);
				page.setOrderby(hqlInfo.getOrderBy());
				page.excecute();
				query.setFirstResult(page.getStart());
				query.setMaxResults(page.getRowsize());
				List dlist = query.list();
				return dlist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return null;
	}

	private Date convertDate(String date, String timeType, String type) throws NumberFormatException, ParseException {
		if ("3".equals(timeType)) {
			return DateUtil.convertStringToDate(date, DateUtil.TYPE_DATE, ResourceUtil.getLocaleByUser());
		} else {
			if ("start".equals(type)) {
				return PeriodTypeModel.getSinglePeriod(date).getFdStart();
			} else {
				return PeriodTypeModel.getSinglePeriod(date).getFdEnd();
			}
		}
	}


	/**
	 * <p>返回当前数据时间差函数</p>
	 * @return
	 * @author 孙佳
	 */
	private String getDateDiffFunction(String startField, String endField) {
		String sqlDialet = ResourceUtil.getKmssConfigString("hibernate.dialect");
		if (sqlDialet.contains("MySQL")) {
			return "TIMESTAMPDIFF(Minute, " + endField + ", " + startField + ")";
		} else if (sqlDialet.contains("SQLServer")) {
			return "DATEDIFF(Minute, " + endField + ", " + startField + ")";
		} else if (sqlDialet.contains("Oracle")) {
			//return "ceil(((To_date(" + endField + ") - To_date(" + startField + "))) * 24 * 60)";
			//return "ROUND(TO_NUMBER(" + startField + " - " + endField + ") * 24 * 60)";
			// 某些版本的Oracle数据为对时间计算存在误差，所以将Oracle数据库的时间计算交给程序处理
			//数据库初始的时间格式是timstamp,因此进行转换 #110490
//			String toStartDate = " to_date(TO_CHAR(to_timestamp("+startField+"),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss')";
//			String toEndDate = "to_date(TO_CHAR(to_timestamp("+endField+"),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss')";
//			return "ROUND(TO_NUMBER(" + toStartDate + " - " + toEndDate + ") * 24 * 60)";
		} else if (sqlDialet.contains("db2")) {
			return "timestampdiff(4, char(timestamp(" + endField + ") - timestamp(" + startField + ")))";
		}
		// 返回-1，表示数据库不支持此函数，需要在程序中计算
		return "-1";
	}

	/**
	 * 计算时间差总和
	 * @param sql
	 * @param startDate
	 * @param endDate
	 * @param select
	 * @return
	 */
	private Map<String, Long> getDateDiffSum(String sql, Date startDate, Date endDate, String select) {
		// SQL处理
		sql = sql.toLowerCase().split("group")[0];
		String[] split = sql.split(" from ");
		StringBuffer sb = new StringBuffer();
		sb.append("select ").append(select);
		sb.append(" from ").append(split[1]);
		if (logger.isInfoEnabled()) {
			logger.info("查询时间区间SQL：" + sb);
		}
		Session session = this.getHibernateSession();
		Query query = session.createNativeQuery(sb.toString());
		if (startDate != null) {
			query.setParameter("fdstartdate", startDate);
		}
		if (endDate != null) {
			query.setParameter("fdenddate", endDate);
		}
		List<Object[]> list = query.list();
		Map<String, Long> map = new HashMap<>();
		if(CollectionUtils.isNotEmpty(list)) {
			for (Object[] objs : list) {
				// 查询字段为：ID，结束时间，开始时间
				String id = (String) objs[0];
				Date end = (Date) objs[1];
				Date start = (Date) objs[2];
				Long times = map.get(id);
				if (times == null) {
					times = 0L;
				}
				times += getDateDiff(start, end);
				map.put(id, times);
			}
		}
		if (logger.isInfoEnabled()) {
			logger.info("查询结果：" + map);
		}
		return map;
	}

	/**
	 * 获取2个时间差（分钟）
	 *
	 * @param start
	 * @param end
	 * @return
	 */
	private long getDateDiff(Date start, Date end) {
		if (start == null || end == null) {
			return 0;
		}
		return (end.getTime() - start.getTime()) / 1000 / 60;
	}

}
