<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/resource/jsp/common.jsp" %>
<script type="text/javascript">Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">DocList_Info.push('TABLE_DocList');</script>
<script type="text/javascript">
    var topicListIds = "";
</script>
<div class="muiFlowInfoW" style="border-bottom: 0;">
    <table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
        <tr data-dojo-type="mui/form/Template" KMSS_IsReferRow="1" style="display:none;" border='0'>
            <td class="detail_wrap_td">
                <table class="muiSimple">
                    <tr celltr-title="true">
                        <td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
                            <div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
                            <span class="index" onclick="expandRow(this);" style="color: #4285F4;">
								!{index}
							</span>
                            <span class="agendaSubject" onclick="expandRow(this);">
							</span>
                            <xform:editShow>
                                <div class="muiDetailTableDel" onclick="deleteRow(this);" style="color: #4285F4;">
                                    <bean:message key="button.delete"/>
                                </div>
                            </xform:editShow>
                        </td>
                    </tr>
                    <!-- 会议议题 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            ${lfn:message('km-imeeting:kmImeetingTopic.docSubject')}
                        </td>
                        <td>
							<span class="td_subject">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].docSubject'/>
							</span>
                            <input type='hidden' name='kmImeetingAgendaForms[!{index}].fdMainId'
                                   value='${kmImeetingMainForm.fdId}'/>
                        </td>
                    </tr>
                    <!-- 承办单位 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            <bean:message bundle="km-imeeting" key="kmImeetingTopic.organizer"/>
                        </td>
                        <td>
							<span class="td_chargeUnit">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdChargeUnitId'/>
							</span>
                        </td>
                    </tr>
                    <!-- 汇报人 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            ${lfn:message('km-imeeting:kmImeetingAgenda.docReporter')}
                        </td>
                        <td>
							<span class="td_reporter">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].docReporterId'/>
							</span>
                        </td>
                    </tr>
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            <bean:message key="kmImeetingTopic.fdExpectStartTime" bundle="km-imeeting"/>
                        </td>
                        <td>
                            <xform:datetime property="kmImeetingAgendaForms[!{index}].fdExpectStartTime"
                                            validators="after valExpectTime" required="true" mobile="true"
                                            subject="${lfn:message('km-imeeting:kmImeetingTopic.fdExpectStartTime') }"/>
                        </td>
                    </tr>
                    <!-- 建议列席单位 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            <bean:message key="kmImeetingTopic.fdAttendUnit" bundle="km-imeeting"/>
                        </td>
                        <td>
							<span class="td_attendUnit">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdAttendUnitIds'
                                       class="topicUnitId"/>
							</span>
                        </td>
                    </tr>
                    <!-- 建议旁听单位 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            <bean:message key="kmImeetingTopic.fdListenUnit" bundle="km-imeeting"/>
                        </td>
                        <td>
							<span class="td_listenUnit">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdListenUnitIds'
                                       class="topicUnitId"/>
							</span>
                        </td>
                    </tr>
                    <!-- 材料负责人 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            ${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}
                        </td>
                        <td>
							<span class="td_respons">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].docResponsId'/>
							</span>
                        </td>
                    </tr>
                    <!-- 上会所需材料 -->
                    <tr data-celltr="true">
                        <td class="muiTitle">
                            ${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}
                        </td>
                        <td>
							<span class="td_fromTopic">
								<input type='hidden' name='kmImeetingAgendaForms[!{index}].fdFromTopicId'
                                       class="muiTopicId"/>
							</span>
                            <span class="td_attachment"></span>
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <td>
							<span class="td_topicCreator">
								<input type="hidden" name="kmImeetingAgendaForms[!{index}].topicCreatorId">
							</span>
                            <span class="td_topicCreatorN">
								<input type="hidden" name="kmImeetingAgendaForms[!{index}].topicCreatorName">
							</span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <c:forEach items="${kmImeetingMainForm.kmImeetingAgendaForms}" var="kmImeetingAgendaitem" varStatus="vstatus">
            <tr KMSS_IsContentRow="1" data-celltr="true">
                <td class="detail_wrap_td">
                    <table class="muiSimple">

                        <tr celltr-title="true">
                            <td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
                                <div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
                                <span class="index" onclick="expandRow(this);" style="color: #4285F4;">
                                        ${vstatus.index+1}
                                </span>
                                <span class="agendaSubject" onclick="expandRow(this);">
								</span>
                                <c:if test="${empty kmImeetingMainForm.fdSchemeId}">
                                    <xform:editShow>
                                        <div class="muiDetailTableDel" onclick="deleteRow(this);"
                                             style="color: #4285F4;">
                                            <bean:message key="button.delete"/>
                                        </div>
                                    </xform:editShow>
                                </c:if>
                            </td>
                        </tr>

                        <!-- 会议议题 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingTopic.docSubject')}
                            </td>
                            <td>
								${kmImeetingAgendaitem.docSubject}
								<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].docSubject"
									   value="${kmImeetingAgendaitem.docSubject}"/>
                                <xform:text property="kmImeetingAgendaForms[${vstatus.index}].fdId" showStatus="noShow"
                                            value="${kmImeetingAgendaitem.fdId}" mobile="true"/>
                                <xform:text property="kmImeetingAgendaForms[${vstatus.index}].fdMainId"
                                            showStatus="noShow" value="${kmImeetingMainForm.fdId}"
                                            mobile="true"/>
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId"
                                       value="${kmImeetingAgendaitem.fdFromTopicId}" class="muiTopicId"/>
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].topicCreatorId"
                                       value="${kmImeetingAgendaitem.topicCreatorId}"/>
                            </td>
                        </tr>
                        <!-- 汇报人 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingAgenda.docReporter')}
                            </td>
                            <td>
                                    ${kmImeetingAgendaitem.docReporterName}
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].docReporterId"
                                       value="${kmImeetingAgendaitem.docReporterId}"/>
                            </td>
                        </tr>
                        <!-- 汇报人 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                <bean:message bundle="km-imeeting" key="kmImeetingTopic.organizer"/>
                            </td>
                            <td>
                                    ${kmImeetingAgendaitem.fdChargeUnitName}
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdChargeUnitId"
                                       value="${kmImeetingAgendaitem.fdChargeUnitId}"/>
                            </td>
                        </tr>
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingAgenda.fdExpectStartTime')}
                            </td>
                            <td>
                                <xform:datetime property="kmImeetingAgendaForms[${vstatus.index}].fdExpectStartTime"
                                                showStatus="edit" subject="议题开始时间" mobile="true" required="true"
                                                validators="after valExpectTime"/>
                            </td>
                        </tr>
                        <!-- 建议列席单位 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingTopic.fdAttendUnit')}
                            </td>
                            <td>
                                    ${kmImeetingAgendaitem.fdAttendUnitNames}
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdAttendUnitIds"
                                       value="${kmImeetingAgendaitem.fdAttendUnitIds}" class="topicUnitId"/>
                            </td>
                        </tr>
                        <!-- 建议旁听单位 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingTopic.fdListenUnit')}
                            </td>
                            <td>
                                    ${kmImeetingAgendaitem.fdListenUnitNames}
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdListenUnitIds"
                                       value="${kmImeetingAgendaitem.fdListenUnitIds}" class="topicUnitId"/>
                            </td>
                        </tr>
                        <!-- 材料负责人 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}
                            </td>
                            <td>
                                    ${kmImeetingAgendaitem.docResponsName}
                                <input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].docResponsId"
                                       value="${kmImeetingAgendaitem.docResponsId}"/>
                            </td>
                        </tr>
                        <!-- 上会所需材料 -->
                        <tr data-celltr="true">
                            <td class="muiTitle">
                                    ${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty param.fdSchemeIds}">
                                        <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
                                            <c:param name="fdKey"
                                                     value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdAttKeyId}"/>
                                            <c:param name="fdModelName"
                                                     value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
                                            <c:param name="fdModelId" value="${kmImeetingMainForm.fdSchemeId}"/>
                                            <c:param name="fdViewType" value="simple"/>
                                            <c:param name="isShowDownloadCount" value="false"/>
                                        </c:import>
                                    </c:when>
                                    <c:when test="${not empty kmImeetingAgendaitem.fdAttKeyId }">
                                        <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
                                            <c:param name="fdKey"
                                                     value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdAttKeyId }"/>
                                            <c:param name="fdModelName"
                                                     value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
                                            <c:param name="fdModelId" value="${kmImeetingMainForm.fdId }"/>
                                            <c:param name="fdViewType" value="simple"/>
                                            <c:param name="isShowDownloadCount" value="false"/>
                                        </c:import>
                                    </c:when>
                                    <c:otherwise>
                                        <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
                                            <c:param name="fdKey"
                                                     value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdId }"/>
                                            <c:param name="fdModelName"
                                                     value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
                                            <c:param name="fdModelId" value="${kmImeetingMainForm.fdId }"/>
                                            <c:param name="fdViewType" value="simple"/>
                                        </c:import>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <script>
                topicListIds += "${kmImeetingAgendaitem.fdFromTopicId},";
            </script>
        </c:forEach>
    </table>

    <script type="text/javascript">
        window.store = [{
            text: '<bean:message key="kmImeetingTopic.fdIsAccept.mobile.all" bundle="km-imeeting"/>',
            value: ''
        },
            {text: '<bean:message key="kmImeetingTopic.fdIsAccept.mobile.false" bundle="km-imeeting"/>', value: '0'},
            {text: '<bean:message key="kmImeetingTopic.fdIsAccept.mobile.true" bundle="km-imeeting"/>', value: '1'}];
    </script>
