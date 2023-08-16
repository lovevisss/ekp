function addBookMarksByWpsAddIn(imissiveBook){
	var result = {};
	var json={};
	var fdContent = "";

	if(imissiveBook !="" && imissiveBook!=null){
		var theString = imissiveBook;
		var bookmarksStr = 'docsubject,doctype,secretgrade,emergency,content,docnum,checker,signature,drafter,drafttime,deadtime,sendunit,draftunit,draftdept,maintounit,copytounit,reporttounit,maintoperson,copytoperson,reporttoperson,signdatecn,signdaten,signdate,printnum,printpagenum,printunit,printtimen,printtime,printtimecn,level,version,secretyear,reserveone,reservetwo,reservethree,reservefour,reservefive';
		//var json = JSON.parse(theString);
		//theString = theString.replace(/[\n\r]/g,"");
		json = (new Function("return ("+theString+");"))();
		for (var o in json) {
			var objVal = json[o];
			if(objVal){
				objVal = objVal.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r").replace( "%5C",   "\\");
			}
			if(bookmarksStr.indexOf(o) == -1){
				var _fdObjE = document.getElementsByName("_extendDataFormInfo.value("+o+")");
				var fdObjE = document.getElementsByName("extendDataFormInfo.value("+o+")");
				var fdObjNameE = document.getElementsByName("extendDataFormInfo.value("+o+".name)");
				if(_fdObjE.length > 0){
					objVal = '';
					for(var i = 0 ;i<_fdObjE.length;i++){
						if(_fdObjE[i].type == 'checkbox' && _fdObjE[i].checked){
							objVal += _fdObjE[i].nextSibling.innerText+";"
						}
					}
				}else if(fdObjE.length > 0){
					objVal = '';
					if(fdObjE[0].nodeName.toLowerCase() == 'select'){
						var index=fdObjE[0].selectedIndex;
						objVal = fdObjE[0].options[index].text;
					}else if(fdObjE[0].type == 'radio'){
						for(var i = 0 ;i<fdObjE.length;i++){
							if(fdObjE[i].type == 'radio' && fdObjE[i].checked){
								objVal = fdObjE[i].nextSibling.nodeValue ? fdObjE[i].nextSibling.nodeValue:fdObjE[i].nextSibling.innerText; 
							}
						}
					}else{
						objVal = fdObjE[0].value;
					}
				}else if(fdObjNameE.length > 0){
						objVal = fdObjNameE[0].value;
						
				}
				result[o] = objVal;
			}else{
				if(o == 'content'){
					fdContent = objVal;
				}
			}
		}
	}	
	
	//文种
	var fdDocTypeNameE = document.getElementsByName("fdDocTypeId");
	var fdDocTypeName = ""
	if(fdDocTypeNameE.length > 0){
		var index=fdDocTypeNameE[0].selectedIndex;
		fdDocTypeName = fdDocTypeNameE[0].options[index].text;
	}else{
		fdDocTypeName = json['doctype'];
		if(fdDocTypeName){
			fdDocTypeName = fdDocTypeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	result['doctype'] = fdDocTypeName;
	
	//密级
	var fdSecretGradeNameE = document.getElementsByName("fdSecretGradeId");
	var fdSecretGradeName = "";
	if(fdSecretGradeNameE.length > 0 ){
		var index = fdSecretGradeNameE[0].selectedIndex;
		fdSecretGradeName = fdSecretGradeNameE[0].options[index].text;
	}else{
		fdSecretGradeName = json['secretgrade'];
		if(fdSecretGradeName){
			fdSecretGradeName = fdSecretGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['secretgrade'] = fdSecretGradeName;
	
	//缓急
	var fdEmergencyGradeNameE = document.getElementsByName("fdEmergencyGradeId");
	var fdEmergencyGradeName = "";
	if(fdEmergencyGradeNameE.length > 0 ){
		var index = fdEmergencyGradeNameE[0].selectedIndex;
		fdEmergencyGradeName = fdEmergencyGradeNameE[0].options[index].text;
	}else{
		fdEmergencyGradeName = json['emergency'];
		if(fdEmergencyGradeName){
			fdEmergencyGradeName = fdEmergencyGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['emergency'] = fdEmergencyGradeName;
	
	//标题
	var docSubjectE = document.getElementsByName("docSubject");
	var docSubject = "";
	if(docSubjectE.length > 0 && docSubjectE[0].value !=''){
		docSubject = docSubjectE[0].value;
	}else{
		docSubject =json['docsubject'];
		if(docSubject){
			docSubject = docSubject.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r").replace( "%5C",   "\\");
		}
	}
	result['docsubject'] = docSubject;
	
	//备注
	var fdContentE = document.getElementsByName("fdContent");
	if(fdContentE.length > 0 && fdContentE[0].value !=''){
		fdContent = fdContentE[0].value;
	}
	result['content'] = fdContent;
	
	// 发文文号
	var fdDocNumE = document.getElementsByName("fdDocNum");
	var fdDocNum = "";
	if(fdDocNumE.length > 0 && fdDocNumE[0].value !=''){
		fdDocNum = fdDocNumE[0].value;
	}else{
		fdDocNum = json['docnum'];
		if(fdDocNum){
			fdDocNum = fdDocNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['docnum'] = fdDocNum;
	
	var fdDocFlow = json['docflow'];
	if(fdDocFlow){
		fdDocFlow = fdDocFlow.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
	}
	result['docflow'] = fdDocFlow;
	
	var fdCheckerNameE = document.getElementsByName("fdCheckerName");
	var fdCheckerName = "";
	if(fdCheckerNameE.length > 0 && fdCheckerNameE[0].value !=''){
		fdCheckerName = fdCheckerNameE[0].value;
	}else{
		fdCheckerName = json['checker'];
		if(fdCheckerName){
			fdCheckerName = fdCheckerName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['checker'] = fdCheckerName;
	
	var fdSignatureNameE = document.getElementsByName("fdSignatureName");
	var fdSignatureName = "";
	if(fdSignatureNameE.length > 0 && fdSignatureNameE[0].value !=''){
		fdSignatureName = fdSignatureNameE[0].value;
	}else{
		fdSignatureName = json['signature'];
		if(fdSignatureName){
			fdSignatureName = fdSignatureName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['signature'] = fdSignatureName;
	
	var fdDrafterNameE = document.getElementsByName("fdDrafterName");
	var fdDrafterName = "";
	if(fdDrafterNameE.length > 0 && fdDrafterNameE[0].value !=''){
		fdDrafterName = fdDrafterNameE[0].value;
	}else{
		fdDrafterName = json['drafter'];
		if(fdDrafterName){
			fdDrafterName = fdDrafterName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['drafter'] = fdDrafterName;
	
	// 起草时间
	var fdDraftTimeE = document.getElementsByName("fdDraftTime");
	var fdDraftTime = "";
	if(fdDraftTimeE.length > 0 && fdDraftTimeE[0].value !=''){
		fdDraftTime = fdDraftTimeE[0].value;
	}else{
		fdDraftTime = json['drafttime'];
		if(fdDraftTime){
			fdDraftTime = fdDraftTime.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['drafttime'] = fdDraftTime;

	// 限办时间
	var fdDeadTimeE = document.getElementsByName("fdDeadTime");
	var fdDeadTime = "";
	if(fdDeadTimeE.length > 0 && fdDeadTimeE[0].value !=''){
		fdDeadTime = fdDeadTimeE[0].value;
	}else{
		fdDeadTime = json['deadtime'];
		if(fdDeadTime){
			fdDeadTime = fdDeadTime.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['deadtime'] = fdDeadTime;
	
	//发文单位
	var fdSendtoUnitNameE = document.getElementsByName("fdSendtoUnitName");
	var fdSendtoUnitName = "";
	if(fdSendtoUnitNameE.length > 0 && fdSendtoUnitNameE[0].value !=''){
		fdSendtoUnitName = fdSendtoUnitNameE[0].value;
	}
	var unitName = fdSendtoUnitName;
	var fdOtherSendUnitNamesE = document.getElementsByName("fdOtherSendUnitNames");
	var fdOtherSendUnitNames = "";
	if(fdOtherSendUnitNamesE.length > 0 && fdOtherSendUnitNamesE[0].value !=''){
		fdOtherSendUnitNames = fdOtherSendUnitNamesE[0].value;
	}
	if(fdOtherSendUnitNames != '' && '${kmImissiveSendMainForm.fdIsJoint}' == '2'){
		unitName += ";" +fdOtherSendUnitNames;
	}else{
		unitName = json['sendunit'];
		if(unitName){
			unitName = unitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['sendunit'] = unitName;
	
	//拟文单位
	var fdDraftUnitNameE = document.getElementsByName("fdDraftUnitName");
	var fdDraftUnitName = "";
	if(fdDraftUnitNameE.length > 0 && fdDraftUnitNameE[0].value !=''){
		fdDraftUnitName = fdDraftUnitNameE[0].value;
	}else{
		fdDraftUnitName = json['draftunit'];
		if(fdDraftUnitName){
			fdDraftUnitName = fdDraftUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['draftunit'] = fdDraftUnitName;
	
	//拟稿部门
	var fdDraftDeptNameE = document.getElementsByName("fdDraftDeptName");
	var fdDraftDeptName = "";
	if(fdDraftDeptNameE.length > 0 && fdDraftDeptNameE[0].value !=''){
		fdDraftDeptName = fdDraftDeptNameE[0].value;
	}else{
		fdDraftDeptName = json['draftdept'];
		if(fdDraftDeptName){
			fdDraftDeptName = fdDraftDeptName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['draftdept'] = fdDraftDeptName;
	
	//主送
	var fdMaintoNamesE = document.getElementsByName("fdMaintoNames");
	var fdMaintoNames = "";
	if(fdMaintoNamesE.length > 0 && fdMaintoNamesE[0].value !=''){
		fdMaintoNames = fdMaintoNamesE[0].value;
	}else{
		fdMaintoNames = json['maintounit'];
		if(fdMaintoNames){
			fdMaintoNames = fdMaintoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	//if(fdMaintoNames != ""){
	//	fdMaintoNames = fdMaintoNames.replace(new RegExp(";",'g'),"、");
	//}
	result['maintounit'] = fdMaintoNames;
	
	//抄送
	var fdCopytoNamesE = document.getElementsByName("fdCopytoNames");
	var fdMaintoNames = "";
	if(fdCopytoNamesE.length > 0 && fdCopytoNamesE[0].value !=''){
		fdCopytoNames = fdCopytoNamesE[0].value;
	}else{
		fdCopytoNames = json['copytounit'];
		if(fdCopytoNames){
			fdCopytoNames = fdCopytoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	//if(fdCopytoNames != ""){
	//	fdCopytoNames = fdCopytoNames.replace(new RegExp(";",'g'),"、");
	//}
	result['copytounit'] = fdCopytoNames;
	
	//抄报
	var fdReporttoNamesE = document.getElementsByName("fdReporttoNames");
	var fdReporttoNames = "";
	if(fdReporttoNamesE.length > 0 && fdReporttoNamesE[0].value !=''){
		fdReporttoNames = fdReporttoNamesE[0].value;
	}else{
		fdReporttoNames = json['reporttounit'];
		if(fdReporttoNames){
			fdReporttoNames = fdReporttoNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	//if(fdReporttoNames != ""){
	//	fdReporttoNames = fdReporttoNames.replace(new RegExp(";",'g'),"、");
	//}
	result['reporttounit'] = fdReporttoNames;
	
	//主送个人
	var fdMissiveMpersonNamesE = document.getElementsByName("fdMissiveMpersonNames");
	var fdMissiveMpersonNames = "";
	if(fdMissiveMpersonNamesE.length > 0 && fdMissiveMpersonNamesE[0].value !=''){
		fdMissiveMpersonNames = fdMissiveMpersonNamesE[0].value;
	}else{
		fdMissiveMpersonNames = json['maintoperson'];
		if(fdMissiveMpersonNames){
			fdMissiveMpersonNames = fdMissiveMpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	//if(fdMissiveMpersonNames != ""){
	//	fdMissiveMpersonNames = fdMissiveMpersonNames.replace(new RegExp(";",'g'),"、");
	//}
	result['maintoperson'] = fdMissiveMpersonNames;
	
	//抄送个人
	var fdMissiveCpersonNamesE = document.getElementsByName("fdMissiveCpersonNames");
	var fdMissiveCpersonNames = "";
	if(fdMissiveCpersonNamesE.length > 0 && fdMissiveCpersonNamesE[0].value !=''){
		fdMissiveCpersonNames = fdMissiveCpersonNamesE[0].value;
	}else{
		fdMissiveCpersonNames = json['copytoperson'];
		if(fdMissiveCpersonNames){
			fdMissiveCpersonNames = fdMissiveCpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	//if(fdMissiveCpersonNames != ""){
	//	fdMissiveCpersonNames = fdMissiveCpersonNames.replace(new RegExp(";",'g'),"、");
	//}
	result['copytoperson'] = fdMissiveCpersonNames;
	
	//抄报个人
	var fdMissiveRpersonNamesE = document.getElementsByName("fdMissiveRpersonNames");
	var fdMissiveRpersonNames = "";
	if(fdMissiveRpersonNamesE.length > 0 && fdMissiveRpersonNamesE[0].value !=''){
		fdMissiveRpersonNames = fdMissiveRpersonNamesE[0].value;
	}else{
		fdMissiveRpersonNames = json['reporttoperson'];
		if(fdMissiveRpersonNames){
			fdMissiveRpersonNames = fdMissiveRpersonNames.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	//if(fdMissiveRpersonNames != ""){
	//	fdMissiveRpersonNames = fdMissiveRpersonNames.replace(new RegExp(";",'g'),"、");
	//}
	result['reporttoperson'] = fdMissiveRpersonNames;
	
	//签发日期（大写）
	var docPublishTimeUpperE = document.getElementsByName("docPublishTimeUpper");
	var docPublishTimeUpper = "";
	if(docPublishTimeUpperE.length > 0 && docPublishTimeUpperE[0].value !=''){
		docPublishTimeUpper = docPublishTimeUpperE[0].value;
	}else{
		docPublishTimeUpper = json['signdatecn'];
		if(docPublishTimeUpper){
			docPublishTimeUpper = docPublishTimeUpper.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['signdatecn'] = docPublishTimeUpper;
	
	//签发日期
	var docPublishTimeNumE = document.getElementsByName("docPublishTimeNum");
	var docPublishTimeNum = "";
	if(docPublishTimeNumE.length > 0 && docPublishTimeNumE[0].value !=''){
		docPublishTimeNum = docPublishTimeNumE[0].value;
	}else{
		docPublishTimeNum = json['signdate'];
		if(docPublishTimeNum){
			docPublishTimeNum = docPublishTimeNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['signdate'] = docPublishTimeNum;
	
	//签发日期
	var docPublishTimeE = document.getElementsByName("docPublishTime");
	var docPublishTime = "";
	if(docPublishTimeE.length > 0 && docPublishTimeE[0].value !=''){
		docPublishTime = docPublishTimeE[0].value;
		//异步更新签发日期大写书签
		var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=transferTime"; 
		 $.ajax({     
		     type:"post", 
		     dataType:"json",
		     url:url,   
		     data:{filed:'docPublishTime',docPublishTime:docPublishTime},
		     async:false,    //用同步方式 
		     success:function(rtn){
		 	   if(rtn['docPublishTimeUpper']){
		 		  Attachment_ObjectInfo[attKey].setBookmark('signdatecn', rtn['docPublishTimeUpper']);
		 	   }
		 	  if(rtn['docPublishTimeNum']){
		 		 Attachment_ObjectInfo[attKey].setBookmark('signdate', rtn['docPublishTimeNum']);
		 	   }
			}   
	   });
	}else{
		docPublishTime = json['signdaten'];
		if(docPublishTime){
			docPublishTime = docPublishTime.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['signdaten'] = docPublishTime;
	
	//打印份数
	var fdPrintNumE = document.getElementsByName("fdPrintNum");
	var fdPrintNum = "";
	if(fdPrintNumE.length > 0 && fdPrintNumE[0].value !=''){
		fdPrintNum = fdPrintNumE[0].value;
	}else{
		fdPrintNum = json['printnum'];
		if(fdPrintNum){
			fdPrintNum = fdPrintNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['printnum'] = fdPrintNum;
	
	//打印页数
	var fdPrintPageNumE = document.getElementsByName("fdPrintPageNum");
	var fdPrintPageNum = "";
	if(fdPrintPageNumE.length > 0 && fdPrintPageNumE[0].value !=''){
		fdPrintPageNum = fdPrintPageNumE[0].value;
	}else{
		fdPrintPageNum = json['printpagenum'];
		if(fdPrintPageNum){
			fdPrintPageNum = fdPrintPageNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['printpagenum'] = fdPrintPageNum;
	
	//印发单位
	var fdPrintUnitNameE = document.getElementsByName("fdPrintUnitName");
	var fdPrintUnitName = "";
	if(fdPrintUnitNameE.length > 0 && fdPrintUnitNameE[0].value !=''){
		fdPrintUnitName = fdPrintUnitNameE[0].value;
	}else{
		fdPrintUnitName = json['printunit'];
		if(fdPrintUnitName){
			fdPrintUnitName = fdPrintUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['printunit'] = fdPrintUnitName;
	
	//印发时间
	var fdPrintTimeNumE = document.getElementsByName("fdPrintTimeNum");
	var fdPrintTimeNum = "";
	if(fdPrintTimeNumE.length > 0 && fdPrintTimeNumE[0].value !=''){
		fdPrintTimeNum = fdPrintTimeNumE[0].value;
	}else{
		fdPrintTimeNum = json['printtime'];
		if(fdPrintTimeNum){
			fdPrintTimeNum = fdPrintTimeNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['printtime'] = fdPrintTimeNum;
	
	//印发时间大写
	var fdPrintTimeUpperE = document.getElementsByName("fdPrintTimeUpper");
	var fdPrintTimeUpper = "";
	if(fdPrintTimeUpperE.length > 0 && fdPrintTimeUpperE[0].value !=''){
		fdPrintTimeUpper = fdPrintTimeUpperE[0].value;
	}else{
		fdPrintTimeUpper = json['printtimecn'];
		if(fdPrintTimeUpper){
			fdPrintTimeUpper = fdPrintTimeUpper.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['printtimecn'] = fdPrintTimeUpper;
	
	//印发时间
	var fdPrintTimeE = document.getElementsByName("fdPrintTime");
	var fdPrintTime = "";
	if(fdPrintTimeE.length > 0 && fdPrintTimeE[0].value !=''){
		fdPrintTime = fdPrintTimeE[0].value;
		//异步更新签发日期大写书签
		var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=transferTime"; 
		 $.ajax({     
		     type:"post", 
		     dataType:"json",
		     url:url,   
		     data:{filed:'fdPrintTime',fdPrintTime:fdPrintTime},
		     async:false,    //用同步方式 
		     success:function(rtn){
		 	   if(rtn['fdPrintTimeUpper']){
		 		  result['fdPrintTimeUpper'] = rtn['fdPrintTimeUpper'];
		 	   }
		 	  if(rtn['fdPrintTimeNum']){
		 		 result['printtime'] = rtn['fdPrintTimeNum'];
		 	   }
			}   
	   });
	}else{
		fdPrintTime = json['printtimen'];
		if(fdPrintTime){
			fdPrintTime = fdPrintTime.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['printtimen'] = fdPrintTime;
	
	//发布层次
	var fdLevelE = document.getElementsByName("fdLevel");
	var fdLevel = "";
	if(fdLevelE.length > 0 && fdLevelE[0].value !=''){
		fdLevel = fdLevelE[0].value;
	}else{
		fdLevel = json['level'];
		if(fdLevel){
			fdLevel = fdLevel.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['level'] = fdLevel;
	
	//版本
	var fdVersionE = document.getElementsByName("fdVersion");
	var fdVersion = "";
	if(fdVersionE.length > 0 && fdVersionE[0].value !=''){
		fdVersion = fdVersionE[0].value;
	}else{
		fdVersion = json['version'];
		if(fdVersion){
			fdVersion = fdVersion.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['version'] = fdVersion;
	
	//保密期限
	var fdSecretYearE = document.getElementsByName("fdSecretYear");
	var fdSecretYear = "";
	if(fdSecretYearE.length > 0 && fdSecretYearE[0].value !=''){
		fdSecretYear = fdSecretYearE[0].value;
	}else{
		fdSecretYear = json['secretyear'];
		if(fdSecretYear){
			fdSecretYear = fdSecretYear.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['secretyear'] = fdSecretYear;
	
	//备用1
	var fdReserveOneE = document.getElementsByName("fdReserveOne");
	var fdReserveOne = "";
	if(fdReserveOneE.length > 0 && fdReserveOneE[0].value !=''){
		fdReserveOne = fdReserveOneE[0].value;
	}else{
		fdReserveOne = json['reserveone'];
		if(fdReserveOne){
			fdReserveOne = fdReserveOne.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['reserveone'] = fdReserveOne;
	
	//备用2
	var fdReserveTwoE = document.getElementsByName("fdReserveTwo");
	var fdReserveTwo = "";
	if(fdReserveTwoE.length > 0 && fdReserveTwoE[0].value !=''){
		fdReserveTwo = fdReserveTwoE[0].value;
	}else{
		fdReserveTwo = json['reservetwo'];
		if(fdReserveTwo){
			fdReserveTwo = fdReserveTwo.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['reservetwo'] = fdReserveTwo;
	
	//备用3
	var fdReserveThreeE = document.getElementsByName("fdReserveThree");
	var fdReserveThree = "";
	if(fdReserveThreeE.length > 0 && fdReserveThreeE[0].value !=''){
		fdReserveThree = fdReserveThreeE[0].value;
	}else{
		fdReserveThree = json['reservethree'];
		if(fdReserveThree){
			fdReserveThree = fdReserveThree.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['reservethree'] = fdReserveThree;
	
	//备用4
	var fdReserveFourE = document.getElementsByName("fdReserveFour");
	var fdReserveFour = "";
	if(fdReserveFourE.length > 0 && fdReserveFourE[0].value !=''){
		fdReserveFour = fdReserveFourE[0].value;
	}else{
		fdReserveFour = json['reservefour'];
		if(fdReserveFour){
			fdReserveFour = fdReserveFour.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['reservefour'] = fdReserveFour;
	
	//备用5
	var fdReserveFiveE = document.getElementsByName("fdReserveFive");
	var fdReserveFive = "";
	if(fdReserveFiveE.length > 0 && fdReserveFiveE[0].value !=''){
		fdReserveFive = fdReserveFiveE[0].value;
	}else{
		fdReserveFive = json['reservefive'];
		if(fdReserveFive){
			fdReserveFive = fdReserveFive.replace(/&#039;/g, "'").replace(/&#034;/g, "\"").replace(/&#010;/g, "\n").replace(/&#013;/g, "\r");
		}
	}
	result['reservefive'] = fdReserveFive;
	return JSON.stringify(result);
}