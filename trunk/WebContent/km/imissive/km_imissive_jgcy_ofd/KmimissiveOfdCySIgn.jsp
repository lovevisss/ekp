<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<input type="hidden" id="fileNameOfd" value="${ofdFile}">
<input type="hidden" id="fdModelId" value="${fdModelId}">
<input type="hidden" id="persionId" value="${persionId}">
<input type="hidden" id="cyUrl" value="${cyUrl}">
<div id="ofd"></div>
<script type="text/javascript">
Com_IncludeFile("surread.js","${KMSS_Parameter_ContextPath}km/imissive/","js",true);
    seajs.use(['lui/jquery'],function($){
            window.onload=function(){
                    // document.getElementById("surread").HidePlugin(0);
                    // document.getElementById("surread").HidePlugin(1);
                    console.log("init函数----------------");
                    init_ofdcy("ofd", "100%", "800px");
                    OnPluginLoadFinished();

        };

    });
    function OnPluginLoadFinished(){
        console.log("OnPluginLoadFinished函数----------------");
        surreadFinished();
    }

    window.surreadFinished = function(flag){
        if(flag =="true"){
            setTimeout(function(){
                surreadSign();
            },500);
        }else{
            surreadSign();
        }
    }

    function  surreadSign() {
        console.log("surreadFinished函数----------------");
        var surread = document.getElementById("surread");
        var file  = document.getElementById("fileNameOfd").value;
        var cyUrl  = document.getElementById("cyUrl").value;


        surread.EnableTools("all", 2);
        surread.EnableTools("ribbon_tab_stamp;stamp_button_sign", 1);
        surread.setCompositeVisible("w_menubar", false);
        surread.setCompositeVisible("w_title", false);
        surread.setCompositeVisible("w_navigator", false);
        surread.opencloudFileBySaveUrl(file,cyUrl);

        console.log("结束");
        $("object[id*='surread']").each(function(i,_obj){
            _obj.value = "1";
        });
    }
</script>