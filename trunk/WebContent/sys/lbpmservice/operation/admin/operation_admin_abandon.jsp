<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
lbpm.globals.includeFile("/sys/lbpmservice/operation/admin/operation_admin_abandon.js");
//定义常量
(function(constant){
	constant.opt.checkSubProcessInProcess='<bean:message bundle="sys-lbpmservice" key="lbpmOperations.confirm.checkSubProcessInProcess" />'; 
})(lbpm.constant);	
