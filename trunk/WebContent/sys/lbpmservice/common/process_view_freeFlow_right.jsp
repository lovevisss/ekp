<%@page import="com.landray.kmss.sys.lbpmext.businessauth.service.ILbpmExtBusinessSettingInfoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.xform.util.SysFormDingUtil"%>
<%
	ILbpmExtBusinessSettingInfoService lbpmExtBusinessSettingInfoService = (ILbpmExtBusinessSettingInfoService) SpringBeanUtil
			.getBean("lbpmExtBusinessSettingInfoService");
	String isOpinionTypeEnabled = lbpmExtBusinessSettingInfoService.getIsOpinionTypeEnabled("imissiveLbpmSwitch");
	request.setAttribute("isOpinionTypeEnabled", isOpinionTypeEnabled);
%>
<link type="text/css" rel="stylesheet" href="<c:url value="/sys/lbpmservice/common/css/process_tab_main.css?s_cache=${LUI_Cache}"/>"/> 
<c:set var="sysWfBusinessForm" value="${requestScope[param.formName]}" />
<c:set var="lbpmProcessForm" value="${sysWfBusinessForm.sysWfBusinessForm.internalForm}" />

<%@ include file="/sys/lbpmservice/include/sysLbpmProcess_script.jsp"%> 
<%@ include file="/sys/lbpmservice/workitem/workitem_common.jsp"%>
<!--引入暂存按钮-->
<c:import url="/sys/lbpmservice/import/sysLbpmProcess_saveDraft.jsp" charEncoding="UTF-8"> 
	<c:param name="formName" value="${param.formName}">
	</c:param>
