<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit"  sidebar="auto">
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<c:if test="${kmImissiveEmergencyGradeForm.method_GET=='edit'}">
		 <ui:button text="${ lfn:message('button.update') }" order="2" onclick="Com_Submit(document.kmImissiveEmergencyGradeForm, 'update');">
		 </ui:button>
		</c:if>
		<c:if test="${kmImissiveEmergencyGradeForm.method_GET=='add'}">
			<ui:button text="${ lfn:message('button.submit') }" order="1" onclick="Com_Submit(document.kmImissiveEmergencyGradeForm, 'save');">
		    </ui:button>
		    <ui:button text="${ lfn:message('button.saveadd') }" order="2" onclick="Com_Submit(document.kmImissiveEmergencyGradeForm, 'saveadd');">
		    </ui:button>
		</c:if>
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		 </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<script src="${LUI_ContextPath}/km/imissive/resource/js/jquery.colorpicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/colpick.css?s_cache=${MUI_Cache}" type="text/css"/>
<html:form action="/km/imissive/km_imissive_emergency_grade/kmImissiveEmergencyGrade.do">
<p class="txttitle"><bean:message bundle="km-imissive" key="table.kmImissiveEmergencyGrade"/></p>

<center>
<table class="tb_normal" width=100%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveEmergencyGrade.fdName"/>
		</td><td width=85% colspan="3">
			<xform:text property="fdName" required="true" style="width:85%"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveEmergencyGrade.fdColor"/>
		</td>
		<td width=85% colspan="3">
			<input name="fdColor"  value="${kmImissiveEmergencyGradeForm.fdColor}" type="hidden"/>
			<ul class="clrfix color_ul">
                 <li class="select"><a style="background-color:${kmImissiveEmergencyGradeForm.fdColor}"></a></li>
                 <li class="line"></li>
                 <li class="color_1"></li>
                 <li class="color_2"></li>
                 <li class="color_3"></li>
                 <li class="color_4"></li>
                 <li class="color_5"></li>
                 <li class="color_6"></li>
                 <li class="color_7"></li>
                 <li class="color_8"></li>
                 <li class="color_9"></li>
                 <li class="color_10"></li>
                 <li class="color_11"></li>
             </ul>
             <div class="selfdef"><a id="selfdef"><bean:message bundle="km-imissive" key="kmImissiveEmergencyGrade.fdColor.selfDef"/></a></div>
            <script type="text/javascript">
		    $(function () {
		        $(".color_ul li").each(function () {
		        	if($(this).prop("className") != 'select' && $(this).prop("className") != 'line'){
		        		 $(this).click(function () {
			                var color = colorRGB2Hex($(this).css("background-color"));
			                $(".color_ul li.select a").css("background-color", color);
			                $("input[name='fdColor']").val(color);
			            });
		        	}
		           
		        });
		        $('#selfdef').colorpicker({
		            ishex: true, //是否使用16进制颜色值
		            fillcolor: false,  //是否将颜色值填充至对象的val中
		            target: null, //目标对象
		            event: 'click', //颜色框显示的事件
		            success: function (o, color) {
		            	
		                $(".color_ul li.select a").css("background-color", color);
		                if(color == '#FFFFFF' || color == '#FFF' || color == '#ffffff' ||color == '#fff'){
		                	 $("input[name='fdColor']").val("");
		                }else{
		                	$("input[name='fdColor']").val(color);
		                }
		            },
		        	reset:function(o){
		        		 $(".color_ul li.select a").css("background-color", "#ffffff");
			             $("input[name='fdColor']").val("");
		            }
		        });
		    });
		    function colorRGB2Hex(color) {
		        var rgb = color.split(',');
		        var r = parseInt(rgb[0].split('(')[1]);
		        var g = parseInt(rgb[1]);
		        var b = parseInt(rgb[2].split(')')[0]);
		     
		        var hex = "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
		        return hex;
		     }
		</script>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveEmergencyGrade.fdOrder"/>
		</td><td width=35%>
			<xform:text property="fdOrder" style="width:85%" validators="digits"/></br>
			<font color="red"><bean:message bundle="km-imissive" key="kmImissiveEmergencyGrade.fdOrder.tips"/></font>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveEmergencyGrade.fdIsAvailable"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsAvailable" enumsType="common_yesno" elementType="radio" />	
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
<script language="JavaScript">
      $KMSSValidation(document.forms['kmImissiveEmergencyGradeForm']);
</script>
</html:form>
</template:replace>
</template:include>