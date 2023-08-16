<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<ui:content title="会中设置" expand="true" >
	 <div class="lui_form_content_frame" style="margin-top:15px">
	 	<div class="tb_simple_container">
			<table class="tb_normal" width=100%>
				<tr>
					<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
						<c:choose>
							<c:when test="${_isBoenEnable}">
								<spaan>
									<c:out value="开启会中系统"></c:out>
								</spaan>
								<c:if test="${isBoenBtn eq 'true'}">
									<%-- <ui:switch property="boenEnable" checkVal="true" unCheckVal="false" enabledText="已开启" disabledText="已关闭" checked="true" showType="show" id="boenEnableBtn"></ui:switch> --%>
									<!-- &nbsp;&nbsp;&nbsp;<input type="button" class="lui_form_button" value="同步终端" bundle="km-imeeting" onclick="selectTopicList();" />  -->
								</c:if>
							</c:when>
							<c:otherwise>
								<span>
									<c:out value="开启会中系统"></c:out>
								</span>
								<ui:switch property="value(boenEnable)" checkVal="2" unCheckVal="1" enabledText="已开启" disabledText="已关闭" checked="false" showType="show" id="boenEnableBtn"></ui:switch>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<c:if test="${_isBoenEnable}">
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							会控人员
						</td>
						<td width="85%" colspan="3">
							<xform:address  style="width:95%;" subject="会控人员" textarea="true" showStatus="view"  propertyId="fdControlPersonId" propertyName="fdControlPersonName" 
										orgType="ORG_TYPE_PERSON" mulSelect="false" required="true">
							</xform:address>
						</td>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							监票人员
						</td>
						<td width="85%" class="" colspan="3">
								<xform:address  style="width:95%;" subject="监票人员" textarea="true" showStatus="view"  propertyId="fdBallotPersonIds" propertyName="fdBallotPersonNames" 
										orgType="ORG_TYPE_PERSON" mulSelect="false" required="true">
							</xform:address>
						</td>
					</tr>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							开启表决
						</td>
						<td width="85%" class="" colspan="3">
							<ui:switch property="fdBallotEnable" checkVal="true" unCheckVal="false" enabledText="已开启" disabledText="已关闭" showType="show" ></ui:switch>
						</td>
					</tr>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							开启投票
						</td>
						<td width="85%" class="" colspan="3">
							<ui:switch property="fdVoteEnable" checkVal="true" unCheckVal="false" enabledText="已开启" disabledText="已关闭"  showType="show"></ui:switch>
							<span id="voteConfig" onclick="voteConfig();" style="display:none;cursor: pointer;" class="lui_text_primary" >投票配置</span>
						</td>
					</tr>
					<tr>
						<td width="15%" class="td_normal_title td_align_center">
							签到开始时间
						</td>
						<td width="35%" class="">
							<xform:datetime property="signStartTime" showStatus="view" dateTimeType="datetime" required="true" style="width:95%"></xform:datetime>
						</td>
						<td width="15%" class="td_normal_title td_align_center">
							签到结束时间
						</td>
						<td width="35%" class="">
							<xform:datetime property="signEndTime" showStatus="view" dateTimeType="datetime" required="true" style="width:95%"></xform:datetime>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</ui:content>