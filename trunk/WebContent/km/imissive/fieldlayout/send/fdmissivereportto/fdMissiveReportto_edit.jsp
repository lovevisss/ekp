<%-- 抄报 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdReporttoIds = parse.getParamValue("fdReporttoIds");
    String fdReporttoNames = parse.getParamValue("fdReporttoNames");
    
    String defaultFdReporttoIds = parse.acquireValue("fdReporttoIds",fdReporttoIds);
    String defaultFdReporttoNames = parse.acquireValue("fdReporttoNames",fdReporttoNames);
    request.setAttribute("defaultFdReporttoIds",defaultFdReporttoIds);
    request.setAttribute("defaultFdReporttoNames",defaultFdReporttoNames);
    
    String line = parse.getParamValue("line");
    boolean isTextArea = line!=null&&line.equals("multi")?true:false;
	parse.addStyle("width", "control_width", "95%");
%>	
	<input type="hidden" name="fdMissiveReporttoIds" value="${kmImissiveSendMainForm.fdMissiveReporttoIds}">
    <input type="hidden" name="fdMissiveReporttoGroupIds" value="${kmImissiveSendMainForm.fdMissiveReporttoGroupIds}">
	<input type="hidden" name="fdReporttoUnitGroupIds" value="${kmImissiveSendMainForm.fdReporttoUnitGroupIds}">
	<c:set var="required" value="<%=required%>"></c:set>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
   		 <input type="hidden" name="fdReporttoIds" value="${kmImissiveSendMainForm.fdReporttoIds}">
   		<div id="report_ad">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_report_ad"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectReport(evt);},"idField":"fdReporttoIds_ad","nameField":"fdReporttoNames_ad","curIds":"${defaultFdReporttoIds}","curNames":"${defaultFdReporttoNames}","subject":"抄报单位","title":"抄报单位","showStatus":"edit","isMul":true,"validate":"required","required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=allUnit",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=allUnit&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<div id="report_s">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_report_s"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectReport(evt);},"idField":"fdReporttoIds_s","nameField":"fdReporttoNames_s","curIds":"${defaultFdReporttoIds}","curNames":"${defaultFdReporttoNames}","subject":"抄报单位","title":"抄报单位","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=report",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=report&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<div id="report_m">
			<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_report_m"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectReport(evt);},"idField":"fdReporttoIds_m","nameField":"fdReporttoNames_m","curIds":"${defaultFdReporttoIds}","curNames":"${defaultFdReporttoNames}","subject":"抄报单位","title":"抄报单位","showStatus":"edit","isMul":true,"validate":"required","required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=true&parentId=!{parentId}&type=all",
		   		   "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<script>
			function afterSelectReport(evt){
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
					fdReporttoUnitGroupIds = fdReporttoUnitGroupIds.substring(0,fdReporttoUnitGroupIds.length-1);
				}
				document.getElementsByName("fdMissiveReporttoIds")[0].value = fdMissiveReporttoIds;
				document.getElementsByName("fdMissiveReporttoGroupIds")[0].value=fdMissiveReporttoGroupIds;
				document.getElementsByName("fdReporttoUnitGroupIds")[0].value=fdReporttoUnitGroupIds;
			}
			require(['dojo/ready','dijit/registry','dojo/topic'],function(ready,registry,topic){
				ready(function(){
					var report_s = document.getElementById("report_s");
				    var report_m = document.getElementById("report_m");
				    var report_ad = document.getElementById("report_ad");
				    
				    var fdIsAdvice = document.getElementsByName("fdIsAdvice");
					 var fdMissiveType = document.getElementsByName("fdMissiveType");
					 var dialog_report_s = registry.byId("dialog_report_s");
					 var dialog_report_m = registry.byId("dialog_report_m");
					 var dialog_report_ad = registry.byId("dialog_report_ad");
					 if(fdMissiveType.length > 0){
						 if(fdMissiveType[0].value == '0' || fdMissiveType[0].value == '1'){
							report_m.style.display = "block";
							report_s.style.display = "none";
							report_ad.style.display = "none";
							if("${required}" == 'true'){
								dialog_report_m._set('validate', 'required');
							}else{
								dialog_report_m._set('validate', '');
							}
							 dialog_report_s._set('validate', '');
							 dialog_report_ad._set('validate', '');
						}else{
							report_ad.style.display = "none";
							report_m.style.display = "none";
							report_s.style.display = "block";
							 dialog_report_m._set('validate', '');
							 if("${required}" == 'true'){
								 dialog_report_s._set('validate', 'required');
							 }else{
								 dialog_report_s._set('validate', '');
							 }
							 dialog_report_m._set('validate', '');
							 dialog_report_ad._set('validate', '');
						}
					 }else{
						 if(fdIsAdvice.length > 0 && fdIsAdvice[0].value == '1'){
							 report_ad.style.display = "block";
							 report_m.style.display = "none";
							 report_s.style.display = "none";
							 if("${required}" == 'true'){
								dialog_report_ad._set('validate', 'required');
							 }else{
								dialog_report_ad._set('validate', '');
							 }
							 dialog_report_s._set('validate', '');
							 dialog_report_m._set('validate', '');
				    	 }else{
				    		 report_m.style.display = "block";
							 report_s.style.display = "none";
							 report_ad.style.display = "none";
							 if("${required}" == 'true'){
								dialog_report_m._set('validate', 'required');
							 }else{
								dialog_report_m._set('validate', '');
							 }
							 dialog_report_s._set('validate', '');
							 dialog_report_ad._set('validate', '');
				    	 }
					 }
				});
				topic.subscribe('/mui/Category/valueChange',function(evt){
					setTimeout(function(){
						if(evt.key == 'fdReporttoIds_s' || evt.key == 'fdReporttoIds_ad' || evt.key == 'fdReporttoIds_m'){
							afterSelectReport(evt);
						}
					},1);
				});
				window.clearDialog_report_s = function(){
					var dialog_report_s = registry.byId("dialog_report_s");
					dialog_report_s.curIds = "";
					dialog_report_s.curNames = "";
					dialog_report_s.set("value","");
					dialog_report_s.buildValue(dialog_report_s.cateFieldShow);
				};
				
				window.clearDialog_report_ad = function(){
					var dialog_report_ad = registry.byId("dialog_report_ad");
					dialog_report_ad.curIds = "";
					dialog_report_ad.curNames = "";
					dialog_report_ad.set("value","");
					dialog_report_ad.buildValue(dialog_report_ad.cateFieldShow);
				};
				window.clearDialog_report_m = function(){
					var dialog_report_m = registry.byId("dialog_report_m");
					dialog_report_m.curIds = "";
					dialog_report_m.curNames = "";
					dialog_report_m.set("value","");
					dialog_report_m.buildValue(dialog_report_m.cateFieldShow);
				};
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					if(widget && widget.name=="fdMissiveType"){
						var report_s = document.getElementById("report_s");
					    var report_m = document.getElementById("report_m");
					    var report_ad = document.getElementById("report_ad");
						if(args.value == '0' || args.value == '1'){
							report_m.style.display = "block";
							report_s.style.display = "none";
							report_ad.style.display = "none";
							clearDialog_report_s();
							clearDialog_report_ad();
						}else{
							document.getElementsByName("fdReporttoIds")[0].value = "";
							document.getElementsByName("fdMissiveReporttoIds")[0].value = "";
					    	document.getElementsByName("fdMissiveReporttoGroupIds")[0].value="";
							document.getElementsByName("fdReporttoUnitGroupIds")[0].value="";
							clearDialog_report_s();
							clearDialog_report_m();
							clearDialog_report_ad();
							report_m.style.display = "none";
							report_ad.style.display = "none";
							report_s.style.display = "block";
						}
					}


					if(widget && widget.nameField=="fdSendtoUnitName"){
						var fdUnitId = widget.curIds;

						var dialog_report_s = registry.byId("dialog_report_s");
						var dialog_report_ad = registry.byId("dialog_report_ad");
						var dialog_report_m = registry.byId("dialog_report_m");

						if(dialog_report_s && dialog_report_ad && dialog_report_m){
							dialog_report_s.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_report_s.fdUnitId = fdUnitId;
							dialog_report_ad.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_report_ad.fdUnitId = fdUnitId;
							dialog_report_m.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_report_m.fdUnitId = fdUnitId;

							var report_s_ids = dialog_report_s.curIds;
							if(report_s_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+report_s_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_report_s._setCurIdsAttr(results['fdUnitIds']);
											dialog_report_s._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_report_s._setCurIdsAttr("");
											dialog_report_s._setCurNamesAttr("");
										}
									}
								});
							}

							var report_m_ids = dialog_report_m.curIds;
							if(report_m_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+report_m_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_report_m._setCurIdsAttr(results['fdUnitIds']);
											dialog_report_m._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_report_m._setCurIdsAttr("");
											dialog_report_m._setCurNamesAttr("");
										}
									}
								});
							}

							var report_ad_ids = dialog_report_ad.curIds;
							if(report_ad_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+report_ad_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_report_ad._setCurIdsAttr(results['fdUnitIds']);
											dialog_report_ad._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_report_ad._setCurIdsAttr("");
											dialog_report_ad._setCurNamesAttr("");
										}
									}
								});
							}
						}


					}

				});
			});
		</script>
    </c:when>
    <c:otherwise>
    <div id="_fdReportto" valField="fdReporttoIds" xform_type="dialog">
	<xform:dialog htmlElementProperties="id='reportUnit'" 
	 			  useNewStyle="true"
	              propertyId="fdReporttoIds"
	              propertyName="fdReporttoNames"
	              idValue="<%=defaultFdReporttoIds%>"
	              textarea="<%=isTextArea%>"
	              nameValue="<%=defaultFdReporttoNames%>"
		          style="<%=parse.getStyle()%>" 
		          required="<%=required%>"
		          subject="${ lfn:message('km-imissive:table.kmImissiveReportto') }">  
	</xform:dialog>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	// if("${kmImissiveSendMainForm.method_GET}"=="add"){
		 var fdMissiveType = document.getElementsByName("fdMissiveType");
		 if(fdMissiveType.length > 0){
			 for(var i=0;i<fdMissiveType.length;i++){
				 if(fdMissiveType[i].checked){
					 changeMissiveTypeReport(fdMissiveType[i].value);
				 }
			 }
		 }else{
			 changeMissiveTypeReport("");
		 }
	// }
	
	 if("${kmImissiveSendMainForm.method_GET}"!="add" ){
		 initEditReport("${kmImissiveSendMainForm.fdMissiveType}");
	  }
});

	function initEditReport(fdMissiveType){
		var ids = document.getElementsByName("fdReporttoIds")[0].value;
	    var names = document.getElementsByName("fdReporttoNames")[0].value;
   		if(fdMissiveType == '0' || fdMissiveType == ''){
   			resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,reportCalBackFn);
   		}else if(fdMissiveType == '1'){
   			resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,ids,names,reportCalBackFn);
   		}else if(fdMissiveType == '2'){
   			resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,ids,names,reportCalBackFn);
   		}
	}
	
	function checkReportAuth(type){
	  var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=checkUintAuth"; 
	 $.ajax({     
	     type:"post",     
	     url:url,     
	     data:{fdType:type,fdUintIds:"${defaultFdReporttoIds}"},  
	     async:false,    //用同步方式 
	     success:function(data){
	    	 results =  eval("("+data+")");
	    	 if("report" == type){
	     		 resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type="+type,false,"","",reportCalBackFn);
	     		 document.getElementsByName("fdReporttoIds")[0].value = "";
		     	 document.getElementsByName("fdReporttoNames")[0].value= "";
	     	 }else{
	     		 resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type="+type,true,results.fdUintIds,results.fdUintNames,reportCalBackFn);
	     		 document.getElementsByName("fdReporttoIds")[0].value = results.fdUintIds;
		     	 document.getElementsByName("fdReporttoNames")[0].value= results.fdUintNames;
	     	  }
	    	 reportCalBackFn();
		  }    
	   });
	}
	
	function changeMissiveTypeReport(value){
    	var fdMissiveType = document.getElementsByName("fdMissiveType");
        //切换类型的时候清空单位，避免权限问题
        //做空判断，避免字段为非必选
        if("${kmImissiveSendMainForm.method_GET}"=="add" ){
	    	//做空判断，避免字段为非必选
	    	if(document.getElementsByName("fdReporttoIds").length>0 && fdMissiveType.length>0){
		    	document.getElementsByName("fdMissiveReporttoIds")[0].value = "";
		    	document.getElementsByName("fdMissiveReporttoGroupIds")[0].value="";
				document.getElementsByName("fdReporttoUnitGroupIds")[0].value="";
	    	}
        }
     	if(document.getElementsByName("fdReporttoIds").length>0){
    	  $("#reportUnit").parent().parent().find(".selectitem").unbind("click"); //移除click
     	}
     	 var fdIsAdvice = document.getElementsByName("fdIsAdvice");
    	 if(fdMissiveType.length==0){
    		 if(fdIsAdvice.length > 0 && fdIsAdvice[0].value == '1'){
   	   			if(document.getElementsByName("fdReporttoIds").length>0){
   	  				 resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",reportCalBackFn);
   	              	  $("#reportUnit").parent().parent().find(".selectitem").click(function(){
   	              		reportSelectAllUnit('report');
   	                  });
   	              }
   	   			return;
   	    	 }else{
   	    		//抄报非必选字典，做空判断
   	           	if(document.getElementsByName("fdReporttoIds").length>0){
   	           		if("${kmImissiveSendMainForm.method_GET}"=="add"){
   	       	    		if("${defaultFdReporttoIds}"!=""){
   	       	    			checkReportAuth("all");
   	       		    	}else{
   	       		    		var ids = document.getElementsByName("fdReporttoIds")[0].value;
   	       		 	     	var names = document.getElementsByName("fdReporttoNames")[0].value;
   	       		 	   		 resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,reportCalBackFn);
   	       		    	}
   	       	    	 }else{
   	       	    		reportCalBackFn();
   	       	    	 }
   	         		$("#reportUnit").parent().parent().find(".selectitem").click(function(){
   	         			reportSelect('all');
   	             	});
   	           	}
   	            return;
   	    	 }
    	 }else{
           	 if(value =="0" || value==""){
           		//抄报非必选字典，做空判断
              	if(document.getElementsByName("fdReporttoIds").length>0){
              		if("${kmImissiveSendMainForm.method_GET}"=="add"){
           	    		if("${defaultFdReporttoIds}"!=""){
           	    			checkReportAuth("all");
           		    	}else{
           		    		var ids = document.getElementsByName("fdReporttoIds")[0].value;
           		 	    	var names = document.getElementsByName("fdReporttoNames")[0].value;
           		 	   		 resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,reportCalBackFn);
           		    	}
           	    	 }else{
           	    		reportCalBackFn();
           	    	 }
            		$("#reportUnit").parent().parent().find(".selectitem").click(function(){
            			reportSelect('all');
                	});
              	}
             	    return;
             }
              if( value=="1"){
              	//抄报非必选字典，做空判断
               	if(document.getElementsByName("fdReporttoIds").length>0){
               		if("${kmImissiveSendMainForm.method_GET}"=="add"){
           	    		if("${defaultFdReporttoIds}"!=""){
           	    			checkReportAuth("distribute");
           		    	}else{
           		    		var ids = document.getElementsByName("fdReporttoIds")[0].value;
           		 	    	var names = document.getElementsByName("fdReporttoNames")[0].value;
           		 	   	    resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,ids,names,reportCalBackFn);
           		    	}
           	    	 }else{
           	    		reportCalBackFn();
           	    	 }
               	    $("#reportUnit").parent().parent().find(".selectitem").click(function(){
               		 reportSelect('distribute');
                 	});
               	}
              	 return;
              }
              if( value=="2"){
              	//抄报非必选字典，做空判断
               	if(document.getElementsByName("fdReporttoIds").length>0){
                 	if("${kmImissiveSendMainForm.method_GET}"=="add"){
           	    		if("${defaultFdReporttoIds}"!=""){
           	    			checkReportAuth("report");
           		    	}else{
           		    		resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",reportCalBackFn);
           		    	}
           	    	 }else{
           	    		resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",reportCalBackFn);
           	    		//reportCalBackFn();
           	    	 }
                 	
                 	$("#reportUnit").parent().parent().find(".selectitem").click(function(){
               		 reportSelect('report');
                 	});
               	}
              	 return;
              }
           } 
        }
	
	function reportSelectAllUnit(){
		var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
	 	Dialog_UnitTreeList(
	 	    	true,
	 	        'fdReporttoIds',
	 	        'fdReporttoNames', 
	 	        ';', 
	 	        'kmImissiveUnitCategoryInnerTreeService&parentId=!{value}',
	 	        '<bean:message key="table.kmImissiveMainMainto" bundle="km-imissive"/>',
	 	        'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit&fdUnitId='+fdSendtoUnitId,
	 	        reportCalBackFn,
	 	        'kmImissiveUnitListWithAuthService&type=allUnit&fdKeyWord=!{keyword}');
	 }
 
	
	
	 function reportSelect(type) {
		 var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
		    if(type=="report"){
		    	Dialog_UnitTreeList(
	    	    	false,
	    	        'fdReporttoIds',
	    	        'fdReporttoNames', 
	    	        ';', 
	    	        'kmImissiveUnitCategoryTreeService&parentId=!{value}',
	    	        '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>',
	    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report&fdUnitId='+fdSendtoUnitId,
	    	        reportCalBackFn,'kmImissiveUnitListWithAuthService&type=report&fdKeyWord=!{keyword}');
		    }else if(type=="distribute"){
		    	Dialog_UnitTreeList(
		    	    	true,
		    	        'fdReporttoIds',
		    	        'fdReporttoNames', 
		    	        ';', 
		    	        'kmImissiveUnitAllCategoryTreeService&parentId=!{value}',
		    	        '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>',
		    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=distribute&fdUnitId='+fdSendtoUnitId,
		    	        reportCalBackFn,'kmImissiveUnitListWithAuthService&type=distribute&fdKeyWord=!{keyword}');
			    
			}else{
				Dialog_UnitTreeList(
		    	    	true,
		    	        'fdReporttoIds',
		    	        'fdReporttoNames',
		    	        ';', 
		    	        'kmImissiveUnitAllCategoryTreeService&parentId=!{value}',
		    	        '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>',
		    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=all&fdUnitId='+fdSendtoUnitId,
		    	        reportCalBackFn,'kmImissiveUnitListWithAuthService&type=all&fdKeyWord=!{keyword}');
			    
			}
		}
		function reportCalBackFn(){
			var ids = document.getElementsByName("fdReporttoIds")[0].value;
			var fdMissiveReporttoIds = "";
			var fdMissiveReporttoGroupIds="";
			var fdReporttoUnitGroupIds="";
			if(ids!=""){
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
				fdReporttoUnitGroupIds = fdReporttoUnitGroupIds.substring(0,fdReporttoUnitGroupIds.length-1);
			}
			document.getElementsByName("fdMissiveReporttoIds")[0].value = fdMissiveReporttoIds;
			document.getElementsByName("fdMissiveReporttoGroupIds")[0].value=fdMissiveReporttoGroupIds;
			document.getElementsByName("fdReporttoUnitGroupIds")[0].value=fdReporttoUnitGroupIds;
		}
	</script>
	 </c:otherwise>
</c:choose>
	
