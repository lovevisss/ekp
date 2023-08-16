package com.landray.kmss.km.carmng.service.spring;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.annotation.RestApi;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/api/km-carmng/main", method = RequestMethod.POST)
@RestApi(docUrl = "/km/carmng/rest/kmCarmngRestHelp.jsp", name = "kmCarmngMainDataService", resourceKey = "km-carmng:kmCarmngMain.job.sync")
public class KMCarmngMainDataServiceImp {

	private IKmCarmngApplicationService kmCarmngApplicationService;

	public void setKmCarmngApplicationService(IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}
	
	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	public void setKmCarmngMotorcadeSetService(IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService) {
		this.kmCarmngMotorcadeSetService = kmCarmngMotorcadeSetService;
	}
	

	@ResponseBody
	@RequestMapping("/get")
	public JSONObject getCarmng(@RequestBody JSONObject paramData) {
		JSONObject result = new JSONObject();
		result.put("success", false);
		try {
			Date beginTime = null;
			if (paramData != null && paramData.containsKey("beginTime")) {
				beginTime = DateUtil.convertStringToDate(paramData.getString("beginTime"));
			}
			// 只获取当天的有效会议
			HQLInfo info = new HQLInfo();
			StringBuffer sb = new StringBuffer();
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			if (beginTime == null || cal.getTime().after(beginTime)) {
				// 如果是当天第一次同步，则同步所有当天的日程
				sb.append(
						"kmCarmngApplication.docStatus=:docStatus and ((kmCarmngApplication.fdStartTime<:beginTime and kmCarmngApplication.fdEndTime>:beginTime) or (kmCarmngApplication.fdStartTime>:beginTime and kmCarmngApplication.fdStartTime<:endTime))");
			} else {
				info.setParameter("publishTime", beginTime);
				sb.append(
						"kmCarmngApplication.docStatus=:docStatus and kmCarmngApplication.fdLastModifiedTime>:publishTime and ((kmCarmngApplication.fdStartTime<:beginTime and kmCarmngApplication.fdEndTime>:beginTime) or (kmCarmngApplication.fdStartTime>:beginTime and kmCarmngApplication.fdStartTime<:endTime))");
			}
			info.setWhereBlock(sb.toString());
			info.setParameter("docStatus", SysDocConstant.DOC_STATUS_PUBLISH);
			info.setParameter("beginTime", cal.getTime());
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 5);
			info.setParameter("endTime", cal.getTime());
			List<?> retVal = kmCarmngApplicationService.findList(info);
			JSONArray array = new JSONArray();
			for (int i = 0; i < retVal.size(); i++) {
				KmCarmngApplication application = (KmCarmngApplication) retVal.get(i);
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("workItemId", application.getFdId());
				jsonObject.put("workTitle", application.getDocSubject());
				jsonObject.put("bgTime",
						application.getFdStartTime() != null ? application.getFdStartTime().getTime() : null);
				jsonObject.put("endTime",
						application.getFdEndTime() != null ? application.getFdEndTime().getTime() : null);
				jsonObject.put("jobStatus", "UPDATE");
				jsonObject.put("brief", application.getFdDeparture()+"-"+application.getFdDestination());
				jsonObject.put("detailUrl", StringUtil.formatUrl(ModelUtil.getModelUrl(application),true));
				List<String> fdLoginName = new ArrayList<String>();
				for (Object element : application.getFdUserPersons()) {
					SysOrgPerson sysOrgPerson = (SysOrgPerson) element;
					fdLoginName.add(sysOrgPerson.getFdLoginName());
				}
				jsonObject.put("loginNames", fdLoginName);
				array.add(jsonObject);
			}
			result.put("datas", array);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "处理过程中出错：" + e.getMessage());
		}
		return result;
	}
	@ResponseBody
	@RequestMapping("/getCate")
	public JSONObject getCarCategory() {
		JSONObject retJson = new JSONObject();
		try {
			retJson.put("errcode", 0);
			retJson.put("errmsg", "");
			JSONArray datas = new JSONArray();
			HQLInfo hql = new HQLInfo();
			List catelist = kmCarmngMotorcadeSetService.findList(hql);
			for(Object obj : catelist) {
				KmCarmngMotorcadeSet cate = (KmCarmngMotorcadeSet)obj;
				JSONObject data = new JSONObject();
				data.put("id", cate.getFdId());
				data.put("name",cate.getFdName());
				datas.add(data);
			}
			retJson.put("data", datas);
		} catch (Exception e) {
			e.printStackTrace();
			retJson.put("errcode", -1);
			retJson.put("errmsg", "system error," + e.toString());
		}
		return retJson;
	}
}
