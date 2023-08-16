<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">  

function addBookMarks(attKey){
	if(attKey==""||attKey==null||attKey=='undefined'){
		attKey = "editonline";
	}
	
	var json = {};
	var jsonStr = "<c:out value='${bookmarkJson}'/>"
	var fdContent = "";
	if(jsonStr !=""){
		var theString = '${bookmarkJson}';
		var bookmarksStr = 'docsubject,doctype,sendunit,docnum,receivenum,secretgrade,emergency,signer,signtime,recorder,recordtime,fddeadtime,receivetime,receiveunit,shareNum,content,reserveone,reservetwo,reservethree,reservefour,reservefive';
		theString = theString.replace(/[\n\r]/g,"");
		json = (new Function("return ("+theString+");"))();
    	
		for (var o in json) {
			var objVal = json[o];
			if(objVal){
				objVal = objVal.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
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
				Attachment_ObjectInfo[attKey].setBookmark(o, objVal);
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
	Attachment_ObjectInfo[attKey].setBookmark('doctype', fdDocTypeName);
	
	//密级
	var fdSecretGradeNameE = document.getElementsByName("fdSecretGradeId");
	var fdSecretGradeName = "";
	if(fdSecretGradeNameE.length > 0 ){
		var index = fdSecretGradeNameE[0].selectedIndex
		fdSecretGradeName = fdSecretGradeNameE[0].options[index].text;
	}else{
		fdSecretGradeName = json['secretgrade'];
		if(fdSecretGradeName){
			fdSecretGradeName = fdSecretGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('secretgrade', fdSecretGradeName);
	
	
	//缓急
	var fdEmergencyGradeNameE = document.getElementsByName("fdEmergencyGradeId");
	var fdEmergencyGradeName = "";
	if(fdEmergencyGradeNameE.length > 0 ){
		var index = fdEmergencyGradeNameE[0].selectedIndex
		fdEmergencyGradeName = fdEmergencyGradeNameE[0].options[index].text;
	}else{
		fdEmergencyGradeName = json['emergency'];
		if(fdEmergencyGradeName){
			fdEmergencyGradeName = fdEmergencyGradeName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('emergency',fdEmergencyGradeName);
	
	//标题
	var docSubjectE = document.getElementsByName("docSubject");
	var docSubject = "";
	if(docSubjectE.length > 0 && docSubjectE[0].value !=''){
		docSubject = docSubjectE[0].value;
	}else{
		docSubject =json['docsubject'];
		if(docSubject){
			docSubject = docSubject.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('docsubject',docSubject);
	
	//备注
	var fdContentE = document.getElementsByName("fdContent");
	var fdContent = "";
	if(fdContentE.length > 0 && fdContentE[0].value !=''){
		fdContent = fdContentE[0].value;
	}
	Attachment_ObjectInfo[attKey].setBookmark('content',fdContent);
	
	// 发文文号
	var fdDocNumE = document.getElementsByName("fdDocNum");
	var fdDocNum = "";
	if(fdDocNumE.length > 0 && fdDocNumE[0].value !=''){
		fdDocNum = fdDocNumE[0].value;
	}else{
		fdDocNum =json['docnum'];
		if(fdDocNum){
			fdDocNum = fdDocNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('docnum',fdDocNum);
	
	var fdDocFlow = json['docflow'];
	if(fdDocFlow){
		fdDocFlow = fdDocFlow.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
	}
	Attachment_ObjectInfo[attKey].setBookmark('docflow',fdDocFlow);
	
	var fdReceiveDocNumE = document.getElementsByName("fdReceiveDocNum");
	var fdReceiveDocNum = "";
	if(fdReceiveDocNumE.length > 0 && fdReceiveDocNumE[0].value !=''){
		fdReceiveDocNum = fdReceiveDocNumE[0].value;
	}else{
		fdReceiveDocNum =json['receivenum'];
		if(fdReceiveDocNum){
			fdReceiveDocNum = fdReceiveDocNum.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('receivenum',fdReceiveDocNum);
	
	var fdSignerNameE = document.getElementsByName("fdSignerName");
	var fdSignerName = "";
	if(fdSignerNameE.length > 0 && fdSignerNameE[0].value !=''){
		fdSignerName = fdSignerNameE[0].value;
	}else{
		fdSignerName =json['signer'];
		if(fdSignerName){
			fdSignerName = fdSignerName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('signer',fdSignerName);
	
	var fdSignTimeE = document.getElementsByName("fdSignTime");
	var fdSignTime = "";
	if(fdSignTimeE.length > 0 && fdSignTimeE[0].value !=''){
		fdSignTime = fdSignTimeE[0].value;
	}else{
		fdSignTime ="<c:out value='${kmImissiveReceiveMainForm.fdSignTime}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('signtime',fdSignTime);
	
	var fdRecorderNameE = document.getElementsByName("fdRecorderName");
	var fdRecorderName = "";
	if(fdRecorderNameE.length > 0 && fdRecorderNameE[0].value !=''){
		fdRecorderName = fdRecorderNameE[0].value;
	}else{
		fdRecorderName ="<c:out value='${kmImissiveReceiveMainForm.fdRecorderName}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('recorder',fdRecorderName);
	
	var fdRecordTimeE = document.getElementsByName("fdRecordTime");
	var fdRecordTime = "";
	if(fdRecordTimeE.length > 0 && fdRecordTimeE[0].value !=''){
		fdRecordTime = fdRecordTimeE[0].value;
	}else{
		fdRecordTime ="<c:out value='${kmImissiveReceiveMainForm.fdRecordTime}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('recordtime',fdRecordTime);
	
	// 限办时间
	var fdDeadTimeE = document.getElementsByName("fdDeadTime");
	var fdDeadTime = "";
	if(fdDeadTimeE.length > 0 && fdDeadTimeE[0].value !=''){
		fdDeadTime = fdDeadTimeE[0].value;
	}else{
		fdDeadTime ="<c:out value='${kmImissiveReceiveMainForm.fdDeadTime}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('deadtime',fdDeadTime);
	
	var fdReceiveTimeE = document.getElementsByName("fdReceiveTime");
	var fdReceiveTime = "";
	if(fdReceiveTimeE.length > 0 && fdReceiveTimeE[0].value !=''){
		fdReceiveTime = fdReceiveTimeE[0].value;
	}else{
		fdReceiveTime ="<c:out value='${kmImissiveReceiveMainForm.fdReceiveTime}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('receivetime',fdReceiveTime);
	
	var fdShareNumE = document.getElementsByName("fdShareNum");
	var fdShareNum = "";
	if(fdShareNumE.length > 0 && fdShareNumE[0].value !=''){
		fdShareNum = fdShareNumE[0].value;
	}else{
		fdShareNum ="<c:out value='${kmImissiveReceiveMainForm.fdShareNum}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('shareNum',fdShareNum);
	
	
	// 限办时间
	var fdDeadTimeE = document.getElementsByName("fdDeadTime");
	var fdDeadTime = "";
	if(fdDeadTimeE.length > 0 && fdDeadTimeE[0].value !=''){
		fdDeadTime = fdDeadTimeE[0].value;
	}else{
		fdDeadTime ="<c:out value='${kmImissiveReceiveMainForm.fdDeadTime}'/>";
	}
	Attachment_ObjectInfo[attKey].setBookmark('deadtime',fdDeadTime);
	
	//发文单位
	var fdSendtoUnitNameE = document.getElementsByName("fdSendtoUnitName");
	var fdSendtoUnitName = "";
	if(fdSendtoUnitNameE.length > 0 && fdSendtoUnitNameE[0].value !=''){
		fdSendtoUnitName = fdSendtoUnitNameE[0].value;
	}else{
		fdSendtoUnitName =json['sendunit'];
		if(fdSendtoUnitName){
			fdSendtoUnitName = fdSendtoUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	var unitName = fdSendtoUnitName;
	
	Attachment_ObjectInfo[attKey].setBookmark('sendunit', unitName);
	
	
	//收文单位
	var fdReceiveUnitNameE = document.getElementsByName("fdReceiveUnitName");
	var fdReceiveUnitName = "";
	if(fdReceiveUnitNameE.length > 0 && fdReceiveUnitNameE[0].value !=''){
		fdReceiveUnitName = fdReceiveUnitNameE[0].value;
	}else{
		fdReceiveUnitName =json['receiveunit'];
		if(fdReceiveUnitName){
			fdReceiveUnitName = fdReceiveUnitName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	
	Attachment_ObjectInfo[attKey].setBookmark('receiveunit', fdReceiveUnitName);
	
	//备用1
	var fdReserveOneE = document.getElementsByName("fdReserveOne");
	var fdReserveOne = "";
	if(fdReserveOneE.length > 0 && fdReserveOneE[0].value !=''){
		fdReserveOne = fdReserveOneE[0].value;
	}else{
		fdReserveOne =json['reserveone'];
		if(fdReserveOne){
			fdReserveOne = fdReserveOne.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('reserveone', fdReserveOne);
	
	
	//备用2
	var fdReserveTwoE = document.getElementsByName("fdReserveTwo");
	var fdReserveTwo = "";
	if(fdReserveTwoE.length > 0 && fdReserveTwoE[0].value !=''){
		fdReserveTwo = fdReserveTwoE[0].value;
	}else{
		fdReserveTwo =json['reservetwo'];
		if(fdReserveTwo){
			fdReserveTwo = fdReserveTwo.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('reservetwo', fdReserveTwo);
	
	
	//备用3
	var fdReserveThreeE = document.getElementsByName("fdReserveThree");
	var fdReserveThree = "";
	if(fdReserveThreeE.length > 0 && fdReserveThreeE[0].value !=''){
		fdReserveThree = fdReserveThreeE[0].value;
	}else{
		fdReserveThree =json['reservethree'];
		if(fdReserveThree){
			fdReserveThree = fdReserveThree.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('reservethree', fdReserveThree);
	
	
	//备用4
	var fdReserveFourE = document.getElementsByName("fdReserveFour");
	var fdReserveFour = "";
	if(fdReserveFourE.length > 0 && fdReserveFourE[0].value !=''){
		fdReserveFour = fdReserveFourE[0].value;
	}else{
		fdReserveFour =json['reservefour'];
		if(fdReserveFour){
			fdReserveFour = fdReserveFour.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('reservefour', fdReserveFour);
	
	//备用5
	var fdReserveFiveE = document.getElementsByName("fdReserveFive");
	var fdReserveFive = "";
	if(fdReserveFiveE.length > 0 && fdReserveFiveE[0].value !=''){
		fdReserveFive = fdReserveFiveE[0].value;
	}else{
		fdReserveFive =json['reservefive'];
		if(fdReserveFive){
			fdReserveFive = fdReserveFive.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
		}
	}
	Attachment_ObjectInfo[attKey].setBookmark('reservefive', fdReserveFive);
	
	return true;
}
</script>