<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttViewerUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	String viewerStyle = request.getAttribute("viewerStyle").toString();
	String fileKeySufix = request.getParameter("fileKeySufix");
	boolean isLowerThanIE8 = (SysAttViewerUtil.isLowerThanIE8(request) ? true : false);
	String highFidelity = request.getAttribute("highFidelity").toString();
	if (viewerStyle.toLowerCase().contains("pdf")|| viewerStyle.toLowerCase().contains("ppt")) {
		if (isLowerThanIE8) {
			fileKeySufix = "-img";
		} else if (highFidelity.contains("html")) {
			if(StringUtil.isNull(fileKeySufix)){
				fileKeySufix = "-svg";
			}
		} else {
			fileKeySufix = "-img";
		}
	}
	if (viewerStyle.toLowerCase().contains("word")) {
		if (isLowerThanIE8) {
			fileKeySufix = "-img";
		} else {
			if (highFidelity.contains("html")) {
				if(StringUtil.isNull(fileKeySufix)){
					fileKeySufix = "-svg";
				}
			} else if (highFidelity.contains("pic")) {
				fileKeySufix = "-img";
			} else {
				if(StringUtil.isNull(fileKeySufix)){
					fileKeySufix = "-svg";
				}
			}
		}
	}
	request.setAttribute("fileKeySufix", fileKeySufix);
	request.setAttribute("totalPageCount",
			"-img".equals(fileKeySufix) ? request.getAttribute("picPageCount").toString()
					: request.getAttribute("htmlPageCount").toString());
	request.setAttribute("isLowerThanIE8", (isLowerThanIE8 ? "true" : "false"));
	request.setAttribute("highFidelity", StringUtil.isNotNull(highFidelity)
			&& (highFidelity.contains("html") || highFidelity.contains("pic")) ? "true" : "false");
