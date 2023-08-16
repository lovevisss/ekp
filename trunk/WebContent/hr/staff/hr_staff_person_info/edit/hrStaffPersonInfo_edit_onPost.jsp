<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.hr.staff.util.HrStaffPersonUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.hr.staff.util.HrStaffPersonUtil,
				com.landray.kmss.hr.organization.model.HrOrganizationSyncSetting"%>
<%
	HrOrganizationSyncSetting syncSetting = new HrOrganizationSyncSetting();
	request.setAttribute("hrToEkpEnable", syncSetting.getHrToEkpEnable());
%>
<template:include ref="default.edit" sidebar="auto">
	<template:replace name="title">
		<c:choose>
			<c:when test="${ hrStaffPersonInfoForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('hr-staff:hrStaffPersonInfo.create.title') } - ${ lfn:message('hr-staff:module.hr.staff') }"></c:out>	
			</c:when>
			<c:otherwise>
				${ hrStaffPersonInfoForm.fdName } - ${ lfn:message('hr-staff:module.hr.staff') }
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="head">
		<style>
			.hr_select{
				width: 50%;
				max-width: 80%;
			}
			select[name=fdOrgRankId]{
				width:200px;
			}
		</style>
		<link rel="stylesheet" href="../resource/css/common_view.css">
  	  <link rel="stylesheet" href="../resource/css/person_info.css">
  	  <style>
	  	  .com_qrcode{
	  	  	display:none !important
	  	  }
  	  	.lui-personnel-file-baseInfo-main-content .inputsgl{
  	  		   border: 1px solid #b4b4b4;
  	  		   height:28px;
  	  		   border-radius:4px;
  	  	}
  	  	.newTable tr{
  	  		height:40px;
  	  		border-spacing:0px 10px;
  	  	}
  	  	.datawidth .inputselectsgl,.lui-custom-Prop .inputselectsgl{
  	  		width:205px!important;
  	  		height:30px!important;
  	  		border-radius:4px;
  	  		border:none;
  	  		background-color:#F7F7F8;
  	  	}
  	  	.inputwidth .inputsgl,.lui-custom-Prop .inputsgl{
  	  		height:28px;
  	  		width:200px!important;
  	  		background-color:#F7F7F8;
  	  		border:none;
  	  		border-radius:4px;
  	  	}
  	  	.hr_select{
  	  		width: 200px;
  	  		height:30px;
  	  		border-radius:4px;
  	  		background-color:#F7F7F8;
  	  		border:none!important;
  	  	}
  	  	.datawidth input,.lui-custom-Prop .inputselectsgl input{
  	  		background-color:#F7F7F8!important;
  	  	}
  	  	.lui-personnel-file-edit-text{
  	  		
  	  	}
  	  	.inputselectsgl{
  	  		width:200px!important;
  	  	}
		.newTable textarea{
			width:200px;
			border:none;
			margin:4px 0;
			background-color:#f7f7f7;
		}
		.lui_form_path_frame,.tempTB{
			min-width:880px!important;
		}
		.lui_form_body{
		background-color:white;
		}
		div.mf_container{
			height: 30px;
			
			border :0!important;
		}
		.inputselectsgl{
		height:30px;
		background-color: #f7f7f8!important;
		}
		.staffInfo .inputselectsgl{
			border-bottom:none!important;
		}
		.inputsgl{
		padding-left: 0px;
		}
		div.input{
			height: 30px;
			background-color: #f7f7f8!important;
			border :0!important;
		}
		.staffInfo .input input{
		background-color: #f7f7f8!important;
		}
		
  	  </style>
	</template:replace>	
	<template:replace name="content">
		<html:form action="/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do" >
			<html:hidden property="fdId" value="${hrStaffPersonInfoForm.fdId}"/>
			<html:hidden property="fdOrgPersonId" value="${hrStaffPersonInfoForm.fdOrgPersonId }"/>
				<table class="staffInfo newTable" >
					<tr>
 						<!-- 工号 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdStaffNo" />
						</td>
						<td width="35%" class="inputwidth">
							<xform:text property="fdStaffNo" showStatus="edit" style="width:84%;" required="true" validators="uniqueStaffNo" className="inputsgl" />
						</td>
						
						<!-- 工作地点 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdWorkAddress" />
						</td>
						<td width="35%" class="inputwidth2">
							<%=HrStaffPersonUtil.buildPersonInfoSettingHtml("fdWorkAddress", request)%>
						</td>
					</tr>
					
					<tr>
						<!-- 所在部门 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdOrgParent" />
						</td>
						<td width="35%" class="inputwidth2">
							<c:choose>
								<c:when test="${hrToEkpEnable == true }">
									<%-- <c:choose>
										<c:when test="${not empty hrStaffPersonInfoForm.fdParentId}">
											<xform:address isHrAddress="true" propertyId="fdParentId" propertyName="fdParentName" showStatus="readOnly" 
												orgType="ORG_TYPE_DEPT" style="width:55%;"></xform:address>
										</c:when>
										<c:otherwise> --%>
											<xform:address isHrAddress="true" propertyId="fdParentId" propertyName="fdParentName" showStatus="edit" 
												orgType="ORG_TYPE_DEPT" required="true" ></xform:address>
											<c:set value="${hrStaffPersonInfoForm.fdParentId }" var="fdParentId"/>
										<%-- </c:otherwise>
									</c:choose> --%>
								</c:when>
								<c:otherwise>
									<%-- <c:choose>
										<c:when test="${not empty hrStaffPersonInfoForm.fdOrgParentId}">
											<xform:address propertyId="fdOrgParentId" propertyName="fdOrgParentName" showStatus="readOnly" 
												orgType="ORG_TYPE_DEPT" required="true" style="width:55%;"></xform:address>
										</c:when>
										<c:otherwise> --%>
											<xform:address propertyId="fdOrgParentId" propertyName="fdOrgParentName" showStatus="edit" 
												orgType="ORG_TYPE_DEPT" required="true" ></xform:address>
											<c:set value="${hrStaffPersonInfoForm.fdOrgParentId }" var="fdParentId"/>
										<%-- </c:otherwise>
									</c:choose> --%>
								</c:otherwise>
							</c:choose>	
						</td>
						<!-- 汇报上级 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdReportLeader" />
						</td>
						<td width="35%" class="inputwidth2">
							<xform:address showStatus="edit" orgType="ORG_TYPE_PERSON" propertyName="fdReportLeaderName" propertyId="fdReportLeaderId" style="width:80%;"></xform:address>
						</td>
					</tr>
					<tr>
						<!-- 系统账号 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdLoginName" />
						</td>
						<td width="35%" class="inputwidth">
							<xform:text validators="uniqueLoginName" showStatus="edit" property="fdLoginName" style="width:84%;" required="true"></xform:text>
						</td>
						<c:if test="${empty hrStaffPersonInfoForm.fdOrgPersonId}">
                    		<td width="15%">${lfn:message('hr-staff:hrStaffPersonInfo.fdPassword') }</td>
	                    	<td width="45%" class="fdNewPassword inputwidth">
									<xform:text  showStatus="edit" property="fdNewPassword" subject="密码"></xform:text>
									<span style="display: none;" class="txtstrong" id="isRequiredFlag">*</span>
	                    	</td>
                    	</c:if>
					</tr>
					<tr>
						<!-- 职务 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdStaffingLevel" />
						</td>
						<td width="35%" class="inputwidth4">
							<xform:staffingLevel propertyName="fdStaffingLevelName" propertyId="fdStaffingLevelId" showStatus="edit" ></xform:staffingLevel>
						</td>						
						<!-- 岗位 -->
						<td width="15%" class="td_normal_title">
							<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdOrgPosts" />
						</td>
						<td width="35%" class="inputwidth2">
							<c:choose>
								<c:when test="${hrToEkpEnable == true }">
									<xform:address isExternal="false" isHrAddress="true" propertyId="fdPostIds" propertyName="fdPostNames"  onValueChange="window.hrPostsChange"
												   mulSelect="false" showStatus="edit" orgType="ORG_TYPE_POST"></xform:address>
									<c:set value="${hrStaffPersonInfoForm.fdPostIds }" var="fdPostIds"/>
								</c:when>
								<c:otherwise>
									<xform:address isExternal="false" propertyId="fdPostIds" propertyName="fdPostNames"  onValueChange="window.hrPostsChange"
												   mulSelect="false" showStatus="edit" orgType="ORG_TYPE_POST"></xform:address>
									<c:set value="${hrStaffPersonInfoForm.fdPostIds }" var="fdPostIds"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<c:if test="${hrToEkpEnable == true }">
						<tr id="staffLevingBox">
							<td>${lfn:message('hr-staff:hrStaffPersonInfo.fdOrgGrade') }</td>
							<td class="grade_add_box">
								<c:if test="${not empty rankList}">
									${ranGrade eq null?"":ranGrade }
								</c:if>
							</td>
							<td>${lfn:message('hr-staff:hrStaffPersonInfo.fdOrgRank') }</td>
							<td id="rank_edit">
								${rankList }
							</td>
							<%-- <td>
								${hrStaffPersonInfoForm.fdOrgRankName }
							</td> --%>
						</tr>
					</c:if>
					<tr>
						<td width="15%" class="td_normal_title">
							<bean:message key="hrOrganizationElement.fdIsBusiness" bundle="hr-organization"/></td>
						</td>
						<td width="35%">
							<ui:switch property="fdIsBusiness" ></ui:switch>
						</td>
						<td>
							<bean:message key="hrStaffPersonInfo.fdCanLogin" bundle="hr-staff"/></td>
						</td>
						<td width="35%">
							<ui:switch property="fdCanLogin"></ui:switch>
						</td>
					</tr>

					<%-- 引入动态属性 --%>
					<tr style="display:none">
						<td colspan="4">
							<table>
								<c:import url="/hr/staff/hr_staff_person_info/edit/custom_fieldEdit.jsp" charEncoding="UTF-8" />
							</table>
						</td>
					</tr>
				</table>
		</html:form>
		<%@ include file="/hr/staff/hr_staff_person_info/hrStaffPersonInfo_edit_script.jsp"%>
		<script>
			var hrToEkpEnable = "${hrToEkpEnable}";
			var _validator = $KMSSValidation(document.forms['hrStaffPersonInfoForm']);

			$("#staffLevingBox select").change(function(e){
				var gradename = $(e.target).find("option:selected").attr("gradeName");
				if(gradename){
					$("#staffLevingBox .grade_add_box").text(gradename);
				}
			})

			window.submitBtn = function (){
				 /*  Com_Submit(document.hrStaffPersonInfoForm, 'update'); */
				 var filed = decodeURIComponent($(document.hrStaffPersonInfoForm).serialize());
				 var dataArr = filed.split("&");
				 var data ={}
				 $.each(dataArr,function(index,item){
					 var itemData = item.split("=")
					 data[itemData[0]]= itemData.length>1?decodeURIComponent(itemData[1]):""
				 })
				 data['type'] = "offical"
				 if(_validator.validate()){
					 cutDept(data);
				 }
			}
			window.submitForm = function(data){
				$.ajax({
					 url:"<%=request.getContextPath()%>/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=updatePersonInfo&fdId=${hrStaffPersonInfoForm.fdId}",
					 method:'post',
					 data:data,
					 success:function(res){
						 if(res.status){
							 window.parent.dialogObj.hide()
							 window.parent.location.reload();
						 }else{
							 
						 }
					 }
				 })
			}
			seajs.use(['lui/jquery', 'lui/dialog'],function($, dialog){
				//切换部门
		  		window.cutDept = function(data){
		  			var newDeptId = null;
		  			var newPostId = null;
		  			if(hrToEkpEnable  == 'true'){
		  				newDeptId = $("input[name='fdParentId']").val();
		  				newPostId = $("input[name='fdPostIds']").val();
		  			}else{
		  				newDeptId = $("input[name='fdOrgParentId']").val();
		  				newPostId = $("input[name='fdOrgPostIds']").val();
		  			}
		  			var oldDeptId = "${fdParentId}";
		  			var oldPostId = "${fdPostIds}";
		  			
		  			if(newDeptId != oldDeptId || newPostId != oldPostId){
		  				dialog.confirm("是否确认修改当前用户部门或岗位，修改后可能影响异动数据不可追溯？", function(ok) {
			  				if(ok == true) {
			  					submitForm(data);
			  				}
			  			});
		  			}else{
		  				submitForm(data);
		  			}
		  		}
				
		  		window.hrPostsChange=function(v){
	  				if(v){
		  				 $.ajax({
			                    url: '${LUI_ContextPath}/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=buildRankHtml',
			                    data: {"fdId":v[0]},
			                    dataType: 'json',
			                    type: 'POST',
			                    async:false,
			                    success: function(data) {
			                 
			                    	if(data){
			                    		var tdChild = $("#staffLevingBox td");
			                    		$("#staffLevingBox").empty();
			                    		if(data.html){
			                    			$("#staffLevingBox").append("<td>职级</td><td>"+data.html+"</td>");
			                    		}
			                    		var gradename = $("#staffLevingBox select option:selected").attr("gradename");
			                    		
			                    		if(gradename){
			                    			$("#staffLevingBox").prepend("<td>职等</td><td class='grade_add_box'>"+gradename+"</td>")
			                    		}
			                    		
			                    		$("#staffLevingBox select").change(function(e){
			                    			var gradename = $(e.target).find("option:selected").attr("gradeName");
			                    			if(gradename){
			                    				$("#staffLevingBox .grade_add_box").text(gradename);
			                    			}
			                    			
			                    		})
			                    		
			                    	}
			                    },
			                    error: function(req) {
									$("#staffLevingBox").empty();
			                    }
			                });
	  				}else{
	  					if($("#staffLevingBox td").length==4){
	  						$("#staffLevingBox").get(0).removeChild($("#staffLevingBox td").last().get(0));
	  						$("#staffLevingBox").get(0).removeChild($("#staffLevingBox td").last().get(0));
	  						$("#staffLevingBox_add").get(0).removeChild($("#staffLevingBox td").last().get(0));
	  						$("#staffLevingBox_add").get(0).removeChild($("#staffLevingBox td").last().get(0));
	  					}
	  				}
	  			}
				
			});
			
		</script>
	</template:replace>
</template:include>