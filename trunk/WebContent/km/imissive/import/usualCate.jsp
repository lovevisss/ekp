<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
	<%
		String mainModelName = request.getParameter("mainModelName");
		mainModelName = org.apache.commons.lang.StringEscapeUtils.escapeHtml(mainModelName);
		
		System.out.print(mainModelName);
		SysDictModel dict = SysDataDict.getInstance().getModel(mainModelName);
		String url = dict.getUrl();
		String addUrl = url.substring(0, url.indexOf(".do"))
				+ ".do";
		addUrl += "?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}";
		if (!addUrl.startsWith("/")) {
			addUrl += "/";
		}
		request.setAttribute("addUrl", addUrl);
	%>
<div id="usualCateDiv">	
	<ui:dataview>
		<ui:event event="load">
			var data = this.data;
			if(data.list && data.list.length == 0){
				this.erase();
			}  
		</ui:event>
		<ui:source type="AjaxJson">
		    {"url":"/sys/lbpmperson/SysLbpmPersonCreate.do?method=listUsual&mainModelName=${JsParam.mainModelName}"}
		</ui:source>
		<ui:render type="Template">
			<c:choose>
				<c:when test="${'true' ne param.isSimpleCategory }">
				{$
					<div class="lui-cate-panel-heading usual-cate-title">		     
						 <h2 class="lui-cate-panel-heading-title"><bean:message key="lbpmperson.recent.cateTemplate" bundle="sys-lbpmperson"/></h2> 
					</div>
					<ul class="zj-cate-panel-list">
				$} 
				var _data = data.list;
				for(var i=0;i < _data.length;i++){
					{$
						<li class="zj-cate-item">
							<div class="link-box-heading">
								<div class="zj-cate-title">
									<div class="zj-cate-c"><span>{%_data[i].templateDesc%}</span></div>
								</div>
								<div class="link-footer">
									<ul>
										<li>文号：</li>
										<li>签发人：</li>
									</ul>
									<a class="btn-add" href="{%Com_Parameter.ContextPath%}{%_data[i].addUrl%}" target="_blank" title="{%_data[i].templateDesc %}"><bean:message key="button.add"/></a>
								</div>
							</div>
						</li>
					$}
				}
			 {$
				</ul>
			$}
			</c:when>
			<c:otherwise>
				{$
					<div class="lui-cate-panel-heading usual-cate-title">		     
						 <h2 class="lui-cate-panel-heading-title"><bean:message key="lbpmperson.recent.category" bundle="sys-lbpmperson"/></h2> 
					</div>
					<ul class="zj-cate-panel-list">
				$} 
				var _data = data.list;
				for(var i=0;i < _data.length;i++){
					{$
						<li class="zj-cate-item">
							<div class="link-box-heading">
								<div class="zj-cate-title">
									<div class="zj-cate-c"><span>{%_data[i].templateDesc%}</span></div>
								</div>
								<div class="link-footer">
									<ul>
										<li>文号：</li>
										<li>签发人：</li>
									</ul>
									<a class="btn-add" href="{%Com_Parameter.ContextPath%}{%_data[i].addUrl%}" target="_blank" title="{%_data[i].templateDesc %}"><bean:message key="button.add"/></a>
								</div>
							</div>
						</li>
					$}
				}
			 {$
				</ul>
			$}
			</c:otherwise>
			</c:choose>
		</ui:render>
	</ui:dataview>
</div>	
	