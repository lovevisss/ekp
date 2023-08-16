<%@page import="java.util.Map"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.common.model.IBaseModel"%>
<%@page import="com.landray.kmss.common.service.IBaseService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="org.apache.commons.beanutils.PropertyUtils"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveTemplatePluginUtil"%>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	String fdModelId = request.getParameter("fdModelId");
	String fdModelName = request.getParameter("fdModelName");
	String isRelationFile = request.getParameter("isRelationFile");
	String method_Get = request.getParameter("method_GET");
	String mobile = request.getParameter("mobile");
	
	if(StringUtil.isNotNull(fdModelId) && StringUtil.isNotNull(fdModelName)){
		SysDictModel dictModel = SysDataDict.getInstance().getModel(fdModelName);
		IBaseService baseServise = (IBaseService) SpringBeanUtil.getBean(dictModel.getServiceBean());
		IBaseModel relatedModel = baseServise.findByPrimaryKey(fdModelId, fdModelName, true);
		if(relatedModel !=null){
			String fdViewUrl = dictModel.getUrl();
			if (StringUtil.isNotNull(fdViewUrl)) {
				fdViewUrl = fdViewUrl.replace("${fdId}", fdModelId);
			}
			String relatedTitle = "";
			// 禁用的模板不显示
			if (PropertyUtils.isReadable(relatedModel,"docSubject")) {
				 relatedTitle = (String)PropertyUtils.getProperty(relatedModel, "docSubject");
			}else if (PropertyUtils.isReadable(relatedModel,"fdName")){
				relatedTitle = (String)PropertyUtils.getProperty(relatedModel, "fdName");
			}
			request.setAttribute("relatedTitle", relatedTitle);
			request.setAttribute("fdViewUrl", fdViewUrl);
			if ("add".equals(method_Get) || "edit".equals(method_Get)) {
				String fdJspUrl = null;
				if("true".equals(mobile)){
					fdJspUrl = KmImissiveTemplatePluginUtil.getExtMobileDataUrl(fdModelName);
				}else{
					fdJspUrl = KmImissiveTemplatePluginUtil.getExtJspUrl(fdModelName);
				}
				request.setAttribute("fdJspUrl", fdJspUrl);
				
				Map<String, String> messageKeyMap = KmImissiveTemplatePluginUtil.getSelectBtnMsg(fdModelName);
				if (messageKeyMap != null) {
					for(Map.Entry<String, String> entry : messageKeyMap.entrySet()){
					    if ("key".equals(entry.getKey())) {
					    	request.setAttribute("btnMsgKey", entry.getValue());
					    } else {
					    	request.setAttribute("btnMsgBundle", entry.getValue());
					    }
					}
				}
			}
		}else{
			request.setAttribute("isShowRelation", false);
		}
	} else if (StringUtil.isNotNull(fdModelName) && "1".equals(isRelationFile)) {
		String fdJspUrl = null;
		if("true".equals(mobile)){
			fdJspUrl = KmImissiveTemplatePluginUtil.getExtMobileDataUrl(fdModelName);
		}else{
			fdJspUrl = KmImissiveTemplatePluginUtil.getExtJspUrl(fdModelName);
		}
		request.setAttribute("fdJspUrl", fdJspUrl);
		
		SysDictModel dictModel = SysDataDict.getInstance().getModel(fdModelName);
		String fdViewUrl = dictModel.getUrl();
		request.setAttribute("fdViewUrl", fdViewUrl);
		
		Map<String, String> messageKeyMap = KmImissiveTemplatePluginUtil.getSelectBtnMsg(fdModelName);
		if (messageKeyMap != null) {
			for(Map.Entry<String, String> entry : messageKeyMap.entrySet()){
			    if ("key".equals(entry.getKey())) {
			    	request.setAttribute("btnMsgKey", entry.getValue());
			    } else {
			    	request.setAttribute("btnMsgBundle", entry.getValue());
			    }
			}
		}
	} else {
		request.setAttribute("isShowRelation", false);
	}
