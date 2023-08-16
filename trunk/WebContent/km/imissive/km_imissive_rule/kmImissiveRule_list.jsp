<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveRule" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  headerClass="width140"  property="docSubject" title="权限名称">
		</list:data-column>
		<list:data-column headerClass="width30"   col="fdImissiveType" title="公文类型">
			<sunbor:enumsShow value="${kmImissiveRule.fdImissiveType}" enumsType="kmImissive_rule" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width140"   property="fdAdditionRuleText" title="权限列表">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imissive:kmImissiveType.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-imissive:kmImissiveType.fdIsAvailable') }">
		   <sunbor:enumsShow value="${kmImissiveRule.fdIsAvailable}" enumsType="common_yesno" />
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveType.docCreateId') }">
		</list:data-column>
		<list:data-column headerClass="width30" property="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveType.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/imissive/km_imissive_rule/kmImissiveRule.do?method=edit&fdId=${kmImissiveRule.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveRule.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imissive/km_imissive_rule/kmImissiveRule.do?method=delete&fdId=${kmImissiveRule.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveRule.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>