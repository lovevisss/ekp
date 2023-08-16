<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.util.ResourceUtil" %>
<%@page import="com.landray.kmss.util.DateUtil" %>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveNumber,
                 com.landray.kmss.sys.number.service.ISysNumberMainMappService,
                 com.landray.kmss.sys.number.service.ISysNumberMainFlowService,
                 com.landray.kmss.sys.number.model.SysNumberMainMapp,
                 com.landray.kmss.sys.number.model.SysNumberMain,
                 com.landray.kmss.sys.number.model.SysNumberMainFlow,
                 com.landray.kmss.util.SpringBeanUtil,
                 com.landray.kmss.util.StringUtil,
                 java.util.*,
                 com.landray.kmss.util.*" %>
<%@ page import="com.landray.kmss.km.imissive.service.IKmImissiveNumberService" %>
<list:data>
    <list:data-columns var="kmImissiveNumber" list="${queryPage.list }">
        <%
            if (pageContext.getAttribute("kmImissiveNumber") != null) {
                KmImissiveNumber kmImissiveNumber = (KmImissiveNumber) pageContext.getAttribute("kmImissiveNumber");
                String fdNumberMainId = "";
                if (StringUtil.isNotNull(kmImissiveNumber.getFdNumberId())) {
                    fdNumberMainId = kmImissiveNumber.getFdNumberId();
                }
                request.setAttribute("fdNumberMainId", fdNumberMainId);

                String fdNumberVal = "";
                String fdFlowId = "";
                String fdFlowNo = "";
                if (StringUtil.isNotNull(kmImissiveNumber.getFdNumberValue())) {
                    fdNumberVal = kmImissiveNumber.getFdNumberValue();
                    fdFlowId = fdNumberVal.substring(fdNumberVal.lastIndexOf("#") + 1, fdNumberVal.length());
                    String[] eleArr = fdNumberVal.split("#");
                    if (eleArr.length > 1) {
                        fdFlowNo = eleArr[1];
                    }
                }
                request.setAttribute("fdNumberVal", fdNumberVal);
                request.setAttribute("fdFlowNo", fdFlowNo);

                String fdName = "";
                if (StringUtil.isNotNull(fdFlowId)) {
                    request.setAttribute("fdFlowId", fdFlowId);
                    ISysNumberMainFlowService sysNumberMainFlowService = (ISysNumberMainFlowService) SpringBeanUtil.getBean("sysNumberMainFlowService");
                    SysNumberMainFlow sysNumberMainFlow = (SysNumberMainFlow) sysNumberMainFlowService.findByPrimaryKey(fdFlowId, SysNumberMainFlow.class, true);
                    if (sysNumberMainFlow != null) {
                        SysNumberMain sysNumberMain = sysNumberMainFlow.getFdNumberMain();
                        String sysNumberMainName = sysNumberMain.getFdName();
                        if (StringUtil.isNotNull(sysNumberMainName)) {
                            fdName = sysNumberMainName;
                        } else {
                            ISysNumberMainMappService sysNumberMainMappService = (ISysNumberMainMappService) SpringBeanUtil.getBean("sysNumberMainMappService");
                            SysNumberMainMapp sysNumberMainMapp = (SysNumberMainMapp) sysNumberMainMappService.findFirstOne("fdNumber.fdId='" + fdNumberMainId + "'", null);
                            if (sysNumberMainMapp != null) {
                                fdName = ((ISysNumberMainFlowService) SpringBeanUtil.getBean("sysNumberMainFlowService")).getLinkModelName(sysNumberMainMapp.getFdModelName(), sysNumberMainMapp.getFdModelId());
                            }
                        }
                    }
                }
                request.setAttribute("fdName", fdName);
            }
        %>


        <list:data-column property="fdId"></list:data-column>
        <%--名称--%>
        <list:data-column col="fdName" title="${ lfn:message('km-imissive:kmImissiveMain.fdNumberMainNameId') }"
                          escape="false" style="text-align:center;width:400px;">
            <c:out value="${fdName}(${fdNumberMainId})"></c:out>
        </list:data-column>
        <list:data-column col="fdFlowNo" title="${ lfn:message('km-imissive:kmImissiveMain.fdFlowNo') }">
            <c:out value="${fdFlowNo}"></c:out>
        </list:data-column>
        <list:data-column col="fdNumberValue" escape="false"
                          title="${ lfn:message('km-imissive:kmImissiveSendMain.numSimulation') }">
            <c:out value="${fdNumberVal}"></c:out>
        </list:data-column>
        <!-- 其它操作 -->
        <list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }"
                          escape="false">
            <!--操作按钮 开始-->
            <div class="conf_show_more_w">
                <div class="conf_btn_edit">
                    <!-- 删除 -->
                    <a class="btn_txt"
                       href="javascript:deleteNum('${kmImissiveNumber.fdId}')">${lfn:message('button.delete')}</a>
                </div>
            </div>
            <!--操作按钮 结束-->
        </list:data-column>
    </list:data-columns>
    <list:data-paging currentPage="${queryPage.pageno }"
                      pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
    </list:data-paging>
</list:data>