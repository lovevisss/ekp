<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="content">
<script src="${LUI_ContextPath}/km/imissive/resource/js/jquery.colorpicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/colpick.css?s_cache=${MUI_Cache}" type="text/css"/>
<script>
Com_IncludeFile("doclist.js");
</script>
<html:form action="/km/imissive/km_imissive_deadline_config/kmImissiveDeadLineConfig.do">
<center>
<table class="tb_normal" width=100%>
	<html:hidden property="fdId"/>
	<input type="hidden" name="fdType" value="send">
	<input type="hidden" name="fdRefer" value="fdDeadTime">
	<tr>
		<td class="td_normal_title" colspan="4">
			<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.fdRefer"/>
		</td>
	</tr>
	<tr>
		<td colspan="4">
		 	<table border="0" width=100%  class="tb_normal" id="TABLE_DocList" align="center">
		 		<tr>
		 			<td class="td_normal_title" width="5%">
					</td>
		 			<td class="td_normal_title" width="10%">
						<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.fdExpression"/>
					</td>
					<td class="td_normal_title" width="20%">
						<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.fdDay"/>
					</td>
					<td class="td_normal_title" width="20%">
						<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.fdDay2"/>
					</td>
					<td class="td_normal_title" width="40%">
						<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.fdColor"/>
					</td>
					<td  width="5%">
					</td>
		 		</tr>
				<!-- 基准行 -->
				<tr KMSS_IsReferRow="1" style="display: none">
					<td align="center">
						<input type="checkbox" name="DocList_Selected">
					</td>
					<td>
						<input type="hidden" name="fdDetails[!{index}].fdConfigId" value="${kmImissiveDeadLineConfigForm.fdId}" />
						<xform:select property="fdDetails[!{index}].fdExpression" onValueChange="changeExp(this.value);">
							<xform:enumsDataSource enumsType="kmImissiveDeadLineConfig_fdDetails_fomula"></xform:enumsDataSource>
						</xform:select>
					</td>
					<td>
						<xform:text property="fdDetails[!{index}].fdDay" validators="digits" required="true" subject="${lfn:message('km-imissive:kmImissiveDeadLineConfig.fdDay')}"/>
					</td>
					<td>
						<xform:text property="fdDetails[!{index}].fdDay2" validators="digits" style="display:none"/>
					</td>
					<td>
						<input name="fdDetails[!{index}].fdColor" type="hidden" value="#5484ed"/>
						<ul class="color_ul" id="haha!{index}">
			                 <li class="select"><a style="background-color:#5484ed"></a></li>
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
			             <a id="selfdef!{index}"><bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.define"/></a>
					</td>
					<!-- 删除按钮 -->
					<td align="center"  class="td_operate">
						<span style="cursor:pointer" class="optStyle opt_del_style" title="<bean:message bundle="sys-xform" key="xform.button.delete" />" onmousedown="DocList_DeleteRow_ClearLast();">
						</span>
					</td>
				</tr>
				<c:forEach items="${kmImissiveDeadLineConfigForm.fdDetails}" var="kmImissiveDeadLineConfigDetailForm" varStatus="vstatus">
					<tr KMSS_IsContentRow="1">
						<td align="center">
							<input type="checkbox" name="DocList_Selected" value="${kmImissiveDeadLineConfigDetailForm.fdId}">
						</td>
						<td>
							<input type="hidden" name="fdDetails[${vstatus.index}].fdConfigId" value="${kmImissiveDeadLineConfigForm.fdId}" />
							<xform:select property="fdDetails[${vstatus.index}].fdExpression" value="${kmImissiveDeadLineConfigDetailForm.fdExpression}" onValueChange="changeExp(this.value);">
								<xform:enumsDataSource enumsType="kmImissiveDeadLineConfig_fdDetails_fomula"></xform:enumsDataSource>
							</xform:select>
						</td>
						<td>
							<xform:text property="fdDetails[${vstatus.index}].fdDay" validators="digits" required="true" subject="${lfn:message('km-imissive:kmImissiveDeadLineConfig.fdDay') }" value="${kmImissiveDeadLineConfigDetailForm.fdDay}"/>
						</td>
						<td>
							<c:choose>
								<c:when test="${kmImissiveDeadLineConfigDetailForm.fdExpression eq 'bt'}">
									<c:set var="styleStr" value="display:block"></c:set>
								</c:when>
								<c:otherwise>
									<c:set var="styleStr" value="display:none"></c:set>
								</c:otherwise>
							</c:choose>
							
							<xform:text property="fdDetails[${vstatus.index}].fdDay2" validators="digits" value="${kmImissiveDeadLineConfigDetailForm.fdDay2}" style="${styleStr}"/>
						</td>
						<td>
							<input name="fdDetails[${vstatus.index}].fdColor" type="hidden" value="${kmImissiveDeadLineConfigDetailForm.fdColor}"/>
							<ul class="color_ul" id="haha${vstatus.index}">
				                 <li class="select"><a style="background-color:${kmImissiveDeadLineConfigDetailForm.fdColor}"></a></li>
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
				             <a id="selfdef${vstatus.index}" class="xxx">自定义</a>
						</td>
						<!-- 删除按钮 -->
						<td align="center"  class="td_operate">
							<span style="cursor:pointer" class="optStyle opt_del_style" title="<bean:message bundle="sys-xform" key="xform.button.delete" />" onmousedown="DocList_DeleteRow_ClearLast();">
							</span>
						</td>
				    </tr>
				</c:forEach>
				<tr class="tr_normal_opt" type="optRow" invalidrow="true">
					<td colspan="5" align="center" column="0" row="3" coltype="optCol">
						<div class="tr_normal_opt_content">
							<div class="tr_normal_opt_l">
								<label class="opt_ck_style">
									<input type="checkbox" name="DocList_SelectAll" onclick="DocList_SelectAllRow(this);"><bean:message bundle="sys-xform" key="xform.button.selectAll" />
								</label>
								<span class="optStyle opt_batchDel_style" onclick="DocList_BatchDeleteRow();" title="<bean:message bundle="sys-xform" key="xform.button.delete" />">
								</span>
							</div>
								<div class="tr_normal_opt_c"> 
									<span class="optStyle opt_add_style" title='<bean:message bundle="sys-xform" key="xform.button.add" />'  onclick="DocList_AddRow()"></span>
									<span class="optStyle opt_up_style"  title='<bean:message bundle="sys-xform" key="xform.button.moveup" />'  onclick="DocList_MoveRowBySelect(-1);"></span>
									<span class="optStyle opt_down_style" title='<bean:message bundle="sys-xform" key="xform.button.movedown" />'  onclick="DocList_MoveRowBySelect(1);"></span>
								</div>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4">
		 	<div>
				<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.tips.info"/><br>
				<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.tips.info1"/><br>
				<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.tips.info2"/><br>
				<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.tips.info3"/><br>
				<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.tips.info4"/><br>
				<bean:message bundle="km-imissive" key="kmImissiveDeadLineConfig.tips.info5"/>
			</div>
		</td>
	</tr>
