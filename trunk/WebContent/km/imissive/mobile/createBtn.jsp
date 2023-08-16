<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="sys/mportal/module/mobile/elements/Button"
		data-dojo-props="icon:'muis-new',datas:[
		<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
		{
			'icon':'muis-pop-send',
			'text':'新建发文',
			'click':function(){
				require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
					SysCategoryUtil.create({
	  						  key: 'signAdd',
	  		                  createUrl: '/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{curIds}&mobile=true',
	  		                  modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
	  		                  mainModelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendMain'
		            });
				});
		    	}
		},
		</kmss:authShow>
		<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
		{
			'icon':'muis-missive-new-accept',
			'text':'新建收文',
			'click':function(){
				require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
					SysCategoryUtil.create({
	  						  key: 'signAdd',
	  		                  createUrl: '/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=!{curIds}&mobile=true',
	  		                  modelName: 'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',
	  		                  mainModelName: 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain'
		            });
				});
		    	}
		},
		</kmss:authShow>
		<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">
		{
			'icon':'muis-missive-new-report',
			'text':'新建签报',
			'click':function(){
				require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
					SysCategoryUtil.create({
	  						  key: 'signAdd',
	  		                  createUrl: '/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=add&fdTemplateId=!{curIds}&mobile=true',
	  		                  modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSignTemplate',
	  		                  mainModelName: 'com.landray.kmss.km.imissive.model.KmImissiveSignMain'
		            });
				});
		    	}
		}
		</kmss:authShow>
	]">
</div>

