<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page import="
		com.landray.kmss.sys.config.design.SysCfgFlowDef,
		com.landray.kmss.sys.config.design.SysCfgFlowVariant,
		com.landray.kmss.sys.config.design.SysConfigs,
		com.landray.kmss.util.ResourceUtil" %>
<%@ page import="
		java.util.List,
		java.util.Map,
		java.util.ArrayList,
		java.util.HashMap" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content"> 
			<br/>
			<p class="txttitle">
				节点权限
			</p>
			<br/>
			<%
String nodeType = request.getParameter("nodeType");
String modelName = request.getParameter("modelName");
List rtnList = new ArrayList();
if(StringUtil.isNotNull(modelName)){
	SysCfgFlowDef cfgFlowDef = SysConfigs.getInstance().getFlowDefByMain(modelName);
	if(cfgFlowDef != null){
		for (int i = 0; i < cfgFlowDef.getVariants().size(); i++) {
			Map<String, String> node = new HashMap<String, String>();
			SysCfgFlowVariant variant = cfgFlowDef.getVariants().get(i);
			node.put("id", variant.getName());
			node.put("name", ResourceUtil.getString(variant.getKey()));
			rtnList.add(node);
		}
	}
	pageContext.setAttribute("variants", rtnList);
}
%>
<c:if test="${not empty variants}">
		<table width="98%" class="tb_normal">
			<tr>
				<td>
					<table width="100%" class="tb_noborder">
					<tr>
			<c:forEach items="${variants}" var="variant" varStatus="_index">
					<td width=50%><label><input type="checkbox" name="${variant.id}"><c:out value="${variant.name}" /></label></td>
					<c:if test="${(_index.index+1) % 2 == 0}">
					</tr><tr>
					</c:if>
			</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
					<%--查询按钮--%>
					<td colspan="4" style="text-align: center;">
					  	<%--选择--%>
						<ui:button id="select_resource_submit" text="${lfn:message('button.submit')}"   onclick="selectSubmit();"/>
						<%--取消--%>
						<ui:button id="select_resource_cancel" text="${lfn:message('button.cancel') }"  onclick="selectCancel();"/>
					</td>
				</tr>
		</table>
</c:if>

	</template:replace>
</template:include>
<script>
	seajs.use([
 	      'lui/jquery',
 	      'lui/dialog',
 	      'lui/topic',
 	      'lui/util/str'
 	        ],function($,dialog,topic,str){
		
		
		$(document).ready(function () {
			var timer = setInterval(function() {
				var dialogR = $dialog;
				if (!dialogR) {
					return;
				} else {
					clearInterval(timer);
				}
				var rule =$dialog.content.params.addition;
				if(rule!=""&&rule!=undefined&&rule!=null){
					rule=JSON.parse(rule);
					$(rule).each(function(i){
				          $("input[name="+this.key+"]").attr("checked", true);
					});
				}
			}, 100);
		});

		//获取checkBox值
		function getCheckBoxValueThree(name) {
            var data = $("input:checkbox[name="+name+"]:checked").map(function () {
                return $(this).val();
            }).get().join(",");
            return data
		}
		
		//提交
		window.selectSubmit=function(){
			var addition = "";
			var additionText = "";
			var additionStr =[];
			$("input:checkbox:checked").each(function (i) {
				var additionRule = {};
				var name = $(this).attr("name");
				var valText = $(this).parent();
				var text = valText[0].innerText;
				/* if (i != 0) {
					addition += ";" + name;
					additionText += ";" + text;
				} else {
					addition += name;
					additionText += text;
				} */
				additionRule['key']=name;
				additionRule['val']=text;
				additionStr.push(additionRule);
			});
			additionStr = JSON.stringify(additionStr);
			if(window.$dialog){
				window.$dialog.hide(additionStr);
			}else{//兼容旧UED
				opener._closeDialog();
				window.close();
			}
			
		};
		//取消
		window.selectCancel=function(){
			if(typeof($dialog)!="undefined"){
				//dialog.iframe形式
				$dialog.hide(null);
			}else{
				//兼容window.open和dialog.showModalDialog形式
				if(window.showModalDialog){
					window.returnValue=null;
				}else{
					opener.dialogCallback(null);
				}
				window.close();
			}
		};
		//取消选定
		window.selectCancelSubmit=function(){
			if(typeof($dialog)!="undefined"){
				//dialog.iframe形式
				$dialog.hide({equipmentId:"",equipmentName:""});
			}else{
				//兼容window.open和dialog.showModalDialog形式
				if(window.showModalDialog){
					window.returnValue={equipmentId:"",equipmentName:""};
				}else{
					opener.dialogCallback({equipmentId:"",equipmentName:""});
				}
				window.close();
			}
		};
		//修改source的URL
		var replaceParameter=function(url,parameterObj){
			for(var key in parameterObj){
				url=Com_SetUrlParameter(url,key,parameterObj[key]);
			}
			return url;
		}
		
	});
</script>