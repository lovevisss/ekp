<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImeetingSchemeTemplate" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<!-- 模板名称 -->	
		<list:data-column  property="fdName" title="${ lfn:message('km-imeeting:kmImeetingTemplate.fdName') }" />
		<!-- 所属分类 -->
		<list:data-column property="docCategory.fdName" title="${ lfn:message('km-imeeting:kmImeetingTemplate.docCategoryId') }" />
		<!-- 排序号 -->
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imeeting:kmImeetingTemplate.fdOrder') }" />
		<!-- 模板状态 -->
		<list:data-column col="fdIsAvailable" title="${lfn:message('km-imeeting:kmImeetingTemplate.fdStatus') }" escape="false">
			<c:choose>
				<c:when test="${kmImeetingSchemeTemplate.fdIsAvailable}">
					<bean:message bundle='km-imeeting' key='kmImeetingTemplate.fdIsAvailable.true' />
				</c:when>
				<c:otherwise>
					<bean:message bundle='km-imeeting' key='kmImeetingTemplate.fdIsAvailable.false' />
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<!-- 创建者 -->
		<list:data-column property="docCreator.fdName" title="${ lfn:message('km-imeeting:kmImeetingTemplate.docCreatorId') }" />
		<!-- 创建时间 -->
		<list:data-column property="docCreateTime" title="${ lfn:message('km-imeeting:kmImeetingTemplate.docCreateTime') }" />
		
		<list:data-column headerClass="width180" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!-- 操作列 -->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/imeeting/km_imeeting_scheme_template/kmImeetingSchemeTemplate.do?method=edit&fdId=${kmImeetingSchemeTemplate.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImeetingSchemeTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imeeting/km_imeeting_scheme_template/kmImeetingSchemeTemplate.do?method=delete&fdId=${kmImeetingSchemeTemplate.fdId}" requestMethod="POST">
						<!-- 删除 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImeetingSchemeTemplate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
					</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>	
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>