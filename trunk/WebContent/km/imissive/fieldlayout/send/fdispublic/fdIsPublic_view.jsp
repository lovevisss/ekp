<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
 <xform:radio property="fdIsPublic" mobile="${param.mobile eq 'true'? 'true':'false'}" style="<%=parse.getStyle()%>" showStatus="view">
   <xform:enumsDataSource  enumsType="kmMissive_fdIsPublic"></xform:enumsDataSource>
</xform:radio>
