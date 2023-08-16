<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
			
			function submitMyForm(formObj){
				
				parent.Com_submitReviewInner();
				
			}
			
			
			var goushi = function(callBackFn){
				
				Com_Submit.ajaxSubmit = submitMyForm;
				
				Com_Submit(document.myForm,"save");
				
			}
			
		</script>
		<form name="myForm" action="11112">
		
		</form>
	</template:replace>	 
</template:include>