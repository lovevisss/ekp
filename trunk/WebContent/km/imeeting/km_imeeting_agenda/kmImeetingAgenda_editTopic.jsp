<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<script>Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">
seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
});
Com_Parameter.event["submit"].push(function(){
	 var flag = true;
	 var url = Com_Parameter.ContextPath+"km/imeeting/km_imeeting_main/kmImeetingMain.do?method=queryFinish&fdId=${kmImeetingMainForm.fdId}";
	 $.ajax({
			url : url,
			type : 'post',
			data : {},
			dataType : 'text',
			async : false,     
			error : function(){
				dialog.alert('请求出错');
			} ,   
			/* success:function(data){
				if(data == "true"){
					flag = true;
				}else{
					dialog.alert("失败！");
					flag = false;
				}
			} */
		});
	return flag;
});
$(document).ready(function() {
	
	var fdStaffingLevel = $('[name="fdPosition"]')[0];
	var fdTransferStaffId = $('input[name="fdHostId"]').val();
	if(fdTransferStaffId){
		$.ajax({
			url : '${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=getPersonInfo',
			type: 'POST',
			dataType: 'json',
			data : {
				id : fdTransferStaffId
			},
			success : function(data, textStatus, xhr){
				var d = eval(data);
				if(fdStaffingLevel && d.level)
					fdStaffingLevel.value = d.level.name;
				if (d.level==undefined) {
					fdStaffingLevel.value = '';
				}
			}
		});
	}else{
		if(fdStaffingLevel)
			fdStaffingLevel.value = '';
	}
		
		
	var topicIds = getTopicIds(".topicIdSign");
	if (!topicIds) {
		topicIds = getTopicIds(".agendaIdSign");
	}
	var isRelationScheme = "${not empty param.fdSchemeId ? 'true' : 'false'}"
	
	if (topicIds) {
		buildAttendUnits();
	}
});

