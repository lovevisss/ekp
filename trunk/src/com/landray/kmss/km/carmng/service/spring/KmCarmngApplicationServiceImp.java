package com.landray.kmss.km.carmng.service.spring;

import com.google.common.collect.Lists;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.constant.SysNotifyConstant;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;
import com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet;
import com.landray.kmss.km.carmng.model.KmCarmngPath;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersInfoService;
import com.landray.kmss.km.carmng.service.IKmCarmngEvaluationService;
import com.landray.kmss.km.carmng.service.IKmCarmngMotorcadeSetService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.notify.interfaces.NotifyReplace;
import com.landray.kmss.sys.number.interfaces.ISysNumberFlowService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.portal.cloud.util.ListDataUtil;
import com.landray.kmss.sys.portal.util.PortletTimeUtil;
import com.landray.kmss.sys.workflow.interfaces.Event_SysFlowFinish;
import com.landray.kmss.sys.workflow.interfaces.SysFlowUtil;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.sunbor.web.tag.Page;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 用车申请业务接口实现
 */
public class KmCarmngApplicationServiceImp extends ExtendDataServiceImp
		implements IKmCarmngApplicationService, ApplicationListener {

	private IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService;

	private IKmCarmngEvaluationService kmCarmngEvaluationService;
	private ISysNumberFlowService sysNumberFlowService;

	public void setSysNumberFlowService(
			ISysNumberFlowService sysNumberFlowService) {
		this.sysNumberFlowService = sysNumberFlowService;
	}
	public IKmCarmngDispatchersInfoService getKmCarmngDispatchersInfoService() {
		return (IKmCarmngDispatchersInfoService)SpringBeanUtil.getBean("kmCarmngDispatchersInfoService");
	}


	public void setKmCarmngEvaluationService(IKmCarmngEvaluationService kmCarmngEvaluationService) {
		this.kmCarmngEvaluationService = kmCarmngEvaluationService;
	}

	public void setKmCarmngMotorcadeSetService(
			IKmCarmngMotorcadeSetService kmCarmngMotorcadeSetService) {
		this.kmCarmngMotorcadeSetService = kmCarmngMotorcadeSetService;
	}

	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public void setSysNotifyMainCoreService(
			ISysNotifyMainCoreService sysNotifyMainCoreService) {
		this.sysNotifyMainCoreService = sysNotifyMainCoreService;
	}

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) modelObj;
		String fdApplicationPath = "";
		for (KmCarmngPath p : kmCarmngApplication.getFdPaths()) {
			if (!StringUtil.isNull(p.getFdDestination())) {
				fdApplicationPath += p.getFdDestination() + ";";
			}
		}
		if (StringUtil.isNotNull(fdApplicationPath)) {
			kmCarmngApplication
					.setFdApplicationPath(fdApplicationPath.substring(0, fdApplicationPath.lastIndexOf(";")));
		}
		KmCarmngMotorcadeSet kmCarmngMotorcadeSet = new KmCarmngMotorcadeSet();
		if (!"10".equals(kmCarmngApplication.getDocStatus())) {
			kmCarmngApplication.setFdNo(
					sysNumberFlowService
							.generateFlowNumber(kmCarmngApplication));
		}
		String rtnVal = super.add(kmCarmngApplication);
		return rtnVal;
	}

	@Override
	public void update(IBaseModel modelObj) throws Exception {
		KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) modelObj;
		String fdApplicationPath = "";
		for (KmCarmngPath p : kmCarmngApplication.getFdPaths()) {
			if (!StringUtil.isNull(p.getFdDestination())) {
				fdApplicationPath += p.getFdDestination() + ";";
			}
		}
		if (StringUtil.isNotNull(fdApplicationPath)) {
			kmCarmngApplication
					.setFdApplicationPath(fdApplicationPath.substring(0, fdApplicationPath.lastIndexOf(";")));
		}
		if (StringUtil.isNull(kmCarmngApplication.getFdNo())
				&& !"10".equals(kmCarmngApplication.getDocStatus())) {
			kmCarmngApplication.setFdNo(sysNumberFlowService.generateFlowNumber(kmCarmngApplication));
		}
		super.update(kmCarmngApplication);
	}

	@Override
	public void delete(IBaseModel modelObj) throws Exception {
		KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) modelObj;
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock("kmCarmngDispatchersInfo.fdApplicationIds like :id");
		hqlInfo.setParameter("id", "%" + kmCarmngApplication.getFdId() + "%");
		List<KmCarmngDispatchersInfo> dispatchersInfoList = getKmCarmngDispatchersInfoService().findList(hqlInfo);
		if (!dispatchersInfoList.isEmpty()) {
			KmCarmngDispatchersInfo kmCarmngDispatchersInfo = dispatchersInfoList.get(0);
			String[] AppIds = kmCarmngDispatchersInfo.getFdApplicationIds().split(";");
			String[] AppNames = kmCarmngDispatchersInfo.getFdApplicationNames().split(";");
			if (AppIds.length <= 1) {
				getKmCarmngDispatchersInfoService().delete(kmCarmngDispatchersInfo);
			} else { 
				//AppIds中除去当前自身的FdId以外的值
				List<String> newAppIds=Lists.newArrayList(); 
				List<String> newAppNames=Lists.newArrayList();  
				//理论上id,name的长度是一样的
				if(AppIds.length == AppNames.length) {
					for (int k = 0; k < AppIds.length; k++) { 	 
						if (!AppIds[k].equals(kmCarmngApplication.getFdId())) { 
							newAppIds.add(AppIds[k]);
							newAppNames.add(AppNames[k]); 
						}
					}  
				} 
				kmCarmngDispatchersInfo.setFdApplicationIds(StringUtil.join(newAppIds,";"));
				kmCarmngDispatchersInfo.setFdApplicationNames(StringUtil.join(newAppNames,";"));
				getKmCarmngDispatchersInfoService().update(kmCarmngDispatchersInfo);
			}
		}

		HQLInfo evalHqlInfo = new HQLInfo();
		evalHqlInfo.setWhereBlock("kmCarmngEvaluation.fdApplication.fdId like :id");
		evalHqlInfo.setParameter("id", "%" + kmCarmngApplication.getFdId() + "%");
		List<KmCarmngEvaluation> evalList = kmCarmngEvaluationService.findList(evalHqlInfo);
		if (evalList.size() > 0) {
			for (KmCarmngEvaluation e : evalList) {
				kmCarmngEvaluationService.delete(e);
			}
		}
		super.delete(kmCarmngApplication);
	}

	/**
	 * @param kmCarmngApplication
	 * @throws Exception
	 *             description:向申请人发送待阅“您申请的用车已经安排，请查看，主题：......”
	 */
	@Override
	public void saveSendNotify(KmCarmngApplication kmCarmngApplication,
							   List otherUser, StringBuffer driverMsg)
			throws Exception {
		List targets = new ArrayList();
		targets.add(kmCarmngApplication.getFdApplicationPerson());
		if (!ArrayUtil.isEmpty(otherUser)) {
			targets.addAll(otherUser);
		}
		sendTodoFromResource(kmCarmngApplication,
				"km-carmng:kmCarmngApplication.dispatcher.notify.1", targets,
				"sendKmCarmngApplicationNotify",
				SysNotifyConstant.NOTIFY_TODOTYPE_ONCE, driverMsg);// 待阅
	}

	@Override
	public void sendNotify_update(KmCarmngApplication kmCarmngApplication,
								  List otherUser, StringBuffer driverMsg) throws Exception {
		List targets = new ArrayList();
		targets.add(kmCarmngApplication.getFdApplicationPerson());
		if (!ArrayUtil.isEmpty(otherUser)) {
			targets.addAll(otherUser);
		}
		sendTodoFromResource(kmCarmngApplication, "km-carmng:kmCarmngApplication.dispatcher.notify.1", targets,
				"sendKmCarmngApplicationNotify_update",
				SysNotifyConstant.NOTIFY_TODOTYPE_ONCE, driverMsg);// 待阅
	}

	/**
	 * @param kmCarmngApplication
	 * @throws Exception
	 *             description:向调度员发送待阅“车辆申请已通过，请调度派车，主题......”
	 */
	public void saveSendNotify_flowPublish(
			KmCarmngApplication kmCarmngApplication) throws Exception {
		List targets = new ArrayList();
		targets.add(kmCarmngApplication.getFdMotorcade().getFdDispatchers());
		// 向调度员发送待办“车辆申请已通过，请调度派车，主题：%km-carmnag:kmCarmngApplication.docSubject%”
		sendTodoFromResource(kmCarmngApplication,
				"km-carmng:kmCarmngApplication.dispatcher.notify.4", targets,
				"sendKmCarmngApplicationPublishNotify",
				SysNotifyConstant.NOTIFY_TODOTYPE_MANUAL, null);// 待办
	}

	private NotifyReplace getNotifyReplace(
			KmCarmngApplication kmCarmngApplication,
			String resource) {
		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText(resource,
				kmCarmngApplication.getDocSubject());
		return notifyReplace;
	}

	private HashMap getReplaceMap(KmCarmngApplication kmCarmngApplication,
			String resource) {
		HashMap replaceMap = new HashMap();
		replaceMap.put(resource, kmCarmngApplication.getDocSubject());
		return replaceMap;
	}

	/**
	 * 
	 * @param kmCarmngApplication
	 * @param resource
	 * @param targetsList
	 * @param key
	 * @throws Exception
	 */
	private void sendTodoFromResource(KmCarmngApplication kmCarmngApplication,
			String resource, List targetsList, String key, int flag,
			StringBuffer driverMsg)
			throws Exception {
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext(resource);
		notifyContext.setNotifyType("todo");
		notifyContext.setFlag(flag);
		notifyContext.setKey(key);
		// 设置待办发起人
		if ("km-carmng:kmCarmngApplication.dispatcher.notify.4"
				.equals(resource)) {
			notifyContext.setDocCreator(kmCarmngApplication.getDocCreator());
		}
		NotifyReplace notifyReplace = getNotifyReplace(kmCarmngApplication,
				"km-carmnag:kmCarmngApplication.docSubject");
		if ("km-carmng:kmCarmngApplication.dispatcher.notify.1"
				.equals(resource)) {
			notifyReplace.addReplaceText("km-carmng:kmCarmngDriversInfo.fdName",
					driverMsg.toString());
		}
		if ("sendKmCarmngApplicationNotify_update".equals(key)) {
			//不过滤重复待阅
			notifyContext.setParameter1("support_moretimes_send_todo");
		}
		notifyContext.setNotifyTarget(targetsList);
		sysNotifyMainCoreService.sendNotify(kmCarmngApplication, notifyContext,
				notifyReplace);
	}

	@Override
	public void onApplicationEvent(ApplicationEvent event) {
		if (event == null) {
            return;
        }
		Object obj = event.getSource();
		if (!(obj instanceof KmCarmngApplication)) {
            return;
        }
		if (event instanceof Event_SysFlowFinish) {
			KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) obj;
			try {
				saveSendNotify_flowPublish(kmCarmngApplication);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	protected IBaseModel initBizModelSetting(RequestContext requestContext)
			throws Exception {
		String templateId = requestContext.getParameter("categoryId");
		if (!StringUtil.isNotNull(templateId)) {
			return null;
		}
		KmCarmngApplication model = new KmCarmngApplication();
		KmCarmngMotorcadeSet template = (KmCarmngMotorcadeSet) kmCarmngMotorcadeSetService
				.findByPrimaryKey(templateId);
		model.setFdIsDispatcher(1);
		// 随车人数
		model.setFdUserNumber("1");
		// 车队名称
		model.setFdMotorcade(template);
		// 创建时间
		model.setDocCreateTime(new Date());
		// 申请时间
		model.setFdApplicationTime(new Date());
		// 备注
		model.setFdRemark(template.getFdRemark());
		SysOrgElement person = UserUtil.getUser();
		// 用车人
		List<SysOrgElement> list = new ArrayList<SysOrgElement>();
		list.add(person);
		model.setFdUserPersons(list);
		// 创建人
		model.setDocCreator((SysOrgPerson) person);
		// 申请人
		model.setFdApplicationPerson((SysOrgPerson) person);
		// 申请人电话
		model.setFdApplicationPersonPhone(((SysOrgPerson) person)
				.getFdMobileNo());
		// 申请部门
		SysOrgElement dept = UserUtil.getUser().getFdParent();
		if (dept != null) {
			model.setFdApplicationDept(dept);
		}
		return model;
	}

	@Override
	protected void initCoreServiceFormSetting(IExtendForm form,
			IBaseModel model, RequestContext requestContext) throws Exception {
		KmCarmngApplication kmCarmngApplication = (KmCarmngApplication) model;
		dispatchCoreService.initFormSetting(form, "kmCarmngMotorcadeSet",
				kmCarmngApplication.getFdMotorcade(), "kmCarmngMotorcadeSet",
				requestContext);
	}

	@Override
	public Map<String, ?> listPortlet(RequestContext request) throws Exception {
		Map<String, Object> rtnMap = new HashMap<>();
		JSONArray datas = new JSONArray();// 列表形式使用
		Page page = Page.getEmptyPage();// 简单列表使用
		String dataview = request.getParameter("dataview");
		String owner = request.getParameter("owner");// 我发起的
		String status = request.getParameter("status");
		String myFlow = request.getParameter("myFlow");// 我审批的
		HQLInfo hqlInfo = new HQLInfo();
		if (StringUtil.isNotNull(owner)) {
			UserOperHelper.setEventType(ResourceUtil.getString(
					"km-carmng:kmCarmngApplication.portlet.myFlow.create.my"));
			getOwnerData(request, status, hqlInfo);
			request.setAttribute("flag", "owner");
		} else {
			if (!"all".equals(myFlow)) {
                UserOperHelper.setEventType(ResourceUtil.getString(
                        "km-carmng:kmCarmngApplication.portlet.myFlow.involved"));
            }
			getMyFlowDate(request, myFlow, hqlInfo);
		}
		hqlInfo.setGetCount(false);
		// 时间范围参数
		String scope = request.getParameter("scope");
		if (StringUtil.isNotNull(scope) && !"no".equals(scope)) {
			String block = hqlInfo.getWhereBlock();
			hqlInfo.setWhereBlock(StringUtil.linkString(block, " and ",
					"kmCarmngApplication.docCreateTime > :fdStartTime"));
			hqlInfo.setParameter("fdStartTime", PortletTimeUtil
					.getDateByScope(scope));
		}
		page = findPage(hqlInfo);
		UserOperHelper.logFindAll(page.getList(), getModelName());
		if ("classic".equals(dataview)) {// 视图展现方式:classic(简单列表)
			List<KmCarmngApplication> topics = page.getList();
			for (KmCarmngApplication topic : topics) {
				JSONObject data = new JSONObject();
				// 主题
				data.put("text", topic.getDocSubject());
				if (request.isCloud()) {
					String isNew = request.getParameter("isNew");
					if(topic.getDocStatus().equals(SysDocConstant.DOC_STATUS_DRAFT) ||
							topic.getDocStatus().equals(SysDocConstant.DOC_STATUS_EXAMINE)){
						if("true".equals(isNew)){
							data.put("statusInfo",ListDataUtil.buildIinfo(null,ResourceUtil.getString(
									"kmCarmng.status.publish.unHold", "km-carmng"),null, "warning", null));
						} else {
							data.put("statusInfo",ResourceUtil.getString(
									"kmCarmng.status.publish.unHold", "km-carmng"));
							data.put("statusColor","warning");
						}
					}
					if("31".equals(topic.getDocStatus()) ||
							topic.getDocStatus().equals(SysDocConstant.DOC_STATUS_PUBLISH)){
						if("true".equals(isNew)){
							data.put("statusInfo",ListDataUtil.buildIinfo(null, ResourceUtil.getString(
									"kmCarmng.status.publish.holding", "km-carmng"), null, "success", null));
						} else {
							data.put("statusInfo",ResourceUtil.getString(
									"kmCarmng.status.publish.holding", "km-carmng"));
							data.put("statusColor","success");
						}
					}
					if(topic.getDocStatus().equals(SysDocConstant.DOC_STATUS_DISCARD)){
						if("true".equals(isNew)){
							data.put("statusInfo",ListDataUtil.buildIinfo(null, ResourceUtil.getString(
									"kmCarmng.tree.discard", "km-carmng"), null, "weaken", null));
						} else {
							data.put("statusInfo",ResourceUtil.getString(
									"kmCarmng.tree.discard", "km-carmng"));
							data.put("statusColor","weaken");
						}
					}
					data.put("creator",
							ListDataUtil.buildCreator(topic.getDocCreator()));
					if("true".equals(isNew)){
						// 车队名称
						data.put("cateName", ListDataUtil.buildIinfo(topic.getFdMotorcade().getFdName()));
						// 创建时间
						data.put("created", ListDataUtil.buildIinfo(topic.getDocCreateTime().getTime()));
					} else {
						// 车队名称
						data.put("cateName", topic.getFdMotorcade().getFdName());
						// 创建时间
						data.put("created", topic.getDocCreateTime().getTime());
					}
					JSONArray infos = new JSONArray();
					JSONObject info = new JSONObject();
					info.put("title",
							ResourceUtil.getString(
									"kmCarmngApplication.fdUserNumber",
									"km-carmng") + ": "
									+ topic.getFdUserNumber());
					infos.add(info);
					data.put("infos", infos);
				} else {
					// 创建人
					data.put("creator", topic.getDocCreator().getFdName());
					// 车队名称
					data.put("catename", topic.getFdMotorcade().getFdName());
					// 创建时间
					data.put("created", DateUtil.convertDateToString(
							topic.getDocCreateTime(), DateUtil.TYPE_DATETIME,
							request.getLocale()));
				}
				StringBuffer sb = new StringBuffer();
				sb
						.append("/km/carmng/km_carmng_application/kmCarmngApplication.do?method=view");
				sb.append("&fdId=" + topic.getFdId());
				data.put("href", sb.toString());
				if (request.isCloud()) {
					// List<IconDataVO> icons = new ArrayList<>(1);
					// IconDataVO icon = new IconDataVO();
					// icon.setName("tree-navigation");
					// icons.add(icon);
					// data.put("icons", icons);
				}
				datas.add(data);
			}
		}
		rtnMap.put("datas", datas);
		rtnMap.put("page", page);
		return rtnMap;
	}

	private void getOwnerData(RequestContext request, String status,
			HQLInfo hqlInfo) throws Exception {

		String param = request.getParameter("rowsize");
		int rowsize = 6;
		if (!StringUtil.isNull(param)) {
            rowsize = Integer.parseInt(param);
        }
		String whereBlock = "";
		if ("all".equals(status)) {
			whereBlock = StringUtil.linkString(whereBlock, " AND ",
					"kmCarmngApplication.docCreator.fdId=:creatorId");
			hqlInfo.setParameter("creatorId", UserUtil.getUser().getFdId());
		} else {
			whereBlock = StringUtil
					.linkString(whereBlock, " AND ",
							"kmCarmngApplication.docStatus=:docStatus AND kmCarmngApplication.docCreator.fdId=:creatorId");
			hqlInfo.setParameter("docStatus", status);
			hqlInfo.setParameter("creatorId", UserUtil.getUser().getFdId());
		}
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setOrderBy("kmCarmngApplication.docCreateTime desc");
		hqlInfo.setRowSize(rowsize);
		hqlInfo.setPageNo(1);
		hqlInfo.setGetCount(false);
	}

	private void getMyFlowDate(RequestContext request, String myFlow,
			HQLInfo hqlInfo) throws Exception {
		String param = request.getParameter("rowsize");
		int rowsize = 6;
		if (!StringUtil.isNull(param)) {
            rowsize = Integer.parseInt(param);
        }

		// 车队名称查询
		String kmCarmngMotorcadeId = request
				.getParameter("kmCarmngMotorcadeId");
		StringBuffer whereBlockBuffer = new StringBuffer();
		if (StringUtil.isNotNull(kmCarmngMotorcadeId)) {
			// 选择的车队
			whereBlockBuffer
					.append("kmCarmngApplication.fdMotorcade.fdId = :kmCarmngMotorcadeId");
			hqlInfo.setParameter("kmCarmngMotorcadeId", kmCarmngMotorcadeId);
		} else {
			whereBlockBuffer.append("1=1 ");
		}

		String whereBlock = whereBlockBuffer.toString();
		if ("executed".equals(myFlow)) {
			SysFlowUtil.buildLimitBlockForMyApproved("kmCarmngApplication",
					hqlInfo);
		} else if ("unExecuted".equals(myFlow)) {
			SysFlowUtil.buildLimitBlockForMyApproval("kmCarmngApplication",
					hqlInfo);
		} else if ("all".equals(myFlow)) {
			hqlInfo.setWhereBlock(whereBlock);
		}
		hqlInfo.setOrderBy("kmCarmngApplication.docCreateTime desc");
		hqlInfo.setRowSize(rowsize);
		hqlInfo.setPageNo(1);
		hqlInfo.setGetCount(false);
	}

}
