<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSettingDefault"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" />
<c:set var="resize_prefix" value="_" scope="request" />
<c:if test="${sysWfBusinessForm.sysWfBusinessForm!=null}">
	<%
		LbpmSettingDefault settingDefault = new LbpmSettingDefault();
		pageContext.setAttribute("approveModel", settingDefault.getApproveModel());
		String title = ResourceUtil.getString("sys-lbpmservice:lbpm.tab.label");
		if("right".equals(request.getParameter("approvePosition"))){
			title = ResourceUtil.getString("sys-lbpmservice:lbpmview.approve.model.dialog.view");
			pageContext.setAttribute("titleicon", "lui-fm-icon-3");
			pageContext.setAttribute("tabcontentId", "_right");
		}else if(StringUtil.isNotNull(request.getParameter("titleicon"))){
			pageContext.setAttribute("titleicon", request.getParameter("titleicon"));
		}
		pageContext.setAttribute("title", title);
	%>
	<c:set var="order" value="${empty param.order ? '10' : param.order}"/>
	<c:set var="disable" value="${empty param.disable ? 'false' : param.disable}"/>
	<c:if test="${(sysWfBusinessForm.docStatus == '00' || sysWfBusinessForm.docStatus >= '30') && param.approveType eq 'right' && LUI_ContextPath!=null && param.approvePosition eq 'right'}">
	    <ui:event event="layoutDone">
	    	$("i.lui-fm-icon-3").closest(".lui_tabpanel_vertical_icon_navs_item_l").hide();
	    </ui:event>
	</c:if>
	<ui:content id="process_review_tabcontent${tabcontentId}"
		title="${title}"
		expand="${sysWfBusinessForm.docStatus == '20' or sysWfBusinessForm.docStatus == '11' or param.isExpand == 'true'?'true':'false'}"
		titleicon="${titleicon}" cfg-order="${order}" cfg-disable="${disable}">
	<ui:event event="show">
		if (this.isBindOnResize) {
			return;
		}
		var element = this.element;
		function onResize() {
			element.find("*[_onresize]").each(function(){
				var elem = $(this);
				var funStr = elem.attr("_onresize");
				var show = elem.closest('tr').is(":visible");
				var init = elem.attr("data-init-resize");
				if(funStr!=null && funStr!="" && show && init == null){
					elem.attr("data-init-resize", 'true');
					var tmpFunc = new Function(funStr);
					tmpFunc.call();
				}
			});
		}
		this.isBindOnResize = true;
		onResize();
		element.click(onResize);
	</ui:event>
	<c:choose>
		<c:when test="${lbpmProcessForm.fdTemplateType=='4'}">
			<c:choose>
				<c:when test="${param.approveType eq 'right' && LUI_ContextPath!=null}">
					<c:choose>
						<c:when test="${param.approvePosition eq 'right'}">
							<c:import url="/sys/lbpmservice/common/process_edit_freeFlow_right.jsp" charEncoding="UTF-8"></c:import>
						</c:when>
						<c:otherwise>
							<c:import url="/sys/lbpmservice/common/process_edit_freeFlow_left.jsp" charEncoding="UTF-8"></c:import>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/lbpmservice/common/process_edit_freeFlow.jsp" charEncoding="UTF-8"></c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${param.approveType eq 'right' && LUI_ContextPath!=null}">
			<c:choose>
				<c:when test="${param.approvePosition eq 'right'}">
					<c:import url="/sys/lbpmservice/common/process_edit_right.jsp" charEncoding="UTF-8"></c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/lbpmservice/common/process_edit_left.jsp" charEncoding="UTF-8">
						<c:param name="approveType" value="${param.approveType }"></c:param>
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<%-- 因在iframe里弹框，弹出的结构是放在最外层，此时用弹框模式会报错，故先屏蔽edit页面的弹框模式，走默认模式 --%>
		<%-- <c:when test="${approveModel eq 'dialog' && LUI_ContextPath!=null}">
				<c:import url="/sys/lbpmservice/common/process_edit_dialog.jsp" charEncoding="UTF-8"></c:import>
		</c:when> --%>
		<c:otherwise>
			<c:import url="/sys/lbpmservice/common/process_edit.jsp" charEncoding="UTF-8"></c:import>
			<%-- <%@ include file="../common/process_edit.jsp"%> --%>
		</c:otherwise>
	</c:choose>
	</ui:content>
</c:if>