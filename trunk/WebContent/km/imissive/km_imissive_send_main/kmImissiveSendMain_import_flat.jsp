<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${requestScope[param.formName]}" />
	
	<!-- 阅读机制 -->
	<c:import url="/sys/readlog/import/sysReadLog_view.jsp" 	charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendMainForm" />
	</c:import>
	<!-- 阅读机制 -->
	<ui:content title="${ lfn:message('km-imissive:kmImissiveSendMain.tracking.record') }">
	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/jquery.qtip.css" />
	<script type="text/javascript" src="${LUI_ContextPath}/km/imissive/resource/js/jquery.qtip.js" charset="UTF-8"></script>
	<script type="text/javascript" src="${LUI_ContextPath}/km/imissive/resource/js/hogan.js" charset="UTF-8"></script>
	<!-- 模板 -->
	<script id="return-Template" type="text/template">
<div style="overflow:hidden;width:200px;">
<ul>
 <li style="font-size:12px;margin-bottom:5px">退回意见:{{fdContent}}</li>
 <li style="font-size:12px;margin-bottom:5px">退回人:{{docCreator}}</li>
 <li style="font-size:12px;margin-bottom:5px">退回单位:{{fdUnitName}}</li>
 <li style="font-size:12px;margin-bottom:5px">退回时间:{{docCreateTime}}</li>
</ul>
</div>
	</script>
	<script id="returnDoc-Template" type="text/template">
<div style="overflow:hidden;width:200px;">
<ul>
 <li style="font-size:12px;margin-bottom:5px">退文意见:{{fdContent}}</li>
 <li style="font-size:12px;margin-bottom:5px">退文人:{{docCreator}}</li>
 <li style="font-size:12px;margin-bottom:5px">退文单位:{{fdUnitName}}</li>
 <li style="font-size:12px;margin-bottom:5px">退文时间:{{docCreateTime}}</li>