</div>
<c:set var="showBtn" value="fasle"/>
<c:if test="${empty kmImeetingMainForm.fdSchemeId}">
    <c:set var="showBtn" value="true"/>
</c:if>
<c:if test="${showBtn eq 'true'}">
    <div
            data-dojo-type="km/imeeting/mobile/resource/js/TopicSelectorButton"
            data-dojo-mixins="km/imeeting/mobile/resource/js/TopicSelectorMixin"
            data-dojo-props="isMul:true"
            id="selectTopicButton" style="display:inline-block;">
        <div class="kmImeetingULBtnBox">
			<span class="muiImeetingSIFont kmImeetingULBtn">
				请选择议题
			</span>
            <span class="fontmuis muis-to-right"></span>
        </div>
    </div>
</c:if>
<script type="text/javascript">
    require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request',
            'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading"],
        function (ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading) {

            // dialog回调
            topic.subscribe('km/imeeting/topicselector/result', function (res) {
                var topicIds = "";
                if (Object.prototype.toString.call(res) == '[object Array]') {
                    for (var i = 0; i < res.length; i++) {
                        topicIds += res[i].fdId + ";";
                    }
                } else {
                    topicIds = res.fdId;
                }
                if (topicIds) {
                    var data = new KMSSData();
                    var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadTopicList&ids=" + topicIds;
                    var tableId = "TABLE_DocList";
                    data.SendToUrl(url, function (data) {
                        var results = eval("(" + data.responseText + ")");
                        if (results.length > 0) {
                            for (var i = 0; i < results.length; i++) {
                                if (topicListIds.indexOf(results[i].fdTopicId, 0) == -1) {
                                    topicListIds += results[i].fdTopicId + ",";

                                    // table 添加逻辑
                                    var newRow = DocList_AddRow(tableId);
                                    newRow.dojoClick = true;
                                    parser.parse(newRow).then(function () {
                                        var tabInfo = DocList_TableInfo[tableId];
                                        if (tabInfo['_getcols'] == null) {
                                            tabInfo.fieldNames = [];
                                            tabInfo.fieldFormatNames = [];
                                            DocListFunc_AddReferFields(tabInfo, newRow, "INPUT");
                                            DocListFunc_AddReferFields(tabInfo, newRow, "TEXTAREA");
                                            DocListFunc_AddReferFields(tabInfo, newRow, "SELECT");
                                            tabInfo['_getcols'] = 1;
                                        }
                                        detail_fixNo();
                                        if (results[i].docSubject) {
                                            $(newRow).find(".td_subject input").val(results[i].docSubject);
                                            $(newRow).find(".td_subject").append(results[i].docSubject);
                                        }
                                        if (results[i].fdChargeUnitId) {
                                            $(newRow).find(".td_chargeUnit input").val(results[i].fdChargeUnitId);
                                            $(newRow).find(".td_chargeUnit").append(results[i].fdChargeUnitName);
                                        }
                                        if (results[i].fdReporterId) {
                                            $(newRow).find(".td_reporter input").val(results[i].fdReporterId);
                                            $(newRow).find(".td_reporter").append(results[i].fdReporterName);
                                        }
                                        if (results[i].fdAttendUnitIds) {
                                            $(newRow).find(".td_attendUnit input").val(results[i].fdAttendUnitIds);
                                            $(newRow).find(".td_attendUnit").append(results[i].fdAttendUnitNames);
                                        }
                                        if (results[i].fdListenUnitIds) {
                                            $(newRow).find(".td_listenUnit input").val(results[i].fdListenUnitIds);
                                            $(newRow).find(".td_listenUnit").append(results[i].fdListenUnitNames);
                                        }
                                        if (results[i].fdMaterialStaffId) {
                                            $(newRow).find(".td_respons input").val(results[i].fdMaterialStaffId);
                                            $(newRow).find(".td_respons").append(results[i].fdMaterialStaffName);
                                        }
                                        if (results[i].topicCreatorId) {
                                            $(newRow).find(".td_topicCreator input").val(results[i].topicCreatorId);
                                            $(newRow).find(".td_topicCreatorN input").val(results[i].topicCreatorName);
                                        }


                                        // 附件
                                        var attIds = "";
                                        var mainAtt = results[i].mainAtt;
                                        var mainHtml = "<table style='border:none'>";
                                        for (var m = 0; m < mainAtt.length; m++) {
                                            if (mainAtt[m].fdId != "") {
                                                attIds += mainAtt[m].fdId + ";";
                                                var fileIcon = window.GetIconNameByFileName(mainAtt[m].fdFileName);
                                                mainHtml += "<tr><td style='padding-right:1rem'>";
                                                mainHtml += "<img src='" + Com_Parameter.ResPath + "style/common/fileIcon/" + fileIcon + "' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />";
                                                mainHtml += Com_HtmlEscape(mainAtt[m].fdFileName);
                                                mainHtml += "</td></tr>";
                                            }
                                        }
                                        mainHtml += "</table>";

                                        var commonAtt = results[i].commonAtt;
                                        var commonHtml = "<table style='border:none'>";
                                        for (var n = 0; n < commonAtt.length; n++) {
                                            if (commonAtt[n].fdId != "") {
                                                attIds += commonAtt[n].fdId + ";";
                                                var fileIcon = window.GetIconNameByFileName(commonAtt[n].fdFileName);
                                                commonHtml += "<tr><td style='padding-right:1rem'>";
                                                commonHtml += "<img src='" + Com_Parameter.ResPath + "style/common/fileIcon/" + fileIcon + "' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />";
                                                commonHtml += Com_HtmlEscape(commonAtt[n].fdFileName);
                                                commonHtml += "</td></tr>";
                                            }
                                        }
                                        commonHtml += "</table>";

                                        $(newRow).find(".td_fromTopic input").val(results[i].fdTopicId);
                                        $(newRow).find(".td_attachment").append(mainHtml + commonHtml);
                                        topic.publish("/mui/list/resize", newRow);
                                        buildUnitInfo();
                                    });
                                }
                            }
                        }
                    });
                }
            });

            ready(function () {
                if (DocList_TableInfo['TABLE_DocList'] == null) {
                    DocListFunc_Init();
                }
            });

            window.detail_fixNo = function () {
                $('#TABLE_DocList').find('.muiDetailTableNo').each(function (i) {
                    $(this).children('.index').text(i + 1);
                });
            };

            window.deleteRow = function (domNode) {
                try {
                    var td = $(domNode).closest('.detail_wrap_td')[0];
                    var topicId = query('.muiTopicId', td)[0].value;
                    if (topicId != null && topicId.length > 0) {
                        topicListIds = topicListIds.replace(topicId, "");
                    }
                    var trDom = td.parentNode;
                    $(trDom).find("*[widgetid]").each(function (idx, widgetDom) {
                        var widget = registry.byNode(widgetDom);
                        if (widget && widget.destroy) {
                            widget.destroy();
                        }
                    });
                    var optTB = DocListFunc_GetParentByTagName("TABLE", trDom);
                    var rowIndex = Com_ArrayGetIndex(optTB.rows, trDom);
                    var tbInfo = DocList_TableInfo[optTB.id];
                    DocList_DeleteRow_ClearLast(trDom);
                    for (var i = rowIndex; i < tbInfo.lastIndex; i++) {
                        var row = tbInfo.DOMElement.rows[i];
                        query('*[widgetid]', row).forEach(function (widgetDom) {
                            var widget = registry.byNode(widgetDom);
                            if (widget.needToUpdateAttInDetail) {
                                var updateAttrs = widget.needToUpdateAttInDetail;
                                for (var j = 0; j < updateAttrs.length; j++) {
                                    if (widget[updateAttrs[j]]) {
                                        var updatFileds = query("[name='" + widget[updateAttrs[j]] + "']", row);
                                        if (updatFileds.length > 0) {
                                            updatFileds[0].name = window["detail_repalceIndexInfo"](updatFileds[0].name, i - tbInfo.firstIndex);
                                        }
                                        widget[updateAttrs[j]] = window["detail_repalceIndexInfo"](widget[updateAttrs[j]], i - tbInfo.firstIndex);
                                    }
                                }
                            } else if (widget.name) {
                                var tmpFileds = query("[name='" + widget.name + "']", row);
                                if (tmpFileds.length > 0) {
                                    tmpFileds[0].name = window["detail_repalceIndexInfo"](tmpFileds[0].name, i - tbInfo.firstIndex);
                                }
                                widget.name = window["detail_repalceIndexInfo"](widget.name, i - tbInfo.firstIndex);
                            } else if (widget.idField) {
                                var tmpIdField = query("[name='" + widget.idField + "']", row);
                                if (tmpIdField.length > 0) {
                                    tmpIdField[0].name = window["detail_repalceIndexInfo"](tmpIdField[0].name, i - tbInfo.firstIndex);
                                }
                                var tmpNameField = query("[name='" + widget.nameField + "']", row);
                                if (tmpNameField.length > 0) {
                                    tmpNameField[0].name = window["detail_repalceIndexInfo"](tmpNameField[0].name, i - tbInfo.firstIndex);
                                }
                                widget.idField = window["detail_repalceIndexInfo"](widget.idField, i - tbInfo.firstIndex);
                                widget.nameField = window["detail_repalceIndexInfo"](widget.nameField, i - tbInfo.firstIndex);
                            }
                        });
                    }
                    topic.publish('/mui/form/valueChanged');
                    topic.publish("/mui/list/resize", trDom);
                    detail_fixNo();
                } catch (e) {
                    query(".topicUnit")[0].innerHTML = "";
                }
                buildUnitInfo();
            };

            window["detail_repalceIndexInfo"] = function (fieldName, index) {
                fieldName = fieldName.replace(/\[\d+\]/g, "[!{index}]");
                fieldName = fieldName.replace(/\.\d+\./g, ".!{index}.");
                fieldName = fieldName.replace(/!\{index\}/g, index);
                return fieldName;
            };

            window.expandRow = function (domNode) {
                var domTable = $(domNode).closest('table')[0];
                var display = domAttr.get(domTable, 'data-display'),
                    newdisplay = (display == 'none' ? '' : 'none');
                domAttr.set(domTable, 'data-display', newdisplay);
                var items = query('tr[data-celltr="true"],tr[statistic-celltr="true"]', domTable);
                for (var i = 0; i < items.length; i++) {
                    if (newdisplay == 'none') {
                        domStyle.set(items[i], 'display', 'none');
                    } else {
                        domStyle.set(items[i], 'display', '');
                    }
                }
                var opt = query('.muiDetailDisplayOpt', domTable)[0];
                var del = query('.muiDetailTableDel', domTable)[0];
                var title = query('input', domTable)[0].value;
                if (newdisplay == 'none') {
                    domClass.add(opt, 'muiDetailUp');
                    domClass.remove(opt, 'muiDetailDown');
                    if (del) {
						domStyle.set(del, 'display', 'none');
					}
                    query('.agendaSubject', domTable).html(title);
                } else {
                    domClass.add(opt, 'muiDetailDown');
                    domClass.remove(opt, 'muiDetailUp');
                    if (del) {
						domStyle.set(del, 'display', '');
					}
                    query('.agendaSubject', domTable).html('');
                }
            };

            window.GetIconNameByFileName = function (fileName) {
                if (fileName == null || fileName == "")
                    return "documents.png";
                var fileExt = fileName.substring(fileName.lastIndexOf("."));
                if (fileExt != "")
                    fileExt = fileExt.toLowerCase();
                switch (fileExt) {
                    case ".doc":
                    case ".docx":
                        return "word.png";
                    case ".xls":
                    case ".xlsx":
                        return "excel.png";
                    case ".ppt":
                    case ".pptx":
                        return "ppt.png";
                    case ".pdf":
                        return "pdf.png";
                    case ".vsd":
                        return "vsd.png";
                    case ".txt":
                        return "text.png";
                    case ".jpg":
                        return "image.png";
                    case ".jpeg":
                        return "image.png";
                    case ".ico":
                        return "image.png";
                    case ".bmp":
                        return "image.png";
                    case ".gif":
                        return "image.png";
                    case ".png":
                        return "image.png";
                    case ".mp3":
                        return "audio.png";
                    case ".mp4":
                    case ".avi":
                    case ".flv":
                    case ".rmvb":
                    case ".m4v":
                        return "video.png";
                    default:
                        return "documents.png";
                }
            };

        });
</script>
