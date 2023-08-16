<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 正文无附件不展示不加载附件代码 --%>
<c:if test="${isShowContentTabpanel eq 'true'}">
<div data-dojo-type="dojox/mobile/View" id="_contentView" class="tabContentView">
	<div class="muiFormContent">
		<c:if test="${not empty _sysAttMain.fdId }">
		    <%--是否有编辑正文权限--%>
			<c:set var="editContent" value="false"/>
			<c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
				<c:set var="editContent" value="true"/>
			</c:if>
			<c:if test="${_isWpsCloudEnable eq 'true' or _isWpsCenterEnable eq 'true'}">
				<c:if test="${kmImissiveSendMainForm.docStatus == '20'}">
					<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
						<c:set var="editContent" value="true"/>
					</kmss:auth>
				</c:if>
				<%--套红 --%>
				<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
					<c:set var="editContent" value="true" />
				</c:if>
				<%--清稿 --%>
				<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
					<c:set var="editContent" value="true" />
				</c:if>
			</c:if>

			<%--下载正文逻辑--%>
			<%@ include file="/km/imissive/mobile/send/sendBtn.jsp" %>

			<%--正文展示--%>
			<%@ include file="/km/imissive/mobile/tabviewContent.jsp" %>

		</c:if>
	</div>
</div>
</c:if>
<div data-dojo-type="dojox/mobile/View" id="trackView">
<div class="revisionInfo_wrapper">
	<c:if test="${kmImissiveSendMainForm.docStatus eq '10' or kmImissiveSendMainForm.docStatus eq '11' or kmImissiveSendMainForm.docStatus eq '20'}">
		<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${kmImissiveSendMainForm.fdId}" requestMethod="GET">
		<div class="detailInfo">
			<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
					data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"revisionView",transitionDir:1,transition:"slide"'><bean:message  bundle="km-imissive" key="kmImissiveSendMain.revision.title"/></div>
		</div>
		</kmss:auth>
	</c:if>
	<c:if test="${kmImissiveSendMainForm.fdMissiveType != '2'}">
		<div class="detailInfo">
			<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
					data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"distributeRecordView",transitionDir:1,transition:"slide"'>分发记录</div>
		</div>
	</c:if>
	<c:if test="${kmImissiveSendMainForm.fdMissiveType != '1'}">
		<div class="detailInfo">
			<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
					data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"reportRecordView",transitionDir:1,transition:"slide"'>上报记录</div>
		</div>
	</c:if>
</div>
</div>

