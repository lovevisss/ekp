<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<ui:content title="会中设置" expand="true" >
	 <div class="lui_form_content_frame">
	 	<div class="tb_simple_container">
			<table class="tb_normal" width=100%>
				<c:if test="${param._isBoenEnable eq 'true'}">
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							会控人员
						</td>
						<td width="85%" colspan="3">
							<xform:address  style="width:95%;" subject="会控人员" textarea="true" showStatus="edit"  propertyId="fdControlPersonId" propertyName="fdControlPersonName" 
										orgType="ORG_TYPE_PERSON" mulSelect="false" required="true" >
							</xform:address>
						</td>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							监票人员
						</td>
						<td width="85%" class="" colspan="3">
								<xform:address  style="width:95%;" subject="监票人员" textarea="true" showStatus="edit"  propertyId="fdBallotPersonIds" propertyName="fdBallotPersonNames" 
										orgType="ORG_TYPE_PERSON" mulSelect="false" required="true">
							</xform:address>
						</td>
					</tr>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							开启表决
						</td>
						<td width="85%" class="" colspan="3">
							<ui:switch property="fdBallotEnable" checkVal="true" unCheckVal="false" enabledText="已开启" disabledText="已关闭" ></ui:switch>
						</td>
					</tr>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							开启投票
						</td>
						<td width="85%" class="" colspan="3">
							<c:choose>
								<c:when test="${kmImeetingMainForm.fdVoteEnable eq 'true'}">
									<c:set var="voteConfigDisplayStyle" value=""></c:set>
								</c:when>
								<c:otherwise>
									<c:set var="voteConfigDisplayStyle" value="display:none;"></c:set>
								</c:otherwise>
							</c:choose>
							<ui:switch property="fdVoteEnable" checkVal="true" unCheckVal="false" enabledText="已开启" disabledText="已关闭" onValueChange="voteEnableChange()" ></ui:switch>
							<span id="voteConfig" onclick="voteConfig();" style="${voteConfigDisplayStyle}cursor: pointer;" class="lui_text_primary" >投票配置</span>
						</td>
					</tr>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							签到开始时间
						</td>
						<td width="35%">
							<xform:datetime property="signStartTime" dateTimeType="datetime" required="true" style="width:95%" subject="签到开始时间"></xform:datetime>
						</td>
						<td width="15%" class="td_normal_title td_align_center">
							签到结束时间
						</td>
						<td width="35%">
							<xform:datetime property="signEndTime" dateTimeType="datetime" required="true" style="width:95%" subject="签到结束时间"></xform:datetime>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</ui:content>