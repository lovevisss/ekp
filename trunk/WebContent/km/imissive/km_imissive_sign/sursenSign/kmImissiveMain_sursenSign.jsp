<%@page import="com.landray.kmss.sys.organization.model.SysOrgPerson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%
    String projectName = request.getServletContext().getContextPath();
%>
<%@ include file="/resource/jsp/common.jsp" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>OFD阅读</title>
    <script type="text/javascript">
        Com_IncludeFile("jquery.js");
        Com_IncludeFile("suwell_ofdReader.js","${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign/sursenSign/","js",true);
        Com_IncludeFile("scene.css","${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign/sursenSign/","css",true);
    </script>
    <script type="text/javascript">
        var projectName = "<%=projectName%>"

        function GetPath() {
            var filePath = "${param.filePath}";
            if (typeof filePath != "undefined" && filePath != "null" && filePath != "") {
                console.log(filePath, "filePath");
                return filePath;
            }
        }
    </script>
    <script language="javascript">
        var ocx = null;

        var signStatus = false;

        function load() {
            ocx = ofdreader.init("OFDDIV", "1910px", "880px");
            if (ocx) {
                // 屏蔽无用组件：[左上角下拉, 批注tab页]
                ocx.setCompositeVisible('toolbar_quickaccessbar', false);
                ocx.setCompositeVisible('tb_annot', false);
                // 注册签章监听事件
                ocx.registListener("d_sealsign", "signatureCompleted", true);

                var filePath = GetPath();
                // 按照本文的规范说明调用插件的各式接口
                ocx.openFile2(filePath, false);
            }
        }

        function signatureCompleted() {
            signStatus = true;
            console.log("签章完成");
        }

        // 提交
        function saveFile() {
            //            var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+"api/controller/ofdSursenSign/saveFile?fdModelId="+fdModelId+
//                    "&modelName="+'${param.fdModelName}'+"&persionId="+persionId;
            // if (signStatus) {
            console.log("已签章")
            var fdId = '${param.fdId}';
            console.log(fdId, 'fdId');
            var fdName = '${param.fdModelName}';
            console.log(fdName, 'fdName');
            var fdUserId = '${param.fdUserId}';
            console.log(fdUserId, 'fdUserId');
            // TODO 本服务器的IP
            //var host = window.document.location.href.substring(0,window.document.location.href.indexOf(window.document.location.pathname));
            // 正式
            var saveFile = ocx.saveFile(Com_GetCurDnsHost()+Com_Parameter.ContextPath + 'api/controller/ofdSursenSign/saveFile?fdModelId=' + fdId + '&persionId=' + fdUserId
                                        +'&modelName=' + fdName);
            console.log(saveFile, 'saveFile');
            if (saveFile) {
                alert('保存成功！')
                history.go(-1);
            }
        }
    </script>
    <style>
        html {
            overflow-y: hidden;
        }

        #OPERATION_BTN {
            background: #078adc;
            /*text-align: center;*/
            /*margin-bottom: 2px;*/
        }

        .operator {
            padding: 5px 15px;
            background: #1361ac;
            border: #fff solid 2px;
            outline: none;
            color: #fff;
            font-size: .9rem;
            letter-spacing: 2px;
            top: 0;
        }

        #OFDDIV {
        }
    </style>
</head>
<body onload="load()">
<div id="OPERATION_BTN">
    <button class="operator" onclick="saveFile()">保存</button>
    <button class="operator" onclick="javascript:history.back(-1);">返回</button>
</div>
<div id="OFDDIV"></div>
</body>
</html>
