<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-11-20
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.ui.util.PCJsCompressUtil" %>
<%@ page import="java.util.Arrays" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/taglib/taglib.tld" prefix="uicf"%>
<uicf:compressSwitch />
<c:if test="${compressSwitch eq 'true'}">
    <%
        String[] imisive_tabContent_JsArray = {"sys/ui/js/qrcode/qrcode.js","sys/authentication/identity/js/auth.js",
                "sys/ui/js/imageP/Toolbar.js","sys/ui/js/imageP/Path.js","sys/ui/js/imageP/Value.js","sys/ui/js/imageP/Thumb.js"
                ,"sys/ui/js/imageP/Panel.js","sys/ui/js/imageP/Play.js","sys/ui/js/imageP/ImageP.js","sys/ui/js/imageP/preview.js",
                "sys/ui/js/listview/paging.js","sys/ui/js/listview/columntable.js","sys/ui/js/listview/listview.js",
                "sys/ui/js/data/source.js"
        };
        String fdType = request.getParameter("fdType");
        String minJsSrc = "resource/dynamic_compress/";
        if ("send".equals(fdType)) {
            minJsSrc += "imissive_edit_gkp_min.js";
        } else {
            minJsSrc += "imissive_" + fdType + "_edit_gkp_min.js";
        }
    %>
    <script src="${LUI_ContextPath}<%= PCJsCompressUtil.getScriptSrc(minJsSrc,
        Arrays.asList(imisive_tabContent_JsArray),false) %>?s_cache=${LUI_Cache}"></script>
</c:if>


