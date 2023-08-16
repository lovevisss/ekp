<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.view">
    <template:replace name="head">
        <style type="text/css">
     		.lui_paragraph_title {
     			font-size: 15px;
     			color: #15a4fa;
     	    	padding: 15px 0px 5px 0px;
     		}
     		.lui_paragraph_title span {
     			display: inline-block;
     			margin: -2px 5px 0px 0px;
     		}
     		.inputsgl[readonly], .tb_normal .inputsgl[readonly] {
     		    border: 0px;
     		    color: #868686
     		}
        </style>
        <script type="text/javascript">
            var formInitData = {
            };
            var messageInfo = {
            };

            var initData = {
                contextPath: '${LUI_ContextPath}',
            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
    	</script>
    </template:replace>

    <template:replace name="content">
        <html:form action="/km/imeeting/km_imeeting_res/kmImeetingRes.do">
            <table class="tb_normal" width="100%">
            	<tr>
            		<td class="td_normal_title" width="15%">
                        会议名称
                    </td>
                    <!--会议名称 -->
                    <td width="85.0%" colspan="3">
                       <c:out value="${kmImeetingMainForm.fdName}"></c:out>
                    </td>
                </tr>
                <tr>
                	 <td class="td_normal_title" width="15%">
                        会议时间
                    </td>
                    <!-- 会议时间 -->
                    <td width="85.0%" colspan="3">
                    	<c:out value="${kmImeetingMainForm.fdHoldDate}"></c:out>
						<span style="position: relative;">~</span>
						<c:out value="${kmImeetingMainForm.fdFinishDate}"></c:out>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        会议地点
                    </td>
                    <!-- 会议地点 -->
                    <td colspan="3" width="85.0%">
                    	<c:out value="${kmImeetingMainForm.fdPlaceName}"></c:out>
                    </td>
                </tr>
            </table>
        </html:form>
    </template:replace>
</template:include>