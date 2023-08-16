<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<script>Com_IncludeFile("doclist.js");</script>
<input type="text" hidden="true" id="fdSelectedAgendaIds">
<table id="TABLE_DetailList" class="tb_normal" style="width: 100%;text-align: center;margin-top: -15px;">
    <tr>
        <td class="td_normal_title" style="width: 8%">
            参会单位
        </td>
        <td class="td_normal_title" style="width: 14%">
            选择议题
        </td>
        <td class="td_normal_title" style="width: 8%">
            参会人
        </td>
        <td class="td_normal_title" style="width: 7%">
            职务
        </td>
        <td class="td_normal_title" style="width: 10%">
            手机号
        </td>
        <td class="td_normal_title" style="width: 7%">
            回执结果
        </td>
        <td class="td_normal_title" style="width: 20%">
            回执备注
        </td>
        <td class="td_normal_title" style="width: 22%">
            请假附件
        </td>
        <c:if test="${fdIsShowOperateBtn eq 'true' && isFeedBackDeadline eq false}">
            <td class="td_normal_title" style="width: 4%">
                <bean:message key="list.operation"/>
            </td>
        </c:if>
    </tr>
    <!-- 基准行 -->
    <tr KMSS_IsReferRow="1" style="display: none" align="center" class="feedback-content feedback-sign-status-edit">
        <td>
            <html:hidden property="fdDetailForms[!{index}].fdUnitId" value="${kmImeetingMainFeedbackForm.fdUnitId}"/>
            <html:hidden property="fdDetailForms[!{index}].fdUnitName"
                         value="${kmImeetingMainFeedbackForm.fdUnitName}"/>
            <c:out value="${kmImeetingMainFeedbackForm.fdUnitName}"></c:out>
        </td>
        <td>
            <xform:dialog propertyId="fdDetailForms[!{index}].fdAgendaIds"
                          propertyName="fdDetailForms[!{index}].fdAgendaNames"
                          className="fdAgendaIds"
                          style="width:90%;"
                          textarea="true"
                          required="true"
                          subject="参加议题"
                          mulSelect="true">
                dialogSelect(true, '选择议题','fdDetailForms[!{index}].fdAgendaIds','fdDetailForms[!{index}].fdAgendaNames',';');
            </xform:dialog>
        </td>
        <td>
            <xform:address
                    propertyName="fdDetailForms[!{index}].docAttendName"
                    propertyId="fdDetailForms[!{index}].docAttendId"
                    orgType="ORG_TYPE_PERSON"
                    subject="参会人"
                    onValueChange="changeAttend(this)"
                    htmlElementProperties="id='docAttendId'"
                    required="true"/>
        </td>
        <td>
            <input type="hidden" name="fdDetailForms[!{index}].fdStaffingLevelId">
            <span id="fdDetailForms[!{index}].fdStaffingLevelSpan"></span>
        </td>
        <td>
            <xform:text property="fdDetailForms[!{index}].fdMobileNo" subject="手机号" validators="phoneNumber"
                        required="true"/>
        </td>
        <td>
            <xform:select property="fdDetailForms[!{index}].fdOperateType" showPleaseSelect="false">
                <xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type"/>
            </xform:select>
        </td>

        <td>
            <xform:textarea property="fdDetailForms[!{index}].fdReason" style="width:98%"/>
        </td>

        <td>
            <input type="hidden" name="fdDetailForms[!{index}].fdLeaveAttKey">
            <c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
                <c:param name="dtable" value="true"/>
                <c:param name="fdAttType" value="byte"/>
                <c:param name="enabledFileType"
                         value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,txt,pdf,jpg,jpeg,png,gif"/>
                <c:param name="fdMulti" value="true"/>
                <c:param name="fdShowMsg" value="true"/>
                <c:param name="fdKey" value="TABLE_DetailList.fdLeaveAttKey"/>
                <c:param name="fdImgHtmlProperty"/>
                <c:param name="formBeanName" value="kmImeetingMainFeedbackForm"/>
                <c:param name="formName" value="kmImeetingMainFeedbackForm"/>
                <c:param name="formListAttribute" value="fdDetailForms"/>
                <c:param name="idx" value="!{index}"/>
            </c:import>
        </td>
        <c:if test="${fdIsShowOperateBtn eq 'true' && isFeedBackDeadline eq false}">
            <td>
                <a href="javascript:void(0);" onclick="delDetailRow(this);" title="${lfn:message('doclist.delete')}"
                   data-index="delBtn[!{index}]">
                    <img src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0"/>
                </a>
            </td>
        </c:if>
    </tr>

    <c:forEach items="${kmImeetingMainFeedbackForm.fdDetailForms}" var="fdDetail" varStatus="vstatus">
        <tr KMSS_IsContentRow="1" class="feedback-content">
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdId" value="${fdDetail.fdId}">
                <input type="hidden" name="fdDetailForms[${vstatus.index}].docCreatorId"
                       value="${fdDetail.docCreatorId}">
                <html:hidden property="fdDetailForms[${vstatus.index}].fdUnitId"
                             value="${kmImeetingMainFeedbackForm.fdUnitId}"/>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdUnitName" value="${fdDetail.fdUnitName}">
                <xform:text property="fdDetailForms[${vstatus.index}].fdUnitName"
                            value="${kmImeetingMainFeedbackForm.fdUnitName}" showStatus="view"/>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdAgendaIds" value="${fdDetail.fdAgendaIds}">
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdAgendaNames"
                       value="${fdDetail.fdAgendaNames}">
                <xform:dialog propertyId="fdDetailForms[${vstatus.index}].fdAgendaIds"
                              propertyName="fdDetailForms[${vstatus.index}].fdAgendaNames"
                              className="fdAgendaIds"
                              showStatus="view"
                              style="width:90%;"
                              textarea="true"
                              required="true"
                              subject="参加议题"
                              mulSelect="true">
                    dialogSelect(true, '选择议题','fdDetailForms[!{index}].fdAgendaIds','fdDetailForms[!{index}].fdAgendaNames',';');
                </xform:dialog>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].docAttendId" value="${fdDetail.docAttendId}">
                <xform:address propertyName="fdDetailForms[${vstatus.index}].docAttendName"
                               propertyId="fdDetailForms[${vstatus.index}].docAttendId" orgType="ORG_TYPE_PERSON"
                               onValueChange="changeAttend(this);" showStatus="${editStatus}"/>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdStaffingLevelId"
                       value="${fdDetail.fdStaffingLevelId}">
                <span id="fdDetailForms[${vstatus.index}].fdStaffingLevelSpan">${fdDetail.fdStaffingLevelName}</span>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdMobileNo" value="${fdDetail.fdMobileNo}">
                <xform:text property="fdDetailForms[${vstatus.index}].fdMobileNo" showStatus="${editStatus}"/>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdOperateType"
                       value="${fdDetail.fdOperateType}">
                <xform:select property="fdDetailForms[${vstatus.index}].fdOperateType" showPleaseSelect="false"
                              showStatus="${editStatus}">
                    <xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type"/>
                </xform:select>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdReason" value="${fdDetail.fdReason}">
                <xform:textarea property="fdDetailForms[${vstatus.index}].fdReason" style="width:98%"
                                showStatus="${editStatus}"/>
            </td>
            <td>
                <input type="hidden" name="fdDetailForms[${vstatus.index}].fdLeaveAttKey"
                       value="${fdDetail.fdLeaveAttKey}">
                <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
                    <c:param name="dtable" value="true"/>
                    <c:param name="dTableType" value="nonxform"/>
                    <c:param name="fdAttType" value="byte"/>
                    <c:param name="enabledFileType"
                             value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,txt,pdf,jpg,jpeg,png,gif"/>
                    <c:param name="fdMulti" value="true"/>
                    <c:param name="fdShowMsg" value="true"/>
                    <c:param name="fdImgHtmlProperty"/>
                    <c:param name="fdKey" value="TABLE_DetailList.fdLeaveAttKey"/>
                    <c:param name="formBeanName" value="kmImeetingMainFeedbackForm"/>
                    <c:param name="formName" value="kmImeetingMainFeedbackForm"/>
                    <c:param name="formListAttribute" value="fdDetailForms"/>
                    <c:param name="idx" value="${vstatus.index}"/>
                </c:import>
            </td>
            <c:if test="${fdIsShowOperateBtn eq 'true' && isFeedBackDeadline eq false}">
                <td>
                </td>
            </c:if>
        </tr>
    </c:forEach>
    <c:if test="${fdIsShowOperateBtn eq 'true' && isFeedBackDeadline eq false}">
        <tr type="optRow" class="addBtn">
            <td>
				<span href="javascript:void(0);" onclick="addDetailRow();" title="${lfn:message('doclist.add')}"
                      class="lui_form_button">
					添加报名
				</span>
            </td>
        </tr>
    </c:if>