</table>
<div style="margin-bottom: 10px;margin-top:25px">
	   <ui:button text="${lfn:message('button.save')}" suspend="bottom" height="35" width="120" onclick="Com_Submit(document.kmImissiveDeadLineConfigForm, 'update');" order="1" ></ui:button>
</div>
<script>
var validation = $KMSSValidation(document.forms['kmImissiveDeadLineConfigDetailForm']);
//快速选择时间
function changeExp(value){
	var optTR = DocListFunc_GetParentByTagName("TR");
	var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);	
	var tbInfo = DocList_TableInfo[optTB.id];
	var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
	var index = rowIndex-1;
	var ele = document.getElementsByName("fdDetails["+index+"].fdDay2")[0];
	if(value == 'bt'){
		ele.style.display = 'block';
		$(ele).attr("validate","digits required");
	}else{
		ele.style.display = 'none';
		$(ele).attr("validate","digits");
		ele.value = '';
	}
}

function colorRGB2Hex(color) {
    var rgb = color.split(',');
    var r = parseInt(rgb[0].split('(')[1]);
    var g = parseInt(rgb[1]);
    var b = parseInt(rgb[2].split(')')[0]);
 
    var hex = "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
    return hex;
 }
 function bindPicker(index){
	 $("#haha"+index).find("li").each(function () {
     	if($(this).prop("className") != 'select' && $(this).prop("className") != 'line'){
     		 $(this).click(function () {
	                var color = colorRGB2Hex($(this).css("background-color"));
	                $("#haha"+index).find("li.select a").css("background-color", color);
	                $("input[name='fdDetails["+index+"].fdColor']").val(color);
	            });
     	}
     });
	 $('#selfdef'+index).colorpicker({
         ishex: true, //是否使用16进制颜色值
         fillcolor: false,  //是否将颜色值填充至对象的val中
         target: null, //目标对象
         event: 'click', //颜色框显示的事件
         success: function (o, color) {
         	 $("#haha"+index).find("li.select a").css("background-color", color);
	                if(color == '#FFFFFF' || color == '#FFF' || color == '#ffffff' ||color == '#fff'){
	                	$("input[name='fdDetails["+index+"].fdColor']").val("");
	                }else{
	                	$("input[name='fdDetails["+index+"].fdColor']").val(color);
	                }
            
         },
     	reset:function(o){
     		 $("#haha"+index).find("li.select a").css("background-color", "#ffffff");
     		 $("input[name='fdDetails["+index+"].fdColor']").val("");
         }
     });
 }
$(document).ready(function(){
	
	$(".xxx").each(function(index){
		bindPicker(index);
	});
	
	$(document).on('table-add',"table[id$='TABLE_DocList']",function(e,row){
		var idx = row.rowIndex;
		var index = parseInt(idx) - 1;
		bindPicker(index);
	});
	$(document).on('table-delete',"table[id$='TABLE_DocList']",function(evt, data){
		if(data) {
			var tbInfo = DocList_TableInfo['TABLE_DocList'];
			for(var i = 0; i<tbInfo.lastIndex; i++) {
				var optTR = tbInfo.DOMElement.rows[i];
				var doms = optTR.getElementsByTagName('a');
				// 更新data-location-container属性中的序号
				for(var k=0; k<doms.length; k++){
					if($(doms[k]).prop("id")){
						var fieldValue = $(doms[k]).prop("id").replace(/\d+/g, "!{index}");
						fieldValue = fieldValue.replace(/!\{index\}/g, i - tbInfo.firstIndex);
						$(doms[k]).prop("id", fieldValue);
					}
				}
			}
		}
	});
});
function colorPickfn(obj){
	$(obj).colorpicker({
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
}

</script>
</center>
<html:hidden property="method_GET"/>
</html:form>
</template:replace>
</template:include>