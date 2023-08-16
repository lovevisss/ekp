<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>



<div id="optBarDiv"><input type="button"
	value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${HtmlParam.name}服务接口说明</p>

<center>
<br/>
	<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width:85%;margin-left: 40px;">
		<tr>
			<td class="td_normal_title" width="20%">参数信息</td>
			<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;KmImissiveJgOfdSignController详细说明如下:</div>
				<table class="tb_normal" cellpadding="0" cellspacing="0" width=100%>
					<tr class="tr_normal_title">
						<td align="center" width="10%"><b>参数</b></td>
						<td align="center" width="10%"><b>描述</b></td>
						<td align="center" width="10%"><b>类型</b></td>
						<td align="center" width="15%"><b>可否为空</b></td>
						<td align="center" width="55%"><b>参数说明</b></td>
						<td align="center" width="55%"><b>调用说明</b></td>
					</tr>
					<tr>
						<td>EnableTools</td>
						<td>设置工具栏按钮可用</td>
						<td>字符串(String)</td>
						<td>允许为空</td>
						<td>参数1：toolNames若干按钮名称，多个则用“;”隔开 。
							参数2：Enabled为按钮状态。0禁用；1启用；</td>
						<td>surread.EnableTools("ribbon_button_bilijian;ribbon_button_bilijia;",false);</td>
					</tr>
					<tr>
						<td>setCompositeVisible</td>
						<td>设置软件界面按钮或组件是否可见</td>
						<td>字符串(String)</td>
						<td>允许为空</td>
						<td>参数1：CompName 按钮或组件标识；
							参数2：bVisible 是否可见
							true表示可见
							false表示不可见</td>
						<td>surread.setCompositeVisible("w_navigator", false);</td>
					</tr>
					<tr>
						<td>opencloudFileBySaveUrl</td>
						<td>打开远程文档。以提供的路径打开文件。打开中不会弹出对话框，并且盖章后自动上传至服务器。</td>
						<td>字符串(String)</td>
						<td>不允许为空</td>
						<td>参数1：strOpenURL需要打开的文件名
							参数2：strSaveURL需要上传的文件地址，可以添加参数在地址中
						</td>
						<td>
							surread.opencloudFileBySaveUrl(file,url);
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>