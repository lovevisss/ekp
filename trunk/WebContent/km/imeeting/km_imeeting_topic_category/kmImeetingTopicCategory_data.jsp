<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImeetingTopicCategory" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<!-- 模板名称 -->	
		<list:data-column  property="fdName" title="${ lfn:message('km-imeeting:kmImeetingTopicCategory.fdName') }" />
		<!-- 所属分类 -->
		<list:data-column property="docCategory.fdName" title="${ lfn:message('km-imeeting:kmImeetingTopicCategory.docCreator') }" />
		<!-- 排序号 -->
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imeeting:kmImeetingTopicCategory.fdOrder2') }" />
		<!-- 创建者 -->
		<list:data-column property="docCreator.fdName" title="${ lfn:message('km-imeeting:kmImeetingTopicCategory.docCreator') }" />
		<!-- 创建时间 -->
		<list:data-column property="docCreateTime" title="${ lfn:message('km-imeeting:kmImeetingTopicCategory.docCreateTime') }" />
		
		<list:data-column headerClass="width180" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!-- 操作列 -->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=edit&fdId=${kmImeetingTopicCategory.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImeetingTopicCategory.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=delete&fdId=${kmImeetingTemplate.fdId}" requestMethod="POST">
						<!-- 删除 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImeetingTopicCategory.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
					</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>	
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>