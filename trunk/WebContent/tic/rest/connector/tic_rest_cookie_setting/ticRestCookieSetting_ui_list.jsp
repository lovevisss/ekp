<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="ticRestCookieSetting" list="${queryPage.list }">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<%--标题--%>
		<list:data-column col="docSubject" title="${ lfn:message('tic-rest-connector:ticRestCookieSetting.docSubject') }" style="text-align:center" escape="false">
			<span class="com_subject"><c:out value="${ticRestCookieSetting.docSubject}" /></span>
		</list:data-column>
		<list:data-column col="fdUseCustCt" title="${ lfn:message('tic-rest-connector:ticRestCookieSetting.fdUseCustCt') }" style="text-align:center" escape="false">
			<sunbor:enumsShow value="${ticRestCookieSetting.fdUseCustCt}" enumsType="rest_fdCookieSetting_type"/>
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
						<a class="btn_txt" style="color:#4285f4;" href="javascript:setCookieSetting('${ticRestCookieSetting.fdId}')">${lfn:message('button.select')}</a>
						<a class="btn_txt" style="color:#4285f4;" href="javascript:editCookieSetting('${ticRestCookieSetting.fdId}')">${lfn:message('button.edit')}</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
