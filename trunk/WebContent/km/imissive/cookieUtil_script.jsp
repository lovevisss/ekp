<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
function getValueFromCookie(key){
	var strCookie=document.cookie; 
	//console.log(strCookie);
	var value; 
	if(strCookie){
		var arrCookie=strCookie.split("; ");
		for(var i=0;i<arrCookie.length;i++){ 
		  var arr=arrCookie[i].split("=");
			if(key==arr[0]){
			   value=arr[1];
			   break;
		  } 
	   }
	}
 return value;
}
function getValueFromParentCookie(key){
	var strCookie=parent.document.cookie; 
	//console.log(strCookie);
	var value; 
	if(strCookie){
		var arrCookie=strCookie.split("; ");
		for(var i=0;i<arrCookie.length;i++){ 
		  var arr=arrCookie[i].split("=");
			if(key==arr[0]){
			   value=arr[1];
			   break;
		  } 
	   }
	}
 	return value;
}
function delCookie(){
    var exp = new Date(); 
    exp.setTime(exp.getTime()-1);
    var strCookie=document.cookie; 
    if(strCookie){
    	var arrCookie=strCookie.split(";"); 
        for(var i=0;i<arrCookie.length;i++){ 
      	  var arr=arrCookie[i].split("="); 
      	  var cval=getValueFromCookie(arr[0]); 
          if(cval!=null)
           document.cookie= (arr[0] + "="+cval+";expires="+exp.toGMTString()); 
       }
    }
}  
function delCookieByName(name){
    var exp = new Date(); 
    exp.setTime(exp.getTime()-1);
	var cval=getValueFromCookie(name); 
    if(cval!=null)
       document.cookie= (name + "="+cval+";expires="+exp.toGMTString()); 
}

function getNumberRule(str){
	var rtnNum = str;
	if(str){
		var arr = str.split("#");
		if(arr.length>0){
		    rtnNum = arr[0];
		}
	}
	return rtnNum;
}

function getFlowNum(str){
	var rtnNum = str;
	if(str){
		var arr = str.split("#");
		if(arr.length>1){
		    rtnNum = arr[1];
		}
	}
	return rtnNum;
}
function getNumberMainId(str){
	var rtnNum = str;
	if(str){
		var arr = str.split("#");
		if(arr.length>2){
		    rtnNum = arr[2];
		}
	}
	return rtnNum;
}


function formatNum(str,fdFlowNo){
	var rtnNum = str;
	//var arr = str.split("#");
	if(str!=""){
	    rtnNum = str.replace(new RegExp("@flow@",'g'),fdFlowNo);
	}
	return rtnNum;
}


function getTempNumberFromDb(fdNumberId,fdModelName){
	var docNum = "";
	var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_number/kmImissiveNumber.do?method=getTempNumFromDb"; 
	 $.ajax({     
	     type:"post",    
	     url:url,   
	     data:{fdNumberId:fdNumberId,fdModelId:"${JsParam.fdId}",fdModelName:fdModelName},
	     async:false,    //用同步方式 
	     success:function(data){
	 	    var results =  eval("("+data+")");
		    if(results['docNum']!=null){
		    	docNum = results['docNum'];
			}
		}   
   });
	 return  docNum;
}

function delTempNumFromDb(fdNumberId,docBufferNum){
	var flag = false;
	var docNum = "";
	var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_number/kmImissiveNumber.do?method=delTempNumFromDb"; 
	 $.ajax({     
	     type:"post",    
	     url:url,   
	     data:{fdNumberId:fdNumberId,docBufferNum:docBufferNum},
	     async:false,    //用同步方式 
	     success:function(data){
	    	flag = true;
		}   
   });
	 return flag;
}

