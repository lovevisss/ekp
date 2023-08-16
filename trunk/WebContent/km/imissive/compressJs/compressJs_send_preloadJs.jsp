<%--
  Created by IntelliJ IDEA.
  User: Butterball
  Date: 2021-11-20
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.ui.util.PCJsCompressUtil" %>
<%@ page import="java.util.Arrays" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/taglib/taglib.tld" prefix="uicf"%>
<uicf:compressSwitch />

<c:if test="${compressSwitch eq 'true'}">
    <%
        String[] imissive_need_JsArray = {"resource/js/jquery.js",
                "resource/js/validation.js", "resource/js/plugin.js", "resource/js/eventbus.js", "resource/js/xform.js",
                "resource/js/json2.js", "resource/js/docutil.js", "resource/js/optbar.js",
                "resource/js/data.js", "resource/js/dialog.js", "resource/js/xml.js", "resource/js/address.js",
                "resource/js/treeview.js", "resource/js/rightmenu.js", "resource/js/popwin.js", "resource/js/formula.js",
                "resource/js/swf_attachment.js",
                "resource/js/unitDialog.js", "resource/js/sysUnitDialog.js", "resource/js/calendar.js"};
    %>
    <script src="${LUI_ContextPath}<%= PCJsCompressUtil.getScriptSrc("resource/dynamic_compress/imissive_need_min.js", Arrays.asList(imissive_need_JsArray), false) %>?s_cache=${ LUI_Cache }"></script>
    <script type="text/javascript">
        var fileList = new Array("js/jquery.js",
            "js/validation.js", "js/plugin.js", "js/eventbus.js", "js/xform.js",
            "js/json2.js", "js/docutil.js", "js/optbar.js",
            "js/data.js", "js/dialog.js", "js/xml.js", "js/address.js", "js/treeview.js", "js/rightmenu.js",
            "js/popwin.js", "js/formula.js", "js/forumla.js", "js/swf_attachment.js",
            "js/unitDialog.js", "js/sysUnitDialog.js", "js/calendar.js");
        for(i=0; i<fileList.length; i++) {
            if(Com_ArrayGetIndex(Com_Parameter.JsFileList, fileList[i])==-1){
                Com_Parameter.JsFileList[Com_Parameter.JsFileList.length] = fileList[i];
            }
        }
    </script>
</c:if>