</c:import>
<!--引入切换表单按钮-->
<%@ include file="/sys/lbpmservice/import/sysLbpmProcess_subform.jsp"%>
		<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
		<c:if test="${empty param.onClickSubmitButton}">
		<form name="sysWfProcessForm" method="POST"
				action="<c:url value="/sys/lbpmservice/support/lbpm_process/lbpmProcess.do" />">
		</c:if>
		</c:if>
		<input type="hidden" id="sysWfBusinessForm.fdParameterJson" name="sysWfBusinessForm.fdParameterJson" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdAdditionsParameterJson" name="sysWfBusinessForm.fdAdditionsParameterJson" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdIsModify" name="sysWfBusinessForm.fdIsModify" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdCurHanderId" name="sysWfBusinessForm.fdCurHanderId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdCurHanderId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdCurNodeSavedXML" name="sysWfBusinessForm.fdCurNodeSavedXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdCurNodeSavedXML}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdFlowContent" name="sysWfBusinessForm.fdFlowContent" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdProcessId" name="sysWfBusinessForm.fdProcessId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdProcessId}" />'>
		<input type="hidden" id="sysWfBusinessForm.fdKey" name="sysWfBusinessForm.fdKey" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdKey}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdModelId" name="sysWfBusinessForm.fdModelId" value='<c:out value="${sysWfBusinessForm.fdId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdModelName" name="sysWfBusinessForm.fdModelName" value='<c:out value="${sysWfBusinessForm.modelClass.name}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdCurNodeXML" name="sysWfBusinessForm.fdCurNodeXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdCurNodeXML}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdTemplateModelName" name="sysWfBusinessForm.fdTemplateModelName" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdTemplateModelName}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdTemplateKey" name="sysWfBusinessForm.fdTemplateKey" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdTemplateKey}" />' >
		<input type="hidden" id="sysWfBusinessForm.canStartProcess" name="sysWfBusinessForm.canStartProcess" value='' >
		<input type="hidden" id="sysWfBusinessForm.fdTranProcessXML" name="sysWfBusinessForm.fdTranProcessXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdTranProcessXML}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdDraftorId" name="sysWfBusinessForm.fdDraftorId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdDraftorId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdDraftorName" name="sysWfBusinessForm.fdDraftorName" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdDraftorName}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdHandlerRoleInfoIds" name="sysWfBusinessForm.fdHandlerRoleInfoIds" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdHandlerRoleInfoIds}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdHandlerRoleInfoNames" name="sysWfBusinessForm.fdHandlerRoleInfoNames" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdHandlerRoleInfoNames}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdAuditNoteFdId" name="sysWfBusinessForm.fdAuditNoteFdId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdAuditNoteFdId}" />' >
		<input type="hidden" id="docStatus" name="docStatus" value='<c:out value="${sysWfBusinessForm.docStatus}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdIdentityId" name="sysWfBusinessForm.fdIdentityId" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdIdentityId}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdProcessStatus" name="sysWfBusinessForm.fdProcessStatus" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdProcessStatus}" />' >
		<input type="hidden" id="sysWfBusinessFormPrefix" name="sysWfBusinessFormPrefix" value='<c:out value="${sysWfBusinessFormPrefix}" />' >
		<input type="hidden" id="sysWfBusinessForm.fdSubFormXML" name="sysWfBusinessForm.fdSubFormXML" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdSubFormXML}" />'>
		<!-- 留下其他信息处理的域，为了兼容特权人修改流程图信息时保存其他设计的信息 -->
		<input type="hidden" id="sysWfBusinessForm.fdOtherContentInfo" name="sysWfBusinessForm.fdOtherContentInfo" value='<c:out value="${sysWfBusinessForm.sysWfBusinessForm.fdOtherContentInfo}" />'>
		<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11' || sysWfBusinessForm.docStatus == '10'}">
			<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
				<div id="handlerTypeRow">
					<div class="lui-lbpm-titleNode">
						<bean:message bundle="sys-lbpmservice" key="lbpmProcess.handlerType" />
					</div>
					<div class="lui-lbpm-detailNode">
						
					</div>
				</div>
			</c:if>
		</c:if>		
		<div id="freeflowRow">
			<div class="lui-lbpm-titleNode">
				<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.flow" />
			</div>
			<div class="lui-lbpm-detailNode">
				<c:if test="${sysWfBusinessForm.docStatus!='10'}">
				<div id="editFreeFlowDIV" style="display:none;">
					<input type="hidden" name="handlerIds_imissive">
					<input type="hidden" name="handlerNames_imissive">
					<div id="freeflow_appendNodeDIV">
						<div class="lbpm_freeflow_appendNode lbpm_freeflow_reviewNode" onclick="lbpm.globals.beforeAddNodeInFreeFlow('reviewNode');"><i></i><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.review" /></div>
						<div class="lbpm_freeflow_appendNode lbpm_freeflow_signNode" onclick="lbpm.globals.beforeAddNodeInFreeFlow('signNode');"><i></i><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.sign" /></div>
						<div class="lbpm_freeflow_appendNode lbpm_freeflow_sendNode" onclick="lbpm.globals.beforeAddNodeInFreeFlow('sendNode');"><i></i><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.send" /></div>
					</div>
					<div class="lbpm_freeflow_modifyFlowContent">
						<a class="com_btn_link" href="javascript:lbpm.globals.modifyFreeFlow('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
							<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.modifyFlowContent" />
						</a>
					</div>
				</div>
				<div id="viewFreeFlowDIV" style="display:none">
					<a class="com_btn_link" href="javascript:lbpm.globals.viewFreeFlow('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
						<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.viewFlowContent" />
					</a>
				</div>
				<div id="flowNodeDIV" style="display:none">
					<ul id="flowNodeUL" class="lbpm_freeflow_draglist">
					</ul>
					<ul class="lbpm_freeflow_add_moreList">
						<li data-node-type="reviewNode"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.reviewNode" /></li>
						<li data-node-type="signNode"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.signNode" /></li>
						<li data-node-type="sendNode"><bean:message bundle="sys-lbpmservice" key="lbpmservice.freeflow.sendNode" /></li>
					</ul>
				</div>
				</c:if>
				<c:if test="${sysWfBusinessForm.docStatus=='10'}">
				<div id="editFreeFlowDIV" style="display:none;">
					<a class="com_btn_link" href="javascript:lbpm.globals.viewFreeFlow('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
						<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.viewFlowContent" />
					</a>
				</div>
				<div id="viewFreeFlowDIV" style="display:none">
					<a class="com_btn_link" href="javascript:lbpm.globals.viewFreeFlow('sysWfBusinessForm.fdFlowContent', 'sysWfBusinessForm.fdTranProcessXML');">
						<bean:message bundle="sys-lbpmservice" key="lbpm.freeFlow.viewFlowContent" />
					</a>
				</div>
				</c:if>
			</div>
		</div>
		<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11'}">
			<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}"><%-- start action --%>
				<div id="operationItemsRow">
					<div class="lui-lbpm-titleNode">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationItems" />
					</div>
					<div class="lui-lbpm-detailNode">
						<bean:message bundle="sys-lbpmservice" key="lbpmProcess.selectNode" />
						<select name="operationItemsSelect" onchange="lbpm.globals.operationItemsChanged(this);">
						</select>
					</div>
				</div>
				<%-- 起草人选择人工分支节点 --%>
				<c:if test="${sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20'}">
					<div id="manualBranchNodeRow" style="display:none">
						<div class="lui-lbpm-titleNode">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.manualNodeSelect" />
						</div>
						<div class="lui-lbpm-detailNode" id="manualNodeSelectTD">
							
						</div>
					</div>
				</c:if>
				<div id="operationHandlerDiv">
					<div id="operationMethodsRow">
						<div class="lui-lbpm-titleNode">
							<span class="txtstrong">*</span><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationMethods" />
						</div>
						<div class="lui-lbpm-detailNode" id="operationMethodsGroup">
							
						</div>
					</div>
					<%-- 动态加载操作--%>
					<c:forEach items="${lbpmProcessForm.curHandlerOperationsReviewJs}" var="reviewJs" varStatus="vstatus">
						<c:if test="${!(fn:contains(syslbpmOperation_jspArray, reviewJs)) || compressSwitch eq 'false'}">
							<c:import url="${reviewJs}" charEncoding="UTF-8" />
						</c:if>
					</c:forEach>
					<%-- 用于起草节点 ,显示即将流向--%>
					<c:if test="${(sysWfBusinessForm.docStatus == null || sysWfBusinessForm.docStatus<'20') && sysWfBusinessForm.docStatus != '10'}">
						<div style="display:none;" id="nextNodeTR">
							<div class="lui-lbpm-titleNode" id="nextNodeTDTitle">
								<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.nextNode" />
							</div>
							<div class="lui-lbpm-detailNode" id="nextNodeTD">
								&nbsp;
							</div>
						</div>
					</c:if>
					<div id="operationsRow_Type" style="display:none;" lbpmMark="operation">
						<div class="lui-lbpm-titleNode" id="operationsTDTitle_Type">
							&nbsp;
						</div>
						<div class="lui-lbpm-detailNode" id="operationsTDContent_Type">
							&nbsp;
						</div>
					</div>
					<div id="operationsRow" style="display:none;" lbpmMark="operation">
						<div class="lui-lbpm-titleNode" id="operationsTDTitle">
						&nbsp;
						</div>
						<div class="lui-lbpm-detailNode" id="operationsTDContent">
							&nbsp;
						</div>
					</div>
					<div id="operationsRow_Scope" style="display:none;" lbpmMark="operation">
						<div class="lui-lbpm-titleNode" id="operationsTDTitle_Scope">
							&nbsp;
						</div>
						<div class="lui-lbpm-detailNode" id="operationsTDContent_Scope">
							&nbsp;
						</div>
					</div>
					<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
						<div id="checkChangeFlowTR" style="display:none;" lbpmmark="operation">
							<div class="lui-lbpm-titleNode">
								<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor" />
							</div>
							<div class="lui-lbpm-detailNode">
								<label id="changeProcessorDIV" style="display:none;">
									<a href="javascript:;" class="com_btn_link" onclick="Com_EventPreventDefault();lbpm.globals.changeProcessorClick();">
										<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor.button" />
									</a>&nbsp;&nbsp;
								</label>
								<label id="modifyFlowDIV" style="display:none;">
									<a class="com_btn_link" href="javascript:lbpm.globals.modifyProcess('sysWfBusinessForm.fdFlowContent','sysWfBusinessForm.fdTranProcessXML');">
										<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.modifyFlow" />
									</a>
								</label>
							</div>
						</div>
					</c:if>
				</div>
				<div id="descriptionRow">
					<div class="lui-lbpm-titleNode">
						<span id="mustSignStar" class="txtstrong" style="display:none">*</span><bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.opinion" />
					</div>
					<div class="lui-lbpm-detailNode">
						<table width=100% border=0 class="tb_noborder">
							<tr>
								<td id="fdUsageContentTd">
									<span style="display: block;" class="lui-lbpm-opinion-outerBox">	
										<span id="fdUsageContentSpan" style="display: block;border: none;">
											<textarea name="fdUsageContent" class="process_review_content" placeholder="${ lfn:message('sys-lbpmservice:lbpmRight.opinion') }" style="height:100px;width:100%;resize:none;border-bottom: 0" key="auditNode" subject="${lfn:message('sys-lbpmservice:lbpmNode.createDraft.opinion')}" validate="fdUsageContentMaxLength(4000)"></textarea>
										</span>
										<div class="lui-lbpm-opinion-action">
					                    	<div class="lui-lbpm-opinion-action-box">
												<div class="commonUsedOpinion">
													<div class="lui-lbpm-advice">
						                          		<span><bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages" /></span>
						                        		<i class="lui-lbpm-downIcon"></i>
						                        		<div class="commonUsedOpinionList">
								                            <ul></ul>
								                        	<div class="lui-lbpm-opinion-custormBtn" onclick="Com_EventPreventDefault();lbpm.globals.openDefiniateUsageWindow();">
								                        		<i class="lui-lbpm-opinion-custormBtn-add"></i>
								                        		<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages.definite" />
								                        	</div>
								                        </div>
						                        	</div>
						                     	</div>
						                      <div class="lui-lbpm-opinion-otherFnc">
						                          <div title="<bean:message key="button.saveDraft" bundle="sys-lbpmservice" />" class="saveOpinion lui-lbpm-opinion-btn" id="saveDraftButton" onclick="lbpm.globals.saveDraftAction(this);">
						                           	<c:choose>
				                            			<c:when test='<%="true".equals(SysFormDingUtil.getEnableDing()) || "true".equals(request.getParameter("ddpage"))%>'>
				                            				<i><div style="display: none" class="lui-lbpm-option-btn-text"><bean:message bundle="sys-lbpmservice" key="button.saveDraft" /></div></i>
				                            			</c:when>
				                            			<c:otherwise>
				                            				<i></i>
				                            			</c:otherwise>
				                            		</c:choose>
						                          </div>
						                          <div class="lui-lbpm-opinion-more lui-lbpm-opinion-btn" style="display:none">
						                            <i></i>
						                            <div class="lui-lbpm-opinion-moreList">
						                              <ul></ul>
						                            </div>
						                          </div>
						                      </div>
					                      </div>
					                  </div>
									</span>
									<c:if test="${isOpinionTypeEnabled eq 'true'}">
										<span id="opinionConfig" >
											<label>
												<input type="checkbox" id="notifyIsScript" checked="checked" name="sysWfBusinessForm.notifyIsScript">
												是否显示在稿纸
											</label>
											<label>
												<xform:select property="sysWfBusinessForm.approveOpinionType" showStatus="edit" subject="默认意见类型" htmlElementProperties="id='approveOpinionType'">
													<xform:customizeDataSource className="com.landray.kmss.sys.lbpmservice.support.service.spring.LbpmAuditNoteTypeDataSource"></xform:customizeDataSource>
												</xform:select>
											</label>
										</span>
									</c:if>
							
									<input id="process_review_button" class="process_review_button" style="display:none;" type=button value="<bean:message key="button.submit"/>"
										onclick="beforeLbpmSubmit();<%String onClickSubmitButton = org.apache.commons.lang.StringEscapeUtils.escapeHtml(request.getParameter("onClickSubmitButton"));
										if (onClickSubmitButton == null || onClickSubmitButton.length() == 0) {
											out.print("Com_Submit(document.sysWfProcessForm, 'update');");
										} else {
											out.print(onClickSubmitButton);
										}%>"/>
									<ui:button id="process_review_ui_button" parentId="toolbar" text="${ lfn:message('button.submit') }" order="1" onclick="$('#process_review_button').click();" styleClass="lui_widget_btn_primary" isForcedAddClass="true"></ui:button>
									<ui:button id="process_review_panel_button" parentId="toolbar" text="${ lfn:message('button.submit') }" order="1" onclick="lbpm.globals.extendRoleOptWindowSubmit('updateByPanel','right');" styleClass="lui_widget_btn_primary lbpmImpotantHidden" isForcedAddClass="true"></ui:button>
								</td>
							</tr>
							<tr id="privateOpinionTr">
								<td>
									<div style="margin-top: 10px"></div>
									<label class='lui-lbpm-checkbox'>
										<input type="checkbox" name="privateOpinion" onclick="lbpm.globals.setPrivateOpinion(this);"/>
										<span class='checkbox-label'><kmss:message key="sys-lbpmservice:lbpmservice.auditnote.privateOpinion" /></span>
									</label>
									<div id="privateOpinionCanViewTr" style="display: none;">
										<input type="hidden" name="privateOpinionCanViewIds" />
										<input type="text" name="privateOpinionCanViewNames" subject="${ lfn:message('sys-lbpmservice:lbpmservice.auditnote.canViewPerson') }" placeholder="${ lfn:message('sys-lbpmservice:lbpmservice.auditnote.placeholder') }" style="height:25px;border:0px;border-bottom:1px solid #b4b4b4;width:85%" onclick="Dialog_Address(true,'privateOpinionCanViewIds','privateOpinionCanViewNames', ';',ORG_TYPE_ALL);" readonly />
										<a href="javascript:;" class="com_btn_link" onclick="Dialog_Address(true,'privateOpinionCanViewIds','privateOpinionCanViewNames', ';',ORG_TYPE_ALL);"><bean:message key="dialog.selectOther" /></a>
										<span class="txtstrong">*</span>
									</div>
								</td>
							</tr>
							<tr>
								<td>
								<div id="nodeDescriptionDiv" class="lui-lbpm-nodeHelp">
									<div class="lui-lbpm-titleNode">
										<bean:message key="lbpmNode.processingNode.changeProcessor.nodeHelpInfo" bundle="sys-lbpmservice" />
									</div>
									<div class="nodeDescription">
										<p>
											<label id="currentNodeDescription"></label>
										</p>
										<div id="extNodeDescriptionDiv">
											<c:import url="/sys/lbpm/flowchart/page/nodeDescription_ext_show.jsp" charEncoding="UTF-8">
												<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
												<c:param name="modelName" value="${param.modelName}" />
												<c:param name="formName" value="${param.formName}" />
												<c:param name="provideFor" value="pc" />
											</c:import>
										</div>
									</div>
									<div style="text-align: right;">
										<span class="lui-lbpm-more lookMore"><bean:message bundle="sys-lbpmservice" key="lbpmRight.lookmore" /></span>
				             			<span class="lui-lbpm-moreFold"><bean:message bundle="sys-lbpmservice" key="lbpmRight.close" /></span>
									</div>
								</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_ext.jsp" charEncoding="UTF-8">
					<c:param name="auditNoteFdId" value="${sysWfBusinessForm.sysWfBusinessForm.fdAuditNoteFdId}" />
					<c:param name="modelName" value="${sysWfBusinessForm.modelClass.name}" />
					<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
					<c:param name="formName" value="${param.formName}" />
					<c:param name="curHanderId" value="${sysWfBusinessForm.sysWfBusinessForm.fdCurHanderId}"/>
					<c:param name="provideFor" value="pc" />
					<c:param name="approveModel" value="right" />
				</c:import>
				<div id="operationOtherDiv"></div>
			</c:if>
			<div id="rerunIfErrorRow" style="display:none">
				<div class="lui-lbpm-titleNode">
					<kmss:message key="sys-lbpmservice-operation-admin:lbpmOperations.fdOperType.addition.rerunEventTitle" />
				</div>
				<div class="lui-lbpm-detailNode" id="rerunIfErrorTDContent">
					<label id="rerunIfErrorLabel" class='lui-lbpm-checkbox'>
					<input type="checkbox" id="rerunIfError" value="true">
					<span class='checkbox-label'><kmss:message key="sys-lbpmservice-operation-admin:lbpmOperations.fdOperType.addition.rerunEventFlag" /></span>
					</label>
				</div>
			</div>
			<div id="keepAuditNoteRow" style="display:none">
				<div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice-operation-historyhandler" key="lbpmOperations.fdOperType.historyhandler.back.keepAuditNote" />
				</div>
				<div class="lui-lbpm-detailNode">
					<xform:radio value="false" showStatus="edit" property="keepAuditNote" onValueChange="setKeepAuditNoteParam(this.value);">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</div>
			</div>
			<div>
				<div>
					<table>
						<c:import url="/sys/lbpmservice/common/process_ext.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="${sysWfBusinessForm.modelClass.name}" />
							<c:param name="modelId" value="${sysWfBusinessForm.fdId}" />
							<c:param name="formName" value="${param.formName}" />
						</c:import>
					</table>
				</div>
			</div>
			<div id="assignmentRow" style="display:none;">
				<%-- <div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.assignment" />
				</div> --%>
				<div class="lui-lbpm-detailNode">
					<!-- Attachments -->
					<c:forEach items="${sysWfBusinessForm.sysWfBusinessForm.fdAttachmentsKeyList}" var="fdAttachmentsKey" varStatus="statusKey">
						<table class="tb_noborder" width="100%" id="${fdAttachmentsKey}" style="display:none;" name="attachmentTable">
							<tr>
								<td>
									<c:import
										url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
										charEncoding="UTF-8">
										<c:param
											name="fdKey"
											value="${fdAttachmentsKey}" />
										<c:param
											name="formBeanName"
											value="${param.formName}"/>
										<c:param
											name="fdModelName"
											value="${sysWfBusinessForm.modelClass.name}"/>
										<c:param
											name="fdModelId"
											value="${sysWfBusinessForm.fdId}"/>
										<c:param name="uploadAfterSelect" value="true" />
										<c:param name="fdViewType" value="/sys/lbpmservice/support/lbpm_right/js/render_right.js" />
									</c:import>
								</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
			<div class="lui-lbpm-fold">
			<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
				<div id="notifyTypeRow" style="display:none">
					<div class="lui-lbpm-titleNode">
						<bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notify.type" />
					</div>
					<div class="lui-lbpm-detailNode" id="systemNotifyTypeTD">
						
					</div>
				</div>
				<!--通知紧急程度 -->
				<div id="notifyLevelRow">
					<div class="lui-lbpm-titleNode">
						<bean:message bundle="sys-notify" key="sysNotifyTodo.level.title" />
					</div>
					<div class="lui-lbpm-detailNode" id="notifyLevelTD">
						<c:if test="${sysWfBusinessForm.docStatus=='11'}">
						<!--文档驳回后，起草人的重新提交页面 紧急度和提交选项 请左对齐-->
						<nobr></nobr> 
						</c:if>
						<kmss:editNotifyLevel property="sysWfBusinessForm.fdNotifyLevel" value=""/> 
					</div>
				</div>
				<%-- 通知选项--%>
				<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
					<input type="hidden" name="sysWfBusinessForm.fdSystemNotifyType" value="" id="sysWfBusinessForm.fdSystemNotifyType">
					<div id="notifyOptionTR">
						<div class="lui-lbpm-titleNode">
							<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption" />
						</div>
						<div class="lui-lbpm-detailNode">
							<label id="notifyOnFinishLabel" class='lui-lbpm-checkbox'>
							<input type="checkbox" id="notifyOnFinish" value="true" alertText="" key="notifyOnFinish">
							<span class='checkbox-label'><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.notifyOption.message" /></span>
							</label>
							&nbsp;&nbsp;
							<label id="notifyForFollowLabel" class='lui-lbpm-checkbox' style="display:none;">
							<input type="checkbox" id="notifyForFollow" value="true" alertText="" key="notifyForFollow">
							<span class='checkbox-label'><bean:message key="lbpmFollow.button.follow" bundle="sys-lbpmservice-support" /></span>
							</label>
						</div>
					</div>
				</c:if>
			</c:if>
		</c:if>
		<div id="fdFlowDescriptionRow">
			<div class="lui-lbpm-titleNode">
				<bean:message bundle="sys-lbpmservice" key="lbpmProcess.history.description" />
			</div>
			<div class="lui-lbpm-detailNode">
				<div id="fdFlowDescription"></div>
				<div style="text-align: right;">
					<span class="lui-lbpm-more lookMore"><bean:message bundle="sys-lbpmservice" key="lbpmRight.lookmore" /></span>
		          	<span class="lui-lbpm-moreFold"><bean:message bundle="sys-lbpmservice" key="lbpmRight.close" /></span>
				</div>
			</div>
		</div>
		<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11'}">
			<%-- 当前流程状态 --%>
			<div id="processStatusRow" style="display:none">
				<div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.processStatus" />
				</div>
				<div class="lui-lbpm-detailNode">
					<label id="processStatusLabel"></label>
				</div>
			</div>
			<div id="currentHandlersRow">
				<div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.currentProcessor" />
				</div>
				<div class="lui-lbpm-detailNode">
					<div id="currentHandlersLabel" style="word-break:break-all">
						<kmss:showWfPropertyValues idValue="${sysWfBusinessForm.fdId}" propertyName="handerNameDetail" />
					</div>
				</div>
			</div>
			<div id="historyHandlersRow">
				<div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.finishProcessor" />
				</div>
				<div class="lui-lbpm-detailNode">
					<div id="historyHandlersLabel" style="word-break:break-all">
						<kmss:showWfPropertyValues idValue="${sysWfBusinessForm.fdId}" propertyName="historyHanderName" />
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${sysWfBusinessForm.docStatus == '10'}">
			<div class="lui_prompt_container lui_prompt_vertical" id="defaultMsgDiv" style="display:none;">
		        <div class="lui_prompt_frame">
		            <div class="lui_prompt_container">
		                <div class="lui_prompt_content_error lui_prompt_content_noData"></div>
		                <div class="lui_prompt_content_right">
		                    <div class="lui_msgtitle"><bean:message bundle="sys-lbpmservice" key="lbpmProcess.right.noOperation" /></div>
		                </div>
		            </div>
		        </div>
		    </div>
		</c:if>
		

	<c:if test="${(sysWfBusinessForm.docStatus>='20' && sysWfBusinessForm.docStatus<'30') || sysWfBusinessForm.docStatus == '11'}">
		</div>
	</c:if>
	<!-- 展开收起按钮 -->
	<div class="lui-lbpm-foldOrUnfold">
	    <div class="lui-lbpm-foldOrUnfold-box">
	      <div>
	        <span><bean:message bundle="sys-lbpmservice" key="lbpmRight.fold" /></span>
	        <i></i>
	      </div>
	    </div>
	</div>
