<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
seajs.use(['lui/topic'], function(topic) {
	window.changeSign = function(fdMainId){
		var url= Com_GetCurDnsHost()+Com_Parameter.ContextPath+"km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&type=3&fdMainId="+fdMainId;
		var waitSign = document.getElementsByName("waitSignS")[0];
		var signed = document.getElementsByName("signedS")[0];
		if(waitSign.checked){
			url += "&waitSign=true";
		}
		if(signed.checked){
			url += "&signed=true ";
		}
		LUI('sign').source.setUrl(url);
		LUI('sign').source.get();
	},
	window.changeDistribute = function(fdMainId,fdRegType){
		var url= Com_GetCurDnsHost()+Com_Parameter.ContextPath+"km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&type=1&fdMainId="+fdMainId+"&fdRegType="+fdRegType;
		var waitSign = document.getElementsByName("waitSignD")[0];
		var signed = document.getElementsByName("signedD")[0];
		if(waitSign.checked){
			url += "&waitSign=true";
		}
		if(signed.checked){
			url += "&signed=true ";
		}
		LUI('distribute').source.setUrl(url);
		LUI('distribute').source.get();
	},
	window.changeReport = function(fdMainId,fdRegType){
		var url= Com_GetCurDnsHost()+Com_Parameter.ContextPath+"km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&deliver=true&type=2&fdMainId="+fdMainId+"&fdRegType="+fdRegType;
		var waitSign = document.getElementsByName("waitSignR")[0];
		var signed = document.getElementsByName("signedR")[0];
		if(waitSign.checked){
			url += "&waitSign=true";
		}
		if(signed.checked){
			url += "&signed=true ";
		}
		LUI('report').source.setUrl(url);
		LUI('report').source.get();
	},
	
	window.encodeExportHTML = function(str){ 
		return str.replace(/&/g,"&amp;")
			.replace(/</g,"&lt;")
			.replace(/>/g,"&gt;")
			.replace(/\"/g,"\"")
			.replace(/\'/g,"&#39;")
			.replace(/¹/g, "&sup1;")
			.replace(/²/g, "&sup2;")
			.replace(/³/g, "&sup3;");
	},
	
	window.openExportWindowWithPost = function(url,name,key,value,thkey,thvalue){
	    var newWindow = window.open(name);  
	    if (!newWindow) 
	        return false;  
	    var html = "";  
	    html += "<html><head></head><body><form id='formid' method='post' action='" + url + "'>";  
	    if (key && value)  
	    {  
	       html += "<input id='"+key+"' type='hidden' name='" + key + "' value='" +value+ "'/>";
	      
	    }
	    if(thkey && thvalue){
	       html += "<input id='"+thkey+"' type='hidden' name='" + thkey + "' value='" +thvalue+ "'/>";
	    }  
	    html += "</form><script type='text/javascript'>document.getElementById('formid').submit();";  
	    html += "<\/script></body></html>".toString().replace(/^.+?\*|\\(?=\/)|\*.+?$/gi, "");   
	    newWindow.document.write(html);  
	    return newWindow; 
	},
	
	window.exportResult = function(type){
		var url='${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveRegDetailList'
		window.export_load = dialog.loading();
		var json = new Array();
		var values;
		var ths = LUI.$("#"+type).find(".lui_listview_columntable_listtable").find("th");
		var thsValues=null;
		var index=0;
		LUI.$("input[name='"+type+"']:checked").each(function(j){
		 var tds = LUI.$(this).parent().parent().find("td");
		 var data = new Array();
			 for (var i = 1; i < ths.length; i++) {
				 var input=LUI.$(ths[i]).find("input[type='checkbox'][name='List_Tongle']");
				if(LUI.$(input).length==0){
					if(tds[i].innerText=='' && LUI.$(tds[i]).children("img").length>0){
						if(LUI.$(tds[i]).children("img").eq(0).attr("title")){
							data.push([ths[i].innerText,LUI.$(tds[i]).children("img").eq(0).attr("title")]);
						}else{
							data.push([ths[i].innerText,encodeExportHTML(tds[i].innerText)]);
						}
					}else{
						data.push([ths[i].innerText,encodeExportHTML(tds[i].innerText)]);
					}
				}
			}
		 json.push(["json"+j,data]);
		 index=j;
		});
		if(json.length!=0){
			for (var i = 1; i < ths.length; i++) {
			if(thsValues==null){
				thsValues=ths[i].innerText;
			}else{
				thsValues=thsValues+","+ths[i].innerText;
			}
		}
		 openExportWindowWithPost(url,"post","json",encodeURI(LUI.stringify(json)),"ths",encodeURI(thsValues));
		 	 if(window.export_load!=null){
			window.export_load.hide(); 
		}
		}else{
			 if(window.export_load!=null){
				window.export_load.hide(); 
			}
			dialog.alert("请选择要导出的数据");
			return;
		}
	},
	
	window.urgeSign = function(type){
	  var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=addUrgeSign";
	  var values = [];
		$("input[name='"+type+"']:checked").each(function(){
				values.push($(this).val());
		});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		$.post(url,$.param({"List_Selected":values},true),function(data){
			if(data.flag=="true"){
				dialog.success('催办成功');
			}else{
				if(data.msg){
					dialog.failure(data.msg);
				}else{
					dialog.failure('催办失败');
				}
			}
		},'json');
	},


	/**
	 * 批量撤回
	 * cancelType: 取消分发还是上报;  channel: 列表频道
	 */
	window.batchCancelDR = function(cancelType, channel) {
		var values = [];
		// 用于jq选择器，查找该记录是否能撤回，prefixStr：选择器内容前缀
		var prefixStr = "a.cancelFlag_"
		$("input[name='" + cancelType + "']:checked").each(function(index) {
			var itemId = $(this).val();
			var selectStr = prefixStr + itemId;
			var flagObj = $(selectStr);
			// 有撤回摁扭才将数据保存
			if (flagObj.length > 0) {
				values.push(itemId);
			}
		});
		if (values.length == 0) {
			dialog.alert('您没有选择需要操作的数据或者您选择的数据都无法撤回');
			return;
		}
		dialog.confirm("取消将回收所选登记单和对应待办，是否继续？", function(flag) {
			window.cancel_load = dialog.loading();
			$.post('<c:url value="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=cancelListDR"/>',
				$.param({"fdIds":values}, true), function(data) {
					if (window.cancel_load != null) {
						window.cancel_load.hide();
					}
					if (data != null && data.flag == "true") {
						topic.channel(channel).publish("list.refresh");
						dialog.success('撤回成功！');
					} else {
						dialog.failure('撤回失败！');
					}
				}, 'json');
		})
	},

	//value为取消的id值，channel为操作成功后刷新的列表标识，type为类型，标识是主送（抄送、抄报）
	  window.cancelDR= function(value,channel,type){
		  var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=cancelDR";
		  dialog.confirm("取消将回收该登记单和待办，是否继续？",function(flag){
		    	if(flag==true){
		    		window.del_load = dialog.loading(null,$("#trackArea"));
		    		$.post(url,$.param({"fdId":value,"fdType":type},true),function(data){
		    			if(window.del_load!=null)
							window.del_load.hide();
		    			if(data.flag=="true"){
		    				topic.channel(channel).publish("list.refresh");
		    				dialog.success('撤回成功！');
		    			}else{
		    				if(data.msg){
		    					dialog.failure(data.msg);
		    				}else{
		    					dialog.failure('撤回失败！');
		    				}
		    			}
					},'json');
		    	}else{
		    		return;
			    }
		  },"warn");  
	   },
	
	  window.opinionDetail= function(fdDetailId,fdDeliverType){
		 var url = '/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=viewByDetailId&fdDetailId='+fdDetailId+"&fdDeliverType="+fdDeliverType;
		 dialog.iframe(url,'查看详情',function(rtn){},{width:650,height:350});
	  }
});
</script>
