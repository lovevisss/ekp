<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${lfn:message('return.systemInfo') }</title>
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath }/<%=(JSONObject.fromObject(SysUiPluginUtil.getThemes(request))).getJSONArray("prompt").get(0)%>"/>
		<%@ include file="/sys/ui/jsp/jshead.jsp"%>
		<script type="text/javascript">
		if('${fdIsAvailable}' == 'false'){
			seajs.use(['lui/dialog'],function(dialog) {
				dialog.confirm('<bean:message  bundle="km-imissive" key="kmImissiveTemplate.msg.notAvailable"/>',function(flag){
					if(flag==true){
					dialog.categoryForNewFile(
							'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
							'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}',false,null,function(rtn){
								window.opener=null;
					    		window.open('','_self');
					    		window.close();
							},'${JsParam.categoryId}',null,'_self',true);
			    	}else{
			    		window.opener=null;
			    		window.open('','_self');
			    		window.close();
				    }
			    },"warn");
			});
		}
		</script>		
	</head>
	<body>
		<input type="hidden" name="fdTemplateId" />
		<input type="hidden" name="fdTemplateName" />
	</body>
</html>