<!-- 右侧模式去掉 洪健  2020-3-1-->
<c:if test="${sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != null && sysWfBusinessForm.sysWfBusinessForm.fdFlowContent != ''}">
	<table>
		<tr class="tr_normal_title" style="display:none">
			<td align="left" colspan="4">
				<label class='lui-lbpm-checkbox'><input type="checkbox" id="flowGraphicShowCheckbox" value="true" onclick="this.checked ? $('#flowGraphic').show() : $('#flowGraphic').hide();">
					<span class='checkbox-label'><bean:message bundle="sys-lbpmservice" key="lbpm.tab.graphic" /></span></label>
			</td>
		</tr>
		<tr id="flowGraphicTemp">
			<td  ${resize_prefix}onresize="lbpm.flow_chart_load_Frame();" colspan="4">

				<script>
					$("#${sysWfBusinessFormPrefix}WF_IFrame").ready(function() {
						setTimeout(function(){
							lbpm.globals.updateFreeFlowNodeUL(true);
							lbpm.globals.initFreeFlowFormList();
						},50);
						var lbpm_panel_reload = function() {
							$("#${sysWfBusinessFormPrefix}WF_IFrame").attr('src', function (i, val) {return val;});
							lbpm.freeFlow.emptyHandlerNodes = [];
							lbpm.globals.updateFreeFlowNodeUL();
							$("#${sysWfBusinessFormPrefix}WF_IFrame")[0].onload = function() {
								lbpm.globals.initFreeFlowFormList();
							};
						};
						lbpm.events.addListener(lbpm.constant.EVENT_MODIFYNODEATTRIBUTE, lbpm_panel_reload);
						lbpm.events.addListener(lbpm.constant.EVENT_MODIFYPROCESS, lbpm_panel_reload);
						lbpm.events.addListener(lbpm.constant.EVENT_SELECTEDMANUAL, lbpm_panel_reload);
					});
					$('#flowGraphicShowCheckbox').bind('click', function() {
						$('#workflowInfoTD').each(function() {
							var str = this.getAttribute('onresize');
							if (str) {
								(new Function(str))();
							}
						});
					});
				</script>
			</td>
		</tr>
	</table>
