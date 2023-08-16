<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-11-20
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/taglib/taglib.tld" prefix="uicf"%>
<%@ page import="com.landray.kmss.sys.ui.util.PCJsCompressUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<uicf:compressSwitch />
<c:if test="${compressSwitch eq 'true'}">
    <%
        String fdType = request.getParameter("fdType");
        List<String> list = new ArrayList<>();
        list.add("sys/ui/js/qrcode/qrcode.js");
        list.add("sys/ui/js/imageP/Toolbar.js");
        list.add("sys/ui/js/imageP/Path.js");
        list.add("sys/ui/js/imageP/Value.js");
        list.add("sys/ui/js/imageP/Thumb.js");
        list.add("sys/ui/js/imageP/Panel.js");
        list.add("sys/ui/js/imageP/Play.js");
        list.add("sys/ui/js/imageP/ImageP.js");
        list.add("sys/ui/js/imageP/preview.js");
        list.add("sys/ui/js/listview/paging.js");
        list.add("sys/ui/js/listview/columntable.js");
        list.add("sys/ui/js/listview/sort.js");
        String minJsSrc = "resource/dynamic_compress/";
        if ("send".equals(fdType)) {
            minJsSrc += "imissive_tabContent_gkp_min.js";
        } else {
            minJsSrc += "imissive_" + fdType + "_tabContent_gkp_min.js";
        }
        if ("receive".equals(fdType)) {
            list.add("sys/ui/js/qrcode.js");
        }
    %>
    <script src="${LUI_ContextPath}<%= PCJsCompressUtil.getScriptSrc(minJsSrc, list,false) %>?s_cache=${LUI_Cache}"></script>
</c:if>


