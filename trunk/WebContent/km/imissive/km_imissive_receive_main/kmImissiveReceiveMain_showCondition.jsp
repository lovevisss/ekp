<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictCommonProperty"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDictUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.lang.String"%>
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<script type="text/javascript">
Com_IncludeFile("jquery.js");
</script>
<form id="conditionForm">
<center>
<input type="hidden" name="fdLimits" value="">
<input type="hidden" name="tempId" value="">
<table class="tb_normal" width=100% style="margin-top:10px">
<c:forEach var="map" items="${rtnMap}">
    <c:set var="condition" value="${map.value}"></c:set>
    <tr><td colspan="2" align="center">计算范围</td></tr>
	<tr>
	   <td width="25%">
	     <%
             SysDictCommonProperty condition = (SysDictCommonProperty) pageContext.getAttribute("condition");
			 if (StringUtil.isNotNull(condition.getMessageKey())) {
				out.print(ResourceUtil.getString(condition.getMessageKey()));
			 }
			    String type = "string";
			    String dataType = condition.getType();
			    if (!StringUtil.isNull(condition.getEnumType()))
				    type = "enum";
			    else if (dataType.equals("Date"))
					type = "date";
				else if(dataType.equals("Time"))
					type = "time";
				else if(dataType.equals("DateTime"))
					type = "datatime";
				else
					type = "foreign";
				pageContext.setAttribute("type",type);
	      %> 
       </td>
	   <td>
	        <c:choose>
		         <c:when test="${type=='foreign'}">
		            <%
						 if (condition.getDialogJS()!=null) {
							String dialogJs = SysDataDictUtil.getDialogJs(condition, new com.landray.kmss.common.actions.RequestContext(request), condition.getName()+"Id",condition.getName()+"Name", false);
							pageContext.setAttribute("dialogScript",dialogJs);
						 }
				     %> 
					<xform:dialog style="width:90%;" showStatus="edit" dialogJs="${dialogScript}" propertyId="${condition.name}Id" propertyName="${condition.name}Name">
					</xform:dialog>
		         </c:when>
		         <c:when test="${type=='enum'}">
		          <xform:radio property="${condition.name}" showStatus="edit">
		             <xform:enumsDataSource enumsType="${condition.enumType}"></xform:enumsDataSource>
		           </xform:radio>
		         </c:when>
		          <c:when test="${type=='date'}"> 
		             <xform:datetime property="${condition.name}" dateTimeType="date"></xform:datetime>
		         </c:when>
		          <c:when test="${type=='time'}">
		            <xform:datetime property="${condition.name}" dateTimeType="time"></xform:datetime>
		         </c:when>
		          <c:when test="${type=='datetime'}">
		           <xform:datetime property="${condition.name}" dateTimeType="datetime"></xform:datetime>
		         </c:when>
		         <c:otherwise>
		           <xform:text property="${condition.name}" style="width:90%;" showStatus="edit"></xform:text>
		         </c:otherwise>
	        </c:choose>
	   </td>
	</tr>
</c:forEach> 
</table>     
<br/><br/>
<input type="button" class="btnopt" value="查询" onclick="doOK();" />
</center>
</form>
<script type="text/javascript">
$(document).ready(function(){
	document.getElementsByName("fdLimits")[0].value = parent.fdLimits;
	document.getElementsByName("tempId")[0].value = parent.tempId;
});

function doOK(){
	url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getNumber";
	$.ajax({
		url:url,
	    type: "POST",
	    data:$('#conditionForm').serialize(),// 你的formid
	    async: false,
	    success: function(data) {
	    	if(data){
	    		var results =  eval("("+data+")");
	    		var contentHTML = '<table class="tb_normal" width=95% style="margin-top:10px">';
		    	contentHTML += '<tr>';
		    	contentHTML += '<td width=25%>';
				contentHTML += '编号规则名称';
				contentHTML += '</td>';
				contentHTML += '<td>';
				contentHTML += results['fdName'];
				contentHTML += '</td>';
				contentHTML += '</tr>';
				contentHTML += '<tr>';
		    	contentHTML += '<td width=25%>';
				contentHTML += '编号模拟值';
				contentHTML += '</td>';
				contentHTML += '<td>';
				contentHTML += results['fdVirtualNumberValue'];
				contentHTML += '</td>';
				contentHTML += '</tr>';
				contentHTML += '<tr>';
		    	contentHTML += '<td width=25%>';
				contentHTML += '当前最大流水号';
				contentHTML += '</td>';
				contentHTML += '<td>';
				contentHTML += results['fdFlowNum'];
				contentHTML += '</td>';
				contentHTML += '</tr>';
				contentHTML += '<tr>';
		    	contentHTML += '<td width=25%>';
				contentHTML += '漏号';
				contentHTML += '</td>';
				contentHTML += '<td>';
				if(results['fdUnuseNum']){
				  contentHTML += results['fdUnuseNum'];
		        }else{
		        	contentHTML += '没查找到任何漏号';
		        }
				contentHTML += '</td>';
				contentHTML += '</tr>';
				if(getTempNumberFromDb(results['fdNumberId'],"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain")){
					contentHTML += '<tr class="clearTr">';
					contentHTML += '<td colspan="2">';
					contentHTML += '1、文件编号操作时，为防止编号跳号，预览时会将该编号规则生成的编号缓存到数据库<br>2、当对编号规则进行预览操作后又修改了模板起始流水号，此时可通过以下清除按钮清除缓存编号';
					contentHTML += '</td>';
					contentHTML += '</tr>';
					contentHTML += '<tr class="clearTr">';
					contentHTML += '<td colspan="2">';
					contentHTML += '<center><input type="button" class="lui_form_button" value="清除" onclick="clearNum(\''+results['fdNumberId']+'\');"/></center>';
					contentHTML += '</td>';
					contentHTML += '</tr>';
				}
				contentHTML += '</table>';
				$("#containDiv",window.parent.document).html(contentHTML);
	    	}
	    }
	});
}
</script>      
<%@ include file="/resource/jsp/edit_down.jsp"%>