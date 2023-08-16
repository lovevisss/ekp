<%-- 旁听单位 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
    <%
    	String isMobileC = (String)request.getParameter("mobile");
	   if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		   parse.addStyle("width", "control_width", "95%");
	   }
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "false"));
	%>

<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<div id="listen_m">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_listen_m"
		    	 data-dojo-props='"afterSelect":function(evt){afterSelectListen(evt);},"idField":"fdListenUnitIds","nameField":"fdListenUnitNames","curIds":"${kmImeetingTopicForm.fdListenUnitIds}","curNames":"${kmImeetingTopicForm.fdListenUnitNames}","subject":"建议旁听单位","title":"建议旁听单位","showStatus":"edit","isMul":true,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
			<script type="text/javascript">
				require(['dojo/query'], function(query) {
					window.afterSelectListen = function(evt) {
						var listenIds = evt.curIds;
						var fdListenUnitIds = "";
						if (!listenIds) {
							return;
						}
						if (listenIds.indexOf("_cate") > 0) {
							listenIdsArr = listenIds.split(";");
							for (var i = 0; i < listenIdsArr.length; i++) {
								if (listenIdsArr[i]) {
									fdListenUnitIds += listenIdsArr[i].substring(0, listenIdsArr[i].indeOf("_cate")) + ";";
								} else {
									fdListenUnitIds += listenIdsArr[i] + ";";
								}
							}
							query("[name='fdListenUnitIds']")[0].value = fdListenUnitIds.substring(0, fdListenUnitIds.length - 1);
						}
					}
	            });
			</script>
		</div>
	</c:when>
	<c:otherwise>
		<xform:dialog 
				propertyId="fdListenUnitIds"
				propertyName="fdListenUnitNames"
			    style="width:95%;" 
			    className="inputsgl"
			    required="<%=required%>"
			    mulSelect="true"
			    showStatus="edit"
			    useNewStyle="true"
			    subject="${lfn:message('km-imeeting:kmImeetingTopic.fdListenUnit')}">
			Dialog_UnitTreeList(true, 'fdListenUnitIds', 'fdListenUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
			  	'<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListService&parentId=!{value}',
				mainCalBackFn,'kmImissiveUnitListService&fdKeyWord=!{keyword}'
			);
		</xform:dialog>
		<script type="text/javascript">
		    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
		    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
		    
		    function mainCalBackFn(value){
		    }
		</script>
	</c:otherwise>
</c:choose>