%>
<template:include ref="default.simple">
	<template:replace name="title">
		<%
			Object obj = request.getAttribute("fileFullName");
					if (obj != null) {
						String fileName = obj.toString();
						if (fileName.indexOf(".") >= 0)
							out.append(fileName.substring(0, fileName
									.lastIndexOf(".")));

					}
		%>
	</template:replace>
	<template:replace name="head">
		<template:super />
		<link rel="stylesheet" type="text/css" href="${fullContextPath}/sys/anonym/dataview/attachment/viewer/resource/common/css/common.css?s_cache=${LUI_Cache }" />
		<c:choose>
			<c:when test="${toolPosition == 'top'}">
				<link rel="stylesheet" type="text/css" href="${fullContextPath}/sys/anonym/dataview/attachment/viewer/resource/common/css/innerviewer.css?s_cache=${LUI_Cache }" />
			</c:when>
			<c:when test="${showAllPage == 'true'}">
				<link rel="stylesheet" type="text/css" href="${fullContextPath}/sys/anonym/dataview/attachment/viewer/resource/common/css/allpageviewer.css?s_cache=${LUI_Cache }" />
			</c:when>
			<c:otherwise>
				<link rel="stylesheet" type="text/css" href="${fullContextPath}/sys/anonym/dataview/attachment/viewer/resource/common/css/newopen.css?s_cache=${LUI_Cache }" />
			</c:otherwise>
		</c:choose>
		
		<script type="text/javascript" src="${fullContextPath}/sys/anonym/dataview/attachment/viewer/resource/common/js/aspose_ckresize.js"></script>
		<script type="text/javascript" src="${fullContextPath}/sys/anonym/dataview/attachment/viewer/resource/common/js/commonfuncs.js?s_cache=${LUI_Cache }"></script>
		<script type="text/javascript">
			var totalPageNum = parseInt("${totalPageCount}");
			var converterKey = "${converterKey}";
			var viewerStyle = "${viewerStyle}";
			var isLowerThanIE8 = "${isLowerThanIE8}";
			var fileKeySufix="${fileKeySufix}";
			var fullScreen="${lfn:escapeJs(fullScreen)}";
			var canCopy="${canCopy}";
			var fdId="${fdId}";
			var highFidelity="${highFidelity}";
			var currentPage=parseInt("${lfn:escapeJs(currentPage)}");
			var showAllPage = "${lfn:escapeJs(showAllPage)}";
			var toolPosition = "${lfn:escapeJs(toolPosition)}";
			var goFullScreenHint = "${lfn:message('sys-attachment:viewer_hint_fullscreen')}";
			var exitFullScreenHint = "${lfn:message('sys-attachment:viewer_hint_cancelfullscreen')}";
			var dataSrc=Com_Parameter.ContextPath+"sys/anonym/sysAnonymData.do";
			var waterMarkConfig=${waterMarkConfig};
			LUI.ready( function() {
				commonFuncs.initialHandlers();
				var browser=commonFuncs.getBrowser();
				if(browser=="IE"&&fullScreen=="yes"){
					commonFuncs.addCss("fullscreencss",Com_Parameter.ContextPath+"sys/anonym/dataview/attachment/viewer/resource/common/css/fullscreen.css?s_cache=${LUI_Cache }");					
					commonFuncs.fsCommonHandler();
					commonFuncs.bindFsKeyDown();
					if(commonFuncs.contains(viewerStyle, "ppt", true)){
						commonFuncs.bindFsPptEvent();
						commonFuncs.addJs("pptfullscreenjs", Com_Parameter.ContextPath+"sys/anonym/dataview/attachment/viewer/resource/common/js/pptfullscreen.js?s_cache=${LUI_Cache }");
					}else{
						commonFuncs.addJs("newopenjs", Com_Parameter.ContextPath+"sys/anonym/dataview/attachment/viewer/resource/common/js/newopen.js?s_cache=${LUI_Cache }",currentPage);
					}
				}else{
					commonFuncs.addJs("aspose_ckresizejs",Com_Parameter.ContextPath+"sys/anonym/dataview/attachment/viewer/resource/common/js/aspose_ckresize.js");
					commonFuncs.addJs("newopenjs",Com_Parameter.ContextPath+"sys/anonym/dataview/attachment/viewer/resource/common/js/newopen.js?s_cache=${LUI_Cache }",currentPage);
				}
				CKResize.totalPageNum = totalPageNum;
				CKResize.showAllPage = showAllPage;
				CKResize.____ckresize____(true);
			});
		</script>
	</template:replace>
	<template:replace name="body">
		<div id="readerOuterContainer">
			<div id="readerTop">
				<div class="top_left">
					<div class="attachment">
						<ul>
							<li>
								<i class="icon"><img src="${fullContextPath}/resource/style/common/fileIcon/${attIconName }" /></i>
								<strong>${fileFullName }</strong><span class="text-muted">(${fileSize })</span>
							 </li>
						</ul>
					</div>
				</div>
			</div>
			<div id="readerMain">
				<div id="mainLeft" class="pageBtn">
					<a href="javascript:void(0);" class="btn_icon" title="" onclick="commonFuncs.prev();"></a>
				</div>
				<div id="mainMiddle"></div>
				<div id="mainRight" class="pageBtn">
					<a href="javascript:void(0);" class="btn_icon" title="" onclick="commonFuncs.next();"></a>
				</div>
				<div id="zoomButton">
					<a class="zoom-icon" href="javascript:void(0);" title="${lfn:message('sys-attachment:viewer_hint_cancelfullscreen')}" onclick="commonFuncs.changeScreenStatus();"></a>
				</div>
			</div>
			<div id="readerBottom" class="pageBottom">
				<div id="bottomContainer">
					<div class="pageNavContainer">
						<div class="pageNav">
							<ul>
								<li class="arrow"><a href="javascript:void(0);" id="prevBtn" class="unable prev" onclick="commonFuncs.prev(event);"></a></li>
								<li class="pages"><input id="currentPageIndex" type="text" onkeydown="return commonFuncs.onPageKeyDown(event)" onkeyup="commonFuncs.onPageKeyUp(event);" />/<span id="totalPageCount"></span></li>
								<li class="arrow"><a href="javascript:void(0);" id="nextBtn" class="next" onclick="commonFuncs.next(event);"></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</template:replace>
</template:include>