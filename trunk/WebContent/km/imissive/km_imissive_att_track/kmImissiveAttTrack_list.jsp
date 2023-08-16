<%@ page language="java" contentType="text/json; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveAttTrack" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称--%>
		<list:data-column headerStyle="width:100px" col="fdNodeName" title="${ lfn:message('km-imissive:kmImissiveAttTrack.fdNodeName') }"  escape="false">
		    <c:out value="${kmImissiveAttTrack.fdNodeName}"/>
		</list:data-column>
		<list:data-column headerStyle="width:60px" col="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveAttTrack.docCreator') }" escape="false">
		   <ui:person personId="${kmImissiveAttTrack.docCreator.fdId}" personName="${kmImissiveAttTrack.docCreator.fdName}"></ui:person> 
		</list:data-column>
		<list:data-column headerStyle="width:120px"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveAttTrack.docCreateTime') }">
		    <kmss:showDate value="${kmImissiveAttTrack.docCreateTime}" type="datetime" />
		</list:data-column>
		<list:data-column col="fileType" headerStyle="width:100px" title="${ lfn:message('km-imissive:kmImissiveAttTrack.fileType') }"  escape="false">
			<sunbor:enumsShow value="${kmImissiveAttTrack.fileType}" enumsType="kmImissiveAttTrack_fileType" bundle="km-imissive" />
		</list:data-column>
		<list:data-column col="fileName"  title="${ lfn:message('km-imissive:kmImissiveAttTrack.fileName') }"  escape="false">
		    <a class="com_btn_link"  href="javascript:void(0)" onclick="openfile('${kmImissiveAttTrack.fileId}')">
		       <c:out value="${kmImissiveAttTrack.fileName}"/>
		    </a>
		</list:data-column>
		<list:data-column col="fdFileId" escape="false">
			<c:out value="${kmImissiveAttTrack.fileId}"/>
		</list:data-column>
		<list:data-column  col="downloadAuth" title="${ lfn:message('list.operation') }" escape="false">
			<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveAttTrack&fdId=${kmImissiveAttTrack.fileId}" requestMethod="GET">
				<c:out value="true"></c:out>
			</kmss:auth>
		</list:data-column>

	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>