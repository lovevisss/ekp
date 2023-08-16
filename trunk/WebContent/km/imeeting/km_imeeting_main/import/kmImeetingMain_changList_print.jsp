<%@page import="com.landray.kmss.util.DateUtil" %>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingMainHistory" %>
<%@page import="java.util.List" %>
<%@page import="com.landray.kmss.util.SpringBeanUtil" %>
<%@page import="com.landray.kmss.km.imeeting.service.IKmImeetingMainHistoryService" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/resource/jsp/common.jsp" %>
<%
    String meetingId = (String) request.getParameter("meetingId");
    IKmImeetingMainHistoryService kmImeetingHistoryService = (IKmImeetingMainHistoryService) SpringBeanUtil
            .getBean("kmImeetingMainHistoryService");
    List<KmImeetingMainHistory> historyList = kmImeetingHistoryService.getChangeHistorysByMeeting(meetingId);
    request.setAttribute("historyList", historyList);
%>

<c:if test="${not empty historyList}">
    <p class="txttitle">
        <bean:message bundle="km-imeeting" key="kmImeetingMainHistory.fdChangeOpt"/>
    </p>
    <table class="tab_listData">
        <tr class="tab_title">
            <td style="width:55px;"><bean:message key="page.serial"/></td>
            <td style="width:120px;"><bean:message bundle="km-imeeting" key="kmImeetingMainHistory.fdOptPerson"/></td>
            <td style="width:180px;"><bean:message bundle="km-imeeting" key="kmImeetingMainHistory.fdOptDate"/></td>
            <td style="width:120px;"><bean:message bundle="km-imeeting"
                                                   key="kmImeetingMainHistory.fdChangeOptType"/></td>
            <td><bean:message bundle="km-imeeting" key="kmImeetingMainHistory.fdChangeOptContent"/></td>
        </tr>
        <c:forEach varStatus="itemStatus" var="history" items="${historyList}">
            <%
                KmImeetingMainHistory kmImeetingMainHistory = (KmImeetingMainHistory) pageContext
                        .getAttribute("history");
                // 操作时间
                String date = DateUtil.convertDateToString(kmImeetingMainHistory.getFdOptDate(),
                        DateUtil.PATTERN_DATETIME);
                request.setAttribute("historyDate", date);

                // 变更事由
                String fdOptContent = kmImeetingMainHistory.getFdOptContent();
                JSONObject content = JSONObject.parseObject(fdOptContent);
                String changeReason = "";
                System.out.println(content.toString());
                if (content.containsKey("changeReason")) {
                    changeReason = content.getString("changeReason");
                }
                request.setAttribute("changeReason", changeReason);
            %>
            <tr class="tab_data">
                <td>${itemStatus.index + 1}</td>
                <td>${history.fdOptPerson.fdName}</td>
                <td>${historyDate}</td>
                <td><bean:message bundle="km-imeeting"
                                  key="enumeration_km_imeeting_main_history_fd_opt_type_change"/></td>
                <td style="text-align: left;">${changeReason}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>