<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">DocList_Info.push('TABLE_DocList');</script>
<script type="text/javascript">
	var topicListIds="";
</script>
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
							<span class="td_subject">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].docSubject' />
							</span>
							<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdMainId' value='${kmImeetingMainForm.fdId}'/>
						</td>
					</tr>
					<!-- 汇报人 -->
					<tr  >
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.docReporter')}
						</td>
						<td>
							<span class="td_reporter">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].docReporterId'/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="muiTitle">
							<bean:message key="kmImeetingTopic.fdExpectStartTime" bundle="km-imeeting"/>
						</td>
						<td>
							<xform:datetime property="kmImeetingAgendaForms[!{index}].fdExpectStartTime" validators="after valExpectTime" required="true" mobile="true" subject="${lfn:message('km-imeeting:kmImeetingTopic.fdExpectStartTime') }"></xform:datetime>
						</td>
					</tr>
					<!-- 建议列席单位 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							<bean:message key="kmImeetingTopic.fdAttendUnit" bundle="km-imeeting"/>
						</td>
						<td>
							<span class="td_attendUnit">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdAttendUnitIds'/>
							</span>
						</td>
					</tr>
					<!-- 建议旁听单位 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							<bean:message key="kmImeetingTopic.fdListenUnit" bundle="km-imeeting"/>
						</td>
						<td>
							<span class="td_listenUnit">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdListenUnitIds'/>
							</span>
						</td>
					</tr>
					<!-- 材料负责人 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}
						</td>
						<td>
							<span class="td_respons">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].docResponsId'/>
							</span>
						</td>
					</tr>
					<!-- 上会所需材料 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}
						</td>
						<td>
							<span class="td_fromTopic">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdFromTopicId' class="muiTopicId"/>
							</span>
							<span class="td_attachment"></span>
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
					<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingAgendaitem.fdFromTopicId}" class="muiTopicId"/>
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
								${kmImeetingAgendaitem.docSubject}
								<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].docSubject" value="${kmImeetingAgendaitem.docSubject}" />
							</td>
						</tr>
						<!-- 汇报人 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.docReporter')}
							</td>
							<td>
								${kmImeetingAgendaitem.docReporterName}
								<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].docReporterId" value="${kmImeetingAgendaitem.docReporterId}"/>
							</td>
						</tr>
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.fdExpectStartTime')}
							</td>
							<td>
								<xform:datetime property="kmImeetingAgendaForms[${vstatus.index}].fdExpectStartTime" showStatus="readOnly" subject="议题开始时间" mobile="true"></xform:datetime>
							</td>
						</tr>
						<!-- 建议列席单位 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingTopic.fdAttendUnit')}
							</td>
							<td>
								${kmImeetingAgendaitem.fdAttendUnitNames}
								<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].fdAttendUnitIds" value="${kmImeetingAgendaitem.fdAttendUnitIds}"/>
							</td>
						</tr>
						<!-- 建议旁听单位 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingTopic.fdListenUnit')}
							</td>
							<td>
								${kmImeetingAgendaitem.fdListenUnitNames}
								<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].fdListenUnitIds" value="${kmImeetingAgendaitem.fdListenUnitIds}"/>
							</td>
						</tr>
						<!-- 材料负责人 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}
							</td>
							<td>
								${kmImeetingAgendaitem.docResponsName}
								<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].docResponsId" value="${kmImeetingAgendaitem.docResponsId}"/>
							</td>
						</tr>
						<!-- 上会所需材料 -->
						<tr data-celltr="true">
							<td class="muiTitle">
								${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}
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
			<script>
			 	topicListIds += "${kmImeetingAgendaitem.fdFromTopicId},";
			</script>
		</c:forEach>
	</table>
	
	<script type="text/javascript">
		window.store = [{text: '<bean:message key="kmImeetingTopic.fdIsAccept.mobile.all" bundle="km-imeeting"/>', value: ''}, 
		                {text: '<bean:message key="kmImeetingTopic.fdIsAccept.mobile.false" bundle="km-imeeting"/>', value: '0'}, 
		                {text: '<bean:message key="kmImeetingTopic.fdIsAccept.mobile.true" bundle="km-imeeting"/>', value: '1'}];
	</script>
	<c:set var="showBtn" value="fasle"></c:set>
	<c:choose>
		<c:when test="${kmImeetingMainForm.method_GET == 'add'}">
			<c:set var="showBtn" value="true"></c:set>
		</c:when>
		<c:otherwise>
			<%
				Boolean isTopicMng = false;
	 			if("true".equals(KmImeetingConfigUtil.isTopicMng())){
	 				isTopicMng = true;
	 			}
	 			request.setAttribute("isTopicMng", isTopicMng);
	 		%>
	 		<c:if test="${isTopicMng eq 'true' and kmImeetingMainForm.fdIsTopic eq 'true'}">
	 			<c:set var="showBtn" value="true"></c:set>
	 		</c:if>
		</c:otherwise>
	</c:choose>	
	<c:if test="${showBtn eq 'true'}">
	<div 
   		data-dojo-type="km/imeeting/mobile/resource/js/TopicSelectorButton"
   		data-dojo-mixins="km/imeeting/mobile/resource/js/TopicSelectorMixin"
   		data-dojo-props="isMul:true"
		id="selectTopicButton">
		+ <bean:message bundle="km-imeeting" key="kmImeetingAgenda.operation.addDetailTopic.mobile"/>
	</div>
	</c:if>
