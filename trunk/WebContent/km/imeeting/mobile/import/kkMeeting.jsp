<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:if test="${isBegin==true and isEnd==false and kmImeetingMainForm.fdIsVideo eq 'true' and canEnterKkVedio eq 'true' and not empty roomId}">	
	<div id="ImeetingEnterBtn" style="display:none">
		<div onclick="enterKkMeeting('${roomId}')"></div>
		<p>视频会议</p>
	</div>
	<script type="text/javascript">
	require(['dojo/topic',
        'dojo/ready',
        'dojo/query',
        'dojo/dom-style',
        'mui/device/adapter',
        "mui/dialog/Tip",
        "mui/device/device"
        ],function(topic,ready,query,domStyle,adapter,Tip,device){
	
			ready(function(){
				if(device.getClientType() == 9 || device.getClientType() == 10){ //kk客户端 
					var kkMeetingBtn = document.getElementById("ImeetingEnterBtn");
					domStyle.set(kkMeetingBtn, 'display', 'block');
				}
			});
			
			window.enterKkMeeting = function(roomId){
				if(roomId){
					adapter.enterVideoMeeting({
						roomId:roomId
					},function(rtn){
						if(rtn.code==0){
							Tip.success({
								text : rtn.text
							});
						}
					},function(rtn){
						Tip.fail({
							text : rtn.text
						});
					});
				}else{
					Tip.fail({
						text : rtn.text
					});
				}
			};
		});
	</script>
</c:if>