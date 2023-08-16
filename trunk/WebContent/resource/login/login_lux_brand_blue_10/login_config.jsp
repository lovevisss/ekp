<%-- {"custom_header_US":"Welcome Login","custom_footInfo_HK":"Copyright © 2001-2023 集团 版權所有","custom_footInfo_JP":"Copyright © 2001-2023 集团 著作権所有","custom_forgot_password_JP":"パスワードを忘れます","custom_header_HK":"歡迎登錄","custom_forgot_password_HK":"忘記密碼","custom_header_JP":"ようこそ","custom_footInfo_US":"Copyright © 2001-2023  nanaholy","custom_forgot_password_US":"Forget password","custom_header_CN":"欢迎登录","custom_logo":"logo/logo.png","custom_footInfo_CN":"Copyright © 2001-2023 集团 版权所有","custom_forgot_password_CN":"忘记密码"} --%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 JSONObject loginConfig = new JSONObject();
 loginConfig.put("custom_header_US", "Welcome Login");
 loginConfig.put("custom_header", "登录界面测试");
 loginConfig.put("custom_footInfo_HK", "Copyright © 2001-2023 集团 版權所有");
 loginConfig.put("custom_footInfo_JP", "Copyright © 2001-2023 集团 著作権所有");
 loginConfig.put("custom_forgot_password_JP", "パスワードを忘れます");
 loginConfig.put("custom_header_HK", "歡迎登錄");
 loginConfig.put("custom_forgot_password_HK", "忘記密碼");
 loginConfig.put("custom_header_JP", "ようこそ");
 loginConfig.put("custom_footInfo_US", "Copyright © 2001-2023  nanaholy");
 loginConfig.put("custom_forgot_password_US", "Forget password");
 loginConfig.put("custom_header_CN", "欢迎登录");
 loginConfig.put("custom_logo", "logo/logo.png");
 loginConfig.put("custom_footInfo_CN", "Copyright © 2001-2023 集团 版权所有");
 loginConfig.put("custom_forgot_password_CN", "忘记密码");
 request.setAttribute("config", loginConfig);
%>