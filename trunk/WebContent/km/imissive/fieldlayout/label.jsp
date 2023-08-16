<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List,
				java.util.Map,
				com.landray.kmss.util.StringUtil,
				com.landray.kmss.util.ResourceUtil,
				com.landray.kmss.util.SpringBeanUtil,
				com.landray.kmss.util.UserUtil,
				com.landray.kmss.sys.config.dict.SysDataDict,
				com.landray.kmss.sys.config.dict.SysDictModel,
				com.landray.kmss.sys.config.dict.SysDictCommonProperty"%>
<%
	String _label = request.getParameter("label");
	String propertyName = request.getParameter("propertyName");
	String mainModel = request.getParameter("mainModel");
	if(StringUtil.isNull(_label)){
		SysDictModel sysDictModel = SysDataDict.getInstance().getModel(mainModel);
		Map<String,SysDictCommonProperty> propertyMap = sysDictModel.getPropertyMap();
		SysDictCommonProperty dictProperty = (SysDictCommonProperty)propertyMap.get(propertyName);
		if(StringUtil.isNotNull(dictProperty.getMessageKey())){
			_label = ResourceUtil.getString(dictProperty.getMessageKey());
		}
	}
	request.setAttribute(propertyName, _label);
%>

