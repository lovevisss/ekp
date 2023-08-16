<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">

seajs.use(['lui/jquery','lui/topic','lui/toolbar'], function($,topic,toolbar) {
	
	window.getCookie = function(){   
		var arr,reg=new RegExp("(^| )isopen=([^;]*)(;|$)");   
		if(arr=document.cookie.match(reg)) return unescape(arr[2]);   
		else return null;   
	};
		
	LUI.ready(function(){
	   var mark=getCookie();
		 if(mark=='open'){
			 var dataInitBtn = toolbar.buildButton({id:'dataInit',order:'1',text:'${lfn:message("sys-datainit:sysDatainitMain.data.export")}',click:'Datainit_Submit()'});
			 LUI('toolbar').addButton(dataInitBtn);
	   }
	  		 
	});
	
	window.Datainit_Submit = function(){
		if(!List_CheckSelect())
			return;
		var form = document.${JsParam.formName};
		var url = Com_Parameter.ContextPath + "sys/datainit/sys_datainit_main/sysDatainitMain.do?method=export&formName="+form.name;
		form.action = url;
		form.submit();
	}
});
</script>