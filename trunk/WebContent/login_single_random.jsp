<%@page import="com.landray.kmss.sys.profile.util.LoginTemplateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.awt.Image,javax.imageio.ImageIO"%>
<%@ page import="java.util.Random,java.io.File,java.io.FilenameFilter"%>
<%@ page import="java.util.Locale,java.util.Date"%>
<%@ page import="com.landray.kmss.web.Globals"%>
<%@ page import="com.landray.kmss.util.ResourceUtil,com.landray.kmss.util.DateUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%-- <%@ include file="/login_single_random_config.jsp"%> --%>
<c:import url="/login_single_random_config.jsp" charEncoding="UTF-8"></c:import>
<c:set var="title_image_login_url" scope="session" value="login_single_random"/>
<%
	Cookie open = new Cookie("isopen", "close");
	open.setMaxAge(0);
	open.setPath(request.getContextPath()+"/");
	response.addCookie(open);
	pageContext.setAttribute("loginImagePath", LoginTemplateUtil.getLoginImagePath());
%>

<template:include ref="default.login">
	<template:replace name="head" >
		<link href="${ LUI_ContextPath }/resource/style/default/login_com/font/iconfont.css?s_cache=${LUI_Cache}" rel="stylesheet" type="text/css" />
		<link type="text/css" rel="stylesheet" href="${ LUI_ContextPath }/resource/style/default/login_single_random/css/login.css?s_cache=${LUI_Cache}" />
		<style>
			.lui_login_button_td .lui_login_button_div_l {
				background-color:${config.loginBtn_bgColor};
				border-color:${config.loginBtn_bgColor};
				color:${config.loginBtn_font_color};
			}
			.lui_login_button_td .lui_login_button_div_l:hover {
				background-color:${config.loginBtn_bgColor_hover};
				border-color:${config.loginBtn_bgColor_hover};
			}
		</style>
		<script>
			Com_IncludeFile("jquery.js");
			Com_IncludeFile("jquery.fullscreenr.js|custom.js", "style/default/login_single_random/js/");
		</script>
	</template:replace>
	<template:replace name="body">
		<div class="login-background-wrap ${config.login_logo_position}">
			<!-- 背景图片 Starts -->
			<div class="login-background-img"><img src="" id="login-bgImg" alt=""/></div>
			<script type="text/javascript">
				// 您必须指定你的背景图片的大小
				// var FullscreenrOptions = { width: 1920, height: 1080, bgID: '#login-bgImg' };
				// 此处将会激活全屏背景
				// jQuery.fn.fullscreenr(FullscreenrOptions);
			</script>
			<!-- 背景图片 Ends -->
			<div class="login_header">
				<div class="login_top_bar">
					<ul>
						<c:forEach items="${config.single_random_head_links }" var="link" varStatus="status">
							<li>
								<a class="login_head_link" target="_blank" href="${ link.single_random_head_link_href}">${lfn:loginArrayLangMsg('single_random_head_links',status.index,'single_random_head_link') }</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="main_content">
                <span class="logo">
                	<img alt="" src="<c:url value="${loginImagePath }/login_single_random/${config.single_random_logo}"/>">
                </span>
				</div>
			</div>
			<div class="login_content main_content">
				<!-- 登录框 开始 -->
				<div class="login_iframe ${config.login_form_align }">
					<c:choose>
						<c:when test="${appId != null &&  appId ne '' && isLding}">
							<!-- 钉钉扫码登录应用ID不为空并且licence是蓝桥的 -->
							<%request.setAttribute("loginForm", "login.form");%>
							<%request.setAttribute("loginPageType", "single_random");%>
							<%@include file="ding_qr_code_login.jsp"%>

						</c:when>
						<c:otherwise>
							<ui:combin ref="login.form"></ui:combin>
						</c:otherwise>
					</c:choose>

					<!-- 下拉弹出窗 Starts -->
					<!-- 登录框 结束 -->
				</div>
				<div class="login_footer">
					<%
						// 版权信息的年份根据服务器时间自动获取
						String s_year = DateUtil.convertDateToString(new Date(), "yyyy");
						String footerInfo = ResourceUtil.getString("login.page.footer.info", null, null, s_year);
					%>
					<p>${lfn:loginLangMsg('single_random_footerInfo') }</p>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			<%
                String lang = request.getParameter("j_lang");
                if (lang == null) {
                    Locale xlocale = ((Locale) session.getAttribute(Globals.LOCALE_KEY));
                    if (xlocale != null)
                        lang = xlocale.getLanguage();
                }
                pageContext.setAttribute("j_lang", lang);
            %>
			LUI.ready(function(){
				if("en-US" == "${lfn:escapeJs(j_lang)}") {
					//英文环境
					$('body').addClass('muilti_eng');
				}
			});

			// 获取随机登录图片信息，返回随机获取的图片名称
			function get_random_bg() {
				var cache = Math.floor(Math.random()*Math.pow(10,13));
				<%
                    String path = request.getSession().getServletContext().getRealPath("/");
                    path = path.replaceAll("\\\\", "/");
                    if (path.endsWith("/")) {
                        path = path.substring(0,path.length()-1);
                    }
                    String filePath = path + LoginTemplateUtil.getLoginImagePath()+"/login_single_random";
                    File file = new File(filePath);
                    Random random = new Random();
                    File[] files = file.listFiles(new FilenameFilter(){
                        public boolean accept(File file, String str) {
                            String name = str.toLowerCase();
                            return name.startsWith(LoginTemplateUtil.RANDOM_PERFIX) && (name.endsWith(".jpg") || name.endsWith(".jpeg") || name.endsWith(".gif") || name.endsWith(".png"));
                        }
                    });
                    File bg = files[random.nextInt(files.length)];
                %>
				return "<%=bg.getName()%>?s_cache="+cache;
			}
			//添加提示
			$('body').append('<div class="tipsClass"><%=ResourceUtil.getString("login.page.captial.tip")%></div>');
		</script>
	</template:replace>
</template:include>

