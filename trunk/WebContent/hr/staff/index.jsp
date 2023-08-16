<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.hr.staff.service.spring.HrStaffPersonInfoValidator,com.landray.kmss.hr.staff.service.spring.HrStaffEntryValidator"%>
<%@ page import="com.landray.kmss.sys.authentication.intercept.ValidatorRequestContext,com.landray.kmss.util.SpringBeanUtil"%>
<%@ page import="com.landray.kmss.hr.staff.model.HrStaffConfig" %>
<template:include ref="default.list" spa="true"  rwd="true">
<template:replace name="title">
		<c:out value="${ lfn:message('hr-staff:module.hr.staff') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script type="text/javascript">
				seajs.use(['theme!list','theme!module']);	
			</script>
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/hr/staff/resource/css/hr_staff.css?s_cache=${LUI_Cache}"/>
	</template:replace>
	<template:replace name="nav">
		<div class="lui_list_noCreate_frame">
		<ui:combin ref="menu.nav.create">
		<ui:varParam name="title" value="${ lfn:message('hr-staff:module.hr.staff') }" />
			<ui:varParam name="button">
				[
					{
						"text": "",
						"href": "javascript:void(0);",
						"icon": "hr_staff"
					}
				]
			</ui:varParam>			
		</ui:combin>
		</div>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
				<ui:content title="${ lfn:message('hr-staff:hr.staff.nav.staff.manage')}"  expand="true">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.overview')}",
		  						"href" :  "/overview",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_overview"
		  					},
		  					<kmss:authShow roles="ROLE_SYS_TIME_DEFAULT">
		  					{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.attendance.management')}",
		  						"href" :  "/management",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_leave"
		  					},
		  					</kmss:authShow>
		  					<kmss:authShow roles="ROLE_HRSTAFF_EMOLUMENT">
		  					{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.benefits')}",
		  						"href" :  "/benefits",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_pay"
		  					},
		  					</kmss:authShow>
		  					<kmss:authShow roles="ROLE_HRSTAFF_PAYMENT">
		  					{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.payroll')}",
		  						"href" :  "/payroll",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_payroll"
		  					},
		  					</kmss:authShow>
		  					<% if (com.landray.kmss.sys.subordinate.util.SubordinateUtil.getInstance().getModelByModuleAndUser("hr-staff:module.hr.staff").size() > 0) { %>
		  					{
		  						"text" : "${lfn:message('hr-staff:subordinate.hrStaffPersonInfo') }",
		  						"href" :  "/sys/subordinate",
			  					"router" : true,
			  					"icon" : "lui_iconfont_navleft_subordinate"
		  					},
		  					<% } %>
		  					]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>	
				</ui:content>
				<%
					HrStaffEntryValidator _val = (HrStaffEntryValidator)SpringBeanUtil.getBean("hrStaffEntryValidator");
					ValidatorRequestContext _ctx = new ValidatorRequestContext();
					boolean _flag = UserUtil.getKMSSUser().isAdmin()||UserUtil.checkRole("ROLE_HRSTAFF_READALL")||_val.validate(_ctx);
					if(_flag){ 
				%>
				<ui:content title="${ lfn:message('hr-staff:hr.staff.nav.staff.entry.info')}" expand="false">
					<ui:combin ref="menu.nav.simple">
						<ui:varParam name="source">
							<ui:source type="Static">
								[
									{
				  						"text" : "${ lfn:message('hr-staff:table.hrStaffEntry.status1')}",
				  						"href" :  "/entryStatus1",
										"router" : true,		  					
					  					"icon" : "lui_iconfont_navleft_hr_employees"
				  					},{
				  						"text" : "${ lfn:message('hr-staff:table.hrStaffEntry.status2')}",
				  						"href" :  "/entryStatus2",
										"router" : true,		  					
					  					"icon" : "lui_iconfont_navleft_hr_employees"
				  					}
								]
							</ui:source>
						</ui:varParam>
					</ui:combin>
				</ui:content>
				<%} %>
				<ui:content title="${ lfn:message('hr-staff:hr.staff.nav.staff.file.info')}"  expand="false">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
							<%
								HrStaffConfig hrStaffConfig = new HrStaffConfig();
								boolean ownerFlag = "true".equals(hrStaffConfig.getFdSelfView());
								pageContext.setAttribute("userSysOrgPersonFdId",UserUtil.getUser().getFdId());
								if(ownerFlag){
							%>
							{
								"text" : "${ lfn:message('hr-staff:hr.staff.nav.staff.owner.file')}",
								"href" :  "/ownerFile",
								"router" : true,
								"icon" : "lui_iconfont_navleft_hr_agreement"
							},
							<% } %>
							<kmss:auth requestURL="/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=list" requestMethod="GET">
		  					{
								"text" : "${ lfn:message('hr-staff:hr.staff.nav.employee.information.in')}",
								"href" :  "/informationIn",
								"router" : true,
								"icon" : "lui_iconfont_navleft_hr_employees"
								},

								{
								"text" : "${ lfn:message('hr-staff:hr.staff.nav.employee.information.quit')}",
								"href" :  "/informationQuit",
								"router" : true,
								"icon" : "lui_iconfont_navleft_hr_quitEmployees"
							},
							</kmss:auth>
		  					{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonExperience.type.contract')}",
		  						"href" :  "/contract",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_agreement"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffTrackRecord.record')}",
		  						"href" :  "/trackrecord",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_hr_trackRecord"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPerson.family')}",
		  						"href" :  "/familyInfo",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_hr_familyInfo"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonExperience.type.work')}",
		  						"href" :  "/work",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_workexp"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonExperience.type.education')}",
		  						"href" :  "/education",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_education"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonExperience.type.training')}",
		  						"href" :  "/training",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_train"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonExperience.type.qualification')}",
		  						"href" :  "/qualification",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_certificate"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonExperience.type.bonusMalus')}",
		  						"href" :  "/bonusMalus",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_reward"
		  					}]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>	
				</ui:content>
				<ui:content title="${ lfn:message('hr-staff:hr.staff.nav.statistical.report')}"  expand="false">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportStaffNum')}",
		  						"href" :  "/reportStaffNum",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportAge')}",
		  						"href" :  "/reportAge",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportWorkTime')}",
		  						"href" :  "/reportWorkTime",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportEducation')}",
		  						"href" :  "/reportEducation",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportStaffingLevel')}",
		  						"href" :  "/reportStaffingLevel",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportStatus')}",
		  						"href" :  "/reportStatus",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hrStaffPersonReport.type.reportMarital')}",
		  						"href" :  "/reportMarital",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_statistics"
		  					}]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>	
				</ui:content>
				<kmss:authShow roles="ROLE_HRSTAFF_WARNING">
				<ui:content title="${ lfn:message('hr-staff:hr.staff.nav.alert.warning')}"  expand="false">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.last.birthday')}",
		  						"href" :  "/birthday",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_beBirthday"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.contract.expiration')}",
		  						"href" :  "/contractExpiration",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_beagreement"
		  					},{
		  						"text" : "${ lfn:message('hr-staff:hr.staff.nav.trial.expiration')}",
		  						"href" :  "/trial",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_hr_beformal"
		  					}]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>	
				</ui:content>
				</kmss:authShow>
				<kmss:authShow roles="ROLE_HRSTAFF_BACKGROUND,ROLE_HRSTAFF_PAYMENT">
				<ui:content title="${ lfn:message('hr-staff:hr.staff.nav.other.operations')}" expand="false">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					<kmss:authShow roles="ROLE_HRSTAFF_BACKGROUND">
		  					{
								"text" : "${ lfn:message('list.manager') }",
								"icon" : "lui_iconfont_navleft_com_background",
								"router" : true,
								"href" : "/management1"
							}
		  					</kmss:authShow>
		  					]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>	
				</ui:content>
				</kmss:authShow>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
			  <ui:tabpanel id="hrStaffPanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
				<ui:content id="entryStatus1" title="${lfn:message('hr-staff:table.hrStaffEntry.status1')}" cfg-route="{path:'/entryStatus1'}">
					<ui:iframe src="${LUI_ContextPath }/hr/staff/hr_staff_entry/index1.jsp"></ui:iframe>
				</ui:content>
				<ui:content id="entryStatus2" title="${lfn:message('hr-staff:table.hrStaffEntry.status2')}" cfg-route="{path:'/entryStatus2'}">
					<ui:iframe src="${LUI_ContextPath }/hr/staff/hr_staff_entry/index2.jsp"></ui:iframe>
				</ui:content>
				<ui:content id="hrStaffContent" title="${lfn:message('hr-staff:hr.staff.nav.overview') }" cfg-route="{path:'/overview'}">
				 	  <ui:iframe id="overview" src="${LUI_ContextPath }/hr/staff/index_new.jsp"></ui:iframe>
				</ui:content>
				<ui:content id="hrStaffContentOwnerFile" title="${lfn:message('hr-staff:hr.staff.nav.staff.owner.file') }" cfg-route="{path:'/ownerFile'}">
					<ui:iframe id="ownerFile" src="${LUI_ContextPath }/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=view&readOnly=true&fdId=${userSysOrgPersonFdId}"></ui:iframe>
				</ui:content>
				<ui:content id="hrStaffTrackRecord" title="${lfn:message('hr-staff:hr.staff.nav.track.record') }" cfg-route="{path:'/trackRecord'}">
				 	  <ui:iframe id="overview" src="${LUI_ContextPath }/hr/staff/hr_staff_person_track_record/index.jsp"></ui:iframe>
				</ui:content>
				<ui:content id="hrStaffPersonFamily" title="${lfn:message('hr-staff:hrStaffPerson.family')}" cfg-route="{path:'/familyInfo'}">
				 	  <ui:iframe id="overview" src="${LUI_ContextPath }/hr/staff/hr_staff_person_family/index.jsp"></ui:iframe>
				</ui:content>
				<ui:content id="hrStaffContentManage" title="${lfn:message('hr-staff:hr.staff.nav.attendance.management') }" cfg-route="{path:'/management'}">
			 		 <ui:iframe id="hrStaffAttendanceManage" src="${LUI_ContextPath}/hr/staff/hr_staff_attendance_manage/manage/index.jsp"></ui:iframe>
			  	</ui:content>
			  	<ui:content id="hrStaffContentBenefits" title="${lfn:message('hr-staff:hr.staff.nav.benefits') }" cfg-route="{path:'/benefits'}">
				 	 <ui:iframe id="hrStaffEmolumentWelfare" src="${LUI_ContextPath}/hr/staff/hr_staff_emolument_welfare/"></ui:iframe>
				  </ui:content>
			  	<ui:content id="hrStaffContentPayroll" title="${lfn:message('hr-staff:hr.staff.nav.payroll') }" cfg-route="{path:'/payroll'}">
			 	 <ui:iframe id="hrStaffPayrollIssuance" src="${LUI_ContextPath}/hr/staff/hr_staff_payroll_issuance/index.jsp?type=payrollIssuance"></ui:iframe>
			  </ui:content>
			   <ui:content id="hrStaffContentIn" title="${lfn:message('hr-staff:hr.staff.nav.employee.information.in') }" cfg-route="{path:'/informationIn'}">
			 	 <ui:iframe id="hrStaffPersonIn" src="${LUI_ContextPath}/hr/staff/hr_staff_person_info/index.jsp"></ui:iframe>
			  </ui:content>
			   <ui:content id="hrStaffContentQuit" title="${lfn:message('hr-staff:hr.staff.nav.employee.information.quit') }">
			 	 <ui:iframe id="hrStaffPersonQuit" src="${LUI_ContextPath}/hr/staff/hr_staff_person_info/index_quit.jsp"></ui:iframe>
			  	</ui:content>
			   <ui:content id="hrStaffContentWork" title="${lfn:message('hr-staff:hrStaffPersonExperience.type.work') }">
			 	 <ui:iframe id="hrStaffWork" src="${LUI_ContextPath}/hr/staff/hr_staff_person_experience/work/"></ui:iframe>
			  </ui:content>
			 <ui:content id="hrStaffContentContractIndex" title="${lfn:message('hr-staff:hrStaffPersonExperience.type.contract') }">
			 	 <ui:iframe id="hrStaffContentContract" src="${LUI_ContextPath}/hr/staff/hr_staff_person_experience/contract/"></ui:iframe>
			  </ui:content>
			  <ui:content id="hrStaffContentEducation" title="${lfn:message('hr-staff:hrStaffPersonExperience.type.education') }">
			 	 <ui:iframe id="hrStaffEducation" src="${LUI_ContextPath}/hr/staff/hr_staff_person_experience/education/"></ui:iframe>
			  </ui:content>
			  <ui:content id="hrStaffContentTraining" title="${lfn:message('hr-staff:hrStaffPersonExperience.type.training') }">
			 	 <ui:iframe id="hrStaffTraining" src="${LUI_ContextPath}/hr/staff/hr_staff_person_experience/training/"></ui:iframe>
			  </ui:content>
			  <ui:content id="hrStaffContentQualification" title="${lfn:message('hr-staff:hrStaffPersonExperience.type.qualification') }">
			 	 <ui:iframe id="hrStaffQualification" src="${LUI_ContextPath}/hr/staff/hr_staff_person_experience/qualification/"></ui:iframe>
			  </ui:content>
			   <ui:content id="hrStaffContentBonusMalus" title="${lfn:message('hr-staff:hrStaffPersonExperience.type.bonusMalus') }">
			 	 <ui:iframe id="hrStaffBonusMalus" src="${LUI_ContextPath}/hr/staff/hr_staff_person_experience/bonusMalus/"></ui:iframe>
			  </ui:content>
				 <ui:content id="hrStaffContentReportStaffNum" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportStaffNum') }">
				 	 <ui:iframe id="reportStaffNum" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportStaffNum"></ui:iframe>
				  </ui:content>
				  <ui:content id="hrStaffContentReportAge" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportAge') }">
				 	 <ui:iframe id="reportAge" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportAge"></ui:iframe>
				  </ui:content>
				 <ui:content id="hrStaffContentReportWorkTime" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportWorkTime') }">
				 	 <ui:iframe id="reportWorkTime" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportWorkTime"></ui:iframe>
				  </ui:content>
				 <ui:content id="hrStaffContentReportEducation" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportEducation') }">
				 	 <ui:iframe id="reportEducation" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportEducation"></ui:iframe>
				  </ui:content>
				 <ui:content id="hrStaffContentReportStaffingLevel" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportStaffingLevel') }">
				 	 <ui:iframe id="reportStaffingLevel" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportStaffingLevel"></ui:iframe>
				  </ui:content>
				 <ui:content id="hrStaffContentReportStatus" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportStatus') }">
				 	 <ui:iframe id="reportStatus" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportStatus"></ui:iframe>
				  </ui:content>
				 <ui:content id="hrStaffContentReportMarital" title="${lfn:message('hr-staff:hrStaffPersonReport.type.reportMarital') }">
				 	 <ui:iframe id="reportMarital" src="${LUI_ContextPath}/hr/staff/hr_staff_person_report/index.jsp?type=reportMarital"></ui:iframe>
				  </ui:content>
				  <ui:content id="hrStaffContentBirthday" title="${ lfn:message('hr-staff:hr.staff.nav.last.birthday')}">
				 	 <ui:iframe id="hrStaffBirthday" src="${LUI_ContextPath}/hr/staff/hr_staff_person_info/index.jsp?type=warningBirthday"></ui:iframe>
				  </ui:content>
				   <ui:content id="hrStaffContentContract" title="${ lfn:message('hr-staff:hr.staff.nav.contract.expiration')}">
				 	 <ui:iframe id="hrStaffContract" src="${LUI_ContextPath}/hr/staff/hr_staff_person_info/index.jsp?type=warningContract"></ui:iframe>
				  </ui:content>
				   <ui:content id="hrStaffContentTrial" title="${ lfn:message('hr-staff:hr.staff.nav.trial.expiration')}">
				 	 <ui:iframe id="hrStaffTrial" src="${LUI_ContextPath}/hr/staff/hr_staff_person_info/index.jsp?type=warningTrial"></ui:iframe>
				  </ui:content>
		</ui:tabpanel>
	</template:replace>
	   	<template:replace name="script">
   		<%-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 --%>
      	<script type="text/javascript">
      		seajs.use(['lui/framework/module'],function(Module){
      			Module.install('hrStaff',{
					//模块变量
					$var : {
						isAdmin : ''
					},
 					//模块多语言
 					$lang : {
 						hrStaffOverview : '${lfn:message("hr-staff:hr.staff.nav.overview") }',
 						pageNoSelect : '${lfn:message("page.noSelect")}',
 						confirmFiled : '${lfn:message("sys-archives:confirm.filed")}',
 						optSuccess : '${lfn:message("return.optSuccess")}',
 						optFailure : '${lfn:message("return.optFailure")}',
 						buttonDelete : '${lfn:message("button.delete")}',
 						buttonFiled : '${lfn:message("sys-archives:button.filed")}',
 						changeRightBatch : '${lfn:message("sys-right:right.button.changeRightBatch")}'
 					},
 					//搜索标识符
 					$search : ''
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/hr/staff/resource/js/index.js?s_cache=${LUI_Cache}"></script>
	</template:replace>
</template:include>