%>
<c:if test="${isShowRelation ne false}">
<div class="imissiveRelationDiv" style="padding: 15px 0">
	<span class="imissiveRelationSpan">
		关联会议通知
	</span>
	
	<c:if test="${not empty  relatedTitle || not empty param.isRelationFile}">
		<a id="imissiveRelationA" class="imissiveRelationA" href='<c:url value="${fdViewUrl}" ></c:url>' target="_blank" style="color: #4285f4">
			<c:out value="${relatedTitle}"></c:out>
		</a>
	</c:if>
	
	<c:if test="${not empty param.isRelationFile || (not empty relatedTitle && param.docStatus <= '30')}">
		<c:choose>
			<c:when test="${'true' eq param.mobile}">
				<span 
					class="muiCategoryAdd fontmuis muis-new muiNewAdd selectFileButton"  
					onclick="selectRelationFile();">
				</span>
				<div class="imissiveRelation imissiveRequiredShow">*</div>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${not empty btnMsgKey && not empty btnMsgBundle}">
						<input type="button" class="lui_form_button" style="margin-left:5px"
							value="<bean:message key="${btnMsgKey}" bundle="${btnMsgBundle}"/>"
							onclick="selectRelationFile();"/>
					</c:when>
					<c:otherwise>
						<input type="button" class="lui_form_button" style="margin-left:5px"
							value="<bean:message key="button.selectFile" bundle="km-imissive"/>"
							onclick="selectRelationFile();"/>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:if>
</div>
</c:if>

<c:choose>
	<c:when test="${'true' eq param.mobile}">
		<script>
		require(['dojo/topic',"mui/commondialog/DialogSelector"], 
				function(topic,DialogSelector){
			
			window.selectRelationFile = function(){
				DialogSelector.select({
					key : '____cateSelect',
					dataURL : '${fdJspUrl}',
					modelName:'${param.fdModelName}',
					callback : function(evt){
						var fdModelName = "${param.fdModelName}";
						if(evt.data[0]){
							if(evt.data[0].href && evt.data[0].label){
								var fdModelId = evt.data[0].fdId;
								var fdModelIdNode = document.getElementsByName("fdModelId")[0];
								var fdModelNameNode = document.getElementsByName("fdModelName")[0];
								fdModelIdNode.value=fdModelId;
								fdModelNameNode.value=fdModelName;
								var imissiveRelationA = document.getElementById("imissiveRelationA");
								imissiveRelationA.innerHTML = evt.data[0].fdName;
								imissiveRelationA.style.disply = "";
								imissiveRelationA.onclick=function(){
									window.open("${LUI_ContextPath}"+evt.data[0].href,"_blank");
								}
							}
						}
					}
					
				})
			}
		});
		</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			seajs.use(['lui/dialog', 'lui/jquery'], function(dialog, $){
				
				window.selectRelationFile = function() {
					var url = Com_GetCurDnsHost() + Com_Parameter.ContextPath + "${fdJspUrl}";
					var fdModelName = "${param.fdModelName}";
					var fdViewUrl = "${LUI_ContextPath}${fdViewUrl}";
					dialog.iframe(url,'选择文件', function(result) {
						if (result) {
							var fdModelId = result.fdId;
							var docSubject = result.docSubject;
							if (fdModelId && docSubject) {
								$("input[name='fdModelId']").val(fdModelId);
								$("input[name='fdModelName']").val(fdModelName);
								$('a.imissiveRelationA').text(docSubject);
								$('a.imissiveRelationA').css("display", "");
								
								fdViewUrl = fdViewUrl.substring(0, fdViewUrl.length - 7) + fdModelId;
								$('a.imissiveRelationA').attr("href", fdViewUrl);
							}
						}
					}, {
						width : 950,
						height : 550
					})
				}
			});
		</script>
	</c:otherwise>
</c:choose>

