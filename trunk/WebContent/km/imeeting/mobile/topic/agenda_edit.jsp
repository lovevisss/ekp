<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">DocList_Info.push('TABLE_DocList');</script>
<div class="muiFlowInfoW" style="border-bottom: 0;">
	<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
		<tr  data-dojo-type="mui/form/Template"  KMSS_IsReferRow="1" style="display:none;" border='0'>
			<td class="detail_wrap_td">
				<table class="muiSimple">
					<tr celltr-title="true">
						<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
							<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
							<span class="index" onclick="expandRow(this);" style="color: #4285F4;">
								!{index}
							</span>
							<span class="agendaSubject" onclick="expandRow(this);">
							</span>
							<xform:editShow>
								<div class="muiDetailTableDel" onclick="deleteRow(this);" style="color: #4285F4;">
									<bean:message key="button.delete" />
								</div>
							</xform:editShow>
						</td>
					</tr>
					<!-- 会议议题 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.docSubject')}
						</td>
						<td>
							<xform:config  orient="none">
								<xform:text property="kmImeetingAgendaForms[!{index}].docSubject" showStatus="edit" htmlElementProperties="class='title' placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.docSubject.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.docSubject')}" required="true" validators="maxLength(200)" mobile="true"></xform:text>
							</xform:config>
						</td>
					</tr>
					<!-- 汇报人 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.docReporter')}
						</td>
						<td>
							<xform:config  orient="none">
								<xform:address propertyName="kmImeetingAgendaForms[!{index}].docReporterName" propertyId="kmImeetingAgendaForms[!{index}].docReporterId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true"/>
							</xform:config>
						</td>
					</tr>
					<!-- 汇报时间 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.docReporterTime')}
						</td>
						<td>
							<xform:config  orient="none">
								<xform:text property="kmImeetingAgendaForms[!{index}].docReporterTime" showStatus="edit" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.docReporterTime.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.docReporterTime')}" validators="digits min(0)" mobile="true"></xform:text>
							</xform:config>
						</td>
					</tr>
					<!-- 上会材料 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}
						</td>
						<td>
							<xform:config  orient="none">
								<xform:text property="kmImeetingAgendaForms[!{index}].attachmentName" showStatus="edit" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.attachment.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}" validators="maxLength(200)" mobile="true"></xform:text>
							</xform:config>
						</td>
					</tr>
					<!-- 材料责任人 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}
						</td>
						<td>
							<xform:config  orient="none">
								<xform:address propertyName="kmImeetingAgendaForms[!{index}].docResponsName" propertyId="kmImeetingAgendaForms[!{index}].docResponsId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true"/>
							</xform:config>
						</td>
					</tr>
					<!-- 材料提交时间 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.attachmentSubmitTime')}
						</td>
						<td>
							<xform:config  orient="none">
								<xform:text property="kmImeetingAgendaForms[!{index}].attachmentSubmitTime" showStatus="edit" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.attachmentSubmitTime.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.attachmentSubmitTime')}" validators="digits min(0)" mobile="true"></xform:text>
							</xform:config>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<c:forEach items="${kmImeetingMainForm.kmImeetingAgendaForms}" var="kmImeetingAgendaitem" varStatus="vstatus">
			<tr KMSS_IsContentRow="1" data-celltr="true">
				<td class="detail_wrap_td">
					<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdId" value="${kmImeetingAgendaitem.fdId}" /> 
					<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdMainId" value="${kmImeetingMainForm.fdId}" />
					<table class="muiSimple">
						<tr celltr-title="true">
							<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
								<div class="muiDetailDisplayOpt muiDetailDown"   onclick="expandRow(this);"></div>
								<span class="index" onclick="expandRow(this);" style="color: #4285F4;">
									${vstatus.index+1}
								</span>
								<span class="agendaSubject" onclick="expandRow(this);">
								</span>
								<xform:editShow>
									<div class="muiDetailTableDel" onclick="deleteRow(this);" style="color: #4285F4;">
										<bean:message key="button.delete" />
									</div>
								</xform:editShow>
							</td>
						</tr>
						<!-- 会议议题 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.docSubject')}
							</td>
							<td>
								<xform:config  orient="none">
									<xform:text property="kmImeetingAgendaForms[${vstatus.index}].docSubject" value="${kmImeetingAgendaitem.docSubject}" htmlElementProperties="class='title' placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.docSubject.mobile') }'" showStatus="edit" subject="${lfn:message('km-imeeting:kmImeetingAgenda.docSubject')}" required="true" validators="maxLength(200)" mobile="true"></xform:text>
								</xform:config>
							</td>
						</tr>
						<!-- 汇报人 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.docReporter')}
							</td>
							<td>
								<xform:config  orient="none">
									<xform:address propertyName="kmImeetingAgendaForms[${vstatus.index}].docReporterName" propertyId="kmImeetingAgendaForms[${vstatus.index}].docReporterId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true"/>
								</xform:config>
							</td>
						</tr>
						<!-- 汇报时间 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.docReporterTime')}
							</td>
							<td>
								<xform:config  orient="none">
									<xform:text property="kmImeetingAgendaForms[${vstatus.index}].docReporterTime" showStatus="edit" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.docReporterTime.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.docReporterTime')}" validators="digits min(0)" mobile="true"></xform:text>
								</xform:config>
							</td>
						</tr>
						<!-- 上会材料 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}
							</td>
							<td>
								<xform:config  orient="none">
									<xform:text property="kmImeetingAgendaForms[${vstatus.index}].attachmentName" showStatus="edit" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.attachment.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}" validators="maxLength(200)" mobile="true"></xform:text>
								</xform:config>
							</td>
						</tr>
						<!-- 材料责任人 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}
							</td>
							<td>
								<xform:config  orient="none">
									<xform:address propertyName="kmImeetingAgendaForms[${vstatus.index}].docResponsName" propertyId="kmImeetingAgendaForms[${vstatus.index}].docResponsId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true"/>
								</xform:config>
							</td>
						</tr>
						<!-- 材料提交时间 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.attachmentSubmitTime')}
							</td>
							<td>
								<xform:config  orient="none">
									<xform:text property="kmImeetingAgendaForms[${vstatus.index}].attachmentSubmitTime" showStatus="edit" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.attachmentSubmitTime.mobile') }'" subject="${lfn:message('km-imeeting:kmImeetingAgenda.attachmentSubmitTime')}" validators="digits min(0)" mobile="true"></xform:text>
								</xform:config>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<div 
		data-dojo-type="sys/xform/mobile/controls/DetailTableAddButton" 
		onclick="window.detail_add(event)">
		${lfn:message('km-imeeting:kmImeetingAgenda.operation.addDetail.mobile')}
	</div>
