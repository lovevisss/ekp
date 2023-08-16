<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="
	com.landray.kmss.util.KmssMessageWriter,
	com.landray.kmss.util.KmssReturnPage" %>
<%
    KmssMessageWriter msgWriter = null;
    if(request.getAttribute("KMSS_RETURNPAGE")!=null){
        msgWriter = new KmssMessageWriter(request, (KmssReturnPage)request.getAttribute("KMSS_RETURNPAGE"));
    }else{
        msgWriter = new KmssMessageWriter(request, null);
    }
    if(request.getHeader("accept")!=null){
        if(request.getHeader("accept").indexOf("application/json") >=0){
            out.write(msgWriter.DrawJsonMessage(false).toString());
            return;
        }
    }
    response.setHeader("lui-status","true");
%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/modeling/base/modeling_head.jsp" %>
<template:include ref="default.dialog">
    <template:replace name="head">
        <style>
            .bg-pc {
                margin: 0 auto;
                width: 140px;
                height: 140px;
                background: url(resources/images/nodata@2x.png) no-repeat center;
                background-size: 140px 140px;
            }
            .bg-title{
                text-align: center;
                margin: 16px 0px 0px;
                font-weight: bold;
                font-size: 18px;
                color: #666666;
            }
            .box{
                margin: 100px auto 0;
                position: absolute;
                top: 90px;
                left: 50%;
                margin-left: -250px;
                width: 500px;
                height: 400px;
            }
        </style>
    </template:replace>
    <template:replace name="content">
        <div class="box">
            <div class="bg-pc"></div>
            <div class="bg-title">${lfn:message('sys-modeling-main:modeling.no.data.export') }</div>
        </div>
    </template:replace>
</template:include>
<script>
    Com_AddEventListener(window,"load",function(){
        setTimeout(function(){
                window.history.go(-1);
        },2000);
    });
</script>


