<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<link href="${LUI_ContextPath}/sys/modeling/base/resources/css/common.css" rel="stylesheet">
<link href="${LUI_ContextPath}/sys/modeling/base/resources/css/process.css" rel="stylesheet">
<link href="${LUI_ContextPath}/sys/modeling/base/resources/css/modeling.css" rel="stylesheet">
<head>

</head>
<body style="background: #fff;">
<div class="model-mask-panel" style="margin-top: 100px;">
    <%--导入成功--%>
    <div id="div_success" >
        <div class="model-mask-panel-prompt suc">
            <div class="model-mask-panel-prompt-wrap">
                <div class="model-mask-panel-prompt-result">
                    <div style="width: 64px;height: 64px"></div>
                    <p>${lfn:message('sys-modeling-base:modeling.form.system.config.success') }</p>
                </div>
                <div class="">
                    <div id="" >
                        <ui:button target="_self" onclick="goBack()" styleClass="lui_toolbar_btn_gray " text="${lfn:message('sys-modeling-base:modeling.form.see.config') }"/>
                        <ui:button onclick="toAppHome()" text="${lfn:message('sys-modeling-base:modeling.form.app.preview') }"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
<script>
    var fdId = "${param.fdId}";
    var fdAppId = "${param.fdAppId}";
    var isFlow = "${param.isFlow }";
    function toAppHome(){

        var url = Com_Parameter.ContextPath + "sys/modeling/main/index.jsp?fdAppId="+ fdAppId;
        Com_OpenWindow(url, "_blank");
    }
    function goBack(){
      var url =  Com_Parameter.ContextPath + 'sys/modeling/base/form/quick_config.jsp?fdAppId='+fdAppId+'&fdId='+fdId+'&isFlow='+isFlow+'&type=self'
        window.open(url,"_self");
    }
</script>
</html>