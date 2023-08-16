<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 附件预览区域 --%>
<script>
	Com_IncludeFile("jquery.js");
</script>	
<script src="${LUI_ContextPath}/km/imissive/resource/js/jquery-ui.js"></script>
<script>
	function attachmentPreview(att, docId) {
		var contentH = $('.content').height();
		if(att.fdKey == 'attachment'){
			$('.attContent').hide();
			
			$('#attachment_preview').css('height', (contentH-50)+'px').show();
			
			var url = att.getUrl("view", docId);
			
			var jg_height = contentH-150; //金格的高度
			if(url){
				url += "&inner=yes&attHeight="+jg_height;
				$('#attachment_preview iframe').attr('src', url).load(function() {
					$('#attachment_preview iframe').css('height', (contentH-70)+'px');
					if($('.bar-right').width() < 550){
					 	$('.bar-right').css('width','50%');
			   			$('.content').css('margin-right','51.5%');
					}
				});
			}
		}else{
			$('.missive_content').hide();
			$('#content_preview').css('height', (contentH-60)+'px').show();
			
			var url;
			if(att.url){
				url = att.url;
			}else{
				url = att.getUrl("view", docId);
			}
			
			if(url){
				url += "&inner=yes";
				$('#content_preview iframe').attr('src', url).load(function() {
					if($('.bar-right').width() < 550){
						$('.bar-right').css('width','50%');
			   			$('.content').css('margin-right','51.5%');
					}
				});
			}
		}
	}
	
	function Frame_CloseWindow(fdKey,win) {
		if(fdKey == 'attachment'){
			$('.attContent').show();
			$('#attachment_preview').hide();
			$(win).trigger('unload');
		}else{
			$('.missive_content').show();
			$('#content_preview').hide();
			$(win).trigger('unload');
		}
		
	}
</script>