</c:if>

<c:if test="${requestScope.sysWfProcess_useActionView != 'true'}">
		<c:if test="${empty param.onClickSubmitButton}">
			</form>
		</c:if>
	</c:if>
<div id="subprocess_list_table_temp" style="display:none;">
<table id="_id_" class="tb_normal" style="width:100%;">
	<tr class="tr_normal_title" >
	<td><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.adminrecover.subtitle" /></td>
	<td style="width:26px;">
		<a href="javascript:void(0);" onclick="lbpm.globals.adminOperationTypeRecover_AddNewSubprocessRows()" >
		<bean:message key="dialog.selectOther" />
		</a>
	</td>
	</tr>
</table>
<input type="hidden" _key_="recoverProcessIds" id="_recoverProcessIds_"
	alertText="<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.adminrecover.alertText" />" >
</div>
<table style="display:none;">
	<tr>
	<td id="subprocess_list_table_col_1">
		<input type="hidden" name="workflow_recover_subprocessid" value="">
		<span></span>
	</td>
	<td id="subprocess_list_table_col_2">
		<a href="javascript:void(0);" onclick="lbpm.globals.adminOperationTypeRecover_DeleteSubprocessRow(this);" >
		<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.adminrecover.delete" />
		</a>
	</td>
	</tr>
