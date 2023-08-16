package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.context.KmCarmngContext;
import com.landray.kmss.km.carmng.dao.IKmCarmngMaintenanceInfoDao;
import com.landray.kmss.km.carmng.service.IKmCarmngExcelService;
import com.landray.kmss.km.carmng.service.IKmCarmngMaintenanceInfoService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.NumberUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.util.excel.Column;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 车辆保养业务接口实现
 */
public class KmCarmngMaintenanceInfoServiceImp extends BaseServiceImp implements
		IKmCarmngMaintenanceInfoService {

	private IKmCarmngExcelService kmCarmngExcelService;

	public void setKmCarmngExcelService(
			IKmCarmngExcelService kmCarmngExcelService) {
		this.kmCarmngExcelService = kmCarmngExcelService;
	}

	@Override
    public List count(HttpServletRequest request) throws Exception {
		List returnList = ((IKmCarmngMaintenanceInfoDao) getBaseDao())
				.count(request);
		return returnList;
	}

	@Override
    public void saveExportExcel(List valueList, HttpServletResponse response,
                                HttpServletRequest request) throws Exception {
		try {
			String title = ResourceUtil.getString("kmCarmng.excel.export3",
					"km-carmng");
			String fdStartTime = request.getParameter("fdStartTime");
			String fdEndTime = request.getParameter("fdEndTime");
			if (StringUtil.isNotNull(fdStartTime) && StringUtil.isNotNull(fdEndTime)) {
				title += " (" + fdStartTime + " - " + fdEndTime + ") ";
			} else if (StringUtil.isNotNull(fdStartTime) || StringUtil.isNotNull(fdEndTime)) {
				if (StringUtil.isNotNull(fdStartTime)) {
					title += " (" + fdStartTime + ") ";
				} else {
					title += " (" + fdEndTime + ") ";
				}
			} else {
				title += " ("
						+ DateUtil.convertDateToString(new Date(),
								DateUtil.TYPE_DATE, UserUtil.getKMSSUser()
										.getLocale()) + ") ";
			}
			Column[] cols = new Column[7];
			for (int i = 0; i < cols.length; i++) {
				cols[i] = new Column();
			}
			cols[0].setTitleKey("kmCarmng.page.serial");
			cols[1].setTitleKey("kmCarmngDispatchersInfo.fdCarInfoId");
			cols[2].setTitleKey("kmCarmngInfomation.docSubject");
			cols[3].setTitleKey("kmCarmngInfomation.fdVehichesType");
			cols[4].setTitleKey("kmCarmngMaintenanceInfo.fdMaintenanceFee");
			cols[5].setTitleKey("kmCarmngMaintenanceInfo.fdRepairFee");
			cols[6].setTitleKey("kmCarmng.fdTotalFee");
			List rowsList = new ArrayList();
			if (valueList.size() == 0) {
				Object[] row = new Object[7];
				row[0] = null;
				row[1] = null;
				row[2] = null;
				row[3] = null;
				row[4] = null;
				row[5] = null;
				row[6] = null;
				rowsList.add(row);
			} else {
				for (int i = 0; i < valueList.size(); i++) {
					Object[] row = new Object[7];
					KmCarmngContext kmCarmngContext = (KmCarmngContext) valueList
							.get(i);
					row[0] = new Integer(i + 1).toString();
					row[1] = kmCarmngContext.getFdCarNo();
					row[2] = kmCarmngContext.getFdCarName();
					row[3] = kmCarmngContext.getFdCarCategoryName();
					row[4] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdMaintenanceFee(), "#.##");
					row[5] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdRepairFee(), "#.##");
					row[6] = NumberUtil.roundDecimal(kmCarmngContext
							.getFdRepairFee()
							+ kmCarmngContext.getFdMaintenanceFee(), "#.##");
					rowsList.add(row);
				}
			}
			kmCarmngExcelService.export(title, cols, rowsList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