function deleteTopicMsg(){
	DocList_DeleteRow_ClearLast();
	var topicIds = getTopicIds("[id='detail_fdTopicId']");
	buildAttendUnits();
}
var topicListIds="";
function showTopicList(){
	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath + 'km/imeeting/km_imeeting_topic/index_dialog_select.jsp'; 
 	dialog.iframe(url,'<bean:message bundle="km-imeeting" key="kmImeetingAgenda.operation.addDetailTopic.mobile" />',function(ids){
 		if (ids != "" && ids != null){
			var data = new KMSSData();
		    var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadTopicList&ids="+ ids;
		    data.SendToUrl(url, function(data) {
		    	
		    	var existIds = topicListIds;   // 出席单位显示
		    	
		    	var results = eval("(" + data.responseText + ")");
		    	if(results.length > 0){
			    	for(var i=0; i<results.length; i++){
				    	if(topicListIds.indexOf(results[i].fdTopicId,0)==-1){
				    		topicListIds +=results[i].fdTopicId +",";
				    		
				    		// table 添加逻辑
				    		var newRow = DocList_AddRow("TABLE_DocList");
				    		
				    		$(newRow).find("#detail_fdTopicId").val(results[i].fdTopicId);
				    		
							if(results[i].docSubject){
								$(newRow).find(".td_subject input").val(results[i].docSubject);
								$(newRow).find(".td_subject").append(results[i].docSubject);
					    	}
							if(results[i].fdReporterId){
								$(newRow).find(".td_reporter input").val(results[i].fdReporterId);
								$(newRow).find(".td_reporter").append(results[i].fdReporterName);
								$(newRow).find("p.td_reporter").attr("title", results[i].fdReporterName);
					    	} else {
								$(newRow).find(".td_reporter").append("<无>");
								$(newRow).find("p.td_reporter").attr("title", "<无>");
							}
							if(results[i].fdChargeUnitId){
								$(newRow).find(".td_chargeUnit input").val(results[i].fdChargeUnitId);
								$(newRow).find(".td_chargeUnit").append(results[i].fdChargeUnitName);
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
							if (results[i].topicCreatorId) {
								$(newRow).find(".td_topicCreator input").val(results[i].topicCreatorId);
								$(newRow).find(".td_topicCreatorN input").val(results[i].topicCreatorName);
							}
							// 附件
							var attIds = "";
					    	var mainAtt = results[i].mainAtt;
					    	var mainHtml = "<table style='border:none'>";
					    	for(var m=0;m<mainAtt.length;m++){
					    		if(mainAtt[m].fdId != ""){
					    			attIds += mainAtt[m].fdId+";";
					    			var fileIcon = window.GetIconNameByFileName(mainAtt[m].fdFileName);
						    		mainHtml +="<tr class='attachment_list'><td style='padding-right:1rem'>";
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
					    			commonHtml +="<tr class='attachment_list'><td style='padding-right:1rem'>";
					    			commonHtml += "<img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />";
					    			commonHtml += Com_HtmlEscape(commonAtt[n].fdFileName);
					    			commonHtml += "</td></tr>";
					    		}
					    	}
					    	commonHtml +="</table>";
					    	$(newRow).find(".td_fromTopic input").val(results[i].fdTopicId);
					    	$(newRow).find(".td_attachment").append(mainHtml+commonHtml);
					    }
			    	}
			    	
			    	if (existIds) {
			    		existIds = existIds.replace(/,/g, ";");
			    		ids = existIds + ids;                               
			    	}
			    	buildAttendUnits();
			    }
			});
		}
		else{
			  return false;
	   }
	 },{width:950,height:550});
}
$(document).on('table-delete',"table[id$='TABLE_DocList']",function(evt, data) {
	var topicObj = $(data).find('.muiTopicId');
	if(topicObj!=null&&topicObj.length>0){
		topicListIds=topicListIds.replace(topicObj[0].value,"");
	}
});


/**
 * 新选择的议题是从topic表上获取的，编辑通知时或者引入方案是议题内容是agenda表，所以分开处理
 */
function buildAttendUnits() {
	// 获取所有新选择的议题topic
	var topicIdDom = $(".topicIdSign");
	// 获取所有旧的议题agenda
	var agendaIdDom = $(".agendaIdSign");
	// 如果没有议题，直接返回
	if (topicIdDom.length == 0 && agendaIdDom.length == 0) {
		var firstTr = $("#attendUnitFirstTr");
		firstTr.nextAll().html("");
		return;
	}
	
	// topic和agenda的所有单位信息
	var allResObj = new Array();
	
	// 处理topic
	var topicIds = "";
	for (var i = 0; i < topicIdDom.length; i++) {
		if (topicIdDom[i].value) {
			if (topicIds.indexOf(topicIdDom[i].value) < 0) {
				topicIds += topicIdDom[i].value + ";";
			}
		}
	}
	topicIds = topicIds.substring(0, topicIds.length - 1);
	var topicResObj = new Object();
	if (topicIds) {
		var topicUrl = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadAttendUnitList&ids=" + topicIds;
		topicResObj = getAttentUnitInfo(topicUrl);
	}
	
	// 处理agenda
	var agendaIds = "";
	for (var j = 0; j < agendaIdDom.length; j++) {
		agendaIds += agendaIdDom[j].value + ";";
	}
	agendaIds = agendaIds.substring(0, agendaIds.length - 1);
	if (agendaIds) {
		var agendaUrl = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_agenda/kmImeetingAgenda.do?method=loadAttendUnitList&ids=" + agendaIds;
		var agendaResObj = getAttentUnitInfo(agendaUrl);
		
		// 如果有topic和agenda两张表的信息，做合并处理
		if (topicIds && agendaIds) {
			topicResObj.forEach(function(_item, _index) {
				agendaResObj.forEach(function(item, index, arr) {
					if (_item.fdUnitId == item.fdUnitId) {
						_item.fdTopicName += "；" + item.fdTopicName;
						arr.splice(index, 1);
					}
				});
			});
			allResObj = topicResObj.concat(agendaResObj);
		} else {
			allResObj = agendaResObj;
		}
	}
	
	
	// 因为在处理topic的时候，为了避免处理agenda数据时的影响，没有将topicResObj值合并到allResObj
	// 所以allResObj的数据为空时，agendaResObj一定为空，但topicResObj不一定为空，故如下处理
	if (allResObj.length == 0) {
		allResObj = topicResObj;
	}
	
	// 构建HTML代码
   	var firstTr = $("#attendUnitFirstTr");
   	firstTr.nextAll().html("");
   	var html = "";
   	for (var k = 0; k < allResObj.length; k++) {
   		html += '<tr>'
   			+ '<td>'
					+ '<input type="hidden" name="fdAttendUnit" ' + 'value="' + allResObj[k].fdUnitId + '" id="fdAttendUnit" >'
					+ allResObj[k].fdUnitName
			+ '</td>'
			+ '<td>'
				+ '<input type="hidden" name="fdMeetingerId" ' + 'value="' + allResObj[k].fdMeetingerId + '" id="fdAttendUnit" >'
				+ allResObj[k].fdMeetingerName
			+ '</td>'
			+ '<td>'
				+ allResObj[k].fdTopicName
			+ '</td>'
		+ '</tr>';
   	}
   	if (html) {
   		firstTr.after(html);
   	}

};

function getAttentUnitInfo(url) {
	var result;
	$.ajax({
		url: url,
		data: {},
		async: false, 
		success: function(res) {
			result = eval("(" + res + ")");
		}
	});
	return result;
}

function selectTopicList(){
	showTopicList();
}

function getTopicIds(selectDomName) {
	var topicIds = "";
	var topicIdArray = new Array();
	topicIdArray = $(selectDomName);
	if (topicIdArray) {
		$.each(topicIdArray, function(index, item) {
			if (item.value) {
				topicIds += item.value + ";";
			}
		});
	}
	return topicIds;
}

</script>
<table  width=100% id="TABLE_DocList" align="center">
	<tr style="visibility:hidden">
		<td  width="4%" ></td>
		<td  width="96%" ></td>
	</tr>
	<tr KMSS_IsReferRow="1" style="display: none">
		<td   KMSS_IsRowIndex="1" width="4%" class="index_num">
			<i class="meeting-content-num">!{index}</i>
		</td>
  		<td width="96%" >
  			<div class="meeting-content-item">
                <div class="meeting-content-panel">
                  <div>
                    <div class="meeting-view-title clearfix">
                      <p class="meeting-view-title-name td_reporter">
                      	<input type='hidden' name='kmImeetingAgendaForms[!{index}].docReporterId' class="docReporterIdValue"/>
                      </p>
                      <div class="meeting-view-title-time clearfix">
                        <p><xform:datetime property="kmImeetingAgendaForms[!{index}].fdExpectStartTime" style="width:200px" required="true"  validators="after valExpectTime" subject="${lfn:message('km-imeeting:kmImeetingAgenda.fdExpectStartTime') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.fdExpectStartTime') }'"></xform:datetime></p>
                      </div>
                      <p class="meeting-view-title-del" onclick="deleteTopicMsg();"><bean:message bundle="km-imeeting" key="kmImeetingTopic.delect" /></p>
                      <p class="meeting-view-title-del" onclick="DocList_MoveRow(1);"><bean:message bundle="km-imeeting" key="kmImeetingTopic.moveDown" /></p>
                      <p class="meeting-view-title-del" onclick="DocList_MoveRow(-1);"><bean:message bundle="km-imeeting" key="kmImeetingTopic.moveUp" /></p>
                    </div>
                    <div class="meeting-view-content">
                      <div class="meeting-view-content-top">
                        <div>
			  			  <input type="hidden" name="kmImeetingAgendaForms[!{index}].fdId" />
		       			  <input type='hidden' name='kmImeetingAgendaForms[!{index}].fdMainId' value='${kmImeetingMainForm.fdId}'/>
		       			  <input type="hidden" id="detail_fdTopicId" value="">
                          <p class="meeting-view-content-title td_subject">
                          	 <input type='hidden' name='kmImeetingAgendaForms[!{index}].docSubject' />
                          </p>
                          <div class="meeting-view-content-line">
                            <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.organizer" />：</p>
                            <p class="meeting-view-content-info td_chargeUnit"><input type='hidden' name='kmImeetingAgendaForms[!{index}].fdChargeUnitId'/></p>
                          </div>
                          <div class="meeting-view-content-line">
                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}：</p>
                            <p class="meeting-view-content-info td_respons"><input type='hidden' name='kmImeetingAgendaForms[!{index}].docResponsId'/></p>
                          </div>
                          <div class="meeting-view-content-line">
                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}：</p>
                            <span class="td_fromTopic">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdFromTopicId' class="muiTopicId topicIdSign"/>
							</span>
							<p class="meeting-view-content-info td_attachment"></p>
                          </div>
                        </div>
                      </div>
                      <div class="meeting-view-content-bottom">
                        <div class="meeting-view-content-line">
                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.recommended.attendance.units" />：</p>
                          <ul class="meeting-view-content-list clearfix">
                            <li class="td_attendUnit"><input type='hidden' name='kmImeetingAgendaForms[!{index}].fdAttendUnitIds' class="fdAttendUnitIdsValue"/></li>
                          </ul>
                        </div>
                        <div class="meeting-view-content-line">
                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.suggested.listening.units" />：</p>
                          <ul class="meeting-view-content-list clearfix">
                            <li class="td_listenUnit"><input type='hidden' name='kmImeetingAgendaForms[!{index}].fdListenUnitIds' class="fdListenUnitIdsValue"/></li>
                          </ul>
                        </div>
                        <div style="display: none;">
                        	<span class="td_topicCreator">
								<input type="hidden" name="kmImeetingAgendaForms[!{index}].topicCreatorId">
							</span>
							<span class="td_topicCreatorN">
								<input type="hidden" name="kmImeetingAgendaForms[!{index}].topicCreatorName">
							</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
             </div>
  		</td>
	</tr>
	<%--内容行--%>
	<c:forEach items="${kmImeetingMainForm.kmImeetingAgendaForms}"  var="kmImeetingAgendaitem" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" >
			<td KMSS_IsContentRow="1"  width="4%" class="index_num">
				<i class="meeting-content-num">${vstatus.index+1}</i>
			</td>
			<td  width="96%">
				<div class="meeting-content-item">
	                <div class="meeting-content-panel">
	                  <div>
	                    <div class="meeting-view-title clearfix">
	                      <p class="meeting-view-title-name td_reporter" title="${kmImeetingAgendaitem.docReporterName}">
							  <c:choose>
								  <c:when test="${empty kmImeetingAgendaitem.docReporterName}">
									<c:out value="<无>" />
								  </c:when>
								  <c:otherwise>
									  ${kmImeetingAgendaitem.docReporterName}
								  </c:otherwise>
							  </c:choose>
							<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].docReporterId" value="${kmImeetingAgendaitem.docReporterId}" class="docReporterIdValue"/>
	                      </p>
	                      <div class="meeting-view-title-time clearfix">
	                        <p><xform:datetime property="kmImeetingAgendaForms[${vstatus.index}].fdExpectStartTime"  style="width:200px" required="true"  validators="after valExpectTime" subject="${lfn:message('km-imeeting:kmImeetingAgenda.fdExpectStartTime') }" showStatus="edit" value="${kmImeetingAgendaitem.fdExpectStartTime}" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingAgenda.fdExpectStartTime') }'"></xform:datetime></p>
	                      </div>
	                      <c:if test="${empty kmImeetingMainForm.fdSchemeId}">
	                      <p class="meeting-view-title-del" onclick="deleteTopicMsg();"><bean:message bundle="km-imeeting" key="kmImeetingTopic.delect" /></p>
	                      <p class="meeting-view-title-del" onclick="DocList_MoveRow(1);"><bean:message bundle="km-imeeting" key="kmImeetingTopic.moveDown" /></p>
	                      <p class="meeting-view-title-del" onclick="DocList_MoveRow(-1);"><bean:message bundle="km-imeeting" key="kmImeetingTopic.moveUp" /></p>
	                      </c:if>
	                      
	                    </div>
	                    <div class="meeting-view-content">
	                      <div class="meeting-view-content-top">
	                        <div>
	                        <c:if test="${kmImeetingMainForm.method_GET !='add'}">
		                        <!-- isOnMainPage 若为true代表通知页面引入该页面 -->
		                        <c:choose>
	                        		<c:when test="${isOnMainPage eq 'true' && not empty kmImeetingMainForm.fdSchemeId && kmImeetingMainForm.method ne 'changeMeeting'}">
	                        			<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdId" value="${kmImeetingAgendaitem.fdAttKeyId}" id="detail_fdTopicId" />
	                        			<c:choose>
	                        				<c:when test="${not empty kmImeetingAgendaitem.fdAttKeyId}">
	                        					<input type="hidden" value="${kmImeetingAgendaitem.fdAttKeyId}" class="agendaIdSign" />
	                        				</c:when>
	                        				<c:otherwise>
	                        					<input type="hidden" value="${kmImeetingAgendaitem.fdId}" class="agendaIdSign" />
	                        				</c:otherwise>
	                        			</c:choose>
	                        		</c:when>
	                        		<c:otherwise>
	                        			<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdId" value="${kmImeetingAgendaitem.fdId}" id="detail_fdTopicId" />
	                        			<c:choose>
	                        				<c:when test="${not empty kmImeetingAgendaitem.fdAttKeyId}">
	                        					<input type="hidden" value="${kmImeetingAgendaitem.fdAttKeyId}" class="agendaIdSign" />
	                        				</c:when>
	                        				<c:otherwise>
	                        					<input type="hidden" value="${kmImeetingAgendaitem.fdId}" class="agendaIdSign" />
	                        				</c:otherwise>
	                        			</c:choose>
	                        		</c:otherwise>
	                        	</c:choose>
	                         </c:if>
	                          <c:if test="${kmImeetingMainForm.method_GET =='add'}">
		                          <c:choose>
	                        		<c:when test="${isOnMainPage eq 'true' && not empty kmImeetingMainForm.fdSchemeId}">
	                        			<input type="hidden" value="${kmImeetingAgendaitem.fdAttKeyId}" id="detail_fdTopicId" class="agendaIdSign" />
	                        		</c:when>
	                        		<c:otherwise>
	                        			<input type="hidden" value="${kmImeetingAgendaitem.fdId}" id="detail_fdTopicId" class="agendaIdSign" />
	                        		</c:otherwise>
	                        	</c:choose>
	                         </c:if>
							  <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingAgendaitem.fdFromTopicId}" />
							  <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdMainId" value="${kmImeetingMainForm.fdId}" />
	                          <p class="meeting-view-content-title td_subject">
	                          	<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].docSubject" value="${kmImeetingAgendaitem.docSubject}"/>
	                          	<c:out value="${kmImeetingAgendaitem.docSubject}"></c:out>
	                          </p>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.organizer" />：</p>
	                            <p class="meeting-view-content-info td_chargeUnit">
	                            	${kmImeetingAgendaitem.fdChargeUnitName}
									<input type='hidden' name='kmImeetingAgendaForms[${vstatus.index}].fdChargeUnitId' value="${kmImeetingAgendaitem.fdChargeUnitId}"/>
	                            </p>
	                          </div>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}：</p>
	                            <p class="meeting-view-content-info td_respons">
	                            	${kmImeetingAgendaitem.docResponsName}
									<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].docResponsId" value="${kmImeetingAgendaitem.docResponsId}"/>
	                            </p>
	                          </div>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}：</p>
	                            <span class="td_fromTopic">
									<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingAgendaitem.fdFromTopicId}" class="muiTopicId"/>
								</span>
								<p class="meeting-view-content-info td_attachment">
									<c:choose>
										<c:when test="${not empty param.fdSchemeIds}">	
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdAttKeyId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
												<c:param name="fdModelId" value="${kmImeetingMainForm.fdSchemeId}" />
												<c:param name="isShowDownloadCount" value="false" />
											</c:import>
										</c:when>
										<c:when test="${not empty kmImeetingAgendaitem.fdAttKeyId }">
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdAttKeyId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
												<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}" />
												<c:param name="isShowDownloadCount" value="false" />
											</c:import>
										</c:when>
										<c:otherwise>
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
												<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}" />
												<c:param name="isShowDownloadCount" value="false" />
											</c:import>
										</c:otherwise>
									</c:choose>
								</p>
	                          </div>
	                        </div>
	                      </div>
	                      <div class="meeting-view-content-bottom">
	                        <div class="meeting-view-content-line">
	                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.recommended.attendance.units" />：</p>
	                          <ul class="meeting-view-content-list clearfix">
	                            <li class="td_attendUnit">
	                            	 ${kmImeetingAgendaitem.fdAttendUnitNames}
									<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].fdAttendUnitIds" value="${kmImeetingAgendaitem.fdAttendUnitIds}" class="fdAttendUnitIdsValue"/>
	                            </li>
	                          </ul>
	                        </div>
	                        <div class="meeting-view-content-line">
	                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.suggested.listening.units" />：</p>
	                          <ul class="meeting-view-content-list clearfix">
	                            <li class="td_listenUnit">
	                            	${kmImeetingAgendaitem.fdListenUnitNames}
									<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].fdListenUnitIds" value="${kmImeetingAgendaitem.fdListenUnitIds}" class="fdListenUnitIdsValue"/>
	                            </li>
	                          </ul>
	                        </div>
	                        <div style="display: none;">
	                        	<span class="td_topicCreator">
									<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].topicCreatorId" value="${kmImeetingAgendaitem.topicCreatorId}">
								</span>
								<span class="td_topicCreatorN">
									<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].topicCreatorName" value="${kmImeetingAgendaitem.topicCreatorName}">
								</span>
	                        </div>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	             </div>
	             <script>
				 	topicListIds += "${kmImeetingAgendaitem.fdFromTopicId},";
				</script>
	  		</td>
		</tr>
	</c:forEach>
</table>