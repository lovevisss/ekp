<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<script type="text/javascript">

var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.imissive.model.KmImissiveSignMain";

seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {

	//记录当前筛选器的分类（或模板）id和节点类型
	 var cateId = "";
	 var nodeType = "";
	// 监听新建更新等成功后刷新
	topic.subscribe('successReloadPage', function() {
		topic.publish('list.refresh');
	});
	
	window.expanded = function(){
		
		LUI('signCriteria').expandCriterions(!LUI('signCriteria').expand);
		
	};
	
	window.doSearchAction = function(evt){
		var topicEvent = {
				criterions :  LUI("signCriteria")._buildCriteriaSelectedValues(),
				query : []
			};
		var obj = {};
		var values = [];
		values.push(evt.searchText);
		obj.key = "docSubject";
		obj.value = values;
		topicEvent.criterions.push(obj);
        var j_path_value;
        if("${param.contentId}" == "kmImissiveSignPContent"){
            j_path_value = "/listAllPublish/sign";
        }
        if("${param.contentId}" == "kmImissiveSignCContent"){
            j_path_value = "/listCreate/sign";
        }
        if("${param.contentId}" == "kmImissiveSignFContent"){
            j_path_value = "/filing/sign";
        }
        if("${param.contentId}" == "kmImissiveSignDContent"){
            j_path_value = "/discard/sign";
        }
        if("${param.contentId}" == "kmImissiveSignContent"){
            j_path_value = "/listAll/sign";
        }
        if(j_path_value != ""){
            var obj2 = {};
            var values2 = [];
            values2.push(j_path_value);
            obj2.key = "j_path";
            obj2.value = values2;
            topicEvent.criterions.push(obj2);
        }
		topic.publish("criteria.changed", topicEvent);
	}	
	
	window.addOffLineDoc = function() {
		var url = "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=addOffLine&fdTemplateId=!{id}";
		dialog.categoryForNewFile('com.landray.kmss.km.imissive.model.KmImissiveSignTemplate',
				url, false, null, null, cateId, null, null, true); 
	};
	
	
	window.addDoc = function() {
		
	   dialog.categoryForNewFile(
				'com.landray.kmss.km.imissive.model.KmImissiveSignTemplate',
				'/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=add&fdTemplateId=!{id}',false,null,null,cateId,null,null,true); 
	};
	window.openSupervise = function(){
			var values = [];
		$("input[name='List_Selected']:checked").each(function(){
			values.push($(this).val());
		});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		if(values.length>1){
			dialog.alert('只能对单个文档进行督办！');
			return;
		}
		var url  = '${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&modelId='+values[0];
		Com_OpenWindow(url,"_blank");
	};
	//批量打印
		window.batchPrint = function(){
			var values = [];
		$("input[name='List_Selected']:checked").each(function(){
			values.push($(this).val());
		});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		if(values.length>50){
			dialog.alert('<bean:message key="kmImissive.print.hint" bundle="km-imissive"/>');
			return;
		}
		var url  = '<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=printBatch"/>'+'&fdIds='+values;
		Com_OpenWindow(url);
	};
	//删除
	window.delDoc = function(){
		var values = [];
		$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		/* dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
			if(value==true){
				window.del_load = dialog.loading();
				$.post('<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=deleteall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType,
						$.param({"List_Selected":values},true),delCallback,'json');
			}
		}); */
		var url='<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=deleteall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType;
		if(docStatus == '10'){
			var url='<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=deleteall&draft=true"/>'+'&categoryId='+cateId+'&nodeType='+nodeType;
		}
		var config = {
			url : url, // 删除数据的URL
			data : $.param({"List_Selected":values},true), // 要删除的数据
			modelName : "com.landray.kmss.km.imissive.model.KmImissiveSignMain"
		};
		// 通用删除方法
		Com_Delete(config, delCallback);
	};
	/* window.delCallback = function(data){
		if(window.del_load!=null)
			window.del_load.hide();
		if(data!=null && data.status==true){
			topic.publish("list.refresh");
			dialog.success('<bean:message key="return.optSuccess" />');
		}else{
			dialog.failure('<bean:message key="return.optFailure" />');
		}
	}; */
	window.delCallback = function(data){
		topic.publish("list.refresh");
		dialog.result(data);
	};
	//分类转移
	window.chgSelect = function() {
		var values = "";
		$("input[name='List_Selected']:checked").each(function(){
			 values += "," + $(this).val();
			});
		if(values==''){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		values = values.substring(1);
		var cfg={
				'modelName':'com.landray.kmss.km.imissive.model.KmImissiveSignTemplate',
				'mulSelect':false,
				<%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
				<% 
					if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMIMISSIVE_SIGN_OPTALL")) {
				%>
				'authType':'00',
				<%
					} else {
				%>
				'authType':'01',
				<%	
					}
				%>
				'action':function(value,____dialog){
					if(value.id){
						window.chg_load = dialog.loading();
						$.post('<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=changeTemplate"/>',
								$.param({"values":values,"fdTemplateId":value.id},true),function(data){
							if(window.chg_load!=null)
								window.chg_load.hide();
							if(data!=null && data.status==true){
								topic.publish("list.refresh");
								dialog.success('<bean:message key="return.optSuccess" />');
							}else{
								dialog.failure('<bean:message key="return.optFailure" />');
							}
						},'json');
					}
				}
			};
			dialog.category(cfg);
	};
	//归档（原有的）
	window.filingDoc = function(){
		var values = [];
		$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
		});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		dialog.confirm('<bean:message bundle="km-imissive" key="alert.msg"/>',function(value){
			if(value==true){
				window.del_load = dialog.loading();
				$.post('<c:url value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=filingall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType,
						$.param({"List_Selected":values},true),filingCallback,'json');
			}
		});
	};
	window.filingCallback = function(data){
		if(window.del_load!=null)
			window.del_load.hide();
		if(data!=null && data.status==true){
			topic.publish("list.refresh");
			dialog.success('<bean:message bundle="km-imissive" key="msg.filing.success"/>');
		}else{
			dialog.success('<bean:message bundle="km-imissive" key="msg.filing.failure"/>');
		}
	};
	
	//归档（现在的）
	window.file_doc = function() {
		var values = [];
		$("input[name='List_Selected']:checked").each(function(){
			values.push($(this).val());
		});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		var url = '${LUI_ContextPath}/sys/archives/sys_archives_file_template/sysArchivesFileTemplate.do?method=fileDocAll';
		dialog.confirm('<bean:message key="confirm.filed" bundle="sys-archives"/>',function(value){
			if(value==true){
				window.file_load = dialog.loading();
				$.ajax({
					url: url,
					type: 'POST',
					data:$.param({"List_Selected":values,
						serviceName:'kmImissiveSignMainService'},true),
					dataType: 'json',
					error: function(data){
						if(window.file_load!=null){
							window.file_load.hide(); 
						}
						dialog.result(data.responseJSON);
					},
					success: function(data){
						if(window.file_load!=null){
							window.file_load.hide(); 
						}
						topic.publish('list.refresh');
						dialog.result(data);
					}
			   });
			}
		});
	};
	
	//查看编号
	window.showNumber = function(){
		if(cateId !=null && cateId != "" && nodeType == "TEMPLATE"){
			var url = '/km/imissive/kmImissiveShowNumber.jsp?fdId='+cateId+'&type=sign';
			dialog.iframe(url,'<bean:message bundle="km-imissive" key="kmImissive.showNumber"/>',function(rtn){},{width:800,height:500});
		}else{
			dialog.alert('<bean:message bundle="km-imissive" key="kmImissive.showNumber.tips"/>');
		}
	};
	
	/******************************************
	  * 验证权限并显示按钮 
	  * param：
	  *       categoryId 模板id
	  *       nodeType 模板类型
	  *****************************************/
	var AuthCache = {};
	window.showButtons = function(cateId,nodeType){
		 if(AuthCache[cateId]){
             if(AuthCache[cateId].delBtn){
            	 if(!LUI('del')){ 
	            	 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.deleteall")}',click:'delDoc()'});
   					 LUI('Btntoolbar').addButton(delBtn);
            	 }
             }else{
            	 if(LUI('del')){ 
            	   LUI('Btntoolbar').removeButton(LUI('del'));
            	   LUI('del').destroy();
            	 }
	         }
             if(AuthCache[cateId].chgCateBtn){
            	 if(!LUI('chgCate')){ 
	            	 var chgCateBtn = toolbar.buildButton({id:'chgCate',order:'2',text:'${lfn:message("km-imissive:kmImissive.button.translate")}',click:'chgSelect()'});
   					 LUI('Btntoolbar').addButton(chgCateBtn);
            	 }
             }else{
            	 if(LUI('chgCate')){ 
            	   LUI('Btntoolbar').removeButton(LUI('chgCate'));
            	   LUI('chgCate').destroy();
            	 }
	         }
             //批量修改权限按钮
             if(AuthCache[cateId].changeRightBatchBtn){
            	 if(!LUI('docChangeRightBatch')){ 
	                 var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:'${lfn:message("sys-right:right.button.changeRightBatch")}',click:'changeRightCheckSelect("'+cateId+'","'+nodeType+'")'});
   					 LUI('Btntoolbar').addButton(changeRightBatchBtn);
            	 }
             }else{
            	 if(LUI('docChangeRightBatch')){ 
            	   LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
            	   LUI('docChangeRightBatch').destroy();
            	 }
	         }
            }
            if(AuthCache[cateId]==null){
           	 	var checkChgCateUrl = "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=changeTemplate&categoryId="+cateId+"&nodeType="+nodeType;
                 var checkDelUrl = "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=deleteall&categoryId="+cateId+"&nodeType="+nodeType;
				 var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&categoryId="+cateId+"&nodeType="+nodeType;
	             var data = new Array();
                 data.push(["delBtn",checkDelUrl]);
                 data.push(["chgCateBtn",checkChgCateUrl]);
                 data.push(["changeRightBatchBtn",changeRightBatchUrl]);
                 $.ajax({
       			  url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
       			  dataType:"json",
       			  type:"post",
       			  data:{"data":LUI.stringify(data)},
       			  async:false,
       			  success: function(rtn){
	       			var btnInfo = {};
	       			if(rtn.length > 0){
       				  for(var i=0;i<rtn.length;i++){
                 		if(rtn[i]['delBtn'] == 'true'){
                 		btnInfo.delBtn = true;
                 		 if(!LUI('del')){ 
	                 		 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.deleteall")}',click:'delDoc()'});
	    					 LUI('Btntoolbar').addButton(delBtn);
                 		 }
                       }
                 		if(rtn[i]['chgCateBtn'] == 'true'){
	                 		btnInfo.chgCateBtn = true;
	                 		 if(!LUI('chgCate')){ 
	                 			 var chgCateBtn = toolbar.buildButton({id:'chgCate',order:'2',text:'${lfn:message("km-imissive:kmImissive.button.translate")}',click:'chgSelect()'});
		    					 LUI('Btntoolbar').addButton(chgCateBtn);
	                 		 }
	                       }
                 		if(rtn[i]['changeRightBatchBtn'] == 'true'){
	                 		btnInfo.changeRightBatchBtn = true;
	                 		 if(!LUI('docChangeRightBatch')){ 
				                 var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:'${lfn:message("sys-right:right.button.changeRightBatch")}',click:'changeRightCheckSelect("'+cateId+'","'+nodeType+'")'});
		    					 LUI('Btntoolbar').addButton(changeRightBatchBtn);
	                 		 }
	                     } 
       				  }
	       			}else{
                   	   btnInfo.delBtn = false;
                   	   btnInfo.chgCateBtn = false;
                   	  if(LUI('del')){ 
                   	    LUI('Btntoolbar').removeButton(LUI('del'));
                   	    LUI('del').destroy();
                   	  }
                   	  if(LUI('chgCate')){ 
                    	    LUI('Btntoolbar').removeButton(LUI('chgCate'));
                    	    LUI('chgCate').destroy();
                      }
                   	  btnInfo.changeRightBatchBtn = false;
                   	  if(LUI('docChangeRightBatch')){ 
                   	    LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
                   	    LUI('docChangeRightBatch').destroy();
                   	  }
	                }
                 	 AuthCache[cateId] = btnInfo;
  		          }
                 });
              }
          };
          window.showFilingBtn = function(cateId,nodeType){
     			 var checkDelUrl ="/sys/archives/sys_archives_file_template/sysArchivesFileTemplate.do?method=fileDocAll&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&categoryId="+cateId+"&nodeType="+nodeType;
		 var data = new Array();
               data.push(["filingAllBtn",checkDelUrl]);
               $.ajax({
     			  url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
     			  dataType:"json",
     			  type:"post",
     			  data:{"data":LUI.stringify(data)},
     			  async:false,
     			  success: function(rtn){
     				if(rtn.length > 0){
      				  for(var i=0;i<rtn.length;i++){
                		if(rtn[i]['filingAllBtn'] == 'true'){
                		if(!LUI('filingAll')){
                 		 var filingAllBtn = toolbar.buildButton({id:'filingAll',order:'2',text:'${lfn:message("km-imissive:button.filingall")}',click:'file_doc()'});
    					 LUI('Btntoolbar').addButton(filingAllBtn);
                		}
                      }
      				 }
      			  }else{
      				removeFilingBtn();
                 }
      		  }
             });
       };
       window.removeDelBtn = function(){
		if(LUI('del')){
           	    LUI('Btntoolbar').removeButton(LUI('del'));
           	    LUI('del').destroy();
           	   }
	};
	 window.removeChgCateBtn = function(){
			if(LUI('chgCate')){
            	    LUI('Btntoolbar').removeButton(LUI('chgCate'));
            	    LUI('chgCate').destroy();
            	   }
		};
	window.removeChangeRightBatchBtn = function(){
		if(LUI('docChangeRightBatch')){
           	    LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
           	    LUI('docChangeRightBatch').destroy();
           	   }
    };
          window.removeFilingBtn = function(){
		 if(LUI('filingAll')){
            	    LUI('Btntoolbar').removeButton(LUI('filingAll'));
            	    LUI('filingAll').destroy();
            	   }
	};
	
	/*  window.removeShowNumberBtn = function(){
	   if(LUI('showNumber')){
            	    LUI('Btntoolbar').removeButton(LUI('showNumber'));
            	    LUI('showNumber').destroy();
            	   }
	}; */
	
	<%
	   request.setAttribute("admin",UserUtil.getKMSSUser().isAdmin());
	%>
	
	var docStatus = "";    //记录筛选器中状态筛选项的值
	//根据筛选器分类异步校验权限
	topic.subscribe('criteria.spa.changed',function(evt){
		if("${admin}"=="false"){
			 removeDelBtn();
			 removeChgCateBtn();
			 removeChangeRightBatchBtn();
		}
		removeFilingBtn();
		//removeShowNumberBtn();
		var hasStatus = false;  //筛选器中是否包含状态筛选项
		var hasTemp = false;    //筛选器中是否包含模板筛选项
		//筛选器变化时清空分类和节点类型的值
		cateId = "";  
		nodeType = "";
		for(var i=0;i<evt['criterions'].length;i++){
		  //获取分类id和类型
           	  if(evt['criterions'][i].key=="fdTemplate"){
               	 cateId= evt['criterions'][i].value[0];
                nodeType = evt['criterions'][i].nodeType;
                hasTemp = true;
           	  }
           	 if(evt['criterions'][i].key=="docStatus" && evt['criterions'][i].value.length==1) {
				hasStatus = true;
				docStatus = evt['criterions'][i].value[0];
		  }
		}
		if(hasTemp){
			 //分类变化或者带有分类刷新
               showButtons(cateId,nodeType);
			/*  if(nodeType == "TEMPLATE"){
				 var showNumberBtn = toolbar.buildButton({id:'showNumber',order:'5',text:'查看编号',click:'showNumber()'});
   					LUI('Btntoolbar').addButton(showNumberBtn);
			 } */
		}
		if(hasStatus){
			if(docStatus=='10') {
				if(!LUI('del')){
					var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.deleteall")}',click:'delDoc()'});
   					LUI('Btntoolbar').addButton(delBtn);
				}
			} else if(docStatus=="30"&&hasTemp){   //包含模板和状态筛选项且状态筛选项值为30
				showFilingBtn(cateId,nodeType);
           		}else{
            		removeFilingBtn();
            	}
		}
		//筛选器全部清空的情况
		if(evt['criterions'].length==0){
			 showButtons("","");
		}
	});
});
</script>
		 
	
