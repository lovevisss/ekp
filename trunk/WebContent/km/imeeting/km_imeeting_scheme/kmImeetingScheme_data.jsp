<%@ page language="java" contentType="text/json; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingScheme"%>
<%@page import="com.landray.kmss.sys.unit.model.KmImissiveUnit"%>
<%@page import="com.landray.kmss.sys.organization.model.SysOrgElement,java.util.*,com.landray.kmss.util.*"%>
<list:data>
	<list:data-columns var="kmImeetingScheme" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"/>
		<%--方案编号--%>
		<list:data-column  headerClass="width200" col="docNumber" title="方案编号"  escape="false">
			<span class="com_subject"><c:out value="${kmImeetingScheme.docNumber}" /></span>
		</list:data-column>
		<%--方案类型--%>
		<list:data-column  headerClass="width200" col="fdType" title="方案类型"  escape="false">
			<span class="com_subject"><c:out value="${kmImeetingScheme.fdType}" /></span>
		</list:data-column>
		<%--方案名称--%>
		<list:data-column  headerClass="width200" col="docSubject" title="方案名称"  escape="false">
			<span class="com_subject"><c:out value="${kmImeetingScheme.docSubject}" /></span>
		</list:data-column>
		<%--主持人--%>
		<list:data-column  headerClass="width200" col="fdHost" title="主持人" escape="false">
			<span class="com_subject">${kmImeetingScheme.fdHost.fdName}</span>
		</list:data-column>
		<%--方案开始时间--%>
		<list:data-column  headerClass="width200" col="fdBeginDate" title="方案开始时间" escape="false">
			<span class="com_subject"><kmss:showDate value="${kmImeetingScheme.fdBeginDate}" type="datetime"/></span>
		</list:data-column>
		<%-- 会议时间 --%>
		<list:data-column  headerClass="width200" col="fdDate" title="方案时间" escape="false">
			<span class="com_subject">
				<kmss:showDate value="${kmImeetingScheme.fdBeginDate}" type="datetime"/>
				<br/>
				<c:if test="${kmImeetingScheme.fdBeginDate!=null && kmImeetingScheme.fdEndDate!=null} ">
					~
				</c:if>
				<kmss:showDate value="${kmImeetingScheme.fdEndDate}" type="datetime"></kmss:showDate>
			</span>
		</list:data-column>
		<%--方案开始时间--%>
		<list:data-column  headerClass="width200" col="fdEndDate" title="方案结束时间" escape="false">
			<span class="com_subject"><kmss:showDate value="${kmImeetingScheme.fdEndDate}" type="datetime"/></span>
		</list:data-column>
		<%--方案地点--%>
		<list:data-column  headerClass="width200" col="fdSchemePlace" title="方案地点" escape="false">
			<span class="com_subject"><c:out value="${kmImeetingScheme.fdSchemePlace}" /></span>
		</list:data-column>
		<%--方案状态--%>
		<list:data-column  headerClass="width200" col="docStatus" title="方案状态" escape="false">
			<sunbor:enumsShow value="${kmImeetingScheme.docStatus}" enumsType="kmImeeting_common_status" />
		</list:data-column>
		
		<list:data-column headerClass="width140"  col="docCreateTime" title="创建时间">
		    <kmss:showDate value="${kmImeetingScheme.docCreateTime}" type="datetime" />
		</list:data-column>
		
		<list:data-column headerClass="width140"  col="docPublishTime" title="发布时间">
		    <kmss:showDate value="${kmImeetingScheme.docPublishTime}" type="datetime" />
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>