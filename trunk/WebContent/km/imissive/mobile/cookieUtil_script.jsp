<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util","mui/device/device" ,'dojo/date/locale'],
			function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util,device,locale){
		
		window.getNumberRule= function(str){
			var rtnNum = str;
			if(str){
				var arr = str.split("#");
				if(arr.length>0){
				    rtnNum = arr[0];
				}
			}
			return rtnNum;
		}
	
		window.getFlowNum= function(str){
			var rtnNum = str;
			if(str){
				var arr = str.split("#");
				if(arr.length>1){
				    rtnNum = arr[1];
				}
			}
			return rtnNum;
		}
		window.getNumberMainId= function(str){
			var rtnNum = str;
			if(str){
				var arr = str.split("#");
				if(arr.length>2){
				    rtnNum = arr[2];
				}
			}
			return rtnNum;
		}
	
	
		window.formatNum= function(str,fdFlowNo){
			var rtnNum = str;
			if(str!=""){
			    rtnNum = str.replace(new RegExp("@flow@",'g'),fdFlowNo);
			}
			return rtnNum;
		}
	
	
		window.getTempNumberFromDb= function(fdNumberId,fdModelName){
			return req(util.formatUrl("/km/imissive/km_imissive_number/kmImissiveNumber.do?method=getTempNumFromDb"), {
				method : 'post',
				data:{fdNumberId:fdNumberId,fdModelId:"${JsParam.fdId}",fdModelName:fdModelName}
			});
		}
	
		window.delTempNumFromDb= function(fdNumberId,docBufferNum){
			var flag = false;
			var docNum = "";
			req(util.formatUrl("/km/imissive/km_imissive_number/kmImissiveNumber.do?method=delTempNumFromDb"), {
				method : 'post',
				data:{fdNumberId:fdNumberId,docBufferNum:docBufferNum}
			}).then(lang.hitch(this, function(data) {
			 	flag = true;
			}));
			return flag;
		}
	
		var count = 0 ;
		window.showEle= function(fdNoRule,fdFlowNo){
			if(fdNoRule!=""){
				count = 0;
				var ruleArr = fdNoRule.split("@");
				query('#numberEle').html("");
				var row = "";
				for(var i = 0;i<ruleArr.length;i++){
					count += 1;
					if(ruleArr[i]!=""){
						if(ruleArr[i]!='flow'){
							 row += '<div style="width:98%;margin-bottom:10px;"><input type="text" class="muiInput" style="width:100%;line-height:30px" name="ele'+i+'" onchange="changeNum();" value="'+ruleArr[i]+'"/></div>';
						}else{
							 row += '<div style="width:98%;margin-bottom:10px;"><input type="text" class="muiInput"  style="width:100%;line-height:30px" name="flow'+i+'" onchange="changeNum();" value="'+fdFlowNo+'"/></div>';
						}
					}
				}
				query('#numberEle').html(row);
				changeNum();
			}
		}
		window.changeNum= function(){
			var fdDocNum="";
			var fdNoRule="";
			var fdFlowNo="";
			for(var i=0;i<count;i++){
				var a = "ele"+i;
				var ele = document.getElementsByName(a);
				if(ele.length>0){
					fdDocNum +=ele[0].value;
					fdNoRule +=ele[0].value;
				}
				if(ele.length==0){
				 	a = "flow"+i;
					ele = document.getElementsByName(a);
					if(ele.length>0){
						fdDocNum +=ele[0].value;
						fdNoRule +="@flow@";
					}
				}
			}
			document.getElementsByName("fdNum")[0].value = fdDocNum;
			if(document.getElementsByName("flow1")[0]){ //多个流水号元素，只取第一个
				document.getElementsByName("fdRtnNum")[0].value = fdNoRule+"#"+document.getElementsByName("flow1")[0].value+"#"+fdNumberMainId;
			}else{
				document.getElementsByName("fdRtnNum")[0].value = fdNoRule+"#"+" "+"#"+fdNumberMainId;
			}
		}
	});
</script>
