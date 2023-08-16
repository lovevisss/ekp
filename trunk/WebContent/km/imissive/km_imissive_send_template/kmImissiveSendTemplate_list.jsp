<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSendTemplate" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-imissive:kmImissiveSendTemplate.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imissive:kmImissiveSendTemplate.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" property="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveSendTemplate.docCreatorId') }">
		</list:data-column>
		<list:data-column headerClass="width140" property="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveSendTemplate.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus') }" escape="false">
		    <c:if test="${kmImissiveSendTemplate.fdIsAvailable}">
				<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.true" />
			</c:if>
			<c:if test="${!kmImissiveSendTemplate.fdIsAvailable}">
				<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.false" />
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<c:if test="${kmImissiveSendTemplate.fdIsAvailable}">
			 		<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=${kmImissiveSendTemplate.fdId}" requestMethod="GET">
						<!-- 新建发文-->
						<a class="btn_txt" href="javascript:addDoc('${kmImissiveSendTemplate.fdId}')">${lfn:message('km-imissive:kmImissiveSendMain.create.title')}</a>
					</kmss:auth>
					</c:if>
					<kmss:auth requestURL="/km/imissive/km_imissive_send_template/kmImissiveSendTemplate.do?method=edit&fdId=${kmImissiveSendTemplate.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveSendTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imissive/km_imissive_send_template/kmImissiveSendTemplate.do?method=delete&fdId=${kmImissiveSendTemplate.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveSendTemplate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>