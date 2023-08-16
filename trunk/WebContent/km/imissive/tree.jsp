<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.unit.util.SysUnitUtil"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.imissive" bundle="km-imissive" />",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,defaultNode;
	n1 = LKSTree.treeRoot;
	
	//参数设置
	n2 = n1.AppendURLChild(
		"<bean:message key="kmImissive.tree.paramSet" bundle="km-imissive" />");
		
	n2.isExpanded = true;	
	<kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">	
	//发文转收文题头设置
	n3=n2.AppendURLChild(
		"<bean:message key="kmMissive.tree.displayConfig" bundle="km-imissive" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.km.imissive.model.KmImissiveConfig" />"
	);	
	//业务类型设置
	n3=n2.AppendURLChild(
		"业务权限设置",
		"<c:url value="/km/imissive/km_imissive_rule/index.jsp" />"
	);
	//限办日期设置
	n3=n2.AppendURLChild(
		"<bean:message key="kmMissive.tree.xianBanRiQiSheZhi" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_deadline_config/kmImissiveDeadLineConfig.do?method=edit" />"
	);
	//文种设置
	n3=n2.AppendURLChild(
		"<bean:message key="table.kmImissiveType" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_type/index.jsp" />"
	);
	// 意见类型设置
	n2.AppendURLChild(
		"意见类型设置",
		"<c:url value="/sys/lbpmservice/support/lbpm_audit_note_type/index.jsp" />"
	);
	//密级程度设置
	n3=n2.AppendURLChild(
		"<bean:message key="table.kmImissiveSecretGrade" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_secret_grade/index.jsp" />"
	);
	//缓急程度设置
	n3=n2.AppendURLChild(
		"<bean:message key="table.kmImissiveEmergencyGrade" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_emergency_grade/index.jsp" />"
	);
	
	<kmss:authShow roles="ROLE_SYSUNIT_CONFIG_SETTING">	
	n3=n2.AppendURLChild(
		"<bean:message key="table.kmImissiveUnitCategory" bundle="km-imissive" />",
		"<c:url value="/sys/unit/km_imissive_unit_category/kmImissiveUnitCategory_tree.jsp" />"
	);
	//单位设置
	n3=n2.AppendURLChild(
		"<bean:message key="table.kmImissiveUnit" bundle="km-imissive" />",
		"<c:url value="/sys/unit/km_imissive_unit/index.jsp" />"
	);
	n3.AppendBeanData("kmImissiveUnitTreeService&parentId=!{value}");
	
	n3=n2.AppendURLChild(
		"<bean:message key="kmMissive.tree.ExchangeUnit" bundle="km-imissive" />",
		"<c:url value="/sys/unit/km_imissive_unit/indexOuter.jsp"/>"
	);
	// 机构组设置
	n3=n2.AppendURLChild(
		"<bean:message key="kmMissive.tree.UnitGroup" bundle="km-imissive" />",
		"<c:url value="/sys/unit/sys_unit_group/index.jsp" />"
	);
	</kmss:authShow>
	</kmss:authShow>
	//公文交换配置
	n3=n2.AppendURLChild(
		"<bean:message key="kmImissiveTemplateCfg.tree.config" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_template_cfg/index.jsp" />"
	);	
	n3.AppendURLChild(
		"<bean:message key="kmImissiveTemplateCfg.type.SR" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_template_cfg/index.jsp?type=SR" />"
	);
	n3.AppendURLChild(
		"<bean:message key="kmImissiveTemplateCfg.type.RS" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_template_cfg/index.jsp?type=RS" />"
	);
	n3.AppendURLChild(
		"<bean:message key="kmImissiveTemplateCfg.type.RR" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_template_cfg/index.jsp?type=RR" />"
	);
	<kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">	
		//列表显示设置
	n4 = n2.AppendURLChild(
		"<bean:message bundle="sys-profile" key="sys.profile.list.display.config"/>"
	);
	n13 = n4.AppendURLChild(
		"<bean:message bundle="km-imissive" key="setting.navigation.polymerization"/>"
	);
	n13.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.tree.Send"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&simple=false"/>"
	);
	n13.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.tree.Receive"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&simple=false"/>"
	);
	n13.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.tree.Sign"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&simple=false"/>"
	);
	n14 = n4.AppendURLChild(
	"<bean:message bundle="km-imissive" key="setting.navigation.ordinary"/>"
	);
	n14.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.tree.Send"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&simple=true"/>"
	);
	n14.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.tree.Receive"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&simple=true"/>"
	);
	n14.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.tree.Sign"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&simple=true"/>"
	);
	n4.AppendURLChild(
	"<bean:message bundle="km-imissive" key="kmImissive.nav.Exchange.reg"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReg"/>"
	)
	n4.AppendURLChild( 
	"<bean:message bundle="km-imissive" key="kmImissive.nav.Exchange.reglist"/>",
	"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveRegDetailList"/>"
	)	
	</kmss:authShow>
	//=========模块设置========
	n4 = n1.AppendURLChild("<bean:message key="kmMissive.tree.sendConfig" bundle="km-imissive" />");
	n4.isExpanded = true;
	defaultNode = n4.AppendURLChild(
		"<bean:message key="km.missive.send.categoryconfig" bundle="km-imissive" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&mainModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&templateName=fdTemplate&categoryName=docCategory&authReaderNoteFlag=2" />"
	);
	n4.AppendCV2Child("<bean:message key="km.missive.send.templateconfig" bundle="km-imissive" />",
		"com.landray.kmss.km.imissive.model.KmImissiveSendTemplate",
		"<c:url value="/km/imissive/km_imissive_send_template/index.jsp?parentId=!{value}&ower=1" />");
	//套红模板设置
	n4.AppendURLChild(
		"<bean:message key="kmImissiveSend.tree.redhead.template" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate_tree.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate&actionUrl=/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do&formName=kmImissiveRedHeadTemplateForm&authReaderNoteFlag=2" />"
	  );
   <kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">
	n4.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonSendNumber" bundle="km-imissive" />",
		"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain" />"
	);
	//流程模板设置
	n4.AppendURLChild(
		"<bean:message key="kmMissive.tree.mainMissiveSendFlow" bundle="km-imissive" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&fdKey=sendMainDoc" />"
	); 
	//表单模板设置
	n4.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonSendXform" bundle="km-imissive" />",
		"<c:url value="/sys/xform/sys_form_common_template/index.jsp">
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
			<c:param name="fdKey" value="sendMainDoc" />
			<c:param name="fdMainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
		</c:url>"
	);

	// 表单存储设置
	n4.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonSendXformCfg" bundle="km-imissive" />",
		"<c:url value="/sys/xform/base/sys_form_db_table/index.jsp">
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
			<c:param name="fdTemplateModel" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"/>
			<c:param name="fdKey" value="sendMainDoc"/>
		</c:url>"
	);
	//搜索设置
	n4.AppendURLChild(
		"<bean:message key="KmImissiveSendMain.search" bundle="km-imissive"/>",
		"<c:url value="/sys/search/sys_search_main/index.jsp?fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&fdTemplateModelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&fdKey=sendMainDoc"/>"
	);
	
	</kmss:authShow>
	n5 = n1.AppendURLChild("<bean:message key="kmMissive.tree.receiveConfig" bundle="km-imissive" />");
	n5.isExpanded = true;
	n5.AppendURLChild(
		"<bean:message key="km.missive.receive.categoryconfig" bundle="km-imissive" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate&mainModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&templateName=fdTemplate&categoryName=docCategory&authReaderNoteFlag=2" />"
	);	
	n5.AppendCV2Child("<bean:message key="km.missive.receive.templateconfig" bundle="km-imissive" />",
		"com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate",
		"<c:url value="/km/imissive/km_imissive_receive_template/index.jsp?parentId=!{value}&ower=1" />");
	<kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">	
	n5.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonReceiveNumber" bundle="km-imissive" />",
		"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />"
	);
	//流程模板设置
	n5.AppendURLChild(
		"<bean:message key="kmMissive.tree.mainMissiveReceiveFlow" bundle="km-imissive" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate&fdKey=receiveMainDoc" />"
	);
	//表单模板设置
	n5.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonReceiveXform" bundle="km-imissive" />",
		"<c:url value="/sys/xform/sys_form_common_template/index.jsp">
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
			<c:param name="fdKey" value="receiveMainDoc" />
			<c:param name="fdMainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		</c:url>"
	);

	// 表单存储设置
	n5.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonReceiveXformCfg" bundle="km-imissive" />",
		"<c:url value="/sys/xform/base/sys_form_db_table/index.jsp">
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"/>
			<c:param name="fdTemplateModel" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"/>
			<c:param name="fdKey" value="receiveMainDoc"/>
		</c:url>"
	);
	n5.AppendURLChild(
		"<bean:message key="KmImissiveReceiveMain.search" bundle="km-imissive"/>",
		"<c:url value="/sys/search/sys_search_main/index.jsp?fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&fdTemplateModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate&fdKey=receiveMainDoc"/>"
	);
	
	</kmss:authShow>
	n6 = n1.AppendURLChild("<bean:message key="kmMissive.tree.signConfig" bundle="km-imissive" />");
	n6.isExpanded = true;
	n6.AppendURLChild(
		"<bean:message key="km.missive.sign.categoryconfig" bundle="km-imissive" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&mainModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&templateName=fdTemplate&categoryName=docCategory&authReaderNoteFlag=2" />"
	);
	n6.AppendCV2Child("<bean:message key="km.missive.sign.templateconfig" bundle="km-imissive" />",
		"com.landray.kmss.km.imissive.model.KmImissiveSignTemplate",
		"<c:url value="/km/imissive/km_imissive_sign_template/index.jsp?parentId=!{value}&ower=1" />");
	//套红模板设置
	n6.AppendURLChild(
		"<bean:message key="kmImissiveSign.tree.redhead.template" bundle="km-imissive" />",
		"<c:url value="/km/imissive/km_imissive_sign_redhead_template/kmImissiveSignRedHeadTemplate_tree.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignRedHeadTemplate&actionUrl=/km/imissive/km_imissive_sign_redhead_template/kmImissiveSignRedHeadTemplate.do&formName=kmImissiveSignRedHeadTemplateForm&authReaderNoteFlag=2" />"
	  );
	<kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">
	n6.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonSignNumber" bundle="km-imissive" />",
		"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain" />"
	);
	
	//流程模板设置
	n6.AppendURLChild(
		"<bean:message key="kmMissive.tree.mainMissiveSignFlow" bundle="km-imissive" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&fdKey=signMainDoc" />"
	); 
	//表单模板设置
	n6.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonSignXform" bundle="km-imissive" />",
		"<c:url value="/sys/xform/sys_form_common_template/index.jsp">
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
			<c:param name="fdKey" value="signMainDoc" />
			<c:param name="fdMainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		</c:url>"
	);

	// 表单存储设置
	n6.AppendURLChild(
		"<bean:message key="kmMissive.tree.commonSignXformCfg" bundle="km-imissive" />",
		"<c:url value="/sys/xform/base/sys_form_db_table/index.jsp">
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
			<c:param name="fdTemplateModel" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"/>
			<c:param name="fdKey" value="signMainDoc"/>
		</c:url>"
	);
	n6.AppendURLChild(
		"<bean:message key="KmImissiveSignMain.search" bundle="km-imissive"/>",
		"<c:url value="/sys/search/sys_search_main/index.jsp?fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&fdTemplateModelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&fdKey=signMainDoc"/>"
	);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">
	n1.AppendURLChild(
		"<bean:message key="kmMissive.tree.cacheNumberQuery" bundle="km-imissive"/>",
		"<c:url value="/km/imissive/km_imissive_number/index.jsp" />"
	);
	</kmss:authShow>
	
	
	n9 = n1.AppendURLChild("<bean:message key="kmImissive.tree.manage.send" bundle="km-imissive" />")
	n9.authType="01";
	<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_OPTALL">
	n9.authRole="optAll";
	</kmss:authShow>
	n9.AppendCategoryDataWithAdmin ("com.landray.kmss.km.imissive.model.KmImissiveSendTemplate",
	"<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain_manageList.jsp?categoryId=!{value}"/>",
	"<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain_manageList.jsp?type=category&categoryId=!{value}"/>");
	n10 = n1.AppendURLChild("<bean:message key="kmImissive.tree.manage.receive" bundle="km-imissive" />")
	n10.authType="01";
	<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_OPTALL">
	n10.authRole="optAll";
	</kmss:authShow>
	n10.AppendCategoryDataWithAdmin ("com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate",
	"<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_manageList.jsp?categoryId=!{value}"/>",
	"<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_manageList.jsp?type=category&categoryId=!{value}"/>");
	n11 = n1.AppendURLChild("<bean:message key="kmImissive.tree.manage.sign" bundle="km-imissive" />")
	n11.authType="01";
	<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_OPTALL">
	n11.authRole="optAll";
	</kmss:authShow>
	n11.AppendCategoryDataWithAdmin ("com.landray.kmss.km.imissive.model.KmImissiveSignTemplate",
	"<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_manageList.jsp?categoryId=!{value}"/>",
	"<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_manageList.jsp?type=category&categoryId=!{value}"/>");	
	//=========回收站========
	<% if(com.landray.kmss.sys.recycle.util.SysRecycleUtil.isEnableSoftDelete("com.landray.kmss.km.imissive.model.KmImissiveSendMain;com.landray.kmss.km.imissive.model.KmImissiveReceiveMain;com.landray.kmss.km.imissive.model.KmImissiveSignMain")) { %>
	n12 = n1.AppendURLChild("<bean:message key="module.sys.recycle" bundle="sys-recycle" />","<c:url value="/km/imissive/import/sysRecycleBox.jsp" />");
	<% } %>
	 <kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">
	n1.AppendURLChild(
			'<bean:message key="kmMissive.tree.permissionDiffusionLog" bundle="km-imissive" />',
			'<c:url value="/km/imissive/km_imissive_spreadauth_log/index.jsp"/>');
	<%if(SysUnitUtil.getExchangeEnable()){ %>
	n1.AppendURLChild(
			'<bean:message key="kmMissive.tree.sendToplatformDocumentQueue" bundle="km-imissive" />',
			'<c:url value="/km/imissive/km_imissive_reg_qu/index.jsp"/>');
	n1.AppendURLChild(
			'<bean:message key="kmMissive.tree.getPlatFormOfficialDocumentQueue" bundle="km-imissive" />',
			'<c:url value="/km/imissive/km_imissive_regdetail_list_qu/index.jsp"/>');	
	
	n1.AppendURLChild(
			'意见发送队列',
			'<c:url value="/km/imissive/km_imissive_opinion_out_qu/index.jsp"/>');
	n1.AppendURLChild(
			'意见接收队列',
			'<c:url value="/km/imissive/km_imissive_opinion_in_qu/index.jsp"/>');	
	<%} %>	
	</kmss:authShow>
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
  </template:replace>
</template:include>