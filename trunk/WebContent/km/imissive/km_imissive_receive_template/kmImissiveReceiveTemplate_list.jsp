<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveReceiveTemplate" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-imissive:kmImissiveReceiveTemplate.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-imissive:kmImissiveReceiveTemplate.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" property="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveReceiveTemplate.docCreatorId') }">
		</list:data-column>
		<list:data-column headerClass="width140" property="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveReceiveTemplate.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus') }" escape="false">
		    <c:if test="${kmImissiveReceiveTemplate.fdIsAvailable}">
				<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.true" />
			</c:if>
			<c:if test="${!kmImissiveReceiveTemplate.fdIsAvailable}">
				<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.false" />
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
				<c:if test="${kmImissiveReceiveTemplate.fdIsAvailable}">
					<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=${kmImissiveReceiveTemplate.fdId}" requestMethod="GET">
						<!-- 新建收文-->
						<a class="btn_txt" href="javascript:addDoc('${kmImissiveReceiveTemplate.fdId}')">${lfn:message('km-imissive:kmImissiveReceiveMain.create.title')}</a>
					</kmss:auth>
					</c:if>
					<kmss:auth requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=edit&fdId=${kmImissiveReceiveTemplate.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveReceiveTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=delete&fdId=${kmImissiveReceiveTemplate.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveReceiveTemplate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>