</div>
<script type="text/javascript">
require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading"], 
		function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading){
	
	ready(function(){
		if(DocList_TableInfo['TABLE_DocList']==null){
			DocListFunc_Init();
		}
	});
	
	//添加行
	window.detail_add = function(event) {
		event = event || window.event;
		if (event.stopPropagation)
			event.stopPropagation();
		else
			event.cancelBubble = true;
		detail_addRow("TABLE_DocList");
	};
	
	window.detail_addRow = function(tableId, callbackFun) {
		var newRow = DocList_AddRow(tableId);
		newRow.dojoClick = true;
		parser.parse(newRow).then(function(){
			var tabInfo = DocList_TableInfo[tableId];
			if(tabInfo['_getcols']== null){
				tabInfo.fieldNames=[];
				tabInfo.fieldFormatNames=[];
				DocListFunc_AddReferFields(tabInfo, newRow, "INPUT");
				DocListFunc_AddReferFields(tabInfo, newRow, "TEXTAREA");
				DocListFunc_AddReferFields(tabInfo, newRow, "SELECT");
				tabInfo['_getcols'] = 1;
			}
			detail_fixNo();
			topic.publish("/mui/list/resize",newRow);
			if(callbackFun)callbackFun(newRow);
		});
	};
	
	window.detail_fixNo = function() {
		$('#TABLE_DocList').find('.muiDetailTableNo').each(function(i) {
			$(this).children('.index').text(i + 1);
		});
	};
	
	window.deleteRow = function(domNode) {
		var td = $(domNode).closest('.detail_wrap_td')[0];
		DocList_DeleteRow_ClearLast(td.parentNode);
		topic.publish('/mui/form/valueChanged');
		topic.publish("/mui/list/resize",td.parentNode);
		detail_fixNo();
	};
	
	window.expandRow = function(domNode){
		var domTable = $(domNode).closest('table')[0];
		var display = domAttr.get(domTable,'data-display'),
			newdisplay = (display == 'none' ? '' : 'none');
		domAttr.set(domTable,'data-display',newdisplay);
		var items = query('tr[data-celltr="true"],tr[statistic-celltr="true"]',domTable);
		for(var i = 0; i < items.length; i++){
			if(newdisplay == 'none'){
				domStyle.set(items[i],'display','none');
			}else{
				domStyle.set(items[i],'display','');
			}
		}
		var opt = query('.muiDetailDisplayOpt',domTable)[0];
		var del = query('.muiDetailTableDel',domTable)[0];
		var title = query('.title .muiInput', domTable)[0].value;
		if(newdisplay == 'none'){
			domClass.add(opt,'muiDetailUp');
			domClass.remove(opt,'muiDetailDown');
			domStyle.set(del, 'display','none');
			query('.agendaSubject', domTable).html(title);
		}else{
			domClass.add(opt,'muiDetailDown');
			domClass.remove(opt,'muiDetailUp');
			domStyle.set(del, 'display','');
			query('.agendaSubject', domTable).html('');
		}
	};

});
</script>