</table>
<script>
    seajs.use([
        'lui/jquery',
        'lui/dialog',
        'lui/dialog_common'
    ], function ($, dialog, dialogCommon) {
        var attendInput;
        var fdAgendaIds = "${kmImeetingMainFeedbackForm.fdAgendaIds}";  // 回执中所需要报名的议题Id
        var selectedAgendaIds = "";   // 已选择的议题Id
        var agendaIdArray = new Array();

        agendaIdArray = fdAgendaIds.split(";");

        var selectedCount = 0; // ，用于判断议题是否已选完
        var selectedArray = new Array();

        $(document).ready(function () {
            DocList_Info.push("TABLE_DetailList");
        });

        window.onload = function () {
            getSelectedAgendaIdsAndCount();
            var editStatus = "${editStatus}";
            if (editStatus == "edit") {
                DocList_AddRow("TABLE_DetailList");
                bindAttendChangeEvt();
            }
        }

        //增加行
        window.addDetailRow = function () {
            if (agendaIdArray.length > selectedArray.length) {
                var fieldValues = new Object();
                DocList_AddRow("TABLE_DetailList", null, fieldValues);
                bindAttendChangeEvt();
            } else {
                dialog.alert("每个需要参加的议题都已经报名了！")
            }
        }

        // 删除行
        window.delDetailRow = function (row) {
            var detailTr = DocListFunc_GetParentByTagName("TR");
            var detailTb = DocListFunc_GetParentByTagName("TABLE", detailTr);
            var tbInfo = DocList_TableInfo[detailTb.id];
            if (tbInfo.lastIndex <= 2) {
                dialog.alert("请至少填写一份报名信息！")
            } else {
                DocList_DeleteRow();
                getSelectedAgendaIdsAndCount();
                bindAttendChangeEvt();
            }
        }

        window.changeAgendaId = function (data) {
            getSelectedAgendaIdsAndCount();
        }

        window.dialogSelect = function (mulSelect, winTitle, idField, nameField, splitStr, isMulField) {
            var dialog = new KMSSDialog(mulSelect, true);
            dialog.winTitle = winTitle;
            dialog.BindingField(idField, nameField, splitStr, isMulField);
            dialog.AddDefaultOptionBeanData("kmImeetingFeedbackService&type=agenda&fdAgendaIds=${kmImeetingMainFeedbackForm.fdAgendaIds}&fdSelectedAgendaIds=" + selectedAgendaIds);
            dialog.SetAfterShow(changeAgendaId);
            dialog.Show();
        }

        window.changeAttend = function (node) {
            if (node.fieldList) {
                var idInput = node.fieldList[0];
                var attendId = idInput.value;
                var name = idInput.name;
                var index = getIndex(name);
                if (index != -1) {

                    // 获取职务
                    getPostInfo(attendId, index);

                    // 电话号码
                    data = new KMSSData();
                    data.AddBeanData("kmImeetingFeedbackService&type=mobile&attendId=" + attendId);
                    data.PutToField("fdMobileNo", "fdDetailForms[" + index + "].fdMobileNo", "", false);
                }
            } else {
                var name = node.idField.name;
                var index = getIndex(name);
                $("[id='fdDetailForms[" + index + "].fdStaffingLevelSpan']").text("");
                data = new KMSSData();
                data.PutToField("fdMobileNo", "fdDetailForms[" + index + "].fdMobileNo", "", false);
            }
        }

        window.getIndex = function (name) {
            var start = name.indexOf("[");
            var end = name.indexOf("]");
            if (start != -1 && end != -1) {
                return name.substring(start + 1, end);
            }
            return -1;
        }

        function getSelectedAgendaIdsAndCount() {
            selectedArray = new Array();
            selectedAgendaIds = "";
            var optTB = document.getElementById("TABLE_DetailList");
            if (!DocList_TableInfo[optTB.id]) {
                DocListFunc_Init();
            }
            var tbInfo = DocList_TableInfo[optTB.id];
            var feedbackIndex = tbInfo.lastIndex;
            for (var i = 1; i < feedbackIndex; i++) {
                var rowAgendaIds = $("input[name='fdDetailForms[" + (i - 1) + "].fdAgendaIds']").val();
                var rowAgendaArr = rowAgendaIds.split(";");
                if (rowAgendaArr.length == 1 && !rowAgendaArr[0]) {
                    continue;
                }
                selectedAgendaIds += rowAgendaIds + ";";
                for (var j = 0; j < rowAgendaArr.length; j++) {
                    selectedArray.push(rowAgendaArr[j]);
                }
            }
        }

        function getPostInfo(attendId, detailIndex) {
            var getPostUrl = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=getPostInfo";
            $.ajax({
                url: getPostUrl,
                type: 'POST',
                data: {
                    attendId: attendId
                },
                async: false,
                success: function (rtnValue) {
                    rtnValue = eval('(' + rtnValue + ')');
                    if (rtnValue) {
                        $("[id='fdDetailForms[" + detailIndex + "].fdStaffingLevelSpan']").text(rtnValue.fdName);
                        $("[name='fdDetailForms[" + detailIndex + "].fdStaffingLevelId']").val(rtnValue.fdId);
                    }
                }
            });
        }

        /*
        * 把参会人的input元素绑定change事件
        * 解决用输入方式取地址本的值后不触发onValueChange事件的bug
        */
        function bindAttendChangeEvt() {
            attendInput = $("input[name$='.docAttendId']");
            // 防止重复绑定change事件
            attendInput.unbind('change').bind('change', function (eventObj) {
                getAttenderInfo(eventObj);
            });
        }

        function getAttenderInfo(eventObj) {

            var attendId = eventObj.target.value;
            var name = eventObj.target.name;
            var index = getIndex(name);
            if (index != -1) {

                // 获取职务
                getPostInfo(attendId, index);

                // 电话号码
                data = new KMSSData();
                data.AddBeanData("kmImeetingFeedbackService&type=mobile&attendId=" + attendId);
                data.PutToField("fdMobileNo", "fdDetailForms[" + index + "].fdMobileNo", "", false);
            }
        }
    });
</script>