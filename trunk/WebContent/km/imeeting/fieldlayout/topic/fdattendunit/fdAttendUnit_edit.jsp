<%-- 承办单位 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
    <%
    	String isMobileC = (String)request.getParameter("mobile");
	   if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		   parse.addStyle("width", "control_width", "95%");
	   }
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>

<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<div id="attend_m">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_attend_m"
		    	 data-dojo-props='"afterSelect":function(evt){afterSelectAttend(evt);},"idField":"fdAttendUnitIds","nameField":"fdAttendUnitNames","curIds":"${kmImeetingTopicForm.fdAttendUnitIds}","curNames":"${kmImeetingTopicForm.fdAttendUnitNames}","subject":"建议列席单位","title":"建议列席单位","showStatus":"edit","isMul":true,"required":true,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileDataBeanService&parentId=!{parentId}",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
			<script type="text/javascript">
				require(['dojo/query'], function(query) {
					window.afterSelectAttend = function(evt) {
						var attendIds = evt.curIds;
						var fdAttendUnitIds = "";
						if (!attendIds) {
							return;
						}
						if (attendIds.indexOf("_cate") > 0) {
							attendIdsArr = attendIds.split(";");
							for (var i = 0; i < attendIdsArr.length; i++) {
								if (attendIdsArr[i]) {
									fdAttendUnitIds += attendIdsArr[i].substring(0, attendIdsArr[i].indeOf("_cate")) + ";";
								} else {
									fdAttendUnitIds += attendIdsArr[i] + ";";
								}
							}
							query("[name='fdAttendUnitIds']")[0].value = fdAttendUnitIds.substring(0, fdAttendUnitIds.length - 1);
						}
					}
	            });
			</script>
		</div>
	</c:when>
	<c:otherwise>
		<div id="_fdAttendUnitIds" valField="fdAttendUnitIds" xform_type="dialog">
			<xform:dialog 
					propertyId="fdAttendUnitIds"
					propertyName="fdAttendUnitNames"
				    style="width:95%;" 
				    className="inputsgl"
				    required="true"
				    mulSelect="true"
				    showStatus="edit"
				    subject="${lfn:message('km-imeeting:kmImeetingTopic.fdAttendUnit')}"
				    useNewStyle="true">
				Dialog_UnitTreeList(true, 'fdAttendUnitIds', 'fdAttendUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
				  	'<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListService&parentId=!{value}&type=allUnit',
					mainCalBackFn,'kmImissiveUnitListService&fdKeyWord=!{keyword}&type=allUnit'
				);
			</xform:dialog>
		</div>
		<script type="text/javascript">
		    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
		    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
		    
		    function mainCalBackFn(value){
		    }
		</script>
	</c:otherwise>
</c:choose>
