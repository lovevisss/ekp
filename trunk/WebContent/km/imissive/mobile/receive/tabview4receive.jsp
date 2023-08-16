<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/mobile/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/component/locker/import/componentLockerVersion_show.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
    <template:replace name="head">
    	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/dis.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/listview.css?s_cache=${MUI_Cache}"></link>
		<c:set var="readViewLog" value="false" />
		<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
			<c:set var="readViewLog" value="true" />
		</kmss:auth>
		<c:set var="existAtt" value="false" scope="request"/>
		<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments}">
			<c:set var="existAtt" value="true" scope="request"/>
		</c:if>

		<c:if test="${kmImissiveReceiveMainForm.docStatus == '30'}">
			<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
		   		var dataStore;
		   		<%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
		   			dataStore = [
						  <c:if test="${isShowContentTabpanel eq 'true'}">
							{'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.docContent" />','moveTo':'_contentView' ,'id':'contentNav' ,'selected':true},
						  </c:if>
		   				 {'text':'收文跟踪', 'moveTo':'trackView'<c:if test="${isShowContentTabpanel ne 'true'}">, 'selected':true</c:if>},
		   				 {'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo" />', 'moveTo':'baseinfoView'},
						 <c:if test="${readViewLog eq 'true'}">
						 	{'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'_noteView'},
						 </c:if>
		   				 {'text':'传阅意见','moveTo':'_opinionView'}
		   			];
			   	<%}else{%> 
			   		dataStore = [{'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo" />', 'moveTo':'baseinfoView','selected':true},
						 <c:if test="${isShowContentTabpanel eq 'true'}">
		   				  	{'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.docContent" />','moveTo':'_contentView','id':'contentNav' },
						 </c:if>
		   				 {'text':'收文跟踪', 'moveTo':'trackView'},
						 <c:if test="${readViewLog eq 'true'}">
							{'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'_noteView'},
						 </c:if>
		   				 {'text':'传阅意见','moveTo':'_opinionView'}
			   		] ;
			    <%}%>
			    window._narStore = new Memory({
		   			data:dataStore
		   		});
		   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
		   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
		   		});
		   	});
		   </script>
	   </c:if>
	   <c:if test="${kmImissiveReceiveMainForm.docStatus != '30'}">
			<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
		   		var dataStore;
		   		<%if("content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())){ %>
		   			dataStore=[
						 <c:if test="${isShowContentTabpanel eq 'true'}">
		   					{'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.docContent" />','moveTo':'_contentView','id':'contentNav', 'selected':true},
						 </c:if>
						 {'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo" />', 'moveTo':'baseinfoView'<c:if test="${isShowContentTabpanel ne 'true'}">, 'selected':true</c:if>},
		   				 {'text':'收文跟踪', 'moveTo':'trackView'},
						 <c:if test="${readViewLog eq 'true'}">
							{'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'_noteView'},
						 </c:if>
		   				 {'text':'传阅意见','moveTo':'_opinionView'}
		   			];
			   	<%}else{%> 
			   		dataStore = [{'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo" />', 'moveTo':'baseinfoView','selected':true},
						 <c:if test="${isShowContentTabpanel eq 'true'}">
							{'text':'<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.docContent" />','moveTo':'_contentView','id':'contentNav'},
						 </c:if>
						 {'text':'收文跟踪', 'moveTo':'trackView'},
						 <c:if test="${readViewLog eq 'true'}">
							{'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'_noteView'},
						 </c:if>
		   				 {'text':'传阅意见','moveTo':'_opinionView'}
		   			];
			    <%}%>
			    window._narStore = new Memory({
		   			data:dataStore
		   		});
		   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
		   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
		   		});
		   	});
		   </script>
	   </c:if>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmImissiveReceiveMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
	<xform:config  orient="vertical">
		<html:form action="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do">	
		<div id="scrollView"  data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
			<div class="muiFlowInfoW">
				<div data-dojo-type="mui/fixed/Fixed" id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore" data-dojo-props="store:_narStore">
						</div>
					</div>
				</div>
				<%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())|| "content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())){ %>
					<%@ include file="/km/imissive/mobile/receive/tabview_content.jsp"%>
					<%@ include file="/km/imissive/mobile/receive/tabview_baseinfo.jsp"%>
				<%}else{ %>
					<%@ include file="/km/imissive/mobile/receive/tabview_baseinfo.jsp"%>
					<%@ include file="/km/imissive/mobile/receive/tabview_content.jsp"%>
				<%} %>
				<div data-dojo-type="dojox/mobile/View" id="_noteView">
					<div class="muiFormContent">
						<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
							<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }"/>
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"/>
							<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
					   </c:import>
				   </div>
				</div>
				<div data-dojo-type="dojox/mobile/View" id="_opinionView">
					<div class="muiFormContent">
						<ul
					    	data-dojo-type="mui/list/JsonStoreList"
					    	data-dojo-mixins="mui/list/ProcessItemListMixin"
					    	data-dojo-props="url:'/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=list&fdModelId=${param.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&isOpinion=true',lazy:false">
						</ul>
				   </div>
				</div>
			</div>
			
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
			                docStatus="${kmImissiveReceiveMainForm.docStatus}" 
							formName="kmImissiveReceiveMainForm"
							viewName="lbpmView"
							allowReview="true">
				<template:replace name="flowArea">
					<c:choose>
						<c:when test="${kmImissiveReceiveMainForm.docStatus < '20' && kmImissiveReceiveMainForm.docStatus >= '10'}">
							<c:if test="${ kmImissiveReceiveMainForm.sysWfBusinessForm.fdIsHander == 'true'}">
								<%--起草人草稿编辑操作 --%>
								<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=edit&fdId=${param.fdId }">
									<div data-dojo-type="mui/tabbar/TabBarButton"
										 data-dojo-props="colSize:1,href:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=edit&fdId=${param.fdId }'">
										<bean:message key="button.edit"/>
									</div>
								</kmss:auth>
							</c:if>
						</c:when>
					</c:choose>
					<c:if test="${kmImissiveReceiveMainForm.docStatus =='20'}">
					<%--分发 --%>
					<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.distribute =='true'}">
						<div data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
							<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute"/>
						</div>
					</c:if>
					<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
					<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveReceiveMainForm.attachmentForms['mainonline'].attachments}">
					     	 <c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='0'}">
						     	 <%-- 集成了易企签、勾选了附件选项 --%>
						     	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
						 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
						 		</div>
					      	 </c:if>
					      	  <c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
						     	 <%-- 集成了易企签、勾选了附件选项 --%>
						      	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
						 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
						 		</div>
					      	 </c:if>
				      	 </c:if>
				    </c:if>
				 	<%--上报 --%>
				 	<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.report =='true'}">
						<div data-dojo-type="mui/tabbar/TabBarButton" onclick="report();">
							<bean:message  bundle="km-imissive" key="kmImissiveSendMain.report"/>
						</div>
					</c:if>
					<c:if test="${existOpinion}">
						<div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
							传阅意见
						</div>
					</c:if>
					</c:if>
				<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></c:param>
					  <c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}"></c:param>
					  <c:param name="fdSubject" value="${kmImissiveReceiveMainForm.docSubject}"></c:param>
				      <c:param name="showOption" value="label"></c:param>
				  </c:import>
				  <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
						<c:param name="showOption" value="label"></c:param>
				  </c:import>
				  <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
					    <c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
					    <c:param name="showOption" value="label"></c:param>
					    <c:param name="isNew" value="true"></c:param>
				      </c:import>
				</template:replace>
				<template:replace name="publishArea">
					<c:if test="${kmImissiveReceiveMainForm.docStatus=='30' and kmImissiveReceiveMainForm.fdIsFiling!= true}">
						<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=distribute&fdId=${param.fdId}" requestMethod="GET">
							<div data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
								<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute"/>
							</div>
						</kmss:auth>
						<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
						<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveReceiveMainForm.attachmentForms['mainonline'].attachments}">
						     	 <c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='0'}">
							     	 <%-- 集成了易企签、勾选了附件选项 --%>
							     	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
							 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
							 		</div>
						      	 </c:if>
						      	  <c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
							     	 <%-- 集成了易企签、勾选了附件选项 --%>
							      	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
							 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
							 		</div>
						      	 </c:if>
					      	 </c:if>
					    </c:if>
						<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=report&fdId=${param.fdId}" requestMethod="GET">
							<div data-dojo-type="mui/tabbar/TabBarButton" onclick="report();">
								<bean:message  bundle="km-imissive" key="kmImissiveSendMain.report"/>
							</div>
						</kmss:auth>
					</c:if>
					<c:if test="${existOpinion}">
						<div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
							传阅意见
						</div>
					</c:if>
				  <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></c:param>
					  <c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}"></c:param>
					  <c:param name="fdSubject" value="${kmImissiveReceiveMainForm.docSubject}"></c:param>
				      <c:param name="showOption" value="label"></c:param>
				  </c:import>
				  <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
						<c:param name="showOption" value="label"></c:param>
				  </c:import>
				      <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
					    <c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
					    <c:param name="showOption" value="label"></c:param>
					    <c:param name="isNew" value="true"></c:param>
				      </c:import>
				</template:replace>
			</template:include>
		</div>
		<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true' and (_isWpsCloudEnable eq 'true' or _isWpsCenterEnable eq 'true')}">
			<%@ include file="/km/imissive/mobile/cookieUtil_script.jsp"%>
			<%@ include file="/km/imissive/mobile/receive/number_include.jsp"%>
		</c:if>
		<%@ include file="/km/imissive/mobile/receive/view_import.jsp"%>
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveReceiveMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveReceiveMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/govding">
			<c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveReceiveMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		</c:import>
		<!-- 版本锁机制 -->
		<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
		</c:import>
		<!-- 钉钉图标 end -->
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="fdKey" value="receiveMainDoc" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
			<c:param name="onClickSubmitButton" value="Com_submitReview();" />
		</c:import>
		<script>
			require(["mui/form/ajax-form!kmImissiveReceiveMainForm"]);
		</script>
		<script type="text/javascript">
			require(["dojo/ready","dojo/dom-style","dojo/dom","mui/dialog/Tip"], function(ready,domStyle,dom,Tip) {
				<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
			    Com_Parameter.event["submit"].push(function(){
			   	//操作类型为通过类型 ，才判断是否已经签署
				var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
			   	if($(canStartProcess).val() == "true" &&  lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
			   		var flag = true;
			   	 	var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryFinish&signId=${param.fdId}";
			   	 	$.ajax({
			   			url : url,
			   			type : 'post',
			   			data : {},
			   			dataType : 'text',
			   			async : false,     
			   			error : function(){
			   				Tip.tip({icon:'mui mui-warn', text:'请求出错',width:'180',height:'60'});
			   				flag = false;
			   			} ,   
			   			success:function(data){
			   				if(data == "true"){
			   					flag = true;
			   				}else{
			   					Tip.tip({icon:'mui mui-warn', text:'当前签署任务未完成，无法提交！！',width:'240',height:'120'});
			   					flag = false;
			   				}
			   			}
			   		});
			   	 	return flag;
			   	}else{
			   		return true;
			   	} 
			    });
			    </c:if>
			});
		</script>
	</html:form>
	</xform:config>
	</template:replace>
</template:include>


