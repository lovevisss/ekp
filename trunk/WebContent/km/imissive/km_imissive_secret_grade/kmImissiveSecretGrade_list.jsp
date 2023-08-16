<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSecretGrade" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-imissive:kmImissiveSecretGrade.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imissive:kmImissiveSecretGrade.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-imissive:kmImissiveSecretGrade.fdIsAvailable') }">
		   <sunbor:enumsShow value="${kmImissiveSecretGrade.fdIsAvailable}" enumsType="common_yesno" />
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveSecretGrade.docCreateId') }">
		</list:data-column>
		<list:data-column headerClass="width140" property="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveSecretGrade.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/imissive/km_imissive_secret_grade/kmImissiveSecretGrade.do?method=edit&fdId=${kmImissiveSecretGrade.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveSecretGrade.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imissive/km_imissive_secret_grade/kmImissiveSecretGrade.do?method=delete&fdId=${kmImissiveSecretGrade.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveSecretGrade.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>