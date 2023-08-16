<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="mobile.view" compatibleMode="true" newMui="true" tiny="true">

	<template:replace name="title">
		会议通知
	</template:replace>
	<template:replace name="csshead">
		<mui:cache-file name="mui-imeeting-view.css" cacheType="md5"/>
	</template:replace>

	<template:replace name="content">
		<div id="scrollView" data-dojo-type="mui/view/DocScrollableView">
			<div id="baseView" data-dojo-type="dojox/mobile/View">
				<table class="muiSimple" cellpadding="0" cellspacing="0" style="margin: 1.0rem">
					<tr>
						<td class="muiTitle">
							<c:out value="会议名称"></c:out>
						</td>
						<td>
							<c:out value="${kmImeetingMainForm.fdName}"></c:out>
						</td>
					</tr>
					<tr>
						<td class="muiTitle">
							<c:out value="会议时间"></c:out>
						</td>
						<td>
							<c:out value="${kmImeetingMainForm.fdHoldDate}"></c:out>
							<span style="position: relative;">~</span>
							<c:out value="${kmImeetingMainForm.fdFinishDate}"></c:out>
						</td>
					</tr>
					<tr>
						<td class="muiTitle">
							<c:out value="会议地点"></c:out>
						</td>
						<td>
							<c:out value="${kmImeetingMainForm.fdPlaceName}"></c:out>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</template:replace>
	
</template:include>
