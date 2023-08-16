<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script type="text/javascript">
	require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util",'dojo/date/locale'],
			function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util,locale){
		window.getAuthUnit = function (fdIds,fdgIds,unitSpan){
			var fdUnitGIds;
			if(unitSpan == "mainUnit"){
				fdUnitGIds = document.getElementsByName("fdMaintoUnitGroupIds")[0].value;
			}
			if(unitSpan == "copyUnit"){
				fdUnitGIds = document.getElementsByName("fdCopytoUnitGroupIds")[0].value;
			}
			if(unitSpan == "reportUnit"){
				fdUnitGIds = document.getElementsByName("fdReporttoUnitGroupIds")[0].value;
			}
			 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getAuthUnit"; 
			 req(url, {
				handleAs : 'json',
				method : 'post',
				data : {
					fdIds:fdIds,fdgIds:fdgIds,fdUnitGIds:fdUnitGIds
				}
			}).then(lang.hitch(this, function(data) {
				 if(data!=""){
		    		 var results = data;
		    	    document.getElementById(unitSpan).innerHTML = "<bean:message key='kmImissive.distribute.result.title' bundle='km-imissive'/>: <font color='red'>"+results['names']+"</font>";
			     }else{
			    	document.getElementById(unitSpan).innerHTML = "<font color='red'><bean:message key='kmImissive.distribute.result.title' bundle='km-imissive'/></font>";
				 }
			}));
		};

		window.afterSelectMain = function (evt){
			var ids = evt.curIds;
			var fdMissiveMaintoIds = "";
			var fdMissiveMaintoGroupIds="";
			var fdMaintoUnitGroupIds="";
			if(ids!=""){
				document.getElementsByName("fdMaintoIds")[0].value = evt.curIds;
				var idsArray = ids.split(";");
				for(var i=0;i<idsArray.length;i++){
					if(idsArray[i]!=""){
						if(idsArray[i].indexOf("cate")>-1){
							fdMissiveMaintoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
						}else if(idsArray[i].indexOf("group")>-1){
							fdMaintoUnitGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("group")-1)+";";
						}else{
							fdMissiveMaintoIds += idsArray[i]+";";
						}
					}
				}
				fdMissiveMaintoIds = fdMissiveMaintoIds.substring(0,fdMissiveMaintoIds.length-1);
				fdMissiveMaintoGroupIds = fdMissiveMaintoGroupIds.substring(0,fdMissiveMaintoGroupIds.length-1);
				fdMaintoUnitGroupIds= fdMaintoUnitGroupIds.substring(0,fdMaintoUnitGroupIds.length-1);
			}
			document.getElementsByName("fdMissiveMaintoIds")[0].value = fdMissiveMaintoIds;
			document.getElementsByName("fdMissiveMaintoGroupIds")[0].value=fdMissiveMaintoGroupIds;
			document.getElementsByName("fdMaintoUnitGroupIds")[0].value=fdMaintoUnitGroupIds;
			getAuthUnit(fdMissiveMaintoIds,fdMissiveMaintoGroupIds,"mainUnit");
		};

		window.afterSelectCopy = function (evt){
			var ids = evt.curIds;
			var fdMissiveCopytoIds = "";
			var fdMissiveCopytoGroupIds="";
			var fdCopytoUnitGroupIds="";
			if(ids!=""){
				document.getElementsByName("fdCopytoIds")[0].value = evt.curIds;
				var idsArray = ids.split(";");
				for(var i=0;i<idsArray.length;i++){
					if(idsArray[i]!=""){
						if(idsArray[i].indexOf("cate")>-1){
							fdMissiveCopytoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
						}else if(idsArray[i].indexOf("group")>-1){
							fdCopytoUnitGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("group")-1)+";";
						}else{
							fdMissiveCopytoIds += idsArray[i]+";";
						}
					}
				}
				fdMissiveCopytoIds = fdMissiveCopytoIds.substring(0,fdMissiveCopytoIds.length-1);
				fdMissiveCopytoGroupIds = fdMissiveCopytoGroupIds.substring(0,fdMissiveCopytoGroupIds.length-1);
				fdCopytoUnitGroupIds = fdCopytoUnitGroupIds.substring(0,fdCopytoUnitGroupIds.length-1);
			}
			document.getElementsByName("fdMissiveCopytoIds")[0].value = fdMissiveCopytoIds;
			document.getElementsByName("fdMissiveCopytoGroupIds")[0].value=fdMissiveCopytoGroupIds;
			document.getElementsByName("fdCopytoUnitGroupIds")[0].value=fdCopytoUnitGroupIds;
			getAuthUnit(fdMissiveCopytoIds,fdMissiveCopytoGroupIds,"copyUnit");
		};


		window.afterSelectReport = function (evt){
			var ids = evt.curIds;
			var fdMissiveReporttoIds = "";
			var fdMissiveReporttoGroupIds="";
			var fdReporttoUnitGroupIds="";
			if(ids!=""){
				document.getElementsByName("fdReporttoIds")[0].value = evt.curIds;
				var idsArray = ids.split(";");
				for(var i=0;i<idsArray.length;i++){
					if(idsArray[i] != ""){
						if(idsArray[i].indexOf("cate")>-1){
							fdMissiveReporttoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
						}else if(idsArray[i].indexOf("group")>-1){
							fdReporttoUnitGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("group")-1)+";";
						}else{
							fdMissiveReporttoIds += idsArray[i]+";";
						}
					}
				}
				fdMissiveReporttoIds = fdMissiveReporttoIds.substring(0,fdMissiveReporttoIds.length-1);
				fdMissiveReporttoGroupIds = fdMissiveReporttoGroupIds.substring(0,fdMissiveReporttoGroupIds.length-1);
				fdReporttoUnitGroupIds = fdReporttoUnitGroupIds.substring(0,fdReporttoUnitGroupIds.length-1);
			}
			document.getElementsByName("fdMissiveReporttoIds")[0].value = fdMissiveReporttoIds;
			document.getElementsByName("fdMissiveReporttoGroupIds")[0].value=fdMissiveReporttoGroupIds;
			document.getElementsByName("fdReporttoUnitGroupIds")[0].value=fdReporttoUnitGroupIds;
			getAuthUnit(fdMissiveReporttoIds,fdMissiveReporttoGroupIds,"reportUnit");
		};
		
		window.checkPdf = function(value,fdMainId,type){
			var url= "";
			var isPdfConvertEnable = false;
			var isOfdConvertEnable = false;
			var existPdf = false;
			var existOfd = false;
			if('send' == type){
				url = Com_Parameter.ContextPath+"km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=checkPdf"; 
			}
			if('receive' == type){
				url = Com_Parameter.ContextPath+"km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkPdf"; 
			}
			
			req(url, {
				handleAs : 'json',
				method : 'post',
				data : { fdMainId:fdMainId }
			}).then(lang.hitch(this, function(data) {
				var results =  data;
				if(results['convertStatus'] == '-2'){
		    		 $('#optType').hide();
	    			 document.getElementsByName("fdContentType")[0].value = '1';
		    	 }else{
		    		 if(results['isWord']){
		    			 $('#optType').show();
			    		 if(results['isPdfConvertEnable']){
			    			 isPdfConvertEnable = true;
			    		 }
			    		 if(results['isOfdConvertEnable']){
			    			 isOfdConvertEnable = true;
			    		 }
			    		 if(results['existPdf']){
			    			 existPdf = true;
		    			 }
			    		 if(results['existOfd']){
			    			 existOfd = true;
		    			 }
			    		 if((!isPdfConvertEnable && !isOfdConvertEnable) || (!existPdf && !existOfd) || (!isPdfConvertEnable && !existOfd) || !isOfdConvertEnable && !existPdf){
			    			 $('#optType').hide();
				    		 document.getElementsByName("fdContentType")[0].value = '1';
			    		 }else{
			    			 if(!isPdfConvertEnable || !existPdf){
			    				 query('.muiRadioItem')[0].style.display = "none";
			    			 }
			    			 if(!isOfdConvertEnable || !existOfd){
			    				 query('.muiRadioItem')[1].style.display = "none";
			    			 }
			    		 }
			    	 }else{
			    		 query('#optType')[0].style.display = "none";
			    		 document.getElementsByName("fdContentType")[0].value = '1';
			    	 }
		    	  }
			}));
		};
		
	});
	</script>
