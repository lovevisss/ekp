<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2020-12-12 15:51:40
 * @LastEditTime:
 * @LastEditors: Please set LastEditors
 -->
 <%@page import="com.landray.kmss.sys.profile.util.LoginTemplateUtil"%>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.awt.Image,javax.imageio.ImageIO"%>
 <%@ page import="java.util.Random,java.io.File,java.io.FilenameFilter"%>
 <%@ page import="java.util.Locale,java.util.Date"%>
<%-- <%@ page import="com.landray.kmss.web.Globals"%>--%>
 <%@ page import="com.landray.kmss.util.ResourceUtil,com.landray.kmss.util.DateUtil"%>
 <%@ include file="/sys/ui/jsp/common.jsp"%>
 <c:import url="./login_config.jsp" charEncoding="UTF-8">
 </c:import>
 <!-- id 变量需要和config.ini id -->
 <c:set var="templatePath" value="${LUI_ContextPath}/resource/login/login_lux_brand_blue_10/" />

 <template:include ref="default.login">
     <template:replace name="head">
         <!-- 登录_金色尊享 -V15版本 -->
         <link href="${ templatePath }font/iconfont.css?s_cache=${LUI_Cache}202001152" rel="stylesheet" type="text/css" />
         <link type="text/css" rel="stylesheet" href="${templatePath}css/login.css?s_cache=${LUI_Cache}202001152" />
         <script src="${templatePath}/js/jquery.js?s_cache=${LUI_Cache}202001152"></script>
         <script src="${templatePath}/js/jquery.fullscreenr.js?s_cache=${LUI_Cache}202001152"></script>
         <script src="${templatePath}/js/custom.js?s_cache=${LUI_Cache}202001152"></script>
         <title>	${lfn:loginLangMsg('custom_header') }</title>
         <%
            // 版权信息的年份根据服务器时间自动获取
            String s_year = DateUtil.convertDateToString(new Date(), "yyyy");
            int b_year = Integer.parseInt(s_year) - 2001;
        %>
         <style>
             body {
                 margin: 0;
                 background-color:#f8f4ef!important;
             }
         </style>
     </template:replace>
     <template:replace name="body">
         <script>
             var templatePath = '${templatePath}';
         </script>
         <!-- 背景图片 Starts -->
         <div class="login-background-img"><img id="login-bgImg"  alt=""/></div>
         <script type="text/javascript">
             // 您必须指定你的背景图片的大小
             var FullscreenrOptions = { width: 1920, height: 1080, bgID: '#login-bgImg' };
             // 此处将会激活全屏背景
             jQuery.fn.fullscreenr(FullscreenrOptions);
         </script>
         <!-- 背景图片 Ends -->

         <div class="login_header logo_header">
             <div class="login_top_bar">
                 <ul>
                     <c:forEach items="${config.single_random_head_links }" var="link" varStatus="status">
                         <li>
                             <a target="_blank" href="${ link.single_random_head_link_href}">${lfn:loginArrayLangMsg('single_random_head_links',status.index,'single_random_head_link') }</a>
                         </li>
                     </c:forEach>
                 </ul>
             </div>
         </div>
         <!-- LOGO路径 end-->

         <!-- 登录框 开始 -->
         <div class="login_iframe">
            <div class="login_iframe_box">
             <!-- --左侧start-- -->
          <%--   <div class="login_iframe_brand_col">
                <div class="login_iframe_logo">
                    <!-- LOGO路径 start-->
                    <span class="form_logo">
                        <img src="${templatePath}${config.custom_logo}?s_cache=${LUI_Cache}202001152" />
                    </span>
                </div>
                <div class="login_iframe_img login_img_01">
                    <img src="${ templatePath }login_bg/image_01.png" alt="" />
                </div>
                <!-- 装饰内容starts -->
                <div class="login_frame_decorate">
                    <%
                        // 版权信息的年份根据服务器时间自动获取
                        String s_year = DateUtil.convertDateToString(new Date(), "yyyy");
                        int b_year = Integer.parseInt(s_year) - 1991;
                        String footerInfo = ResourceUtil.getString("login.page.footer.info", null, null, s_year);
                    %>
                    <div class="login_frame_con">
                        <div class="login_frame_text">
                            <h1>年年红家具（国际）集团数字化办公平台</h1>
                            <p class="login_lux_decorate"><%=b_year%> 年匠心制造</p>
                            <p>数字推动创新</p>
                        </div>
                    </div>
                </div>
                <!-- 装饰内容ends -->
             </div>--%>
             <!-- --左侧end-- -->

             <!-- --中间start-- -->
                <div class="login_iframe_info_col" style="    width: 66%;">
                    <div class="login_iframe_info" style='background: url("${ templatePath }login_bg/image_02.png") no-repeat;
                            background-size: 100% 100%;'>
                   <%-- <h2 class="login_inofo_title">最新资讯</h2>--%>
<%--                    <div class="login_iframe_img login_img_02">--%>
<%--                        <img src="${ templatePath }login_bg/image_02.png" alt="" />--%>
<%--                    </div>--%>
                    <!-- 资讯内容starts -->
                   <%-- <div class="login_inofo_con">
                        <div class="login_frame_text">
                            <h2>传统文化铸良缘 凝心聚力构和谐</h2>
                            <p class="login_info_p">
                            年年红家具年年红家具（国际）集团创建于1989年，总部地处浙江省义乌市稠江街道江湾工业区，同时在浙江龙游建有“家居”、“孝福”两大生产基地，总占地面积达62万平方米，是目前国内最大的中式家具研发生产基地，是中国家具协会副会长及常务理事单位，中国传统家具专业委员会主席团主席单位，浙江省家具行业协会副会长单位，浙商全国理事会主席团主席单位，浙江义乌全国总商会副会长单位。“年年红”商标为中国驰名商标，年年红产品被评为国家A级产品，通过ISO9001国际质量体系认证。
                            </p>
                        </div>
                    </div>--%>
                    <!-- 资讯内容ends -->
                </div>
             </div>
             <!-- --中间end-- -->

             <!-- --右侧start-- -->
             <div class="login_iframe_wrap_col">
                 <div class="login_iframe_wrap">
                     <!-- 表格内容 start -->
                     <div class="login_iframe_form">
                        <div class="login_iframe_item">
                            <div class="login_iframe_area">
                            <%@ include file="./form.jsp"%>
                            </div>
                        </div>
                     </div>
                     <!-- 表格内容 end -->
                     <!--版权信息starts-->
                    <div class="login_footer">
                        <p>${lfn:loginLangMsg('custom_hotline') }</p>
                    </div>
                    <!--版权信息ends-->
                 </div>
             </div>
             <!-- --右侧end-- -->
             </div>
         </div>
         <div style="text-align: center; margin-top: -20px ">
             <p>${lfn:loginLangMsg('custom_footInfo') }</p>
			 <img src="/resource/login/login_lux_brand_blue_10/images/beiantubiao.png" height="20px" width="20px">
			 <a href="https://beian.miit.gov.cn/" target=" blank">浙ICP备18001359号-2</a>
         </div>

         <!-- 登录框 结束 -->
         <div class="tipsClass"><%=ResourceUtil.getString("login.page.captial.tip")%></div>
         <div class="hiddenDiv"></div>
     </template:replace>
 </template:include>
