<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${'0' ne _jGForMobile
            and ('true' eq _isWpsCloudEnable or 'true' eq _isWpsCenterEnable or 'true' eq hasViewer
            or '2' eq _readOLConfig or '5' eq _readOLConfig)}">
    <div class="tabContentViewDownloadBar">
        <ul class="tabContentViewDownload">
            <script>
                function downloadPdf(){
                    var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdId=${fdAttMainId}&fdFileName="+encodeURI('${kmImissiveReceiveMainForm.docSubject}')+"&convertType=${_isPdfServiceName}";
                    Com_OpenWindow(url,'_blank');
                }
                function downloadOfd(){
                    var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdId=${fdAttMainId}&fdFileName="+encodeURI('${kmImissiveReceiveMainForm.docSubject}')+"&convertType=${_isOfdServiceName}";
                    Com_OpenWindow(url,'_blank');
                }
            </script>
            <%--pdf or ofd下载--%>
            <c:choose>
                <c:when test="${not empty attId and not empty signedKey}">
                    <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}" requestMethod="GET">
                        <li>
                            <a onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}&downloadType=manual');">
                                <c:choose>
                                    <c:when test="${'pdf' eq attType}">
                                        下载pdf
                                    </c:when>
                                    <c:when test="${'ofd' eq attType}">
                                        下载ofd
                                    </c:when>
                                    <c:otherwise>
                                        下载
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </li>
                    </kmss:auth>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${not empty convertAttId and not empty convertAttType}">
                            <c:if test="${'toPDF' eq convertAttType}">
                                <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&fdId=${convertAttId}" requestMethod="GET">
                                    <li>
                                        <a onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${convertAttId}&downloadType=manual');">
                                            <bean:message  bundle="km-imissive" key="missive.button.downloadPdf"/>
                                        </a>
                                    </li>
                                </kmss:auth>
                            </c:if>
                            <c:if test="${'toOFD' eq convertAttType}">
                                <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&fdId=${convertAttId}" requestMethod="GET">
                                    <li>
                                        <a onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${convertAttId}&downloadType=manual');">
                                            下载ofd
                                        </a>
                                    </li>
                                </kmss:auth>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <%
                                if(KmImissiveConfigUtil.checkExistPdfReq(request)){
                            %>
                            <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&fdId=${fdAttMainId}" requestMethod="GET">
                                <li>
                                    <a onclick="downloadPdf();">
                                        <bean:message  bundle="km-imissive" key="missive.button.downloadPdf"/>
                                    </a>
                                </li>
                            </kmss:auth>
                            <%
                                }
                            %>
                            <%
                                //取fdAttMainId的值判断附件是否已经转换OFd
                                if(KmImissiveConfigUtil.checkExistOdfReq(request)){
                            %>
                            <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&fdId=${fdAttMainId}" requestMethod="GET">
                                <li>
                                    <a onclick="downloadOfd();">
                                        下载ofd
                                    </a>
                                </li>
                            </kmss:auth>
                            <%
                                }
                            %>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <%--正文下载--%>
            <c:choose>
                <c:when test="${kmImissiveReceiveMainForm.docStatus!='30'}">
                    <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}" requestMethod="GET">
                    <li>
                    <a onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}&downloadType=manual');">
                                <bean:message  bundle="km-imissive" key="button.download"/></a>
                    </kmss:auth>
                    </li>
                </c:when>
                <c:otherwise>
                    <kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_DOWNLOADCONTENT">
                        <kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}" requestMethod="GET">
                        <li>
                            <a onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}&downloadType=manual');">
                                <bean:message  bundle="km-imissive" key="button.download"/>
                            </a>
                        </li>
                        </kmss:auth>
                    </kmss:authShow>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</c:if>