</ul>
</div>
	</script>
	<script>
	function ccc(){
		var source = $("#return-Template").html();  
		var template = Hogan.compile(source);
		$(".aaa").each(function(){
			$(this).qtip({
				content: {
					text: 'Loading...',
					ajax: {
						url: "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=loadOpinionById&fdDetailId="+this.id,
						type: 'GET', // POST or GET
						dataType:"json",
						success: function(data, status) {
							this.set('content.text', template.render(data));
						}
					}
				},
			    position: {
					my: 'right top',
					at: 'right bottom',
				    effect: false,
				    target: 'mouse'
				}
			})
		});
	 }
	function ddd(){
			var source = $("#returnDoc-Template").html();
			var template = Hogan.compile(source);
			$(".bbb").each(function(){
				$(this).qtip({
					content: {
						text: 'Loading...',
						ajax: {
							url: "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=loadOpinionById&fdDetailId="+this.id,
							type: 'GET', // POST or GET
							dataType:"json",
							success: function(data, status) {
								this.set('content.text', template.render(data));
							}
						}
					},
				    position: {
						my: 'right top',
						at: 'right bottom',
					    effect: false,
					    target: 'mouse'
					}
				})
			});
		 }
	seajs.use(['lui/topic'], function(topic) {
	 topic.channel("report").subscribe("list.loaded",ccc);
	 topic.channel("report").subscribe("list.loaded",ddd);
	});
	</script>
     <div id ="trackArea">
		<table width=100% class="tb_normal">
			  <!-- 会签记录 -->
		      <tr  id="signDeptTr">	  
			   <td>
			   <div style="margin-top: 15px;">
			     <div style="float:left">
					 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.sign"/>
					 </b>
				 </div>
				 <div style="margin-right:10px;text-align:right" id="signBtn">
					  <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=sign&fdId=${mainForm.fdId}" requestMethod="GET">
					     <a href="javascript:;" onclick="urgeSign('sign')" class="com_btn_link"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.btn.urgeSign"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  </kmss:auth>
					  <input type="checkbox" name="waitSignS"  onclick="changeSign()"><bean:message  bundle="km-imissive" key="status.waitSign"/>
					  <input type="checkbox" name="signedS"  onclick="changeSign()"><bean:message  bundle="km-imissive" key="status.signed"/>
			     </div>
			   </div>
			 	<div style="height: 15px;"></div>
				   <list:listview id="sign" channel="sign">
						<ui:source type="AjaxJson">
							{"url":"/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&fdMainId=${mainForm.fdId}&type=3"}
						</ui:source>
						<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
						    <list:col-checkbox name="sign"></list:col-checkbox>
							<list:col-auto props="kmImissiveRegDetailList.fdReg.fdName;kmImissiveRegDetailList.fdReg.fdDeliverType;fdUnit.fdName;docCreateTime;fdOrgNames;fdStatus;nodeName;handlerName"></list:col-auto>
						</list:colTable>
						<ui:event topic="list.loaded">
						   var waitSignS = document.getElementsByName("waitSignS")[0];
						   var signedS = document.getElementsByName("signedS")[0];
						   if(LUI('sign')._data.datas.length==0&&!waitSignS.checked&&!signedS.checked){
						      $("#signBtn").css("visibility","hidden");
						   }
						</ui:event>						
					</list:listview>
					<div style="height: 15px;"></div>
					<list:paging layout="sys.ui.paging.simple" channel="sign"></list:paging>
			   </td>
			  </tr>	
			  <!--分发记录 -->
			  <c:if test="${mainForm.fdMissiveType != '2'}">
			  	 <c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_distributeDoc.jsp" charEncoding="UTF-8">
					<c:param name="fdRegType" value="send" />
					<c:param name="fdMainId" value="${mainForm.fdId}" />
				 </c:import>
			  </c:if>
			  <!-- 上报记录 -->
			  <c:if test="${mainForm.fdMissiveType != '1'}">
			  	 <c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_reportDoc.jsp" charEncoding="UTF-8">
					<c:param name="fdRegType" value="send" />
					<c:param name="fdMainId" value="${mainForm.fdId}" />
				 </c:import>
			  </c:if>
			  <!-- 退文记录 -->
			  <c:if test="${mainForm.docStatus =='30' && mainForm.fdMissiveType != '1'}">
				<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_returnDoc.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
				 </c:import>
			  </c:if>
			  <!-- 附件跟踪 -->
			   <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${mainForm.fdId}" requestMethod="GET">
				 <c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_attTrack.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
				 </c:import>
			  </kmss:auth>
			  <tr>	  
			   <td>
			    <div style="margin-top: 15px;">
				    <div style="float:left">
						 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.circulate"/>
						 </b>
					 </div>
					 <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;
				     </div>
			    </div>
			 	<div style="height: 15px;"></div>
			    <c:import
					url="/km/imissive/km_imissive_circulation/kmImissiveCirculation_view.jsp"
					charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmImissiveSendMainForm" />
					<c:param
						name="isShowUiContent"
						value="false" />
				</c:import>
				 </td>
			  </tr>
			  <c:if test="${mainForm.docStatus =='30'}">
			   <tr>	  
			   <td>
			    <div style="margin-top: 15px;">
				    <div style="float:left">
						 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.publish"/>
						 </b>
					 </div>
					 <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;
				     </div>
			    </div>
			 	<div style="height: 15px;"></div>
				<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="isShowUiContent" value="false" />
			    </c:import>
			    <c:choose> 
				   <c:when test="${mainForm.fdNeedContent=='1'}">
				       <c:set var="contentAttKey" value="editonline" scope="request"/>
				   </c:when>
				   <c:otherwise>
					  <c:set var="contentAttKey" value="mainonline" scope="request"/>
					</c:otherwise>
				</c:choose>	
			    <c:import url="/sys/news/import/sysNewsPublishMain_view4att.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="isShowUiContent" value="false" />
					<c:param name="attKey" value="attachment" />
					<c:param name="contentAttKey" value="${contentAttKey}" />
			    </c:import>
			   </td>
			  </tr>
			  </c:if>
		</table> 
	</div>
	</ui:content>

	<!-- 权限机制-->
	<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
		<table class="tb_normal" width=100%>
			<tr>
				<td class="td_normal_title" width="15%"><bean:message key="kmImissiveSendMain.authAppRecReaderIds" bundle="km-imissive" /></td>
				<td width="85%" colspan='3'>
				    <c:if test="${empty mainForm.authAppRecReaderNames}">
						<bean:message bundle="sys-right" key="right.other.person" />
					</c:if>
					<c:if test="${not empty mainForm.authAppRecReaderNames}">
						<c:out value="${mainForm.authAppRecReaderNames}"></c:out>
					</c:if>
				</td>
			</tr>
			<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSendMainForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
		</table>
	</ui:content>
	<c:import url="/sys/bookmark/import/bookmark_bar.jsp"
			charEncoding="UTF-8">
			<c:param name="fdSubject" value="${mainForm.docSubject}" />
			<c:param name="fdModelId" value="${mainForm.fdId}" />
			<c:param name="fdModelName"
				value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
	</c:import>		