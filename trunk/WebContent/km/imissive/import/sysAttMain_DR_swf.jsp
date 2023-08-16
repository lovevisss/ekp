<%@page import="com.landray.kmss.sys.tag.model.SysTagAppConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List,
				java.util.ArrayList,
				com.landray.kmss.util.StringUtil,
				com.landray.kmss.util.ResourceUtil,
				com.landray.kmss.util.SpringBeanUtil,
				com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.dao.ISysAttMainCoreInnerDao"%>
<%
		try{
			List sysAttMains = null;
			String _modelName = request.getParameter("fdModelName");
			String _modelId = request.getParameter("fdModelId");
			String _attKey = request.getParameter("fdKey");
			if(StringUtil.isNotNull(_modelName) 
					&& StringUtil.isNotNull(_modelId)){
				String cacheKey = _modelName + "_" + _modelId+"_"+_attKey;
				List cacheAtts = (List)request.getAttribute(cacheKey);
				if(cacheAtts!=null && !cacheAtts.isEmpty()){
					sysAttMains = cacheAtts;
				}else{
					String caheFlag = (String)request.getAttribute(cacheKey+"_flag");
					if(!"1".equals(caheFlag)){
						ISysAttMainCoreInnerService sysAttMainService = (ISysAttMainCoreInnerService)SpringBeanUtil.getBean("sysAttMainService");
						sysAttMains = ((ISysAttMainCoreInnerDao) sysAttMainService
								.getBaseDao()).findByModelKey(_modelName, _modelId, _attKey);
						request.setAttribute(cacheKey,sysAttMains);
						request.setAttribute(cacheKey+"_flag","1");
					}else{
						sysAttMains = new ArrayList();
					}
				}
				pageContext.setAttribute("sysAttMains",sysAttMains);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>
<c:if test="${sysAttMains!=null && fn:length(sysAttMains)>0}">
	<table class="contentAttTb" id="${param.fdKey}">
		<tr>
			<td colspan="2" style="font-weight:bold">${param.showTitle}:</td>
		</tr>
		<tr style="line-height:30px">
			 <td>
			 	<c:forEach items="${sysAttMains}" var="sysAttMain"	varStatus="vstatus">
				<c:if test="${sysAttMain.fdKey==param.fdKey}">
						<xform:checkbox property="List_Selected"  showStatus="edit" mobile="${param.mobile?param.mobile:false}" value="${sysAttMain.fdId}" >
							<xform:simpleDataSource value="${sysAttMain.fdId}">${sysAttMain.fdFileName}</xform:simpleDataSource>
						</xform:checkbox>
			 	</c:if>
			 	</c:forEach>
			 </td>
		</tr>
	</table>
</c:if>	