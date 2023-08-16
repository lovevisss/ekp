<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" />

<c:if test="${sysWfBusinessForm.sysWfBusinessForm!=null}"> 
<tr>
	<td> 
		<%@include file="/sys/lbpmservice/import/sysLbpmProcess_view.jsp"%>
	</td>
</tr>
</c:if>