var count = 0 ;
function showEle(fdNoRule,fdFlowNo){
	if(fdNoRule!=""){
		//var arr = docNoStr.split("#");
		//var fdNoRule = "";
		//if(arr.length>1){
		count = 0;
		//fdNoRule = arr[0];
		var ruleArr = fdNoRule.split("@");
		$('#numberEle').html("");
		var row = "";
		for(var i = 0;i<ruleArr.length;i++){
			count += 1;
			if(ruleArr[i]!=""){
				if(ruleArr[i]!='flow'){
					 row += '<div style="float:left;width:30%;margin-left:15px;"><input type="text" class="inputsgl" style="width:100%" name="ele'+i+'" onchange="changeNum();" value="'+ruleArr[i]+'"/></div>';
				}else{
					 row += '<div style="float:left;width:30%;margin-left:15px;"><input type="text" class="inputsgl"  style="width:100%" name="flow'+i+'" onchange="changeNum();" value="'+fdFlowNo+'"/></div>';
				}
			}
		}
		$('#numberEle').html(row);
		$('#numberEle').css({
			"padding-top":"25px",
		    "height":"35px"
		});
		changeNum();
		//}
	}
}
function changeNum(){
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

function getHost() {
	var host = location.protocol.toLowerCase() + "//" + location.hostname;
	if (location.port != '' && location.port != '80') {
		host = host + ":" + location.port;
	}
	return host;
}
function addAuditShowInfo(bookmarks,attachmentObject,fdModelId,extendFilePath){
	var auditShowArr = [];
	var url = getHost() + Com_Parameter.ContextPath + "sys/print/word/file";
	for(var i = 1 ;i <= bookmarks.Count;i++){
		var bookmarkRecord = {};
		var bookmarkObj = bookmarks.Item(i);
		var markName = bookmarkObj.Name;
		if(markName.indexOf('_auditShow') > -1){
			bookmarkRecord.name = markName;
			bookmarkRecord.bookmarkObj = bookmarkObj;
			auditShowArr.push(bookmarkRecord);
		}
	}
	if(auditShowArr.length>0){
		var editType = attachmentObject.ocxObj.EditType;
		//插入审批意见文档必须可编辑
		attachmentObject.ocxObj.EditType = "1,1";
		
		for(var idx = 0;idx<auditShowArr.length;idx++){
			var fdId = auditShowArr[idx].name.replace('_auditShow','');
			var queryStr = "/" + fdId + "/" + fdModelId + "/" + extendFilePath;
			var bookmarkObj = auditShowArr[idx].bookmarkObj;
				bookmarkObj.Range.insertFile(url + queryStr);
		}
		if(editType){
			//重新设置文档原来的编辑状态
			attachmentObject.ocxObj.EditType = editType;
		}else{
			 if(!attachmentObject.canCopy){
		    	attachmentObject.ocxObj.CopyType = "1";
		    	attachmentObject.ocxObj.EditType = "0,1";
			}else{
				attachmentObject.ocxObj.CopyType = "1";
				attachmentObject.ocxObj.EditType = "4,1";
			}
		}
	}
}

function encodeStr(str){
	if(str){
		return str.replace(/</g,"&lt;")
			 .replace(/>/g,"&gt;")
			 .replace(/\'/g, "&#39;")
			 .replace(/\\/g, "\\\\")
			 .replace(/\n/g, "\\n")
			 .replace(/\r/g,"\\r")
			  .replace(/\t/g,"\\t")
			 .replace(/ /g, "&nbsp;");
	}
}


function clearNum(fdNumberId){
	if(delTempNumFromDb(fdNumberId,"")){
 		seajs.use(['sys/ui/js/dialog'],function(dialog) {
 			dialog.success("清除成功！");
 			$(".clearTr").remove();
 		});
 	}
}

//标志是否初始化年份
var init_year = false ;
//年份选择器
function  Year_Select(id,length){ 
	var date = new Date();
	var obj=document.getElementById(id); 
	var year;
	if(!init_year){
         year = date.getFullYear();
    }else{
    	   year = obj.value;
    	   obj.options.length = 0;
    }
    var tempYear = year;
	for(var i = 0;i<= length;i++){
		if(i==0){
		   //当前年份之前
           for(var j=1;j>0;j--){
        	  	 var before=new Option(year-j,year-j);
        	     obj.add(before);
           }
		}
		var op=new Option(year,year); 
		year++;
        obj.add(op); 
	 }
	//设置选中的值
	obj.value = tempYear;
	init_year = true;
}


</script>
