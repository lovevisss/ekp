<%@page import="com.landray.kmss.km.imeeting.util.BoenUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div id="_readStat_container">
	<ui:tabpanel id="statAccess" layout="sys.ui.tabpanel.light">
		<ui:content title="签到情况">
			
			<ui:event event="show">
				document.getElementById('statContent0').src = '<c:url value="/km/imeeting/km_imeeting_main/import/kmImeeting_sign.jsp" />?fdId=${kmImeetingMainForm.fdId}';
			</ui:event>
		
			<table width="100%">
				<tr> 
					<td>
						<iframe id="statContent0" width="100%" height="1000" frameborder=0 scrolling=no></iframe>
					</td>
				</tr> 
			</table>
		</ui:content>
		<ui:content title="投票统计">
			<ui:event event="show">
				document.getElementById('statContent1').src = '<c:url value="/km/imeeting/km_imeeting_main/import/kmImeeting_vote.jsp" />?fdId=${kmImeetingMainForm.fdId}';
			</ui:event>
		
			<table width="100%">
				<tr> 
					<td>
						<iframe id="statContent1" width="100%" height="1000" frameborder=0 scrolling=no></iframe>
					</td>
				</tr> 
			</table>
		</ui:content>
		<ui:content title="表决统计">
			<ui:event event="show">
				document.getElementById('statContent2').src = '<c:url value="/km/imeeting/km_imeeting_main/import/kmImeeting_ballot.jsp" />?fdId=${kmImeetingMainForm.fdId}';
			</ui:event>
		
			<table width="100%">
				<tr> 
					<td>
						<iframe id="statContent2" width="100%" height="1000" frameborder=0 scrolling=no></iframe>
					</td>
				</tr> 
			</table>
		</ui:content>
	</ui:tabpanel>
</div>
<script>
	function showStatTab(){
		var tab = LUI('statAccess');
		tab.on('indexChanged',function(data) {
			console.log(data);
			seajs.use(['lui/jquery'],function($) {
				//火狐浏览器下在iframe未显示出来之前获取body高度始终是0，所以这里只能需要添加延时，确保iframe已经显示出来
				setTimeout(function() {
					var $frame = $('#statContent'+data.index.after);
					var _window = $frame[0].contentWindow;
					var fHeight = $frame.height();  //iframe的高度
					var bHeight = $(_window.document.body).height();  //body的高度
					if(fHeight < bHeight) {
						if(_window.setBodyHeight)
							_window.setBodyHeight();
					}
				},100);
			});
		});
	}
</script>
