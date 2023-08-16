package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.hibernate.CacheMode;
import org.hibernate.query.NativeQuery;

import com.landray.kmss.common.dao.IBaseDao;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList;
import com.landray.kmss.km.carmng.model.KmCarmngRegisterInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoListService;
import com.landray.kmss.km.carmng.service.IKmCarmngExcelService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.excel.Column;
import org.hibernate.type.StandardBasicTypes;

public class KmCarmngDispatchersInfoListServiceImp extends BaseServiceImp implements
		IKmCarmngDispatchersInfoListService {

	private IKmCarmngExcelService kmCarmngExcelService;

	public void setKmCarmngExcelService(IKmCarmngExcelService kmCarmngExcelService) {
		this.kmCarmngExcelService = kmCarmngExcelService;
	}

	@Override
    public void saveExportExcel(List kmCarmngDispatchersInfoList, HttpServletResponse response) throws Exception {
		try {
			String title = ResourceUtil.getString("kmCarmng.excel.export1", "km-carmng");
			Column[] cols = new Column[15];
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[0].setTitleKey("kmCarmng.page.serial");
			cols[1].setTitleKey("kmCarmngDispatchersInfo.fdNotifyPerson.1");
			cols[2].setTitleKey("kmCarmngApplication.fdApplicationDept");
			cols[3].setTitleKey("kmCarmngApplication.fdApplicationDeptParent");
			cols[4].setTitleKey("kmCarmngDispatchersInfo.fdCarInfoId");
			cols[5].setTitleKey("kmCarmngInfomation.docSubject");
			cols[6].setTitleKey("kmCarmngDispatchersInfo.fdStartTime");
			cols[7].setTitleKey("kmCarmngDispatchersInfo.fdEndTime");
			cols[8].setTitleKey("kmCarmngDispatchersInfo.fdTravelPath");
			cols[9].setTitleKey("kmCarmngRegisterInfo.fdStartTime");
			cols[10].setTitleKey("kmCarmngRegisterInfo.fdEndTime");
			cols[11].setTitleKey("kmCarmngUserFeeInfo.fdMileageNumber");
			cols[12].setTitleKey("kmCarmngRegisterInfo.fdTotalFee1");
			cols[13].setTitleKey("kmCarmngDispatchersInfo.fdDriverId");
			cols[14].setTitleKey("kmCarmngDispatchersInfo.fdFlag");
			List rowsList = new ArrayList();
			if (kmCarmngDispatchersInfoList.size() == 0) {
				Object[] row = new Object[15];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				row[7] = null;
				row[8] = null;
				row[9] = null;
				row[10] = null;
				row[11] = null;
				row[12] = null;
				row[13] = null;
				row[14] = null;
				rowsList.add(row);
			} else {
				for (int i = 0; i < kmCarmngDispatchersInfoList.size(); i++) {
					Object[] row = new Object[15];
					KmCarmngDispatchersInfoList k = (KmCarmngDispatchersInfoList) kmCarmngDispatchersInfoList
							.get(i);
					KmCarmngRegisterInfo kmCarmngRegisterInfo = k.getFdRegisterInfo();
					row[0] = new Integer(i + 1).toString();
					row[4] = k.getFdCarInfoNo();
					row[5] = k.getFdCarInfoName();
					row[6] = DateUtil.convertDateToString(
							k.getFdDispatchersInfo().getFdStartTime(),
							DateUtil.TYPE_DATETIME, Locale.getDefault());

					row[7] = DateUtil.convertDateToString(
							k.getFdDispatchersInfo().getFdEndTime(),
							DateUtil.TYPE_DATETIME, Locale.getDefault());

					IBaseDao baseDao = (IBaseDao) SpringBeanUtil.getBean("KmssBaseDao");
					String sql = "select m.fd_departure, m.fd_destination, "
							+ "(SELECT fd_name FROM sys_org_element WHERE fd_id = fd_application_person) AS personName, "
							+ "(SELECT fd_name FROM sys_org_element WHERE fd_id = fd_application_dept) AS deptName, "
							+ "(SELECT fd_name FROM sys_org_element WHERE fd_id = (SELECT fd_parentid FROM sys_org_element WHERE fd_id = fd_application_dept)) AS gsName "
							+ "from km_carmng_application m where m.fd_id in ('"
							+ k.getFdDispatchersInfo().getFdApplicationIds().replace(";", "','") + "')";
					NativeQuery query = baseDao.getHibernateSession().createNativeQuery(sql);
					query.setCacheable(true);
					query.setCacheMode(CacheMode.NORMAL);
					query.setCacheRegion("km-carmng");
					// 增加别名
					query.addScalar("fd_departure", StandardBasicTypes.STRING)
							.addScalar("fd_destination",
									StandardBasicTypes.STRING)
							.addScalar("personName", StandardBasicTypes.STRING)
							.addScalar("deptName", StandardBasicTypes.STRING)
							.addScalar("gsName", StandardBasicTypes.STRING);
					;
					for (Object obj : query.list()) {
						Object[] result = (Object[]) obj;
						row[8] = result[0] + "-" + result[1];
						// 申请人
						row[1] = result[2];
						// 申请人部门
						row[2] = result[3];
						// 所属机构
						row[3] = result[4];
					}

					// row[5] =
					// DateUtil.convertDateToString(k.getFdDispatchersInfo().getFdEndTime(),
					// DateUtil.TYPE_DATETIME, Locale.getDefault());

					if (kmCarmngRegisterInfo != null) {
						row[9] = DateUtil.convertDateToString(
								kmCarmngRegisterInfo.getFdStartTime(),
								DateUtil.TYPE_DATETIME, Locale.getDefault());
						row[10] = DateUtil.convertDateToString(
								kmCarmngRegisterInfo.getFdEndTime(),
								DateUtil.TYPE_DATETIME, Locale.getDefault());
						if (kmCarmngRegisterInfo.getFdMileageNumber() != null) {
							row[11] = kmCarmngRegisterInfo.getFdMileageNumber()
									.toString();
						}
						// 用车费用合计
						if (kmCarmngRegisterInfo.getFdTotalFee() != null) {
							row[12] = kmCarmngRegisterInfo.getFdTotalFee()
									.toString();
						}
					}
					row[13] = k.getFdDriverName();
					if ("0".equals(k.getFdFlag())) {
						row[14] = ResourceUtil.getString(
								"kmCarmngDispatchersInfo.fdFlag1", "km-carmng");
					} else {
						row[14] = ResourceUtil.getString(
								"kmCarmngDispatchersInfo.fdFlag2", "km-carmng");
					}
					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
