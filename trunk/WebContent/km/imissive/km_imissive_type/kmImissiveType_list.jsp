<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveType" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-imissive:kmImissiveType.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imissive:kmImissiveType.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-imissive:kmImissiveType.fdIsAvailable') }">
		   <sunbor:enumsShow value="${kmImissiveType.fdIsAvailable}" enumsType="common_yesno" />
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveType.docCreateId') }">
		</list:data-column>
		<list:data-column headerClass="width140" property="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveType.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/imissive/km_imissive_type/kmImissiveType.do?method=edit&fdId=${kmImissiveType.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveType.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imissive/km_imissive_type/kmImissiveType.do?method=delete&fdId=${kmImissiveType.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveType.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>