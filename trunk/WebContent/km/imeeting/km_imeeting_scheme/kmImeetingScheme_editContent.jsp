<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<html:hidden property="fdId"/>
<html:hidden property="docStatus"/>
<html:hidden property="method_GET"/>
<ui:content id="kmImeetingSchemeContent" titleicon="lui-tab-icon tab-icon-02" title="详情" expand="true">
    <c:import url="/sys/xform/include/sysForm_edit.jsp"
              charEncoding="UTF-8">
        <c:param name="formName" value="kmImeetingSchemeForm"/>
        <c:param name="fdKey" value="ImeetingScheme"/>
        <c:param name="useTab" value="false"/>
    </c:import>
</ui:content>

<ui:content id="attPreview" titleicon="lui-tab-icon tab-icon-02" title="正文">
    <div id="attachment_preview">
        <iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="previewAttFrame"
                src="${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/import/preview_noDataM.jsp"></iframe>
    </div>
</ui:content>
<c:choose>
    <c:when test="${param.approveModel eq 'right'}">
        <ui:event event="indexChanged" args="data">
            var panel = data.panel;
            var selectedContent = panel.contents[data.index.after];
            if (selectedContent.id == "attPreview") {
            initContentAtt();
            }
        </ui:event>
    </c:when>
    <c:otherwise>
        <ui:event event="toggleAfter" args="data">
            if (data.index === 1) {
            var contentObj = data.panel.children;
            for (let i = 0; i < contentObj.length; i++) {
            if (contentObj[i].cid === "attPreview"
            && contentObj[i].isShow) {
            initContentAtt();
            }
            }
            }
        </ui:event>
    </c:otherwise>
</c:choose>

<%-- 发布机制隐藏页面 --%>
<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
    <c:param name="formName" value="kmImeetingSchemeForm"/>
    <c:param name="fdKey" value="ImeetingScheme"/>
    <c:param name="isShow" value="false"/>
</c:import>
<script>
    Com_IncludeFile("security.js", null, "js");
    seajs.use(['km/imeeting/resource/js/dateUtil', 'lui/topic'], function (dateUtil, topic) {
        //自定义校验器:校验召开时间不能晚于结束时间
        var validation = $KMSSValidation();//校验框架
        validation.addValidator('schemeTime', '方案结束时间不可早于方案开始时间', function (v, e, o) {
            var fdBeginDate = $('[name="fdBeginDate"]');
            var fdEndDate = $('[name="fdEndDate"]');
            var result = true;
            if (fdBeginDate.val() && fdEndDate.val()) {
                var start = dateUtil.parseDate(fdBeginDate.val());
                var end = dateUtil.parseDate(fdEndDate.val());
                if (start.getTime() >= end.getTime()) {
                    result = false;
                }
            }
            if (result) {
                topic.publish("km/imeeting/scheme/time/validator", $(e).attr('name'));
            }
            return result;
        });

        topic.subscribe('km/imeeting/scheme/time/validator', function (curDomName) {
            if (curDomName === 'fdEndDate') {
                let remarkDom = $('#_fdBeginDate').next();
                let remarkTextDom = remarkDom.find('.validation-advice-msg');
                if (remarkTextDom.length > 0) {
                    if ($(remarkTextDom).text().trim() === '方案结束时间不可早于方案开始时间') {
                        remarkDom.remove();
                    }
                }
            } else {
                let remarkDom = $('#_fdEndDate').next();
                let remarkTextDom = remarkDom.find('.validation-advice-msg');
                if (remarkTextDom.length > 0) {
                    if ($(remarkTextDom).text().trim() === '方案结束时间不可早于方案开始时间') {
                        remarkDom.remove();
                    }
                }
            }
        });
    });
</script>