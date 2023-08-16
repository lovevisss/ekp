<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil" %>
<%@page import="com.landray.kmss.util.ArrayUtil" %>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingSummaryForm" %>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.landray.kmss.util.StringUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService" %>
<%@ page import="com.landray.kmss.util.SpringBeanUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.util.JgWebOffice" %>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConstant" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.landray.kmss.sys.attachment.model.SysAttConfig" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%
    KmImeetingSummaryForm kmImeetingSummaryForm = (KmImeetingSummaryForm) request.getAttribute("kmImeetingSummaryForm");
    String[] fdNotifyPersonList = kmImeetingSummaryForm.getFdNotifyPersonList();
    String notifyPerson = "";
    if (fdNotifyPersonList != null && fdNotifyPersonList.length > 0) {
        notifyPerson = ArrayUtil.concat(fdNotifyPersonList, ';');
    }
    request.setAttribute("notifyPerson", notifyPerson);
%>

<%
    Boolean _isWpsWebOffice = false;
    boolean existViewPath = JgWebOffice.isExistViewPath(request);
    String onlineToolType = SysAttConfigUtil.getOnlineToolType();
    Boolean _isWpsCloudEnable = false;
    Boolean _isWpsCenterEnable = false;
    Boolean _isFoxitEnable = false;
    String readOLConfig = SysAttConfigUtil.getReadOLConfig();
    if ("3".equals(onlineToolType) && "1".equals(readOLConfig) && !existViewPath) {
        //wps加载项+aspose，文件没有转换完成时，使用加载项
        _isWpsWebOffice = true;
    }
    if ("3".equals(readOLConfig)) {
        _isWpsCloudEnable = true;
    } else if ("5".equals(readOLConfig)) {
        _isWpsCenterEnable = true;
    } else if ("6".equals(readOLConfig)) {
        _isFoxitEnable = true;
    }
    pageContext.setAttribute("_wpsoaassist", "false");
    if (SysAttConstant.ATTCONFIG_ONLINETOOLTYPE_WPSWPSOAASSIST.equals(SysAttConfigUtil.getOnlineToolType())) {
        Map map = new SysAttConfig().getDataMap();
        if (map == null || map.isEmpty() || "0".equals(map.get("wpsoaassistEmbed"))) {
            pageContext.setAttribute("_wpsoaassist", "true");
        }
    }
    pageContext.setAttribute("_isWpsCloudEnable", _isWpsCloudEnable);
    pageContext.setAttribute("_isWpsWebOffice", _isWpsWebOffice);
    pageContext.setAttribute("_isWpsCenterEnable", _isWpsCenterEnable);
    pageContext.setAttribute("_isFoxitEnable", _isFoxitEnable);
