<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${kmImissiveRegDetailListForm.fdRegName}"></c:out>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do">		
		<div id="scrollView" 
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/form/_ValidateMixin">
			<div data-dojo-type="mui/panel/AccordionPanel">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message key="table.kmImissiveReg" bundle="km-imissive" />',icon:'mui-ul'">
				   <div class="muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message key="kmImissiveReg.fdName" bundle="km-imissive" />
								</td><td>
									<c:out value="${kmImissiveRegDetailListForm.fdRegName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
								</td><td>
									<c:if test="${empty kmImissiveRegDetailListForm.fdRegNo}">
								          	${lfn:message("km-imissive:kmImissiveSendMain.fdDocNum.auto") }
								    </c:if>
								    <c:if test="${not empty kmImissiveRegDetailListForm.fdRegNo}">
								              <c:out value="${kmImissiveRegDetailListForm.fdRegNo}" />
					                </c:if>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListForm.fdRegDocCreateTime}"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSendUnit"/>
								</td><td>
									<c:out value="${fdFromUnit}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdUnit"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListForm.fdUnitName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdOrgNames"/>
								</td><td>
									<c:out value="${kmImissiveRegDetailListForm.fdOrgNames}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdStatus"/>
								</td><td>
								    <sunbor:enumsShow value="${kmImissiveRegDetailListForm.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
								</td>
							</tr>
							<c:if test="${not empty kmImissiveRegDetailListForm.fdSignTime}">
							 <tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignerName"/>
								</td>
								<td>
									<c:out value="${kmImissiveRegDetailListForm.fdSignerName}"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignTime"/>
								</td>
								<td>
									<c:out value="${kmImissiveRegDetailListForm.fdSignTime}"/>
								</td>
							</tr>
						</c:if>
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '2' or kmImissiveRegDetailListForm.fdStatus eq '4'}">
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject"/>
								</td>
								<td>
									<c:choose>
							            <c:when test="${not empty kmImissiveRegDetailListForm.fdReceiveId}">
							              <a class="com_btn_link" href="javascript:void(0)" onclick="openReceiveDoc();">${ReceiveDocName}</a>
							            </c:when>
							            <c:otherwise>
							               <bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject.null"/>
							            </c:otherwise>
						          </c:choose>
								</td>
							</tr>
						</c:if>
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '3'}">
							 <tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveReg.return.reason"/>
								</td>
								<td>
									<c:out value="${docContent}"/>
								</td>
							</tr>
						</c:if>
						</table>
					</div>
				</div>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'正文附件',icon:'mui-ul'">
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
				</div>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'文档附件',icon:'mui-ul'">
				    <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="regAtt" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
				</div>
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'签署附件',icon:'mui-ul'">
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="eqbSign" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="ofdEqbSign" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="ofdCySign" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="yqqSigned" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="convert_toPDF" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="convert_toOFD" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					</c:import>
				</div>
				<c:if test="${kmImissiveRegDetailListForm.fdReadSendOpinion eq '1' and kmImissiveRegDetailListForm.fdReadReviewOpinion eq '1'}">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReg.signRecord"/>',icon:'mui-ul'">
					   <c:choose>
							 <c:when test="${kmImissiveRegDetailListForm.fdRegType eq '2' }">
								<c:set var="fdModelId" value="${kmImissiveRegDetailListForm.fdRegReceiveId}" scope="request"/>
								<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" scope="request"/>
								<c:set var="formBeanName" value="kmImissiveReceiveMainFormx" scope="request"/>
							</c:when>
							<c:otherwise>
								<c:set var="fdModelId" value="${kmImissiveRegDetailListForm.fdRegSendId}" scope="request"/>
								<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" scope="request"/>
								<c:set var="formBeanName" value="kmImissiveSendMainFormx" scope="request"/>
							</c:otherwise>
						</c:choose>
						<c:import url="/km/imissive/mobile/import/kmImissiveReg_listNote.jsp" charEncoding="UTF-8">
							<c:param name="fdMainId" value="${fdModelId}" />
							<c:param name="fdModelName" value="${fdModelName}" />
							<c:param name="formBeanName" value="${formBeanName}"/>
							<c:param name="fdRegId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						</c:import>
					</div>
				</c:if>
		   </div>
		   <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
			   <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=updateSign&fdId=${kmImissiveRegDetailListForm.fdId}" requestMethod="GET">
				  	<c:choose>
						<c:when test="${kmImissiveRegDetailListForm.fdRegType eq '2' }">
								<c:if test="${kmImissiveRegDetailListForm.fdStatus!='2' and kmImissiveRegDetailListForm.fdStatus!='3' and kmImissiveRegDetailListForm.fdStatus!='4'}">
								    <c:choose>
								    	<c:when test="${'true' eq existRS }">
								    		<li data-dojo-type="km/imissive/mobile/list/CreateButtonDetailList"
						  						data-dojo-props="icon1:'',key:'RS',type:'RS',fdDetailId:'${kmImissiveRegDetailListForm.fdId}',fdSendId:'${kmImissiveRegDetailListForm.fdRegSendId}',fdReceiveId:'${kmImissiveRegDetailListForm.fdRegReceiveId}'">
						  						<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSignSend"/>
						  					 </li>
								    	</c:when>
								    	<c:otherwise>
								    		<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" data-dojo-props="colSize:2"
							            			onclick="updateSignSend();">
												<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSignSend"/>
											</li>
								    	</c:otherwise>
								    </c:choose>
				  					 <c:choose>
								    	<c:when test="${'true' eq existRR}">
						  					 <li data-dojo-type="km/imissive/mobile/list/CreateButtonDetailList"
						  						data-dojo-props="icon1:'',key:'RR',type:'RR',fdDetailId:'${kmImissiveRegDetailListForm.fdId}',fdSendId:'${kmImissiveRegDetailListForm.fdRegSendId}',fdReceiveId:'${kmImissiveRegDetailListForm.fdRegReceiveId}'">
						  						<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSignReceive"/>
						  					 </li>
						  				</c:when> 
				  						 <c:otherwise>
				  						 	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" data-dojo-props="colSize:2"
							            			onclick="updateSignReceive();">
												<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSignReceive"/>
											</li>
									  	 </c:otherwise>
									  </c:choose> 
								</c:if>
						</c:when>
						<c:otherwise>
							 <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=updateSign&fdId=${param.fdId}" requestMethod="GET">
								<c:if test="${kmImissiveRegDetailListForm.fdStatus!='2' and kmImissiveRegDetailListForm.fdStatus!='3' and kmImissiveRegDetailListForm.fdStatus!='4'}">
								   <c:choose>
								    	<c:when test="${'true' eq existSR}">
										    <li data-dojo-type="km/imissive/mobile/list/CreateButtonDetailList"
						  						data-dojo-props="icon1:'',type:'SR',fdDetailId:'${kmImissiveRegDetailListForm.fdId}',fdSendId:'${kmImissiveRegDetailListForm.fdRegSendId}',fdReceiveId:'${kmImissiveRegDetailListForm.fdRegReceiveId}'">
						  						<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSign"/>
						  					</li>
										</c:when>
										 <c:otherwise>
										 	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" data-dojo-props="colSize:2"
							            			onclick="updateSign();">
												<bean:message  bundle="km-imissive" key="kmImissiveReg.updateSign"/>
											</li>
									  	 </c:otherwise>
									</c:choose>	
								</c:if>
							</kmss:auth>
						</c:otherwise>
					</c:choose>
					<!-- 退回 -->
					<c:if test="${canReturn  and kmImissiveRegDetailListForm.fdStatus eq '1'}">
						<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" data-dojo-props="colSize:2"
		            			onclick="addBack();">
							${lfn:message('km-imissive:kmImissiveReg.updateReturn')}
						</li>
					</c:if>
				</kmss:auth> 	
				<c:if test="${kmImissiveRegDetailListForm.fdRegDeliverType!='3' and kmImissiveRegDetailListForm.fdStatus!='2' and kmImissiveRegDetailListForm.fdStatus!='3' and kmImissiveRegDetailListForm.fdStatus!='4'}">
				 	<li data-dojo-type="km/imissive/mobile/list/SignOnlyButton" data-dojo-props="url:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceiveOnly&fddetaiId=${kmImissiveRegDetailListForm.fdId}',fdDetailId:'${kmImissiveRegDetailListForm.fdId}'"></li>
				</c:if>
			</ul>
	</html:form>
	<script type="text/javascript">
		require(["mui/device/adapter", "dojo/_base/lang", "mui/dialog/Tip", "dojo/request", "mui/syscategory/SysCategoryUtil", "mui/util", "dojo/Deferred"],
				function(adapter, lang, Tip, req, SysCategoryUtil, util, Deferred) {
			window.openReceiveDoc = function(){
				var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveRegDetailListForm.fdReceiveId}";
				if("${kmImissiveRegDetailListForm.fdSignType}" == '1'){
					url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveRegDetailListForm.fdReceiveId}";
				}
				adapter.open(url, "_blank");
			};
			
			window.updateSignOnly = function(){
				regDetailListSign(function() {
					var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceiveOnly&fddetaiId=${kmImissiveRegDetailListForm.fdId}";
					window.open(url, "_self");
				})
			};
			
			window.addBack = function() {
				regDetailListSign(function() {
					window.open('${LUI_ContextPath}/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?'
							 + 'method=add&fdImissiveId=${kmImissiveRegDetailListForm.fdRegSendId}&fddetaiId=${kmImissiveRegDetailListForm.fdId}','_self');
				});
			}
			
			window.updateSignSend = function() {
				regDetailListSign(function() {
					SysCategoryUtil.create({
						key: "sendAdd",
						createUrl: "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=!{curIds}&mobile=true",
						modelName: "com.landray.kmss.km.imissive.model.KmImissiveSendTemplate",
						mainModelName: "com.landray.kmss.km.imissive.model.KmImissiveSendMain",
     					showFavoriteCate:'true',
						authType: '02'
		            });
				});
			}
			
			window.updateSignReceive = function() {
				regDetailListSign(function() {
					SysCategoryUtil.create({
						key: "receiveAdd",
		                createUrl: "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=!{curIds}&mobile=true",
		                modelName: "com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate",
		                mainModelName: "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain",
     					showFavoriteCate:'true',
						authType: '02'
		            });
				});
			};
			
			window.updateSign = function() {
				regDetailListSign(function() {
					SysCategoryUtil.create({
						key: "receiveAdd",
		                createUrl: "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=!{curIds}&mobile=true",
		                modelName: "com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate",
		                mainModelName: "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain",
     					showFavoriteCate:'true',
						authType: '02'
		            });
				});
			};
			
			// 校验是否撤回，校验通过进行签收
			function regDetailListSign(callback) {
				var canflag = false;
				var deferred = new Deferred();
				req(util.formatUrl("/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt"), {
					handleAs : 'json',
					method : 'post',
					data : {
						fdDetailId: "${kmImissiveRegDetailListForm.fdId}",
						justCheckCancel: "true"
					}
				}).then(lang.hitch(this, function(results) {
					if (results && results['cancel'] != 'true'){
						canflag = true;
					}
					deferred.resolve();
				}));
				
				deferred.then(function() {
					// 未撤回才可以进行操作
					if (canflag) {
						if (callback && typeof(callback) === "function") {
							callback();
						}
					} else {
						Tip.tip({icon:'mui mui-warn', text:'该签收单已经撤回，无法进行此操作',width:'260',height:'120'});
					}
				});
			}
			
		});
	</script>
	</template:replace>
</template:include>
