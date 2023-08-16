<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">
seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
});
var topicListIds="";
function showTopicList(){
	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath + 'km/imeeting/km_imeeting_topic/index_dialog_select.jsp'; 
 	dialog.iframe(url,'<bean:message bundle="km-imeeting" key="kmImeetingAgenda.operation.addDetailTopic.mobile" />',function(ids){
 		
 		if (ids!=""&&ids!=null){
			var data = new KMSSData();
		    var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadTopicList&ids="+ ids;
		    data.SendToUrl(url, function(data) {
		    	var results = eval("(" + data.responseText + ")");
		    	if(results.length>0){
			    	for(var i=0;i<results.length;i++){
				    	if(topicListIds.indexOf(results[i].fdTopicId,0)==-1){
				    		topicListIds +=results[i].fdTopicId +",";
				    		// table 添加逻辑
				    		var newRow = DocList_AddRow("TABLE_DocList");
							if(results[i].docSubject){
								$(newRow).find(".td_subject input").val(results[i].docSubject);
								$(newRow).find(".td_subject").append(results[i].docSubject);
					    	}
							if(results[i].fdReporterId){
								$(newRow).find(".td_reporter input").val(results[i].fdReporterId);
								$(newRow).find(".td_reporter").append(results[i].fdReporterName);
					    	}
							if(results[i].fdReporterId){
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
								$(newRow).find(".td_responsN input").append(results[i].fdMaterialStaffName);
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
						    		mainHtml += "<span style='float: left;'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='float:left;margin-right:3px;margin-left:3px' />";
						    		mainHtml += Com_HtmlEscape(mainAtt[m].fdFileName)+"</span>";
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
					    			commonHtml += "<span style='float: left;'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='float:left;margin-right:3px;margin-left:3px' />";
					    			commonHtml += Com_HtmlEscape(commonAtt[n].fdFileName)+"</span>";
					    			commonHtml += "</td></tr>";
					    		}
					    	}
					    	commonHtml +="</table>";
					    	$(newRow).find(".td_fromTopic input").val(results[i].fdTopicId);
					    	$(newRow).find(".td_attachment").append(mainHtml+commonHtml);
					    }
			    	}
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

function selectTopicList(){
	showTopicList();
}
</script>
<table border="0" width=100%  tbdraggable="true" class="tb_normal" id="TABLE_DocList" align="center" style="text-align:center">
		<tr>
		<td class="td_normal_title" width="5%">
		</td>
		<td class="td_normal_title" width="5%">
			序号
		</td>
		<td class="td_normal_title" width="15%">
			议题名称
		</td>
		<td class="td_normal_title" width="10%">
			承办单位
		</td>
		<td class="td_normal_title" width="8%">
			汇报人
		</td>
		<td class="td_normal_title" width="14%">
			建议列席单位
		</td>
		<td class="td_normal_title" width="14%">
			建议旁听单位
		</td>
		<td class="td_normal_title" width="29%">
			<bean:message bundle="km-imeeting" key="kmImeetingAgenda.attachmentName"/>
		</td>
		<td class="td_normal_title" width="5%">
			
		</td>
	</tr>
	<!-- 基准行 -->
	<tr KMSS_IsReferRow="1" style="display: none" draggable="true" class="dragTrbox">
		<td align="center">
			<input type="checkbox" name="DocList_Selected">
		</td>
		<td   KMSS_IsRowIndex="1" width="4%">
	     !{index}
	    </td>
		<td>
			<span class="meeting-view-content-title td_subject">
                        	<input type="hidden" name="kmImeetingAgendaForms[!{index}].docSubject" value=""/>
                  </span>
		</td>
		<td>
			<span class="meeting-view-content-title td_chargeUnit">
                        	<input type="hidden" name="kmImeetingAgendaForms[!{index}].fdChargeUnitId" value=""/>
                  </span>
		</td>
		<td>
			<span class="meeting-view-content-title td_reporter">
                        	<input type="hidden" name="kmImeetingAgendaForms[!{index}].docReporterId" value="${kmImeetingAgendaitem.docReporterId}"/>
                  </span>
		</td>
		<td>
			<span class="meeting-view-content-title td_attendUnit">
                         	<input type="hidden" name="kmImeetingAgendaForms[!{index}].fdAttendUnitIds" value="${kmImeetingAgendaitem.fdAttendUnitIds}"/>
			</span>
		</td>
		<td>
			<span class="meeting-view-content-title td_listenUnit">
                         	<input type="hidden" name="kmImeetingAgendaForms[!{index}].fdListenUnitIds" value="${kmImeetingAgendaitem.fdListenUnitIds}"/>
			</span>
		</td>
		<td>
			<span class="meeting-view-content-title td_attachment">
			
			</span>
			<span class="td_fromTopic">
				<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdFromTopicId' class="muiTopicId"/>
			</span>
			<span class="td_respons">
				<input type='hidden' name='kmImeetingAgendaForms[!{index}].docResponsId'/>
			</span>
			<span class="td_responsN">
				<input type='hidden' name='kmImeetingAgendaForms[!{index}].docResponsName'/>
			</span>
			<span class="td_topicCreator">
				<input type="hidden" name="kmImeetingAgendaForms[!{index}].topicCreatorId">
			</span>
			<span class="td_topicCreatorN">
				<input type="hidden" name="kmImeetingAgendaForms[!{index}].topicCreatorName">
			</span>
		</td>
		<!-- 删除按钮 -->
		<td align="center"  class="td_operate">
			<span style="cursor:pointer" class="optStyle opt_del_style" title="<bean:message bundle="sys-xform" key="xform.button.delete" />" onmousedown="DocList_DeleteRow_ClearLast();">
			</span>
		</td>
	</tr>
	 <c:forEach items="${kmImeetingSchemeForm.kmImeetingAgendaForms}"  var="kmImeetingAgendaitem" varStatus="vstatus">
		<tr KMSS_IsContentRow="1"  draggable="true" class="dragTrbox">
		<td align="center">
			<input type="checkbox" name="DocList_Selected">
			<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdId" value="${kmImeetingAgendaitem.fdId}" />
			<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdSchemeId" value="${kmImeetingSchemeForm.fdId}" />
			<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].topicCreatorId" value="${kmImeetingAgendaitem.topicCreatorId}" />
		</td>
		<td  KMSS_IsContentRow="1" width="4%">
	      ${vstatus.index+1}
	    </td>
		<td>
			<span class="meeting-view-content-title td_subject">
            	<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].docSubject" value="${kmImeetingAgendaitem.docSubject}"/>
                <c:out value="${kmImeetingAgendaitem.docSubject}"></c:out>
        	</span>
		</td>
		<td>
			<span class="meeting-view-content-title td_chargeUnit">
					<input type='hidden' name='kmImeetingAgendaForms[${vstatus.index}].fdChargeUnitId'/>
					${kmImeetingAgendaitem.fdChargeUnitName}
                  </span>
		</td>
		<td>
			<span class="meeting-view-content-titrle td_reporter">
				<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].docReporterId" value="${kmImeetingAgendaitem.docReporterId}"/>
                       ${kmImeetingAgendaitem.docReporterName}
                  </span>
		</td>
		<td>
			<span class="meeting-view-content-title td_attendUnit">
				<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].fdAttendUnitIds" value="${kmImeetingAgendaitem.fdAttendUnitIds}"/>
                    ${kmImeetingAgendaitem.fdAttendUnitNames}
			</span>
		</td>
		<td>
			<span class="meeting-view-content-title td_listenUnit">
				<input type="hidden"  name="kmImeetingAgendaForms[${vstatus.index}].fdListenUnitIds" value="${kmImeetingAgendaitem.fdListenUnitIds}"/>
				 ${kmImeetingAgendaitem.fdListenUnitNames}
			</span>
		</td>
		<td>
			<span class="meeting-view-content-title td_attachment">
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdId }" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
					<c:param name="fdModelId" value="${kmImeetingSchemeForm.fdId }" />
					<c:param name="isShowDownloadCount" value="false" />
				</c:import>
			</span>
			<span class="td_fromTopic">
				<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingAgendaitem.fdFromTopicId}" class="muiTopicId"/>
			</span>
			<span class="td_respons">
				<input type='hidden' name='kmImeetingAgendaForms[${vstatus.index}].docResponsId' value="${kmImeetingAgendaitem.docResponsId}"/>
			</span>
			<span class="td_responsN">
				<input type='hidden' name='kmImeetingAgendaForms[${vstatus.index}].docResponsName' value="${kmImeetingAgendaitem.docResponsName}"/>
			</span>
			<span class="td_topicCreator">
				<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].topicCreatorId" value="${kmImeetingAgendaitem.topicCreatorId}">
			</span>
			<span class="td_topicCreatorN">
				<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].topicCreatorName" value="${kmImeetingAgendaitem.topicCreatorName}">
			</span>
		</td>
		<script>
	 		topicListIds += "${kmImeetingAgendaitem.fdFromTopicId},";
		</script>
		<!-- 删除按钮 -->
		<td align="center"  class="td_operate">
			<span style="cursor:pointer" class="optStyle opt_del_style" title="<bean:message bundle="sys-xform" key="xform.button.delete" />" onmousedown="DocList_DeleteRow_ClearLast();">
			</span>
		</td>
		</tr>
	</c:forEach>
	
	
	<tr class="tr_normal_opt" type="optRow" invalidrow="true">
		<td colspan="9" align="center" column="0" row="3" coltype="optCol">
			<div class="tr_normal_opt_content">
				<div class="tr_normal_opt_l">
					<label class="opt_ck_style">
						<input type="checkbox" name="DocList_SelectAll" onclick="DocList_SelectAllRow(this);"><bean:message bundle="sys-xform" key="xform.button.selectAll" />
					</label>
					<span class="optStyle opt_batchDel_style" onclick="DocList_BatchDeleteRow();" title="<bean:message bundle="sys-xform" key="xform.button.delete" />">
					</span>
				</div>
					<div class="tr_normal_opt_c"> 
						<span class="optStyle opt_add_style" title='<bean:message bundle="sys-xform" key="xform.button.add" />'  onclick="selectTopicList()"></span>
						<span class="optStyle opt_up_style"  title='<bean:message bundle="sys-xform" key="xform.button.moveup" />'  onclick="DocList_MoveRowBySelect(-1);"></span>
						<span class="optStyle opt_down_style" title='<bean:message bundle="sys-xform" key="xform.button.movedown" />'  onclick="DocList_MoveRowBySelect(1);"></span>
					</div>
			</div>
		</td>
	</tr>
</table>