</div>
<script type="text/javascript">
require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading"], 
		function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading){
	
	// dialog回调
	topic.subscribe('km/imeeting/topicselector/result', function(res){
		var topicIds = "";
		if(Object.prototype.toString.call(res) == '[object Array]') {
			for (var i = 0; i < res.length; i++) {
				topicIds += res[i].fdId + ";";
			}
		} else {
			topicIds = res.fdId;
		}
		if (topicIds) {
			var data = new KMSSData();
		    var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadTopicList&ids="+ topicIds;
		    var tableId = "TABLE_DocList";
		    data.SendToUrl(url, function(data) {
		    	var results = eval("(" + data.responseText + ")");
		    	if(results.length>0){
		    		for(var i=0;i<results.length;i++){
		    			if(topicListIds.indexOf(results[i].fdTopicId,0)==-1){
				    		topicListIds +=results[i].fdTopicId +",";
				    		
				    		// table 添加逻辑
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
								if(results[i].docSubject){
									$(newRow).find(".td_subject input").val(results[i].docSubject);
									$(newRow).find(".td_subject").append(results[i].docSubject);
						    	}
								if(results[i].fdReporterId){
									$(newRow).find(".td_reporter input").val(results[i].fdReporterId);
									$(newRow).find(".td_reporter").append(results[i].fdReporterName);
						    	}
								if(results[i].fdAttendUnitIds){
									$(newRow).find(".td_attendUnit input").val(results[i].fdAttendUnitIds);
									$(newRow).find(".td_attendUnit").append(results[i].fdAttendUnitNames);
						    	}
								if(results[i].fdListenUnitIds){
									$(newRow).find(".td_listenUnit input").val(results[i].fdListenUnitIds);
									$(newRow).find(".td_listenUnit").append(results[i].fdListenUnitNames);
						    	}
								if(results[i].fdMaterialStaffId){
									$(newRow).find(".td_respons input").val(results[i].fdMaterialStaffId);
									$(newRow).find(".td_respons").append(results[i].fdMaterialStaffName);
						    	}
								
								// 附件
								var attIds = "";
						    	var mainAtt = results[i].mainAtt;
						    	var mainHtml = "<table style='border:none'>";
						    	for(var m=0;m<mainAtt.length;m++){
						    		if(mainAtt[m].fdId != ""){
						    			attIds += mainAtt[m].fdId+";";
						    			var fileIcon = window.GetIconNameByFileName(mainAtt[m].fdFileName);
							    		mainHtml +="<tr><td style='padding-right:1rem'>";
							    		mainHtml += "<img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />";
							    		mainHtml += Com_HtmlEscape(mainAtt[m].fdFileName);
							    		mainHtml += "</td></tr>";
						    		}
						    	}
						    	mainHtml +="</table>";
						    	
						    	var commonAtt = results[i].commonAtt;
						    	var commonHtml = "<table style='border:none'>";
						    	for(var n=0;n<commonAtt.length;n++){
						    		if(commonAtt[n].fdId != ""){
						    			attIds += commonAtt[n].fdId+";";
						    			var fileIcon = window.GetIconNameByFileName(commonAtt[n].fdFileName);
						    			commonHtml +="<tr><td style='padding-right:1rem'>";
						    			commonHtml += "<img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />";
						    			commonHtml += Com_HtmlEscape(commonAtt[n].fdFileName);
						    			commonHtml += "</td></tr>";
						    		}
						    	}
						    	commonHtml +="</table>";
						    	
						    	$(newRow).find(".td_fromTopic input").val(results[i].fdTopicId);
						    	$(newRow).find(".td_attachment").append(mainHtml+commonHtml);
								
								topic.publish("/mui/list/resize",newRow);
							});
		    			}
		    		}
		    	}
		    });
		}
	});
	
	ready(function(){
		if(DocList_TableInfo['TABLE_DocList']==null){
			DocListFunc_Init();
		}
	});
	
	window.detail_fixNo = function() {
		$('#TABLE_DocList').find('.muiDetailTableNo').each(function(i) {
			$(this).children('.index').text(i + 1);
		});
	};
	
	window.deleteRow = function(domNode) {
		var td = $(domNode).closest('.detail_wrap_td')[0];
		var topicId = query('.muiTopicId', td)[0].value;
		if(topicId!=null&&topicId.length>0){
			topicListIds=topicListIds.replace(topicId,"");
		}
		DocList_DeleteRow_ClearLast(td.parentNode);
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
		var title = query('input', domTable)[0].value;
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
	
	window.GetIconNameByFileName = function(fileName) {
		if(fileName==null || fileName=="")
			return "documents.png";
		var fileExt = fileName.substring(fileName.lastIndexOf("."));
		if(fileExt!="")
			fileExt=fileExt.toLowerCase();
		switch(fileExt){
			case ".doc":
			case ".docx":
				  return "word.png";
			case ".xls":
			case ".xlsx":
				return "excel.png";
			case ".ppt":
			case ".pptx":
				return "ppt.png";
			case ".pdf":return "pdf.png";
			case ".vsd":return "vsd.png";
			case ".txt":return "text.png";
			case ".jpg":return "image.png";
			case ".jpeg":return "image.png";
			case ".ico":return "image.png";
			case ".bmp":return "image.png";
			case ".gif":return "image.png";
			case ".png":return "image.png";
			case ".mp3":return "audio.png";
			case ".mp4":
			case ".avi":
			case ".flv":
			case ".rmvb":
			case ".m4v":
			    	   return "video.png";
			default:return "documents.png";
		}
	};

});
</script>
