<%-- 主送 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdMaintoIds = parse.getParamValue("fdMaintoIds");
    String fdMaintoNames = parse.getParamValue("fdMaintoNames");
    
    String defaultFdMaintoIds = parse.acquireValue("fdMaintoIds",fdMaintoIds);
    String defaultFdMaintoNames = parse.acquireValue("fdMaintoNames",fdMaintoNames);
    request.setAttribute("defaultFdMaintoIds",defaultFdMaintoIds);
    request.setAttribute("defaultFdMaintoNames",defaultFdMaintoNames);
    
    
    String line = parse.getParamValue("line");
    boolean isTextArea = line!=null&&line.equals("multi")?true:false;
	parse.addStyle("width", "control_width", "95%");
%>
<input type="hidden" name="fdMissiveMaintoIds" value="${kmImissiveSendMainForm.fdMissiveMaintoIds}">
<input type="hidden" name="fdMissiveMaintoGroupIds" value="${kmImissiveSendMainForm.fdMissiveMaintoGroupIds}">
<input type="hidden" name="fdMaintoUnitGroupIds" value="${kmImissiveSendMainForm.fdMaintoUnitGroupIds}">
<c:set var="required" value="<%=required%>"></c:set>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<input type="hidden" name="fdMaintoIds" value="${kmImissiveSendMainForm.fdMaintoIds}">
    	<div id="main_ad">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_main_ad"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectMain(evt);},"idField":"fdMaintoIds_ad","nameField":"fdMaintoNames_ad","curIds":"${defaultFdMaintoIds}","curNames":"${defaultFdMaintoNames}","subject":"主送单位","title":"主送单位","showStatus":"edit","isMul":true,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=allUnit",
		   		 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=allUnit&fdKeyWord=!{keyword}",
		   		 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
    	<div id="main_s">
	    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_main_s"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectMain(evt);},"idField":"fdMaintoIds_s","nameField":"fdMaintoNames_s","curIds":"${defaultFdMaintoIds}","curNames":"${defaultFdMaintoNames}","subject":"主送单位","title":"主送单位","showStatus":"edit","isMul":false,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=report",
		   		 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=report&fdKeyWord=!{keyword}",
		   		 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<div id="main_m">
			<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_main_m"
		    	 data-dojo-props='"showAllGroup":true,"afterSelect":function(evt){afterSelectMain(evt);},"idField":"fdMaintoIds_m","nameField":"fdMaintoNames_m","curIds":"${defaultFdMaintoIds}","curNames":"${defaultFdMaintoNames}","subject":"主送单位","title":"主送单位","showStatus":"edit","isMul":true,"required":<%=required%>,
		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=true&parentId=!{parentId}&type=all",
		   		 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=all&fdKeyWord=!{keyword}",
		   		 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
		   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
			</div>
		</div>
		<input name="fdAutoDeliver" type="hidden" value="0">
		<div id="deliverDiv"></div>
		</div>
		<script>
			function changeMissiveTypeMain(value){
				if(value =="0" || value==""){
					document.getElementsByName("fdAutoDeliver")[0].value="0";
					$("#deliverDiv").html("");
					return;
				}
				if( value=="1"){
					if(document.getElementsByName("fdMaintoIds").length>0){
						if("${kmImissiveSendMainForm.method_GET}"=="add"){
							//默认自动分发
							document.getElementsByName("fdAutoDeliver")[0].value="1";
							var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" checked><bean:message key="kmImissiveSendMain.distribute.auto" bundle="km-imissive"/>';
							$("#deliverDiv").html(html);
						}else{
							document.getElementsByName("fdAutoDeliver")[0].value="${kmImissiveSendMainForm.fdAutoDeliver}";
							var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" <c:if test="${\"1\" eq kmImissiveSendMainForm.fdAutoDeliver}">checked</c:if>><bean:message key="kmImissiveSendMain.distribute.auto" bundle="km-imissive"/>';
							$("#deliverDiv").html(html);
						}
					}
					return;
				}
				if( value=="2"){
					if(document.getElementsByName("fdMaintoIds").length>0){
						if("${kmImissiveSendMainForm.method_GET}"=="add"){
							//默认自动上报
							document.getElementsByName("fdAutoDeliver")[0].value="1";
							var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" checked><bean:message key="kmImissiveSendMain.report.auto" bundle="km-imissive"/>';
							$("#deliverDiv").html(html);
						}else{
							document.getElementsByName("fdAutoDeliver")[0].value="1";
							var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" <c:if test="${\"1\" eq kmImissiveSendMainForm.fdAutoDeliver}">checked</c:if>><bean:message key="kmImissiveSendMain.report.auto" bundle="km-imissive"/>';
							$("#deliverDiv").html(html);
						}
					}
					return;
				}
			}
			function changeVal(obj){
				if(obj.checked){
					document.getElementsByName("fdAutoDeliver")[0].value="1";
				}else{
					document.getElementsByName("fdAutoDeliver")[0].value="0";
				}
			}
			function afterSelectMain(evt){
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
					fdMaintoUnitGroupIds = fdMaintoUnitGroupIds.substring(0,fdMaintoUnitGroupIds.length-1);
				}
				document.getElementsByName("fdMissiveMaintoIds")[0].value = fdMissiveMaintoIds;
				document.getElementsByName("fdMissiveMaintoGroupIds")[0].value=fdMissiveMaintoGroupIds;
				document.getElementsByName("fdMaintoUnitGroupIds")[0].value=fdMaintoUnitGroupIds;
			}
			require(['dojo/ready','dijit/registry','dojo/topic'],function(ready,registry,topic){
				ready(function(){
					 var main_s = document.getElementById("main_s");
					 var main_m = document.getElementById("main_m");
					 var main_ad = document.getElementById("main_ad");
					 
					 var fdIsAdvice = document.getElementsByName("fdIsAdvice");
		    		 var fdMissiveType = document.getElementsByName("fdMissiveType");
					 var dialog_main_s = registry.byId("dialog_main_s");
					 var dialog_main_m = registry.byId("dialog_main_m");
					 var dialog_main_ad = registry.byId("dialog_main_ad");
					 if(fdMissiveType.length > 0){
						 if(fdMissiveType[0].value == '0' || fdMissiveType[0].value == '1'){
							main_m.style.display = "block";
							main_s.style.display = "none";
							main_ad.style.display = "none";
							if("${required}" == 'true'){
								dialog_main_m._set('validate', 'required');
							}else{
								dialog_main_m._set('validate', '');
							}
							dialog_main_s._set('validate', '');
							dialog_main_ad._set('validate', '');
						}else{
							main_ad.style.display = "none";
							main_m.style.display = "none";
							main_s.style.display = "block";
							 dialog_main_m._set('validate', '');
							 if("${required}" == 'true'){
								 	dialog_main_s._set('validate', 'required');
								}else{
									dialog_main_s._set('validate', '');
								}
							 dialog_main_m._set('validate', '');
							 dialog_main_ad._set('validate', '');
						}
					 }else{
						 if(fdIsAdvice.length > 0 && fdIsAdvice[0].value == '1'){
							 main_ad.style.display = "block";
							 main_m.style.display = "none";
							 main_s.style.display = "none";
							 if("${required}" == 'true'){
								dialog_main_ad._set('validate', 'required');
							 }else{
								dialog_main_ad._set('validate', '');
							 }
							 dialog_main_s._set('validate', '');
							 dialog_main_m._set('validate', '');
				    	 }else{
				    		 main_m.style.display = "block";
							 main_s.style.display = "none";
							 main_ad.style.display = "none";
							 if("${required}" == 'true'){
								dialog_main_m._set('validate', 'required');
							 }else{
								dialog_main_m._set('validate', '');
							 }
							 dialog_main_s._set('validate', '');
							 dialog_main_ad._set('validate', '');
				    	 }
					 }
					if(fdMissiveType.length > 0){
						for(var i=0;i<fdMissiveType.length;i++){
							if(fdMissiveType[i].value){
								changeMissiveTypeMain(fdMissiveType[i].value);
							}
						}
					}else{
						changeMissiveTypeMain("");
					}
				});
				
				topic.subscribe('/mui/Category/valueChange',function(evt){
					setTimeout(function(){
						if(evt.key == 'fdMaintoIds_s' || evt.key == 'fdMaintoIds_ad' || evt.key == 'fdMaintoIds_m'){
							afterSelectMain(evt);
						}
					},1);
				});
				window.clearDialog_main_s = function(){
					var dialog_main_s = registry.byId("dialog_main_s");
					dialog_main_s.curIds = "";
					dialog_main_s.curNames = "";
					dialog_main_s.set("value","");
					dialog_main_s.buildValue(dialog_main_s.cateFieldShow);
				};
				window.clearDialog_main_ad = function(){
					var dialog_main_ad = registry.byId("dialog_main_ad");
					dialog_main_ad.curIds = "";
					dialog_main_ad.curNames = "";
					dialog_main_ad.set("value","");
					dialog_main_ad.buildValue(dialog_main_ad.cateFieldShow);
				};
				window.clearDialog_main_m = function(){
					var dialog_main_m = registry.byId("dialog_main_m");
					dialog_main_m.curIds = "";
					dialog_main_m.curNames = "";
					dialog_main_m.set("value","");
					dialog_main_m.buildValue(dialog_main_m.cateFieldShow);
				};
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					if(widget && widget.name=="fdMissiveType"){
						var main_s = document.getElementById("main_s");
						var main_ad = document.getElementById("main_ad");
					    var main_m = document.getElementById("main_m");
					    
						if(args.value == '0' || args.value == '1'){
							main_m.style.display = "block";
							main_s.style.display = "none";
							main_ad.style.display = "none";
							clearDialog_main_s();
							clearDialog_main_ad();
						}else{
							document.getElementsByName("fdMaintoIds")[0].value = "";
							document.getElementsByName("fdMissiveMaintoIds")[0].value = "";
					    	document.getElementsByName("fdMissiveMaintoGroupIds")[0].value="";
							document.getElementsByName("fdMaintoUnitGroupIds")[0].value="";
							clearDialog_main_s();
							clearDialog_main_ad();
							clearDialog_main_m();
							main_m.style.display = "none";
							main_ad.style.display = "none";
							main_s.style.display = "block";
						}
					}

					if(widget && widget.nameField=="fdSendtoUnitName"){
						var fdUnitId = widget.curIds;

						var dialog_main_s = registry.byId("dialog_main_s");
						var dialog_main_m = registry.byId("dialog_main_m");
						var dialog_main_ad = registry.byId("dialog_main_ad");

						if(dialog_main_s && dialog_main_m && dialog_main_ad){
							dialog_main_s.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_main_s.fdUnitId = fdUnitId;
							dialog_main_m.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_main_m.fdUnitId = fdUnitId;
							dialog_main_ad.decDataUrl = '/sys/common/datajson.jsp?s_bean=sysUnitMobileAuthDataWithDecBeanService&parentId=!{parentId}&type=allUnit&fdUnitId='+fdUnitId;
							dialog_main_ad.fdUnitId = fdUnitId;


							var main_s_ids = dialog_main_s.curIds;
							if(main_s_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+main_s_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_main_s._setCurIdsAttr(results['fdUnitIds']);
											dialog_main_s._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_main_s._setCurIdsAttr("");
											dialog_main_s._setCurNamesAttr("");
										}
									}
								});
							}

							var main_m_ids = dialog_main_m.curIds;
							if(main_m_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+main_m_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_main_m._setCurIdsAttr(results['fdUnitIds']);
											dialog_main_m._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_main_m._setCurIdsAttr("");
											dialog_main_m._setCurNamesAttr("");
										}
									}
								});
							}

							var main_ad_ids = dialog_main_ad.curIds;
							if(main_ad_ids){
								var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=removeDecUnit&fdUnitIds="+main_ad_ids;
								$.ajax({
									type:"post",
									url:url,
									async:true,
									success:function(data){
										var results =  eval("("+data+")");
										if(results['fdUnitIds']&&results['fdUnitNames']){
											dialog_main_ad._setCurIdsAttr(results['fdUnitIds']);
											dialog_main_ad._setCurNamesAttr(results['fdUnitNames']);
										}else{
											dialog_main_ad._setCurIdsAttr("");
											dialog_main_ad._setCurNamesAttr("");
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
    <div style="display: inline">
    <div id="_fdMainto" valField="fdMaintoIds" xform_type="dialog">
    <xform:dialog htmlElementProperties="id='mainUnit'"
    			  useNewStyle="true"
                  propertyId="fdMaintoIds"
				  textarea="<%=isTextArea%>"
	              propertyName="fdMaintoNames"
	              idValue="<%=defaultFdMaintoIds%>"
	              nameValue="<%=defaultFdMaintoNames%>"
		          style="<%=parse.getStyle()%>"
		          required="<%=required%>"
		          subject="${ lfn:message('km-imissive:table.kmImissiveMainMainto') }"> 
	</xform:dialog>
	</div>
	<input name="fdAutoDeliver" type="hidden" value="0">
	<div id="deliverDiv"></div>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		// if("${kmImissiveSendMainForm.method_GET}"=="add"){
			 var fdMissiveType = document.getElementsByName("fdMissiveType");
			 if(fdMissiveType.length > 0){
				 for(var i=0;i<fdMissiveType.length;i++){
					 if(fdMissiveType[i].checked){
						 changeMissiveTypeMain(fdMissiveType[i].value);
					 }
				 }
			 }else{
				 changeMissiveTypeMain("");
			 }
		// }
		 if("${kmImissiveSendMainForm.method_GET}"!="add" ){
			 initEditMain("${kmImissiveSendMainForm.fdMissiveType}");
    	}
	});
	
	function initEditMain(fdMissiveType){
		var ids = document.getElementsByName("fdMaintoIds")[0].value;
	   	var names = document.getElementsByName("fdMaintoNames")[0].value;
		if(fdMissiveType == '0' || fdMissiveType == ''){
			resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,mainCalBackFn);
		}else if(fdMissiveType == '1'){
			resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,ids,names,mainCalBackFn);
		}else if(fdMissiveType == '2'){
			resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,ids,names,mainCalBackFn);
		}
	}

    function changeVal(obj){
        if(obj.checked){
        	document.getElementsByName("fdAutoDeliver")[0].value="1";
        }else{
        	document.getElementsByName("fdAutoDeliver")[0].value="0";
        }
    }

  function checkMainAuth(type){
	 var url="${KMSS_Parameter_ContextPath}sys/unit/km_imissive_unit/kmImissiveUnit.do?method=checkUintAuth"; 
	 $.ajax({     
	     type:"post",     
	     url:url,     
	     data:{fdType:type,fdUintIds:"${defaultFdMaintoIds}"},   
	     async:false,    //用同步方式 
	     success:function(data){
	    	 results =  eval("("+data+")");
	     	 if("report" == type){
	     		 resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type="+type,false,"","",mainCalBackFn);
	     		 document.getElementsByName("fdMaintoIds")[0].value = "";
		     	 document.getElementsByName("fdMaintoNames")[0].value= "";
	     	 }else{
	     		 resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type="+type,true,results.fdUintIds,results.fdUintNames,mainCalBackFn);
	     		 document.getElementsByName("fdMaintoIds")[0].value = results.fdUintIds;
		     	 document.getElementsByName("fdMaintoNames")[0].value= results.fdUintNames;
	     	  }
	     	 mainCalBackFn();
		 }    
	  });
  }
    
    function changeMissiveTypeMain(value){
    	var fdMissiveType = document.getElementsByName("fdMissiveType");
        //切换类型的时候清空单位，避免权限问题
        //做空判断，避免字段为非必选
         if("${kmImissiveSendMainForm.method_GET}"=="add" ){
	    	if(document.getElementsByName("fdMaintoIds").length>0 && fdMissiveType.length>0){
		    	document.getElementsByName("fdMissiveMaintoIds")[0].value = "";
		    	document.getElementsByName("fdMissiveMaintoGroupIds")[0].value="";
				document.getElementsByName("fdMaintoUnitGroupIds")[0].value="";
	    	}
         } 
    	 if(document.getElementsByName("fdMaintoIds").length>0){
    	   $("#mainUnit").parent().parent().find(".selectitem").unbind("click"); //移除click
    	 }
    	 var fdIsAdvice = document.getElementsByName("fdIsAdvice");
   		 if(fdMissiveType.length==0){
   			 if(fdIsAdvice.length > 0 && fdIsAdvice[0].value == '1'){
	   			if(document.getElementsByName("fdMaintoIds").length>0){
	  				 resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",mainCalBackFn);
	              	  $("#mainUnit").parent().parent().find(".selectitem").click(function(){
	              		 mainSelectAllUnit('report');
	                  });
	              }
	   			return;
	    	 }else{
	    		document.getElementsByName("fdAutoDeliver")[0].value="0";
     		    if(document.getElementsByName("fdMaintoIds").length>0){
     		    	if("${kmImissiveSendMainForm.method_GET}"=="add"){
         	    		if("${defaultFdMaintoIds}"!=""){
         	    			checkMainAuth("all");
         		    	}else{
         		    		var ids = document.getElementsByName("fdMaintoIds")[0].value;
         		    	   	var names = document.getElementsByName("fdMaintoNames")[0].value;
         		    		resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,mainCalBackFn);
         		    	}
         	    	}else{
         	    		mainCalBackFn();
         	    	}
     		    	
 	    			$("#mainUnit").parent().parent().find(".selectitem").click(function(){
 	         			mainSelect('all');
 	             	});
     		    }
          		$("#deliverDiv").html("");
              	return;
	    	 } 
    	 }else{
           	 if(value =="0" || value==""){
           		document.getElementsByName("fdAutoDeliver")[0].value="0";
           		if(document.getElementsByName("fdMaintoIds").length>0){
           			if("${kmImissiveSendMainForm.method_GET}"=="add"){
        	    		if("${defaultFdMaintoIds}"!=""){
        	    			checkMainAuth("all");
        		    	}else{
        		    		var ids = document.getElementsByName("fdMaintoIds")[0].value;
        		    	   	var names = document.getElementsByName("fdMaintoNames")[0].value;
        		    		resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=all",true,ids,names,mainCalBackFn);
        		    	}
        	    	}else{
        	    		mainCalBackFn();
        	    	}
            		$("#mainUnit").parent().parent().find(".selectitem").click(function(){
            			mainSelect('all');
                	});
           		}
           		$("#deliverDiv").html("");
             	    return;
                }
               if( value=="1"){
                   if(document.getElementsByName("fdMaintoIds").length>0){
                	   if("${kmImissiveSendMainForm.method_GET}"=="add"){
           	    		if("${defaultFdMaintoIds}"!=""){
           	    			checkMainAuth("distribute");
           		    	}else{
           		    		var ids = document.getElementsByName("fdMaintoIds")[0].value;
        		    	   	var names = document.getElementsByName("fdMaintoNames")[0].value;
           		    		resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,ids,names,mainCalBackFn);
           		    	}
           	    	 //默认自动分发
                    	document.getElementsByName("fdAutoDeliver")[0].value="1";
           	    		var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" checked><bean:message key="kmImissiveSendMain.distribute.auto" bundle="km-imissive"/>';
                   	 	$("#deliverDiv").html(html);
           	    	  }else{
           	    		mainCalBackFn();
                       	 document.getElementsByName("fdAutoDeliver")[0].value="${kmImissiveSendMainForm.fdAutoDeliver}";
                       	 var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" <c:if test="${\"1\" eq kmImissiveSendMainForm.fdAutoDeliver}">checked</c:if>><bean:message key="kmImissiveSendMain.distribute.auto" bundle="km-imissive"/>';
                       	 $("#deliverDiv").html(html);
          	    	  }
	               	 $("#mainUnit").parent().parent().find(".selectitem").click(function(){
	            			mainSelect('distribute');
	                 });
                   }
              	 return;
               }
               if( value=="2"){
              	if(document.getElementsByName("fdMaintoIds").length>0){
              		if("${kmImissiveSendMainForm.method_GET}"=="add"){
           	    		if("${defaultFdMaintoIds}"!=""){
           	    			checkMainAuth("report");
           		    	}else{
           		    		resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",mainCalBackFn);
           		    	}
           		    	//默认自动上报
	           	    	 document.getElementsByName("fdAutoDeliver")[0].value="1";
	          			 var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" checked><bean:message key="kmImissiveSendMain.report.auto" bundle="km-imissive"/>';
	          			 $("#deliverDiv").html(html);
           	    	 }else{
           	    		resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",mainCalBackFn);
         	    		//mainCalBackFn();
         	    		 document.getElementsByName("fdAutoDeliver")[0].value="1";
              			 var html='<input type="checkbox" name="isAuto" onchange="changeVal(this);" <c:if test="${\"1\" eq kmImissiveSendMainForm.fdAutoDeliver}">checked</c:if>><bean:message key="kmImissiveSendMain.report.auto" bundle="km-imissive"/>';
              			 $("#deliverDiv").html(html);
         	    	 }
               	    $("#mainUnit").parent().parent().find(".selectitem").click(function(){
            			mainSelect('report');
                    });
              	 }
              	 return;
              }       
           } 
      }
    
	    function mainSelectAllUnit(){
			var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
	    	Dialog_UnitTreeList(
	    	    	true,
	    	        'fdMaintoIds',
	    	        'fdMaintoNames', 
	    	        ';', 
	    	        'kmImissiveUnitCategoryInnerTreeService&parentId=!{value}',
	    	        '<bean:message key="table.kmImissiveMainMainto" bundle="km-imissive"/>',
	    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit&fdUnitId='+fdSendtoUnitId,
	    	        mainCalBackFn,
	    	        'kmImissiveUnitListWithAuthService&type=allUnit&fdKeyWord=!{keyword}');
	    }
       
	    function mainSelect(type) {
	    	//alert("main---"+type);
			var fdSendtoUnitId = document.getElementsByName("fdSendtoUnitId")[0].value;
	    	if(type=="report"){
		    	Dialog_UnitTreeList(
	    	    	false,
	    	        'fdMaintoIds',
	    	        'fdMaintoNames', 
	    	        ';', 
	    	        'kmImissiveUnitCategoryTreeService&parentId=!{value}',
	    	        '<bean:message key="table.kmImissiveMainMainto" bundle="km-imissive"/>',
	    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report&fdUnitId='+fdSendtoUnitId,
	    	        mainCalBackFn,'kmImissiveUnitListWithAuthService&type=report&fdKeyWord=!{keyword}');
		    }else if(type=="distribute"){
		    	Dialog_UnitTreeList(
		    	    	true,
		    	        'fdMaintoIds',
		    	        'fdMaintoNames',
		    	        ';', 
		    	        'kmImissiveUnitAllCategoryTreeService&parentId=!{value}',
		    	        '<bean:message key="table.kmImissiveMainMainto" bundle="km-imissive"/>',
		    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=distribute&fdUnitId='+fdSendtoUnitId,
		    	        mainCalBackFn,'kmImissiveUnitListWithAuthService&type=distribute&fdKeyWord=!{keyword}');
			    
			}else{
				Dialog_UnitTreeList(
		    	    	true,
		    	        'fdMaintoIds',
		    	        'fdMaintoNames', 
		    	        ';', 
		    	        'kmImissiveUnitAllCategoryTreeService&parentId=!{value}',
		    	        '<bean:message key="table.kmImissiveMainMainto" bundle="km-imissive"/>',
		    	        'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=all&fdUnitId='+fdSendtoUnitId,
		    	        mainCalBackFn,
		    	        'kmImissiveUnitListWithAuthService&type=all&fdKeyWord=!{keyword}');
			    
			}
		}

	    function mainCalBackFn(){
	    	var ids = document.getElementsByName("fdMaintoIds")[0].value;
	    	var names = document.getElementsByName("fdMaintoNames")[0].value;
	    	var fdMissiveMaintoIds = "";
	    	var fdMissiveMaintoGroupIds="";
			var fdMaintoUnitGroupIds="";
	    	if(ids!=""){
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
				fdMaintoUnitGroupIds = fdMaintoUnitGroupIds.substring(0,fdMaintoUnitGroupIds.length-1);
			}
			document.getElementsByName("fdMissiveMaintoIds")[0].value = fdMissiveMaintoIds;
			document.getElementsByName("fdMissiveMaintoGroupIds")[0].value=fdMissiveMaintoGroupIds;
			document.getElementsByName("fdMaintoUnitGroupIds")[0].value=fdMaintoUnitGroupIds;
		}
    </script>
   </c:otherwise> 
 </c:choose>
    