<%-- 抄送--%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdCopytoIds = parse.getParamValue("fdCopytoIds");
    String fdCopytoNames = parse.getParamValue("fdCopytoNames");
    
    String defaultFdCopytoIds = parse.acquireValue("fdCopytoIds",fdCopytoIds);
    String defaultFdCopytoNames = parse.acquireValue("fdCopytoNames",fdCopytoNames);
    request.setAttribute("defaultFdCopytoIds",defaultFdCopytoIds);
    request.setAttribute("defaultFdCopytoNames",defaultFdCopytoNames);
    
    String line = parse.getParamValue("line");
    boolean isTextArea = line!=null&&line.equals("multi")?true:false;
	parse.addStyle("width", "control_width", "95%");
%>	
	<input type="hidden" name="fdMissiveCopytoIds" value="${kmImissiveSendMainForm.fdMissiveCopytoIds}">
    <input type="hidden" name="fdMissiveCopytoGroupIds" value="${kmImissiveSendMainForm.fdMissiveCopytoGroupIds}">
	<input type="hidden" name="fdCopytoUnitGroupIds" value="${kmImissiveSendMainForm.fdCopytoUnitGroupIds}">
	<c:set var="required" value="<%=required%>"></c:set>
 <c:choose>
    <c:when test="${param.mobile eq 'true'}">
     	<input type="hidden" name="fdCopytoIds" value="${kmImissiveSendMainForm.fdCopytoIds}">
	    <div id="copy_ad">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_copy_ad"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectCopy(evt);},"idField":"fdCopytoIds_ad","nameField":"fdCopytoNames_ad","curIds":"${defaultFdCopytoIds}","curNames":"${defaultFdCopytoNames}","subject":"抄送单位","title":"抄送单位","showStatus":"edit","isMul":true,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=addUnit",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=allUnit&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
	    <div id="copy_s">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_copy_s"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectCopy(evt);},"idField":"fdCopytoIds_s","nameField":"fdCopytoNames_s","curIds":"${defaultFdCopytoIds}","curNames":"${defaultFdCopytoNames}","subject":"抄送单位","title":"抄送单位","showStatus":"edit","isMul":false,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=report",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=report&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<div id="copy_m">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_copy_m"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectCopy(evt);},"idField":"fdCopytoIds_m","nameField":"fdCopytoNames_m","curIds":"${defaultFdCopytoIds}","curNames":"${defaultFdCopytoNames}","subject":"抄送单位","title":"抄送单位","showStatus":"edit","isMul":true,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=true&parentId=!{parentId}&type=all",
		   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
		   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<script>
			function afterSelectCopy(evt){
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
					fdCopytoUnitGroupIds = fdCopytoUnitGroupIds.substring(0,fdCopytoUnitGroupIds.length-1);
				}
				document.getElementsByName("fdMissiveCopytoIds")[0].value = fdMissiveCopytoIds;
				document.getElementsByName("fdMissiveCopytoGroupIds")[0].value=fdMissiveCopytoGroupIds;
				document.getElementsByName("fdCopytoUnitGroupIds")[0].value=fdCopytoUnitGroupIds;
			}
			require(['dojo/ready','dijit/registry','dojo/topic'],function(ready,registry,topic){
				ready(function(){
					 var copy_ad = document.getElementById("copy_ad");
					 var copy_s = document.getElementById("copy_s");
					 var copy_m = document.getElementById("copy_m");
					 
					 var fdIsAdvice = document.getElementsByName("fdIsAdvice");
					 var fdMissiveType = document.getElementsByName("fdMissiveType");
					 var dialog_copy_s = registry.byId("dialog_copy_s");
					 var dialog_copy_ad = registry.byId("dialog_copy_ad");
					 var dialog_copy_m = registry.byId("dialog_copy_m");
					 if(fdMissiveType.length > 0){
						 if(fdMissiveType[0].value == '0' || fdMissiveType[0].value == '1'){
							copy_m.style.display = "block";
							copy_s.style.display = "none";
							 copy_ad.style.display = "none";
							if("${required}" == 'true'){
								 dialog_copy_m._set('validate', 'required');
							}else{
								dialog_copy_m._set('validate', '');
							}
							 dialog_copy_s._set('validate', '');
							 dialog_copy_ad._set('validate', '');
						}else{
							copy_m.style.display = "none";
							copy_s.style.display = "block";
							 copy_ad.style.display = "none";
							 dialog_copy_m._set('validate', '');
							 if("${required}" == 'true'){
								 dialog_copy_s._set('validate', 'required');
							}else{
								dialog_copy_s._set('validate', '');
							}
						   dialog_copy_m._set('validate', '');
						   dialog_copy_ad._set('validate', '');
						}
					 }else{
						 if(fdIsAdvice.length > 0 && fdIsAdvice[0].value == '1'){
							 copy_ad.style.display = "block";
							 copy_m.style.display = "none";
							 copy_s.style.display = "none";
							 if("${required}" == 'true'){
								dialog_copy_ad._set('validate', 'required');
							 }else{
								dialog_copy_ad._set('validate', '');
							 }
							 dialog_copy_s._set('validate', '');
							 dialog_copy_m._set('validate', '');
				    	 }else{
							 copy_m.style.display = "block";
							 copy_s.style.display = "none";
							 copy_ad.style.display = "none";
							 if("${required}" == 'true'){
								 dialog_copy_m._set('validate', 'required');
							 }else{
								dialog_copy_m._set('validate', '');
							 }
							 dialog_copy_s._set('validate', '');
							 dialog_copy_ad._set('validate', '');
				    	 }
					 }
				});
				
				topic.subscribe('/mui/Category/valueChange',function(evt){
					setTimeout(function(){
						if(evt.key == 'fdCopytoIds_s' || evt.key == 'fdCopytoIds_ad' || evt.key == 'fdCopytoIds_m'){
							afterSelectCopy(evt);
						}
					},1);
				});
				window.clearDialog_copy_s = function(){
					var dialog_copy_s = registry.byId("dialog_copy_s");
					dialog_copy_s.curIds = "";
					dialog_copy_s.curNames = "";
					dialog_copy_s.set("value","");
					dialog_copy_s.buildValue(dialog_copy_s.cateFieldShow);
				};
				window.clearDialog_copy_ad = function(){
					var dialog_copy_ad = registry.byId("dialog_copy_ad");
					dialog_copy_ad.curIds = "";
					dialog_copy_ad.curNames = "";
					dialog_copy_ad.set("value","");
					dialog_copy_ad.buildValue(dialog_copy_ad.cateFieldShow);
				};
				window.clearDialog_copy_m = function(){
					var dialog_copy_m = registry.byId("dialog_copy_m");
					dialog_copy_m.curIds = "";
					dialog_copy_m.curNames = "";
					dialog_copy_m.set("value","");
					dialog_copy_m.buildValue(dialog_copy_m.cateFieldShow);
				};
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					if(widget && widget.name=="fdMissiveType"){
						var copy_s = document.getElementById("copy_s");
					    var copy_m = document.getElementById("copy_m");
					    var copy_ad = document.getElementById("copy_ad");
						if(args.value == '0' || args.value == '1'){
							copy_m.style.display = "block";
							copy_s.style.display = "none";
							copy_ad.style.display = "none";
							clearDialog_copy_s();
							clearDialog_copy_ad();
						}else{
							document.getElementsByName("fdCopytoIds")[0].value = "";
							document.getElementsByName("fdMissiveCopytoIds")[0].value = "";
					    	document.getElementsByName("fdMissiveCopytoGroupIds")[0].value="";
							document.getElementsByName("fdCopytoUnitGroupIds")[0].value="";
							clearDialog_copy_s();
							clearDialog_copy_m();
							clearDialog_copy_ad();
							copy_m.style.display = "none";
							copy_ad.style.display = "none";
							copy_s.style.display = "block";
						}
					}


					if(widget && widget.nameField=="fdSendtoUnitName"){
						var fdUnitId = widget.curIds;

						var dialog_copy_s = registry.byId("dialog_copy_s");
						var dialog_copy_ad = registry.byId("dialog_copy_ad");
						var dialog_copy_m = registry.byId("dialog_copy_m");

						if(dialog_copy_s && dialog_copy_ad && dialog_copy_m){
							dialog_copy_s.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_copy_s.fdUnitId = fdUnitId;
							dialog_copy_ad.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_copy_ad.fdUnitId = fdUnitId;
							dialog_copy_m.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_copy_m.fdUnitId = fdUnitId;


							var copy_s_ids = dialog_copy_s.curIds;
							if(copy_s_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+copy_s_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_copy_s._setCurIdsAttr(results['fdUnitIds']);
											dialog_copy_s._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_copy_s._setCurIdsAttr("");
											dialog_copy_s._setCurNamesAttr("");
										}
									}
								});
							}

							var copy_m_ids = dialog_copy_m.curIds;
							if(copy_m_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+copy_m_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_copy_m._setCurIdsAttr(results['fdUnitIds']);
											dialog_copy_m._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_copy_m._setCurIdsAttr("");
											dialog_copy_m._setCurNamesAttr("");
										}
									}
								});
							}

							var copy_ad_ids = dialog_copy_ad.curIds;
							if(copy_ad_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+copy_ad_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_copy_ad._setCurIdsAttr(results['fdUnitIds']);
											dialog_copy_ad._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_copy_ad._setCurIdsAttr("");
											dialog_copy_ad._setCurNamesAttr("");
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
    <div id="_fdCopyto" valField="fdCopytoIds" xform_type="dialog">
	<xform:dialog htmlElementProperties="id='copyUnit'" 
				  useNewStyle="true"
	              propertyId="fdCopytoIds"
	              propertyName="fdCopytoNames"
	              textarea="<%=isTextArea%>"
	              idValue="<%=defaultFdCopytoIds%>"
	              nameValue="<%=defaultFdCopytoNames%>"
		          style="<%=parse.getStyle()%>" 
		          required="<%=required%>"
		          subject="${ lfn:message('km-imissive:table.kmImissiveMainCopyto') }">  
	</xform:dialog>
	</div>
 <script type="text/javascript">
 $(document).ready(function(){
	 //if("${kmImissiveSendMainForm.method_GET}"=="add"){
		 var fdMissiveType = document.getElementsByName("fdMissiveType");
		 if(fdMissiveType.length > 0){
			 for(var i=0;i<fdMissiveType.length;i++){
				 if(fdMissiveType[i].checked){
					 changeMissiveTypeCopy(fdMissiveType[i].value);
				 }
			 }
		 }else{
			 changeMissiveTypeCopy("");
		 }
	// }
	 if("${kmImissiveSendMainForm.method_GET}"!="add" ){
		 initEditCopy("${kmImissiveSendMainForm.fdMissiveType}");
   	}
});
 
 
 function initEditCopy(fdMissiveType){
	    var ids = document.getElementsByName("fdCopytoIds")[0].value;
	    var names = document.getElementsByName("fdCopytoNames")[0].value;
		if(fdMissiveType == '0' || fdMissiveType == ''){
			resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,copyCalBackFn);
		}else if(fdMissiveType == '1'){
			resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,ids,names,copyCalBackFn);
		}else if(fdMissiveType == '2'){
			resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,ids,names,copyCalBackFn);
		}
 }
 
 
 function checkCopyAuth(type){
	  var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=checkUintAuth"; 
	 $.ajax({     
	     type:"post",     
	     url:url,     
	     data:{fdType:type,fdUintIds:"${defaultFdCopytoIds}"},   
	     async:false,    //用同步方式 
	     success:function(data){
	    	 results =  eval("("+data+")");
	    	 if("report" == type){
	     		 resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type="+type,false,"","",copyCalBackFn);
	     		 document.getElementsByName("fdCopytoIds")[0].value = "";
		     	 document.getElementsByName("fdCopytoNames")[0].value= "";
	     	 }else{
	     		 resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type="+type,true,results.fdUintIds,results.fdUintNames,copyCalBackFn);
	     		 document.getElementsByName("fdCopytoIds")[0].value = results.fdUintIds;
		     	 document.getElementsByName("fdCopytoNames")[0].value= results.fdUintNames;
	     	  }
	    	 copyCalBackFn();
		 }    
	   });
	}
 
 function changeMissiveTypeCopy(value){
 	var fdMissiveType = document.getElementsByName("fdMissiveType");
     //切换类型的时候清空单位，避免权限问题
     //做空判断，避免字段为非必选
     if("${kmImissiveSendMainForm.method_GET}"=="add" ){
    	//做空判断，避免字段为非必选
	    if(document.getElementsByName("fdCopytoIds").length>0 && fdMissiveType.length>0){
			document.getElementsByName("fdMissiveCopytoIds")[0].value = "";
			document.getElementsByName("fdMissiveCopytoGroupIds")[0].value="";
			document.getElementsByName("fdCopytoUnitGroupIds")[0].value="";
	    }
     } 
 	 if(document.getElementsByName("fdCopytoIds").length>0){
 	   $("#copyUnit").parent().parent().find(".selectitem").unbind("click"); //移除click
 	 }
 	 var fdIsAdvice = document.getElementsByName("fdIsAdvice");
 	 if(fdMissiveType.length==0){
 		if(fdIsAdvice.length > 0 && fdIsAdvice[0].value == '1'){
   			if(document.getElementsByName("fdCopytoIds").length>0){
  				 resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",copyCalBackFn);
              	  $("#copyUnit").parent().parent().find(".selectitem").click(function(){
              		copySelectAllUnit('report');
                  });
              }
   			return;
    	 }else{
		    if(document.getElementsByName("fdCopytoIds").length>0){
		    	if("${kmImissiveSendMainForm.method_GET}"=="add"){
		    		if("${defaultFdCopytoIds}"!=""){
			    		checkCopyAuth("all");
			    	}else{
			    		var ids = document.getElementsByName("fdCopytoIds")[0].value;
			    	    var names = document.getElementsByName("fdCopytoNames")[0].value;
			    	    resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,copyCalBackFn);
			    	}
		    	}
		    	copyCalBackFn();
	       		$("#copyUnit").parent().parent().find(".selectitem").click(function(){
	       			copySelect('all');
	           	});
		    }
	        return;
    	}
 	 }else{
	       	if(value =="0" || value==""){
	       		 if(document.getElementsByName("fdCopytoIds").length>0){
	       			if("${kmImissiveSendMainForm.method_GET}"=="add"){
	    	    		if("${defaultFdCopytoIds}"!=""){
	    		    		checkCopyAuth("all");
	    		    	}else{
	    		    		var ids = document.getElementsByName("fdCopytoIds")[0].value;
	    		    	    var names = document.getElementsByName("fdCopytoNames")[0].value;
	    		    	    resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,copyCalBackFn);
	    		    	}
	    	    	}else{
	    	    		copyCalBackFn();
	    	    	}
	       			
	        		$("#copyUnit").parent().parent().find(".selectitem").click(function(){
	        			copySelect('all');
	            	});
	       		 }
	       	 }
           if( value=="1"){
          	 if(document.getElementsByName("fdCopytoIds").length>0){
          		if("${kmImissiveSendMainForm.method_GET}"=="add"){
    	    		if("${defaultFdCopytoIds}"!=""){
    		    		checkCopyAuth("distribute");
    		    	}else{
    		    		var ids = document.getElementsByName("fdCopytoIds")[0].value;
    		    	    var names = document.getElementsByName("fdCopytoNames")[0].value;
    		    	    resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,ids,names,copyCalBackFn);
    		    	}
    	    	}else{
    	    		copyCalBackFn();
    	    	}
           	     $("#copyUnit").parent().parent().find(".selectitem").click(function(){
           		   copySelect('distribute');
             	 });
          	 }
           }
           if( value=="2"){
          	 if(document.getElementsByName("fdCopytoIds").length>0){
          		if("${kmImissiveSendMainForm.method_GET}"=="add"){
    	    		if("${defaultFdCopytoIds}"!=""){
    		    		checkCopyAuth("report");
    		    	}else{
    		    		resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",copyCalBackFn);
    		    	}
    	    	}else{
    	    		resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",copyCalBackFn);
    	    		//copyCalBackFn();
    	    	}
           	    $("#copyUnit").parent().parent().find(".selectitem").click(function(){
           			copySelect('report');
             	});
          	 }
           }
       } 
    }
	 function copySelectAllUnit(){
		 var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
	 	Dialog_UnitTreeList(
	 	    	true,
	 	        'fdCopytoIds',
	 	        'fdCopytoNames', 
	 	        ';', 
	 	        'kmImissiveUnitCategoryInnerTreeService&parentId=!{value}',
	 	        '<bean:message key="table.kmImissiveMainMainto" bundle="km-imissive"/>',
	 	        'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit&fdUnitId='+fdSendtoUnitId,
	 	        copyCalBackFn,
	 	        'kmImissiveUnitListWithAuthService&type=allUnit&fdKeyWord=!{keyword}');
	 }
 
	 function copySelect(type) {
		 var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
		    if(type=="report"){
		    	Dialog_UnitTreeList(
	    	    	false,
	    	        'fdCopytoIds',
	    	        'fdCopytoNames', 
	    	        ';', 
	    	        'kmImissiveUnitCategoryTreeService&parentId=!{value}',
	    	        '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>',
	    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report&fdUnitId='+fdSendtoUnitId,
	    	        copyCalBackFn,'kmImissiveUnitListWithAuthService&type=report&fdKeyWord=!{keyword}');
		    }else if(type=="distribute"){
		    	Dialog_UnitTreeList(
		    	    	true,
		    	        'fdCopytoIds',
		    	        'fdCopytoNames', 
		    	        ';', 
		    	        'kmImissiveUnitAllCategoryTreeService&parentId=!{value}',
		    	        '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>',
		    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=distribute&fdUnitId='+fdSendtoUnitId,
		    	        copyCalBackFn,'kmImissiveUnitListWithAuthService&type=distribute&fdKeyWord=!{keyword}');
			    
			}else{
				Dialog_UnitTreeList(
		    	    	true,
		    	        'fdCopytoIds',
		    	        'fdCopytoNames', 
		    	        ';', 
		    	        'kmImissiveUnitAllCategoryTreeService&parentId=!{value}',
		    	        '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>',
		    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=all&fdUnitId='+fdSendtoUnitId,
		    	        copyCalBackFn,'kmImissiveUnitListWithAuthService&type=all&fdKeyWord=!{keyword}');
			}
		}

	 
	    function copyCalBackFn(){
			var ids = document.getElementsByName("fdCopytoIds")[0].value;
			var fdMissiveCopytoIds = "";
			var fdMissiveCopytoGroupIds="";
			var fdCopytoUnitGroupIds="";
			if(ids!=""){
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
				fdCopytoUnitGroupIds = fdCopytoUnitGroupIds.substring(0,fdCopytoUnitGroupIds.length-1);
			}
			document.getElementsByName("fdMissiveCopytoIds")[0].value = fdMissiveCopytoIds;
			document.getElementsByName("fdMissiveCopytoGroupIds")[0].value=fdMissiveCopytoGroupIds;
			document.getElementsByName("fdCopytoUnitGroupIds")[0].value=fdCopytoUnitGroupIds;
		}
    </script>
   </c:otherwise>
</c:choose>