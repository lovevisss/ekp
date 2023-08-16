<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 附件预览区域 --%>
<script>
	Com_IncludeFile("jquery.js");
</script>	
<script>
$(document).ready(function(){
	if($('#previewAttFrame')){
		$('#previewAttFrame').height( (800)+"px");
	}
	var fdId="${kmImeetingSchemeForm.attachmentForms[kmImeetingScheme].attachments}";
	var fileList=Attachment_ObjectInfo["kmImeetingScheme"].fileList;
	var path="${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=view&inner=yes&fdId="+fileList[0].fdId;
	$('#previewAttFrame').attr("src",path);
});
</script>

