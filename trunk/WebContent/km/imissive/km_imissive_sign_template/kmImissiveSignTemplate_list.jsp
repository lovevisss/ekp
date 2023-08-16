<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSignTemplate" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-imissive:kmImissiveSignTemplate.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imissive:kmImissiveSignTemplate.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" property="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveSignTemplate.docCreatorId') }">
		</list:data-column>
		<list:data-column headerClass="width140" property="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveSignTemplate.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus') }" escape="false">
		    <c:if test="${kmImissiveSignTemplate.fdIsAvailable}">
				<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.true" />
			</c:if>
			<c:if test="${!kmImissiveSignTemplate.fdIsAvailable}">
				<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.false" />
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
				<c:if test="${kmImissiveSignTemplate.fdIsAvailable}">
					<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=add&fdTemplateId=${kmImissiveSignTemplate.fdId}" requestMethod="GET">
						<!-- 新建签报-->
						<a class="btn_txt" href="javascript:addDoc('${kmImissiveSignTemplate.fdId}')">${lfn:message('km-imissive:kmImissiveSignMain.create.title')}</a>
					</kmss:auth>
				</c:if>
					<kmss:auth requestURL="/km/imissive/km_imissive_sign_template/kmImissiveSignTemplate.do?method=edit&fdId=${kmImissiveSignTemplate.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveSignTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imissive/km_imissive_sign_template/kmImissiveSignTemplate.do?method=delete&fdId=${kmImissiveSignTemplate.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveSignTemplate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>