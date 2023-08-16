<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveTemplateCfg,java.util.*,com.landray.kmss.util.*"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"%>
<list:data>
	<list:data-columns var="kmImissiveTemplateCfg" list="${queryPage.list }">
		<%
			List<KmImissiveSendTemplate>  sendTempListOne = null;
			List<KmImissiveReceiveTemplate>  receiveTempListOne = null;
			List<KmImissiveSendTemplate>  sendTempListTwo = null;
			List<KmImissiveReceiveTemplate>  receiveTempListTwo = null;
			if(pageContext.getAttribute("kmImissiveTemplateCfg")!=null){
				KmImissiveTemplateCfg  tempCfg = (KmImissiveTemplateCfg)pageContext.getAttribute("kmImissiveTemplateCfg");
				sendTempListOne = tempCfg.getFdSendTempListOne();
			    receiveTempListOne = tempCfg.getFdReceiveTempListOne();
				sendTempListTwo = tempCfg.getFdSendTempListTwo();
				receiveTempListTwo = tempCfg.getFdReceiveTempListTwo();
			}
		%>
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-imissive:kmImissiveUnitCategory.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdType" title="${ lfn:message('km-imissive:kmImissiveTemplateCfg.fdType') }">
		     <sunbor:enumsShow value="${kmImissiveTemplateCfg.fdType}" enumsType="kmImissiveTemplateCfg_type" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width140" col="from" title="${ lfn:message('km-imissive:kmImissiveTemplateCfg.from') }" escape="false">
		     <c:if test="${kmImissiveTemplateCfg.fdSendTempListOne!=null}">
				<%
					String sendTempListOneName="";
					for(int i=0;i<sendTempListOne.size();i++){
						if(i==sendTempListOne.size()-1){
							sendTempListOneName+=((KmImissiveSendTemplate)sendTempListOne.get(i)).getFdName();	
						}else{
							sendTempListOneName+=((KmImissiveSendTemplate)sendTempListOne.get(i)).getFdName()+";";	
						}
					 }
					request.setAttribute("sendTempListOneName",sendTempListOneName);
				%>
				<p title="${sendTempListOneName}">
					<c:forEach items="${kmImissiveTemplateCfg.fdSendTempListOne}" var="fdSendTempOne" varStatus="vstatus_" begin="0" end="1">
						<c:out value="${fdSendTempOne.fdName}" />
					</c:forEach>
					<c:if test="${fn:length(kmImissiveTemplateCfg.fdSendTempListOne)>2}">
						...
					</c:if>
				</p>
			 </c:if>
			 <c:if test="${kmImissiveTemplateCfg.fdReceiveTempListOne!=null}">
			 	<%
					String receiveTempListOneName="";
					for(int i=0;i<receiveTempListOne.size();i++){
						if(i==receiveTempListOne.size()-1){
							receiveTempListOneName+=((KmImissiveReceiveTemplate)receiveTempListOne.get(i)).getFdName();	
						}else{
							receiveTempListOneName+=((KmImissiveReceiveTemplate)receiveTempListOne.get(i)).getFdName()+";";	
						}
					 }
					request.setAttribute("receiveTempListOneName",receiveTempListOneName);
				%>
				<p title="${receiveTempListOneName}">
					<c:forEach items="${kmImissiveTemplateCfg.fdReceiveTempListOne}" var="fdReceiveTempOne" varStatus="vstatus_" begin="0" end="1">
						 <c:out value="${fdReceiveTempOne.fdName}" />
					</c:forEach>
					<c:if test="${fn:length(kmImissiveTemplateCfg.fdReceiveTempListOne)>2}">
						...
					</c:if>
				</p>
			 </c:if>
		</list:data-column>
		<list:data-column headerClass="width140" col="to" title="${ lfn:message('km-imissive:kmImissiveTemplateCfg.to') }" escape="false">
		      <c:if test="${kmImissiveTemplateCfg.fdSendTempListTwo!=null}">
			    <%
					String sendTempListTwoName="";
					for(int i=0;i<sendTempListTwo.size();i++){
						if(i==sendTempListTwo.size()-1){
							sendTempListTwoName+=((KmImissiveSendTemplate)sendTempListTwo.get(i)).getFdName();	
						}else{
							sendTempListTwoName+=((KmImissiveSendTemplate)sendTempListTwo.get(i)).getFdName()+";";	
						}
					 }
					request.setAttribute("sendTempListTwoName",sendTempListTwoName);
				%>
				<p title="${sendTempListTwoName}">
					<c:forEach items="${kmImissiveTemplateCfg.fdSendTempListTwo}" var="fdSendTempTwo" varStatus="vstatus_" begin="0" end="1">
						<c:out value="${fdSendTempTwo.fdName}" />
					</c:forEach>
					<c:if test="${fn:length(kmImissiveTemplateCfg.fdSendTempListTwo)>2}">
						...
					</c:if>
				</p>
			 </c:if>
			 <c:if test="${kmImissiveTemplateCfg.fdReceiveTempListTwo!=null}">
			 	<%
					String receiveTempListTwoName="";
					for(int i=0;i<receiveTempListTwo.size();i++){
						if(i==receiveTempListTwo.size()-1){
							receiveTempListTwoName+=((KmImissiveReceiveTemplate)receiveTempListTwo.get(i)).getFdName();	
						}else{
							receiveTempListTwoName+=((KmImissiveReceiveTemplate)receiveTempListTwo.get(i)).getFdName()+";";	
						}
					 }
					request.setAttribute("receiveTempListTwoName",receiveTempListTwoName);
				%>
				<p title="${receiveTempListTwoName}">
					<c:forEach items="${kmImissiveTemplateCfg.fdReceiveTempListTwo}" var="fdReceiveTempTwo" varStatus="vstatus_" begin="0" end="1">
						 <c:out value="${fdReceiveTempTwo.fdName}" />
					</c:forEach>
					<c:if test="${fn:length(kmImissiveTemplateCfg.fdReceiveTempListTwo)>2}">
						...
					</c:if>
				</p>
			 </c:if>
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:authShow roles="ROLE_KMIMISSIVE_CONFIG_SETTING">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmImissiveTemplateCfg.fdId}')">${lfn:message('button.edit')}</a>
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmImissiveTemplateCfg.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:authShow>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>