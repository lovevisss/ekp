<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
    <script>
        Com_IncludeFile("dialog.js|jquery.js");
        Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
    </script>
    <script type="text/javascript">
        $(document).ready(function() {
            resetNewDialog("fdAttendUnitIds","fdAttendUnitNames",";","kmImissiveUnitListService&newSearch=true&type=allUnit",true,"","",null);
            resetNewDialog("fdListenUnitIds","fdListenUnitNames",";","kmImissiveUnitListService&newSearch=true&type=allUnit",true,"","",null);
            if("${ kmImeetingTopicForm.method_GET}" != 'add'){
                resetNewDialog("fdAttendUnitIds","fdAttendUnitNames",";","kmImissiveUnitListService&newSearch=true&type=allUnit",true,"${kmImeetingTopicForm.fdAttendUnitIds}","${kmImeetingTopicForm.fdAttendUnitNames}",null);
                resetNewDialog("fdListenUnitIds","fdListenUnitNames",";","kmImissiveUnitListService&newSearch=true&type=allUnit",true,"${kmImeetingTopicForm.fdListenUnitIds}","${kmImeetingTopicForm.fdListenUnitNames}",null);
            }
        });

        function commitMethod(commitType, saveDraft) {
            if (!validation.validate()) {
                // 移除检验组件在新UI顶部的提示
                if ($("#lui_validate_message").length > 0) {
                    $("#lui_validate_message").remove();
                }
                if (LUI("tabpanelBox")) {
                    var contents = LUI("tabpanelBox").contents;
                    for (var i = 0; i < contents.length; i++) {
                        if (contents[i].id == "kmImeetingTopicContent") {
                            LUI("tabpanelBox").setSelectedIndex(i);
                        }
                    }
                }
            }
            var formObj = document.kmImeetingTopicForm;
            var docStatus = document.getElementsByName("docStatus")[0];
            var fdModelId = "${kmImeetingTopicForm.fdModelId}";
            var fdModelName = "${kmImeetingTopicForm.fdModelName}";
            var fdIsOtherDraft = "${kmImeetingTopicForm.fdIsOtherDraft}";
            if(saveDraft=="true") {
                docStatus.value="10";
            }else{
                docStatus.value="20";
            }
            if('save'==commitType) {
                if ('true' == saveDraft) {
                    if (!isCanIncorporate(fdModelId, fdModelName)) {
                        return;
                    }
                    Com_Submit(formObj, commitType,'fdId');
                } else {
                    Com_Submit(formObj, commitType,'fdId');
                }
            } else{
                Com_Submit(formObj, commitType);
            }
        }

        function confirmChgCate(modeName,url,canClose){
            seajs.use(['sys/ui/js/dialog'],	function(dialog) {
                dialog.confirm("${lfn:message('km-doc:kmDoc.changeCate.confirmMsg')}",function(flag){
                    if(flag==true){
                        window.changeDocCate(modeName,url,canClose);
                    }},"warn");
            });
        };

        function changeDocCate(modeName,url,canClose,flag) {
            if(modeName==null || modeName=='' || url==null || url=='')
                return;
            seajs.use(['sys/ui/js/dialog'],	function(dialog) {
                dialog.simpleCategoryForNewFile(modeName,url,false,function(rtn) {
                    // 门户无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
                    if (!rtn && flag == "portlet")
                        window.close();
                },null,null,"_self",canClose);
            });
        };

        function rilegou(rtn,obj){
            if(rtn[0]!="" && rtn[1] != ""){
                var fdMaterialStaffValues=[];
                var fdOrgId = rtn[0];
                var fdOrgName = rtn[1];
                fdMaterialStaffObj={
                    id:fdOrgId,
                    name:fdOrgName
                };
                fdMaterialStaffValues.push(fdMaterialStaffObj);
                var fdMaterialStaffAddress = Address_GetAddressObj("fdMaterialStaffName");
                fdMaterialStaffAddress.reset(";",ORG_TYPE_PERSON,false,fdMaterialStaffValues);

                var url="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=getDept";
                $.ajax({
                    url:url,
                    data:{fdOrgId:fdOrgId},
                    async:false,    //用同步方式
                    success:function(data){
                        var results =  eval("("+data+")");
                        var values=[];
                        if(results['deptId'] && results['deptName']){
                            var obj={
                                id:	results['deptId'],
                                name:results['deptName']
                            };
                            values.push(obj);
                        }
                        var address = Address_GetAddressObj("fdChargeUnitName");
                        address.reset(";",ORG_TYPE_ORGORDEPT,false,values);
                    }
                });
            }
        }

        seajs.use(['lui/dialog','lui/jquery'],function(dialog,$) {
            window.isCanIncorporate = function(fdModelId, fdModelName) {
                var isCanIncorporate = false;
                if (fdModelId && fdModelName) {
                    var checkUrl = '${LUI_ContextPath}/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=checkIsIncorporated';
                    $.ajax({
                        url : checkUrl,
                        type : 'POST',
                        data : {
                            fdModelId : fdModelId,
                            fdModelName : fdModelName
                        },
                        async : false,
                        success : function(result) {
                            result = eval('(' + result + ')');
                            if (result != null) {
                                if (result.flag == true) {
                                    dialog.alert("该公文已进行纳入议题的操作，请勿重复纳入！");
                                } else {
                                    isCanIncorporate = true;
                                }
                            }
                        }
                    });
                } else {
                    isCanIncorporate = true;
                }
                return isCanIncorporate;
            }
        });
    </script>
    <c:if test="${param.approveModel ne 'right'}">
        <form name="kmImeetingTopicForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do">
    </c:if>

    <!-- <div class="lui_form_content_frame" style="padding-top:20px">

    </div> -->
    <c:choose>
        <c:when test="${param.approveModel eq 'right'}">
            <ui:tabpanel id="tabpanelBox" suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
                         var-supportExpand="true" var-expand="true">
                <!-- 议题详情 -->
                <c:import url="/km/imeeting/km_imeeting_topic/kmImeetingTopic_editContent.jsp" charEncoding="UTF-8">
                </c:import>

                <%--权限机制 --%>
                <c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImeetingTopicForm" />
                    <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
                </c:import>

                <%--流程--%>
                <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImeetingTopicForm" />
                    <c:param name="fdKey" value="mainTopic" />
                    <c:param name="showHistoryOpers" value="true" />
                    <c:param name="isExpand" value="true" />
                    <c:param name="approveType" value="right" />
                </c:import>
            </ui:tabpanel>
        </c:when>
        <c:otherwise>
            <ui:tabpage expand="false">
                <!-- 议题详情 -->
                <c:import url="/km/imeeting/km_imeeting_topic/kmImeetingTopic_editContent.jsp" charEncoding="UTF-8">
                </c:import>
                <%--流程机制 --%>
                <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImeetingTopicForm" />
                    <c:param name="fdKey" value="mainTopic" />
                </c:import>
                <%--权限机制 --%>
                <c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmImeetingTopicForm" />
                    <c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
                </c:import>
            </ui:tabpage>
            </form>
        </c:otherwise>
    </c:choose>
    <c:if test="${param.approveModel ne 'right'}">
        </form>
    </c:if>
    <script language="JavaScript">
        var validation = $KMSSValidation(document.forms['kmImeetingTopicForm']);
    </script>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
    <template:replace name="barRight">
        <ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
            <%--流程--%>
            <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
                <c:param name="formName" value="kmImeetingTopicForm" />
                <c:param name="fdKey" value="mainTopic" />
                <c:param name="showHistoryOpers" value="true" />
                <c:param name="isExpand" value="true" />
                <c:param name="approveType" value="right" />
                <c:param name="approvePosition" value="right" />
            </c:import>
        </ui:tabpanel>
    </template:replace>
</c:if>
