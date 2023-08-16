<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>Com_IncludeFile("doclist.js");</script>
<style>
	.agendaSubject {
		display: inline-block;
	    width: 80%;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    overflow: hidden;
	    position: absolute;
	    margin-left: 10px;
	}
</style>
<c:if test="${fn:length(kmImeetingMainForm.kmImeetingAgendaForms)  > 0 }">
<div style="border-bottom: 0;padding-left: 1rem;">
	<table width="100%" cellspacing="0" cellpadding="0" id="TABLE_DocList">
		<c:forEach items="${kmImeetingMainForm.kmImeetingAgendaForms}" var="kmImeetingAgendaitem" varStatus="vstatus">
			<tr KMSS_IsContentRow="1">
				<td class="detail_wrap_td">
					<table class="muiSimple">
						<tr celltr-title="true">
							<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
								<div class="muiDetailDisplayOpt muiDetailDown"   onclick="expandRow(this);"></div>
								<span class="index" onclick="expandRow(this);" style="color: #4285F4;">
									${vstatus.index+1}
								</span>
								<span class="agendaSubject" onclick="expandRow(this);">
								</span>
							</td>
						</tr>
						<!-- 会议议题 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								<bean:message key="kmImeetingAgenda.docSubject" bundle="km-imeeting"/>
							</td>
							<td>
								<span class="title">
									<c:out value="${kmImeetingAgendaitem.docSubject }"></c:out>
								</span>
							</td>
						</tr>
						<!-- 汇报人 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								<bean:message key="kmImeetingAgenda.docReporter" bundle="km-imeeting"/>
							</td>
							<td>
								<c:out value="${kmImeetingAgendaitem.docReporterName }"></c:out>
							</td>
						</tr>
						<!-- 汇报时间 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								<bean:message key="kmImeetingAgenda.docReporterTime" bundle="km-imeeting"/>
							</td>
							<td>
								<c:if test="${not empty kmImeetingAgendaitem.docReporterTime }">
									<c:out value="${kmImeetingAgendaitem.docReporterTime }"></c:out>
									<bean:message key="date.interval.minute"/>
								</c:if>
							</td>
						</tr>
						<!-- 上会材料 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								<bean:message bundle="km-imeeting" key="kmImeetingAgenda.attachmentName"/>
							</td>
							<td>
								<c:out value="${kmImeetingAgendaitem.attachmentName}"></c:out>
							</td>
						</tr>
						<!-- 材料负责人 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								<bean:message bundle="km-imeeting" key="kmImeetingAgenda.docRespons"/>
							</td>
							<td>
								<c:out value="${kmImeetingAgendaitem.docResponsName}"></c:out>
							</td>
						</tr>
						<!-- 上会材料 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								<bean:message bundle="km-imeeting" key="kmImeetingAgenda.attachmentName"/>
							</td>
							<td>
								<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdId }" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
									<c:param name="fdModelId" value="${kmImeetingMainForm.fdId }" />
									<c:param name="fdViewType" value="simple" />
								</c:import>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</c:if>
<script type="text/javascript">
require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading"], 
		function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading){

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
		var title = query('.title', domTable).text();
		if(newdisplay == 'none'){
			domClass.add(opt,'muiDetailUp');
			domClass.remove(opt,'muiDetailDown');
			query('.agendaSubject', domTable).html(title);
		}else{
			domClass.add(opt,'muiDetailDown');
			domClass.remove(opt,'muiDetailUp');
			query('.agendaSubject', domTable).html('');
		}
	};
	
});
</script>