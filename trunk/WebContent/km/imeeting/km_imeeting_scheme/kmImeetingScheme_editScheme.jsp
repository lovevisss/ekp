<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">
seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
});
var topicListIds="";
function showSchemeList(){
	
	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath + 'km/imeeting/km_imeeting_scheme/index_dialog_selectScheme.jsp'; 
 	dialog.iframe(url, '选择方案', function(ids) {
 		if (ids!=""&&ids!=null) {
 			idss=ids.split(";");
 			if (idss.length>2) {
 				dialog.alert('只能选择一个方案!');
 				return false;
			} else{
				var data = new KMSSData();
				 var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main/kmImeetingMain.do?method=";
				var method = "${kmImeetingMainForm.method}";
				if (method=="add") {
			 		url += "add&fdTemplateId=${kmImeetingMainForm.fdTemplateId}&i.docTemplate=${kmImeetingMainForm.fdTemplateId}&fdSchemeIds="+ ids;
				} else if(method == "edit"){
			   		url += "edit&fdId=${kmImeetingMainForm.fdId}&fdSchemeIds="+ ids+"&schemeFlag=true";
				} else if (method == "changeMeeting") {
					url += "changeMeeting&fdId=${kmImeetingMainForm.fdId}&fdSchemeIds="+ ids+"&schemeFlag=true";
				}
			    window.open(url, "_self");
			}
		} else{
			  return false;
	   }
	 }, {width:950,height:550});
}

$(document).on('table-delete',"table[id$='TABLE_DocList']",function(evt, data) {
	var topicObj = $(data).find('.muiTopicId');
	if(topicObj!=null&&topicObj.length>0){
		topicListIds=topicListIds.replace(topicObj[0].value,"");
	}
});

function buildAttendUnits(ids) {
	if (!ids) {
		return;
	}
	var data = new KMSSData();
    var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadAttendUnitList&ids="+ ids;
    data.SendToUrl(url, function(data) {
    	var results = eval("(" + data.responseText + ")");
    	var firstTr = $("#attendUnitFirstTr");
    	firstTr.nextAll().html("");
    	var html = "";
    	for (var i = 0; i < results.length; i++) {
    		html += '<tr>'
    			+ '<td>'
						+ '<input type="hidden" name="fdAttendUnit" ' + 'value="' + results[i].fdUnitId + '" id="fdAttendUnit" >'
						+ results[i].fdUnitName 
				+ '</td>'
				+ '<td>'
					+ '<input type="hidden" name="fdMeetingerId" ' + 'value="' + results[i].fdMeetingerId + '" id="fdAttendUnit" >'
					+ results[i].fdMeetingerName
				+ '</td>'
				+ '<td>'
					+ results[i].fdTopicName
				+ '</td>'
			+ '</tr>';
    	}
    	if (html) {
    		firstTr.after(html);
    	}
    });
};

function selectSchemeList(){
	showSchemeList();
}
</script>