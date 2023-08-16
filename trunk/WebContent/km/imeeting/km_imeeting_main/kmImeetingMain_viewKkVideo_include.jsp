<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KKUtil"%>
<c:if test="${isBegin==true and isEnd==false and kmImeetingMainForm.fdIsVideo eq 'true' and kmImeetingMainForm.docStatus ne '41' and canEnterKkVedio eq 'true' and not empty roomId}">	
	<div id="ImeetingEnterBtn"  onclick="enterVedioMeeting('${roomId}');">
		<p  onclick="enterVedioMeeting('${roomId}');">视频会议</p>
	</div>
</c:if>	
<%
	request.setAttribute("fdKkVideoUrl", KKUtil.getKKUrlHttps());

%>

<script type="text/javascript">
function enterVedioMeeting(roomId){
	if(roomId){
		var videoUrl = "${fdKkVideoUrl}/serverj/alimeeting/enter.ajax?roomId=" + roomId;
		window.open(videoUrl,"_blank");
	}else{
		dialog.alert("无法进入会议，请确认会议是否已经同步到KK中");
	}
};

function syncVedioMeeting(){
	var url = '<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=addSyncToKk"/>';
	$.ajax({
		url: url,
		type: 'post',
		dataType: 'json',
		data:{fdId:'${kmImeetingMainForm.fdId}'},
		error: function(data){
		},
		success: function(data){
	    	 if(data['success'] =='false'){
	    		 dialog.failure('同步失败!');
	    	 }else{
	    		 dialog.success('同步成功!');
	    	 }
		}
   });
};
</script>	
		