%>
<template:replace name="content">
    <script>
        seajs.use(['lui/dialog', 'lui/jquery', 'km/imeeting/resource/js/dateUtil'], function (dialog, $, dateUtil) {
            window.dialog = dialog;
            //删除
            window.docDel = function () {
                dialog.confirm("${lfn:message('page.comfirmDelete')}", function (flag) {
                    if (flag == true) {
                        Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=delete&fdId=${JsParam.fdId}', '_self');
                    } else {
                        return false;
                    }
                }, "warn");
            };

            //图片压缩函数
            window.doZipImage = function () {
                $('.lui_form_content_frame').find('img').each(function () {
                    this.style.cssText = "";
                    var pt;
                    if (this.height && this.height != "" && this.width && this.width != "")
                        pt = parseInt(this.height) / parseInt(this.width);//高宽比
                    if (this.width > 700) {
                        this.width = 700;
                        if (pt)
                            this.height = 700 * pt;
                    }
                });
            };
            $(document).ready(function () {
                var obj = document.getElementById("JGWebOffice_editonline");
                if (obj) {
                    obj.setAttribute("height", 550);
                }
            });

            //初始化会议历时
            if ('${kmImeetingSummaryForm.fdHoldDuration}') {
                //将小时分解成时分
                var timeObj = dateUtil.splitTime({"ms": "${kmImeetingSummaryForm.fdHoldDuration}"});
                $('#fdHoldDurationHour').html(timeObj.hour);
                $('#fdHoldDurationMin').html(timeObj.minute);
                if (timeObj.minute) {
                    $('#fdHoldDurationMinSpan').show();
                } else {
                    $('#fdHoldDurationMinSpan').hide();
                }
            }

        });

        function setFrameSize() {
            var frame = document.getElementById("IFrame_Content");
            if (frame) {//金格控件
                // 金格控件中图片居中兼容
                var ___imgs = frame.contentWindow.document.getElementsByTagName('img');
                for (var j = 0; j < ___imgs.length; j++) {
                    ___imgs[j].style.display = 'block';
                    ___imgs[j].style.margin = '0 auto';
                }
                //获取所有a元素
                var elems = frame.contentWindow.document.getElementsByTagName("a");
                for (var i = 0; i < elems.length; i++) {
                    elems[i].setAttribute("target", "_top");
                }
                var IFrame_Content = document.getElementById("IFrame_Content");
                var chs = IFrame_Content.contentWindow.document.body.childNodes;
                var bh = 0;
                for (var i = 0; i < chs.length; i++) {
                    var tbh = chs[i].offsetTop + chs[i].offsetHeight;
                    if (tbh > bh) {
                        bh = tbh;
                    }
                }
                document.getElementById("contentDiv").style.height = bh + "px";
            } else {//rtf输出文本
                // xform输出默认设置最大宽度
                // doZipImage();
            }
        };
    </script>
    <div class="lui_form_content_frame" style="padding-top:20px">
        <c:if test="${param.approveModel ne 'right'}">
        <form name="kmImeetingSummaryForm" method="post"
              action="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_summary/kmImeetingSummary.do">
            </c:if>
            <p class="txttitle">
                <bean:message bundle="km-imeeting" key="table.kmImeetingSummary"/>
            </p>
            <table class="tb_normal" width=100% id="Table_Main">
                <tr>
                    <%-- 会议名称--%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdName"/>
                    </td>
                    <td width="35%">
                        <xform:text property="fdName" style="width:80%"/>
                    </td>
                    <%-- 会议类型 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdTemplate"/>
                    </td>
                    <td width="35%">
                        <c:out value="${kmImeetingSummaryForm.fdTemplateName}"></c:out>
                    </td>
                </tr>
                <%-- 所属场所 --%>
                <c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                    <c:param name="id" value="${kmImeetingSummaryForm.authAreaId}"/>
                </c:import>
                <tr>
                    <%-- 主持人 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdHost"/>
                    </td>
                    <td colspan="3">
                        <c:out value="${kmImeetingSummaryForm.fdHostName}"></c:out>
                    </td>
                </tr>
                <tr>
                    <%-- 会议时间--%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingMain.fdDate"/>
                    </td>
                    <td width="35%">
                        <xform:datetime property="fdHoldDate" dateTimeType="datetime"
                                        style="width:36%"></xform:datetime>~
                        <xform:datetime property="fdFinishDate" dateTimeType="datetime"
                                        style="width:36%"></xform:datetime>
                    </td>
                    <%--会议历时--%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingMain.fdHoldDuration"/>
                    </td>
                    <td width="35%">
                        <span id="fdHoldDurationHour"></span><bean:message key="date.interval.hour"/>
                        <span id="fdHoldDurationMinSpan"><span id="fdHoldDurationMin"></span><bean:message
                                key="date.interval.minute"/></span>
                    </td>
                </tr>
                <tr>
                    <%-- 选择会议室 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingMain.fdPlace"/>
                    </td>
                    <td width="85%" colspan="3">
                        <c:choose>
                            <c:when test="${not empty kmImeetingSummaryForm.fdVicePlaceNames or not empty kmImeetingSummaryForm.fdOtherVicePlace }">
                                <!-- 主会场 -->
                                <bean:message bundle="km-imeeting" key="kmImeetingMain.fdMainPlace"/>：
                                <c:out value="${kmImeetingSummaryForm.fdPlaceName}"/>
                                <!-- 外部主会场 -->
                                <c:set var="hasSysAttend" value="false"></c:set>
                                <kmss:ifModuleExist path="/sys/attend">
                                    <c:set var="hasSysAttend" value="true"></c:set>
                                </kmss:ifModuleExist>
                                <c:if test="${hasSysAttend == true }">
                                    <c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
                                        <c:param name="propertyName" value="fdOtherPlace"></c:param>
                                        <c:param name="propertyCoordinate" value="fdOtherPlaceCoordinate"></c:param>
                                        <c:param name="validators" value="validateplace"></c:param>
                                        <c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdPlace')}"></c:param>
                                        <c:param name="style" value="width:40%;"></c:param>
                                        <c:param name="showStatus" value="view"></c:param>
                                    </c:import>
                                </c:if>
                                <c:if test="${hasSysAttend == false }">
                                    <xform:text property="fdOtherPlace" style="width:40%;"></xform:text>
                                </c:if>

                                <br/><br/>

                                <!-- 分会场 -->
                                <bean:message bundle="km-imeeting" key="kmImeetingMain.fdVicePlaces"/>：
                                <c:out value="${kmImeetingSummaryForm.fdVicePlaceNames}"/>
                                <!-- 外部分会场 -->
                                <c:if test="${hasSysAttend == true }">
                                    <c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
                                        <c:param name="propertyName" value="fdOtherVicePlace"></c:param>
                                        <c:param name="propertyCoordinate" value="fdOtherVicePlaceCoord"></c:param>
                                        <c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace')}"></c:param>
                                        <c:param name="style" value="width:40%;"></c:param>
                                        <c:param name="showStatus" value="view"></c:param>
                                    </c:import>
                                </c:if>
                                <c:if test="${hasSysAttend == false }">
                                    <xform:text property="fdOtherVicePlace" style="width:40%;"></xform:text>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${kmImeetingSummaryForm.fdPlaceName}"/>
                                <!-- 其他会议地点 -->
                                <c:set var="hasSysAttend" value="false"></c:set>
                                <kmss:ifModuleExist path="/sys/attend">
                                    <c:set var="hasSysAttend" value="true"></c:set>
                                </kmss:ifModuleExist>
                                <c:if test="${hasSysAttend == true }">
                                    <c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
                                        <c:param name="propertyName" value="fdOtherPlace"></c:param>
                                        <c:param name="propertyCoordinate" value="fdOtherPlaceCoordinate"></c:param>
                                        <c:param name="validators" value="validateplace"></c:param>
                                        <c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdOtherPlace')}"></c:param>
                                        <c:param name="style" value="width:40%;"></c:param>
                                        <c:param name="showStatus" value="view"></c:param>
                                    </c:import>
                                </c:if>
                                <c:if test="${hasSysAttend == false }">
                                    <xform:text property="fdOtherPlace" style="width:40%;"></xform:text>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <%-- 计划参加人员 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanAttendPersons"/>
                    </td>
                    <td width="85%" colspan="3" style="word-break:break-all">
                        <c:if test="${ not empty kmImeetingSummaryForm.fdPlanAttendPersonNames }">
                            <div>
							<span style="vertical-align: top;">
								<c:out value="${kmImeetingSummaryForm.fdPlanAttendPersonNames }"></c:out>
							</span>
                            </div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <%-- 计划邀请参加人员 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanInvitePersons"/>
                    </td>
                    <td width="85%" colspan="3" style="word-break:break-all">
                        <c:if test="${ not empty kmImeetingSummaryForm.fdPlanInvitePersonNames }">
                            <div>
							<span style="vertical-align: top;">
								<c:out value="${kmImeetingSummaryForm.fdPlanInvitePersonNames }"></c:out>
							</span>
                            </div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <%-- 计划列席人员 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanParticipantPersons"/>
                    </td>
                    <td width="85%" colspan="3" style="word-break:break-all">
                        <c:if test="${ not empty kmImeetingSummaryForm.fdPlanParticipantPersonNames }">
                            <div>
							<span style="vertical-align: top;">
								<c:out value="${kmImeetingSummaryForm.fdPlanParticipantPersonNames }"></c:out>
							</span>
                            </div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <!-- 实际与会人员 -->
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdActualAttendPersons"/>
                    </td>
                    <td width="85%" colspan="3" style="word-break:break-all">
                        <c:if test="${ not empty kmImeetingSummaryForm.fdActualAttendPersonNames }">
                            <div>
							<span style="vertical-align: top;">
								<c:out value="${kmImeetingSummaryForm.fdActualAttendPersonNames }"></c:out>
							</span>
                            </div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <%-- 编辑内容 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.docContent"/>
                    </td>
                    <td width=85% colspan="3" id="contentDiv">
                        <c:if test="${kmImeetingSummaryForm.fdContentType=='rtf'}">
                            <xform:rtf property="docContent"></xform:rtf>
                        </c:if>
                        <c:if test="${kmImeetingSummaryForm.fdContentType=='word'}">
                            <%
                                List sysAttMains = (List) pageContext.getAttribute("sysAttMains");
                                if(sysAttMains == null || sysAttMains.isEmpty()){
                                    try {
                                        String _modelId = request.getParameter("fdId");
                                        if (StringUtil.isNotNull(_modelId)) {
                                            ISysAttMainCoreInnerService sysAttMainService = (ISysAttMainCoreInnerService)
                                                    SpringBeanUtil.getBean("sysAttMainService");
                                            sysAttMains = sysAttMainService.findByModelKey(
                                                    "com.landray.kmss.km.imeeting.model.KmImeetingSummary", _modelId, "editonline");
                                        }
                                        if (sysAttMains!=null && !sysAttMains.isEmpty()) {
                                            pageContext.setAttribute("sysAttMains", sysAttMains);
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                            %>
                            <c:forEach items="${sysAttMains}" var="sysAttMain"	varStatus="vstatus">
                                <c:set var="attachmentId" value="${sysAttMain.fdId}"/>
                                <c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
                            </c:forEach>
                            <!-- 判断附件文件是否已经转换 -->
                            <%
                                Boolean isExistViewHTML = JgWebOffice.isExistViewPath(request);
                                request.setAttribute("isExistViewHTML", isExistViewHTML.toString());
                            %>

                            <c:choose>
                                <c:when test="${isExistViewHTML eq 'true'}">
                                    <jsp:include page="/km/imeeting/import/wps/wpsoaassist.jsp">
                                        <jsp:param name="attId" value="${attachmentId}"/>
                                    </jsp:include>
                                    <%--<jsp:include page="/km/imeeting/km_imeeting_summary/import/kmImeetingSummary_viewHTML.jsp" />--%>
                                </c:when>
                                <c:when test="${_isWpsCloudEnable}">
                                    <script>
                                        seajs.use(['lui/topic'], function (topic) {
                                            var officeIframeh = "560";
                                            if ($('.content').length > 0) {
                                                var contentH = $('.content').height();
                                                officeIframeh = contentH - 70;
                                            }
                                            topic.subscribe('/sys/attachment/wpsCloud/loaded', function (obj) {
                                                if (obj) {
                                                    obj.iframe.style.height = (officeIframeh) + "px"
                                                }
                                            });
                                        });
                                    </script>
                                    <c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
                                        <c:param name="fdKey" value="editonline"/>
                                        <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}"/>
                                        <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                                        <c:param name="formBeanName" value="kmImeetingSummaryForm"/>
                                    </c:import>
                                </c:when>
                                <c:when test="${_isWpsCenterEnable}">
                                    <script>
                                        seajs.use(['lui/topic'], function (topic) {
                                            var officeIframeh = "560";
                                            if ($('.content').length > 0) {
                                                var contentH = $('.content').height();
                                                officeIframeh = contentH - 70;
                                            }
                                            topic.subscribe('/sys/attachment/wpsCenter/loaded', function (obj) {
                                                if (obj) {
                                                    console.log("WPS Center has loaded!!!")
                                                    obj.iframe.style.height = (officeIframeh) + "px"
                                                }
                                            });
                                        });
                                    </script>
                                    <c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
                                        <c:param name="fdKey" value="editonline"/>
                                        <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}"/>
                                        <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                                        <c:param name="formBeanName" value="kmImeetingSummaryForm"/>
                                    </c:import>
                                </c:when>
                                <c:when test="${_isWpsWebOffice}">
                                    <div>
                                        <c:forEach items="${sysAttMains}" var="sysAttMain"	varStatus="vstatus">
                                            <c:set var="attachmentId" value="${sysAttMain.fdId}"/>
                                            <c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
                                        </c:forEach>
                                        <c:import url="/sys/attachment/sys_att_main/wps/oaassist/sysAttMain_view.jsp" charEncoding="UTF-8">
                                            <c:param name="fdKey" value="editonline" />
                                            <c:param name="fdMulti" value="false" />
                                            <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}" />
                                            <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
                                            <c:param name="formBeanName" value="kmImeetingSummaryForm" />
                                            <c:param name="fdTemplateModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate" />
                                            <c:param name="fdTemplateKey" value="editonline" />
                                            <c:param name="templateBeanName" value="KmImeetingTemplateForm" />
                                            <c:param name="showDelete" value="false" />
                                            <c:param name="wpsExtAppModel" value="kmImeeting" />
                                            <c:param name="canRead" value="true" />
                                            <c:param name="addToPreview" value="false" />
                                            <c:param  name="hideTips"  value="true"/>
                                            <c:param  name="hideReplace"  value="true"/>
                                            <c:param  name="canEdit"  value="false"/>
                                            <c:param name="canPrint" value="false" />
                                            <c:param  name="canChangeName"  value="false"/>
                                        </c:import>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <%if (com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()) {%>
                                        <jsp:include page="/km/imeeting/km_imeeting_summary/import/kmImeetingSummary_viewHTML.jsp" />
                                    <% } else { %>
                                        ${kmImeetingSummaryForm.fdHtmlContent}
                                    <%} %>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </td>
                </tr>
                <tr>
                        <%-- 相关资料 --%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="sys-attachment" key="table.sysAttMain"/>
                    </td>
                    <td width="85%" colspan="3">
                        <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
                            <c:param name="formBeanName" value="KmImeetingSummaryForm"/>
                            <c:param name="fdKey" value="attachment"/>
                            <c:param name="fdModelId" value="${JsParam.fdId }"/>
                            <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                        </c:import>
                    </td>
                </tr>

                <!-- 盖章文件 -->
                <c:if test="${kmImeetingSummaryForm.fdSignEnable == 'true' }">
                    <tr>
                        <td class="td_normal_title" width=15%>
                            <bean:message bundle="km-imeeting" key="KmImeetingSummary.fdSignFile"/>
                        </td>
                        <td width="85%" colspan="3">
                            <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
                                <c:param name="fdKey" value="fdSignFile"/>
                                <c:param name="fdModelId" value="${JsParam.fdId }"/>
                                <c:param name="fdModelName"
                                         value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                            </c:import>
                        </td>
                    </tr>

                    <tr>
                        <td class="td_normal_title" width=15%>
                            <bean:message bundle="km-imeeting" key="KmImeetingSummary.yqqSignFile"/>
                        </td>
                        <td width="85%" colspan="3">
                            <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
                                <c:param name="fdKey" value="yqqSigned"/>
                                <c:param name="fdModelId" value="${JsParam.fdId }"/>
                                <c:param name="fdModelName"
                                         value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                            </c:import>
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdNotifyType"/>
                    </td>
                    <td colspan="3">
                        <kmss:showNotifyType value="${kmImeetingSummaryForm.fdNotifyType}"></kmss:showNotifyType>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdNotifyPerson"/>
                    </td>
                    <td colspan="3">
                        <xform:checkbox property="fdNotifyPersonList" value="${notifyPerson}" showStatus="readOnly">
                            <xform:enumsDataSource enumsType="kmImeetingSummary_fdNotifyPerson"></xform:enumsDataSource>
                        </xform:checkbox>
                    </td>
                </tr>
                <tr>
                        <%-- 纪要录入人--%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.docCreator"/>
                    </td>
                    <td width="35%">
                        <input type="hidden" name="docCreatorId" value="${kmImeetingSummaryForm.docCreatorId}">
                        <input type="hidden" name="docCreatorName" value="${kmImeetingSummaryForm.docCreatorName}">
                        <c:out value="${kmImeetingSummaryForm.docCreatorName }"></c:out>
                    </td>
                        <%-- 录入时间--%>
                    <td class="td_normal_title" width=15%>
                        <bean:message bundle="km-imeeting" key="kmImeetingSummary.docCreateTime"/>
                    </td>
                    <td width="35%">
                        <input type="hidden" name="docCreateTime" value="${kmImeetingSummaryForm.docCreateTime}">
                        <c:out value="${kmImeetingSummaryForm.docCreateTime }"></c:out>
                    </td>
                </tr>
            </table>
            <c:if test="${param.approveModel ne 'right'}">
        </form>
        </c:if>
    </div>
    <c:choose>
        <c:when test="${param.approveModel eq 'right'}">
            <ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false'
                         var-useMaxWidth='true'
                         var-supportExpand="true" var-expand="true">
                <%@include file="/km/imeeting/km_imeeting_summary/kmImeetingSummary_viewContent.jsp" %>
            </ui:tabpanel>
        </c:when>
        <c:otherwise>
            <ui:tabpage expand="false">
                <%@include file="/km/imeeting/km_imeeting_summary/kmImeetingSummary_viewContent.jsp" %>
            </ui:tabpage>
        </c:otherwise>
    </c:choose>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
    <template:replace name="barRight">
        <c:choose>
            <c:when test="${kmImeetingSummaryForm.docStatus>='30' || kmImeetingSummaryForm.docStatus=='00'}">
                <ui:accordionpanel>
                    <!-- 基本信息-->
                    <c:import url="/km/imeeting/km_imeeting_summary/kmImeetingSummary_viewBaseInfo.jsp"
                              charEncoding="UTF-8">
                    </c:import>
                </ui:accordionpanel>
            </c:when>
            <c:otherwise>
                <ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
                    <c:if test="${kmImeetingSummaryForm.docStatus != '10'}">
                        <c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
                            <c:param name="formName" value="kmImeetingSummaryForm"/>
                            <c:param name="fdKey" value="ImeetingSummary"/>
                            <c:param name="showHistoryOpers" value="true"/>
                            <c:param name="isExpand" value="true"/>
                            <c:param name="approveType" value="right"/>
                            <c:param name="approvePosition" value="right"/>
                        </c:import>
                    </c:if>
                    <!-- 审批记录 -->
                    <c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp"
                              charEncoding="UTF-8">
                        <c:param name="formName" value="kmImeetingSummaryForm"/>
                        <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}"/>
                        <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
                    </c:import>
                    <!-- 基本信息-->
                    <c:import url="/km/imeeting/km_imeeting_summary/kmImeetingSummary_viewBaseInfo.jsp"
                              charEncoding="UTF-8">
                    </c:import>
                </ui:tabpanel>
            </c:otherwise>
        </c:choose>
    </template:replace>
</c:if>	
