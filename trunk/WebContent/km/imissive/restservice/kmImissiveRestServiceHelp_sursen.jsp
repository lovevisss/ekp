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
			<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;KmImissiveSursenSignController详细说明如下:</div>
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
						<td>init</td>
						<td>初始化</td>
						<td>字符串(String)</td>
						<td>不允许为空</td>
						<td>参数1：容器id 。
							参数2：宽度；
							参数3：高度；</td>
						<td>ofdreader.init("DIV", "1910px", "880px");</td>
					</tr>
					<tr>
						<td>openFile2</td>
						<td>打开文件</td>
						<td>字符串(String)</td>
						<td>不允许为空</td>
						<td>参数1：文件下载地址；
							参数2：是否只读</td>
						<td>ocx.openFile2(filePath, false);</td>
					</tr>
					<tr>
						<td>saveFile</td>
						<td>文件保存</td>
						<td>字符串(String)</td>
						<td>不允许为空</td>
						<td>参数1：保存Url
						</td>
						<td>
							ocx.saveFile(url);
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>