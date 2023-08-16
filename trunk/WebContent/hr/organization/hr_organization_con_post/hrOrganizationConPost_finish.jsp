<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<template:include ref="default.dialog">
	<template:replace name="head">
    	<link rel="stylesheet" href="${LUI_ContextPath}/hr/organization/resource/css/lib/form.css">
		<link rel="stylesheet" href="${LUI_ContextPath}/hr/organization/resource/css/organization.css">
	</template:replace>
	<template:replace name="content" >
		<script type="text/javascript">Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js|dialog.js", null, "js");</script>
			<c:import url="/hr/organization/hr_organization_common/hr_organization_del.jsp" charEncoding="UTF-8">
  			</c:import>
		<script>
			var validation=$KMSSValidation();//校验框架
			seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
				//确定
				var __isSubmit = false;
				window.clickOk = function(){
					if(__isSubmit){
						return;
					}
					if(validation.validate()){
						__isSubmit = true;
						var ids = $("#ids").val();
						var url = '<c:url value="/hr/organization/hr_organization_con_post/hrOrganizationConPost.do?method=finishConPost"/>' + "&fdId="+ids;
						window.del_load = dialog.loading();
						$.ajax({
							url : url,
							type : 'GET',
							data : $(document.hrOrganizationConPostForm).serialize(),
							error : function(data) {
								if(window.del_load != null) {
									window.del_load.hide(); 
								}
								dialog.result(data.responseJSON);
								$dialog.hide('success')
							},
							success: function(data) {
								if(window.del_load != null){
									window.del_load.hide(); 
									topic.publish("list.refresh");
								}
								dialog.success('<bean:message key="return.optSuccess" />');
								setTimeout(function (){
									window.$dialog.hide("success");
								}, 1500);
							}
					   });

					}
				}
			});
		</script>
	</template:replace>
</template:include>