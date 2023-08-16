<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div data-dojo-type="dojox/mobile/View" id="_contentView" class="tabContentView">
	<div class="muiFormContent">
		<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
			<c:if test="${not empty _sysAttMain.fdId }">
				<%--是否有编辑正文权限--%>
				<c:set var="editContent" value="false"/>
				<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
					<c:set var="editContent" value="true"/>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus =='20'}">
					<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
						<c:set var="editContent" value="true"/>
					</kmss:auth>
				</c:if>

				<%--下载正文逻辑--%>
				<%@ include file="/km/imissive/mobile/sign/signBtn.jsp" %>
				<%--正文展示--%>
				<%@ include file="/km/imissive/mobile/tabviewContent.jsp" %>
			</c:if>
		</c:if>
	</div>	
</div>
