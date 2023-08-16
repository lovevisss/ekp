<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<ui:accordionpanel style="min-width:200px;" layout="${not empty param.layout ? param.layout : '' }">
	<c:set var="_max_count" value="2"/>
	<c:forEach items="${sysRelationMainForm.sysRelationEntryFormList}" varStatus="vstatus" var="sysRelationEntryForm">
		<c:choose>
			<c:when test="${ '5' eq sysRelationEntryForm.fdType && 'true' eq sysRelationEntryForm.fdIsTemplate }">
				<c:set var="_max_count" value="3"/>
			</c:when>
			<c:otherwise>
				<c:set var="isExpanded" value="true"/>
				<c:if test="${ vstatus.index > _max_count}">
					<c:set var="isExpanded" value="false"/>
				</c:if>
				<ui:content title="${sysRelationEntryForm.fdModuleName}" expand="${isExpanded}">
					<ui:dataview>
						<ui:source type="AjaxJson">
							{
								url:'/sys/relation/relation.do?method=result&forward=listUi&currModelId=${currModelId}&currModelName=${currModelName}&fdKey=${JsParam.fdKey}&sortType=time&fdType=${sysRelationEntryForm.fdType}&moduleModelId=${sysRelationEntryForm.fdId}&moduleModelName=${sysRelationEntryForm.fdModuleModelName}&showCreateInfo=${JsParam.showCreateInfo}'
							}
						</ui:source>
						<ui:render ref="sys.ui.classic.tile" var-showCreator="true" var-showCreated="true" var-ellipsis="false">
						</ui:render>
						<ui:event event="load">
							if(window.Sidebar_Refresh){
								Sidebar_Refresh(true);
							}
						</ui:event>
					</ui:dataview>		
				</ui:content>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</ui:accordionpanel> 
 