</table>
<script>
	if(lbpm){
		lbpm.approveType = "right";
	}
	lbpm.globals.includeFile("/sys/lbpmservice/node/node_common_review.js","<%=request.getContextPath()%>");
	if(lbpm.adminOperationsReviewJs.length>0){
		var pAdminJsArr=lbpm.adminOperationsReviewJs;
		for(var i=0,size=pAdminJsArr.length;i<size;i++){
			if(pAdminJsArr[i]!="")
			lbpm.globals.includeFile(pAdminJsArr[i],"<%=request.getContextPath()%>","js");
		};
	}
	if(lbpm.drafterOperationsReviewJs.length>0){
		var pDrafterJsArr=lbpm.drafterOperationsReviewJs;
		for(var i=0,size=pDrafterJsArr.length;i<size;i++){
			if(pDrafterJsArr[i]!="")
			lbpm.globals.includeFile(pDrafterJsArr[i],"<%=request.getContextPath()%>","js");
		}
	}
	if(lbpm.historyhandlerOperationsReviewJs.length>0){
		var pHistoryhandlerJsArr=lbpm.historyhandlerOperationsReviewJs;
		for(var i=0,size=pHistoryhandlerJsArr.length;i<size;i++){
			if(pHistoryhandlerJsArr[i]!="")
			lbpm.globals.includeFile(pHistoryhandlerJsArr[i],"<%=request.getContextPath()%>","js");
		};
	}
	if(lbpm.branchAdminOperationsReviewJs.length>0){
		var pBranchAdminJsArr=lbpm.branchAdminOperationsReviewJs;
		for(var i=0,size=pBranchAdminJsArr.length;i<size;i++){
			if(pBranchAdminJsArr[i]!="")
			lbpm.globals.includeFile(pBranchAdminJsArr[i],"<%=request.getContextPath()%>","js");
		};
	}
	lbpm.globals.setAdminNodeNotifyType=function(nodeId,operationName){
		var notifyTypeDivIdEl = document.getElementById("systemNotifyTypeTD");
		notifyTypeDivIdEl.innerHTML=lbpm.globals.getNotifyType4NodeHTML(nodeId);
		var text = $.trim(notifyTypeDivIdEl.innerText);
		//如果是特权人身份操作，并且开关是开的或者是起草人身份
		var isShow =(Lbpm_SettingInfo["isNotifyCurrentHandler"] === "true" && lbpm.constant.ROLETYPE === "authority") || (lbpm.constant.ROLETYPE === "drafter");
		if(text!="" && isShow){
			$("#notifyTypeRow").show();
		} 
		//催办无论开关与否都要显示
		if (typeof operationName != "undefined" && operationName === "press"){
			$("#notifyTypeRow").show();
		}
		if (typeof operationName == "undefined" && Lbpm_SettingInfo["isNotifyCurrentHandler"] === "false" 
				&& lbpm.constant.ROLETYPE === "authority"){
			$("#notifyTypeRow").hide();
		}
	}
	
	lbpm.onLoadEvents.delay.push(function() {
		if (!lbpm.globals.isError) {
			$("#rerunIfErrorRow").remove();
		}
	});
	
	function setKeepAuditNoteParam(value){
		if ("true"==value) {
			lbpm.globals.setOperationParameterJson(true, "Back_keepAuditNote", "param");
		} else {
			lbpm.globals.setOperationParameterJson(false, "Back_keepAuditNote", "param");
		}
	}
	
	lbpm.onLoadEvents.delay.push(function(){
		
		var isOpinionConfig="";
		var opinionTypeValue="";
		if(lbpm.nowNodeId){
			isOpinionConfig=lbpm.nodes[lbpm.nowNodeId].opinionConfig;
			opinionTypeValue=lbpm.nodes[lbpm.nowNodeId].opinionType;
		}
		
		
		if(isOpinionConfig=="true"){
			$("#opinionConfig").show();//显示div
		}else{
			$("#opinionConfig").hide();//隐藏div
		}
		
		//设置节点设置的默认值
		if(opinionTypeValue!=""){
			$("#approveOpinionType option[value='"+opinionTypeValue+"']").attr("selected", true);
		}
		
		//如果不是当前处理人隐藏opinionConfig，并且设置下拉框无效
		if(lbpm.allMyProcessorInfoObj&&lbpm.allMyProcessorInfoObj.length==0){
			$("#fdUsageContentTd #opinionConfig").hide();//隐藏div
			$('#fdUsageContentTd #approveOpinionType').remove();
		}
		
	});
</script>