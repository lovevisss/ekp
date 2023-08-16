<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
    
    <c:set var="isRole" value="false" ></c:set>
    <kmss:authShow roles="ROLE_KMIMEETING_SETTING">
    	<c:set var="isRole" value="true" ></c:set>
    </kmss:authShow>
    
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.imeeting" bundle="km-imeeting"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,n6,n7,n8,n9, defaultNode, topic, scheme, main;
	n1 = LKSTree.treeRoot;
	
	<%-- 模块设置--%>
	n2 = n1.AppendURLChild(
		"<bean:message key="kmImeeting.tree.moduleConfig" bundle="km-imeeting" />"
	);
	
	topic = n1.AppendURLChild("<bean:message key="tree.topic" bundle="km-imeeting" />");
	
	scheme = n1.AppendURLChild("<bean:message key="tree.scheme" bundle="km-imeeting" />");
	
	main = n1.AppendURLChild("<bean:message key="tree.main" bundle="km-imeeting" />");
	
	 topic.AppendURLChild(
		"<bean:message key="tree.issueCategorySetting" bundle="km-imeeting" />",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory&actionUrl=/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do&formName=kmImeetingTopicCategoryForm&mainModelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic&docFkName=fdTopicCategory" />"
	);
	
	<%-- 会议方案设置--%>
	scheme.AppendURLChild(
		"<bean:message key="kmImeeting.tree.schemeSetting" bundle="km-imeeting" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&mainModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&categoryName=docCategory&templateName=fdSchemeTemplate&authReaderNoteFlag=2" />"
	);
	
	<%-- 会议方案模版设置--%>
	scheme.AppendURLChild(
		"方案模版设置",
		"<c:url value="/km/imeeting/km_imeeting_scheme_template/index.jsp" />"
	);
	
	main.AppendURLChild(
		"<bean:message key="kmImeeting.tree.categorySetting" bundle="km-imeeting" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingTemplate&mainModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&categoryName=docCategory&templateName=fdTemplate&authReaderNoteFlag=2" />"
	);
	
	main.AppendURLChild(
		"<bean:message key="kmImeeting.tree.templateSetting.card" bundle="km-imeeting" />",
		"<c:url value="/km/imeeting/km_imeeting_template/index.jsp" />"
	);
	
	<kmss:authShow roles="ROLE_KMIMEETING_SETTING">
	/*议题通用表单模板*/
    topic.AppendURLChild(
        '${ lfn:message("km-imeeting:kmImeetingTopicCategory.tongyongbiaodanmuban") }',
        '<c:url value="/sys/xform/sys_form_common_template/index.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory&fdKey=mainTopic&fdMainModelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>'
	);

    /*议题表单数据映射*/
    topic.AppendURLChild(
        '${ lfn:message("km-imeeting:kmImeetingTopicCategory.biaodanshujuyingshe") }',
        '<c:url value="/sys/xform/base/sys_form_db_table/index.jsp?fdTemplateModel=com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory&fdKey=mainTopic&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>'
	);
	
	topic.AppendURLChild(
		"<bean:message key="tree.issueFlowTemp" bundle="km-imeeting" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory&fdKey=mainTopic" />"
	);

	/*方案通用表单模板*/
    scheme.AppendURLChild(
        '${ lfn:message("km-imeeting:tree.schemetongyongbiaodanmuban") }',
        '<c:url value="/sys/xform/sys_form_common_template/index.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&fdKey=ImeetingScheme&fdMainModelName=com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>'
	);

    /*方案表单数据映射*/
    scheme.AppendURLChild(
        '${ lfn:message("km-imeeting:tree.schemeBiaodanshujuyingshe") }',
        '<c:url value="/sys/xform/base/sys_form_db_table/index.jsp?fdTemplateModel=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&fdKey=ImeetingScheme&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>'
	);
	
	<%-- 会议方案流程模板--%>
	scheme.AppendURLChild(
		"<bean:message key="kmImeeting.tree.schemeFlow" bundle="km-imeeting" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&fdKey=ImeetingScheme" />"
	);	
	
	<%-- 会议通知流程模板--%>
	main.AppendURLChild(
		"<bean:message key="kmImeeting.tree.mainMeetingFlow" bundle="km-imeeting" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingTemplate&fdKey=ImeetingMain" />"
	);
	<c:if test="${imissiveSummaryEnable != 'true'}">
	<%-- 会议纪要流程模板--%>
	main.AppendURLChild(
		"<bean:message key="kmImeeting.tree.summaryFlow" bundle="km-imeeting" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingTemplate&fdKey=ImeetingSummary" />"
	);
	</c:if>
	LKSTree.ExpandNode(topic);
	
	LKSTree.ExpandNode(scheme);
	
	LKSTree.ExpandNode(main);
	
	LKSTree.ExpandNode(n2);
	
	topic.AppendURLChild(
		"<bean:message key="tree.issueNumRule" bundle="km-imeeting" />",
		"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic" />"
	);
	
	<%-- 方案通用编号规则--%>
	scheme.AppendURLChild(
		"方案通用编号规则",
		"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingScheme" />"
	);
	
	<%-- 编号机制--%>
	main.AppendURLChild(
			"<bean:message bundle="km-imeeting" key="kmImeetingMain.docNumSetting"/>",
			"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain" />"
		);
		
	<%-- 基础设置--%>	
	defaultNode = n2.AppendURLChild(
		"<bean:message key="kmImeeting.tree.moduleBaseConflict" bundle="km-imeeting" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.km.imeeting.model.KmImeetingConfig" />"
	);
	
	<!-- 坐席模板设置 -->
	n2.AppendURLChild(
		"<bean:message key="kmImeetingSeatTemplate.config" bundle="km-imeeting" />",
		"<c:url value="/km/imeeting/km_imeeting_seat_template/index.jsp" />"
	);
	
	n2.AppendURLChild(
		"<bean:message key="kmImeetingTopic.tree.listShow" bundle="km-imeeting" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>"
	);
	n2.AppendURLChild(
		"<bean:message key="kmImeetingScheme.tree.listShow" bundle="km-imeeting" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>"
	);
	
	<%-- 列表显示设置--%>	
	n2.AppendURLChild(
		"<bean:message key="kmImeeting.tree.listShow" bundle="km-imeeting" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain"/>"
	);
	
	<c:if test="${imissiveSummaryEnable != 'true'}">
	<%-- 纪要列表显示设置--%>	
	n2.AppendURLChild(
		"<bean:message key="kmImeetingSummary.tree.listShow" bundle="km-imeeting" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>"
	);
	</c:if>
	</kmss:authShow>
	
	<%-- 会议室管理设置--%>
	n2 = n1.AppendURLChild(
		"<bean:message key="kmImeeting.tree.place" bundle="km-imeeting" />"
	);
	
	<%-- 会议室分类 --%>
	n2.AppendURLChild(
		"<bean:message key="table.kmImeetingResCategory" bundle="km-imeeting" />",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.imeeting.model.KmImeetingResCategory&actionUrl=/km/imeeting/km_imeeting_res_category/kmImeetingResCategory.do&formName=kmImeetingResCategoryForm&mainModelName=com.landray.kmss.km.imeeting.model.KmImeetingRes&docFkName=docCategory" />"
	);
	
	<%-- 会议室信息 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.kmImeetingRes" bundle="km-imeeting" />",
		"<c:url value="/km/imeeting/km_imeeting_res/index.jsp" />"
	);	
	
	n3.AppendSimpleCategoryData(
    	"com.landray.kmss.km.imeeting.model.KmImeetingResCategory",
    	"<c:url value="/km/imeeting/km_imeeting_res/index.jsp?docCategoryId=!{value}&authReaderNoteFlag=2&dataWithAdmin=true" />"
    );
	
	<kmss:authShow roles="ROLE_KMIMEETING_RES_READER">
	<%-- 会议室查询 --%>
	 n2.AppendURLChild(
		"<bean:message key="kmImeeting.tree.listUse" bundle="km-imeeting" />",
		"<c:url value="/km/imeeting/km_imeeting_res/index_listuse.jsp" />"
	);
	</kmss:authShow>
	
	<%-- 会议辅助设备 --%>
	 n2.AppendURLChild(
		"<bean:message key="table.kmImeetingEquipment" bundle="km-imeeting" />",
		"<c:url value="/km/imeeting/km_imeeting_equipment/index.jsp" />"
	);
	
	<%-- 会议辅助服务 --%>
	 n2.AppendURLChild(
		"<bean:message key="table.kmImeetingDevice" bundle="km-imeeting" />",
		"<c:url value="/km/imeeting/km_imeeting_device/index.jsp" />"
	);
	
	LKSTree.ExpandNode(n2);
	
	<%-- 文档维护 --%>
	n6 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")	
	
	<%-- 会议议题--%>
	n9 = n6.AppendURLChild("<bean:message key="kmImeeting.tree.myHandleTopic" bundle="km-imeeting" />")
	n9.authType="01";
	<kmss:authShow roles="ROLE_KMIMEETING_OPTALL">
		n9.authRole="optAll";
	</kmss:authShow>
	n9.AppendSimpleCategoryDataWithAdmin ("com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory","<c:url value="/km/imeeting/km_imeeting_topic/kmImeetingTopic_manageList.jsp?categoryId=!{value}"/>","<c:url value="/km/imeeting/km_imeeting_topic/kmImeetingTopic_manageList.jsp?categoryId=!{value}" />");
	
	<!-- 方案 -->
	n7 = n6.AppendURLChild("<bean:message key="table.kmImeetingScheme" bundle="km-imeeting" />")
	n7.authType="01";
	<kmss:authShow roles="ROLE_KMIMEETING_SCHEME_OPTALL">
		n7.authRole="optAll";
	</kmss:authShow>
	n7.AppendCategoryDataWithAdmin("com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate",
		"<c:url value="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_manageList.jsp?categoryId=!{value}"/>",
		"<c:url value="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_manageList.jsp?categoryId=!{value}"/>"
	);
	
	
	<%-- 会议通知--%>
	n8 = n6.AppendURLChild("<bean:message key="kmImeeting.tree.myHandleMeeting" bundle="km-imeeting" />")
	n8.authType="01";
	<kmss:authShow roles="ROLE_KMIMEETING_OPTALL">
		n8.authRole="optAll";
	</kmss:authShow>
	n8.AppendCategoryDataWithAdmin("com.landray.kmss.km.imeeting.model.KmImeetingTemplate",
		"<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain_manageList.jsp?categoryId=!{value}"/>",
		"<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain_manageList.jsp?categoryId=!{value}"/>"
	);
	<c:if test="${imissiveSummaryEnable != 'true'}">
	<%-- 会议纪要--%>
	n9 = n6.AppendURLChild("<bean:message key="kmImeeting.tree.myHandleSummary" bundle="km-imeeting" />")
	n9.authType="01";
	<kmss:authShow roles="ROLE_KMIMEETING_OPTALL">
		n9.authRole="optAll";
	</kmss:authShow>
	n9.AppendCategoryDataWithAdmin ("com.landray.kmss.km.imeeting.model.KmImeetingTemplate","<c:url value="/km/imeeting/km_imeeting_summary/kmImeetingSummary_manageList.jsp?categoryId=!{value}"/>","<c:url value="/km/imeeting/km_imeeting_summary/kmImeetingSummary_manageList.jsp?categoryId=!{value}"/>");
	</c:if>
	
	LKSTree.ExpandNode(n3);
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
 </template:replace>
</template:include>