<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/portal/sys_portal_page/page.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/portal/portal.tld" prefix="portal"%>
<template:include ref="template.person" pagewidth="1200px">  
 <template:replace name="content">  
  <table width="980" style="table-layout: fixed;" data-lui-type="lui/portal!VBox">
   <script type="text/config">{"column":1,"boxWidth":980,"boxStyle":""}</script> 
   <tbody> 
    <tr> 
     <td valign="top" width="980" data-lui-type="lui/portal!Container"><script type="text/config">{"columnProportion":"1","columnWidth":"980","hSpacing":null,"vSpacing":"10","columnStyle":"","columnLock":false}</script>  
      <ui:nonepanel layout="sys.ui.nonepanel.transparent" height="64" scroll="false" var-style="padding-top:4px;
background:#fff;
border-radius: 6px;" id="p_4688c2da850f2aaf5d94">
       <portal:portlet title="快捷方式" subtitle="" titleicon="" cfg-extClass="lui_panel_ext_padding" var-fdModelNames="com.landray.kmss.km.collaborate.model.KmCollaborateMain,com.landray.kmss.km.doc.model.KmDocKnowledge,com.landray.kmss.km.imeeting.model.KmImeetingMain,com.landray.kmss.km.review.model.KmReviewMain,com.landray.kmss.km.supervise.model.KmSuperviseMain,com.landray.kmss.sys.bookmark.model.SysBookmarkMain,com.landray.kmss.sys.follow.model.SysFollowPersonConfig,com.landray.kmss.sys.task.model.SysTaskMain">
        <ui:dataview format="sys.ui.stat">
         <ui:source ref="sys.person.stat.source" var-fdModelNames="com.landray.kmss.km.collaborate.model.KmCollaborateMain,com.landray.kmss.km.doc.model.KmDocKnowledge,com.landray.kmss.km.imeeting.model.KmImeetingMain,com.landray.kmss.km.review.model.KmReviewMain,com.landray.kmss.km.supervise.model.KmSuperviseMain,com.landray.kmss.sys.bookmark.model.SysBookmarkMain,com.landray.kmss.sys.follow.model.SysFollowPersonConfig,com.landray.kmss.sys.task.model.SysTaskMain"></ui:source>
         <ui:render ref="sys.ui.stat.simpleStatis"></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
       </portal:portlet>
      </ui:nonepanel>  </td> 
    </tr> 
   </tbody> 
  </table> 
  <div style="height: 10px;" data-lui-type="lui/vspace!VSpace"> 
  </div> 
  <table width="980" style="table-layout: fixed;" data-lui-type="lui/portal!VBox">
   <script type="text/config">{"column":2,"boxWidth":980,"boxStyle":""}</script> 
   <tbody> 
    <tr> 
     <td valign="top" width="685" data-lui-type="lui/portal!Container"><script type="text/config">{"columnProportion":"840","columnWidth":"685","hSpacing":null,"vSpacing":"10","columnStyle":"","columnLock":false}</script>  
      <ui:tabpanel height="427" scroll="true" layout="sys.ui.tabpanel.default" var-timeInterval="" var-parentTitle="" var-subtitle="" var-icon="" var-style="" id="p_6d0212e586fda9c12780">
       <portal:portlet title="待办" subtitle="" titleicon="" var-sortType="datetime" var-fdType="13" var-showAvatar="0" var-rowSize="10">
        <ui:dataview format="sys.ui.iframe">
         <ui:source ref="sys.notify.simplicity.todo.source" var-sortType="datetime" var-fdType="13" var-showAvatar="0" var-rowSize="10"></ui:source>
         <ui:render ref="sys.ui.iframe.default" var-frameName=""></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
        <ui:operation href="javascript:(function() {        var url;        var AppName = '!{fdAppName}';        if (AppName != '') {      url = '${LUI_ContextPath }/sys/notify/index.jsp#j_path=%2Fprocess&dataType=todo&cri.list_todo.q=fdType:!{fdType};fdAppName:!{fdAppName}';     } else {      url = '${LUI_ContextPath }/sys/notify/index.jsp#j_path=%2Fprocess&dataType=!{dataType}&cri.list_todo.q=fdType:!{fdType}';        }        Com_OpenWindow(url);    })();" name="{operation.more}" target="_self" type="more" align="right"></ui:operation>
       </portal:portlet>
       <portal:portlet title="待阅" subtitle="" titleicon="" var-sortType="datetime" var-fdType="13" var-showAvatar="0" var-rowSize="10">
        <ui:dataview format="sys.ui.iframe">
         <ui:source ref="sys.notify.simplicity.todo.source" var-sortType="datetime" var-fdType="13" var-showAvatar="0" var-rowSize="10"></ui:source>
         <ui:render ref="sys.ui.iframe.default" var-frameName=""></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
        <ui:operation href="javascript:(function() {        var url;        var AppName = '!{fdAppName}';        if (AppName != '') {      url = '${LUI_ContextPath }/sys/notify/index.jsp#j_path=%2Fprocess&dataType=todo&cri.list_todo.q=fdType:!{fdType};fdAppName:!{fdAppName}';     } else {      url = '${LUI_ContextPath }/sys/notify/index.jsp#j_path=%2Fprocess&dataType=!{dataType}&cri.list_todo.q=fdType:!{fdType}';        }        Com_OpenWindow(url);    })();" name="{operation.more}" target="_self" type="more" align="right"></ui:operation>
       </portal:portlet>
      </ui:tabpanel> 
      <div style="height: 10px;" data-lui-type="lui/vspace!VSpace"> 
      </div> 
      <ui:tabpanel height="340" scroll="true" layout="sys.ui.tabpanel.default" var-timeInterval="" var-parentTitle="" var-subtitle="" var-icon="" var-style="" id="p_a388a1fc91f6530d9374">
       <portal:portlet title="集团新闻" subtitle="" titleicon="" var-scope="no" var-rowsize="6" var-cateid="">
        <ui:dataview format="sys.ui.image.desc">
         <ui:source ref="sys.news.image.desc.source" var-scope="no" var-rowsize="6" var-cateid=""></ui:source>
         <ui:render ref="sys.ui.image.desc.extensionSwitch" var-imgWidth="300" var-radius="4" var-marginB="8" var-isStretch="0" var-iscate="0" var-style=""></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
        <ui:operation href="/sys/news/?categoryId=!{cateid}" name="{operation.more}" type="more" align="right"></ui:operation>
        <ui:operation href="javascript:(function(){seajs.use(['sys/news/sys_news_ui/js/create'], function(create) {         create.addDoc('!{cateid}');       });})();" name="{operation.create}" target="_self" type="create" align="right"></ui:operation>
       </portal:portlet>
       <portal:portlet title="集团公告" subtitle="" titleicon="" var-scope="no" var-rowsize="5" var-cateid="16dbf5cd82eb3b80b1bc7164cdab5bf0" var-type="main">
        <ui:dataview format="sys.ui.classic">
         <ui:source ref="sys.news.main.withAtt.source" var-scope="no" var-rowsize="5" var-cateid="16dbf5cd82eb3b80b1bc7164cdab5bf0" var-type="main"></ui:source>
         <ui:render ref="sys.ui.classic.breakLine" var-marginB="15" var-isStyle="gray_disc" var-style=""></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
        <ui:operation href="/sys/news/?categoryId=!{cateid}" name="{operation.more}" type="more" align="right"></ui:operation>
        <ui:operation href="javascript:(function(){seajs.use(['sys/news/sys_news_ui/js/create'], function(create) {         create.addDoc('!{cateid}');       });})();" name="{operation.create}" target="_self" type="create" align="right"></ui:operation>
       </portal:portlet>
      </ui:tabpanel> 
      <div style="height: 10px;" data-lui-type="lui/vspace!VSpace"> 
      </div> 
      <ui:panel toggle="false" layout="sys.ui.panel.default" height="290" scroll="true" var-style="" id="p_d5f0635f169fd8ef2add">
       <portal:portlet title="公司论坛" subtitle="" titleicon="" var-scope="no" var-persontype="replier" var-rowsize="6" var-type="new" var-fdForumIds="">
        <ui:dataview format="sys.ui.classic">
         <ui:source ref="km.forum.topic.classic.source" var-scope="no" var-persontype="replier" var-rowsize="6" var-type="new" var-fdForumIds=""></ui:source>
         <ui:render ref="sys.ui.classic.withNumber" var-marginB="10" var-style=""></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
        <ui:operation href="/km/forum/indexCriteria.jsp#cri.q=categoryId:!{fdForumIds}" name="{operation.more}" type="more" align="right"></ui:operation>
        <ui:operation href="/km/forum/km_forum/kmForumPost.do?method=add&fdForumId=!{fdForumIds}" name="{operation.create}" type="create" align="right"></ui:operation>
       </portal:portlet>
      </ui:panel>  </td> 
     <td width="10" style="min-width:10px;"> </td> 
     <td valign="top" width="285" data-lui-type="lui/portal!Container"><script type="text/config">{"columnProportion":"350","columnWidth":"285","hSpacing":"10","vSpacing":"10","columnStyle":"","columnLock":false}</script>  
      <ui:nonepanel layout="sys.ui.nonepanel.transparent" height="390" scroll="true" var-style="overflow:hidden;" id="p_93b0e6590f18457f83b4">
       <portal:portlet title="新版日历" subtitle="" titleicon="" var-rowsize="6">
        <ui:dataview format="sys.ui.html">
         <ui:source ref="km.calendar.portlet.month.source" var-rowsize="6"></ui:source>
         <ui:render ref="sys.ui.html.default"></ui:render>
         <ui:var name="showNoDataTip" value="true"></ui:var>
         <ui:var name="showErrorTip" value="true"></ui:var>
        </ui:dataview>
        <ui:operation href="/km/calendar" name="{operation.more}" type="more" align="right"></ui:operation>
        <ui:operation href="javascript:calendarPortletOpen('/km/calendar/km_calendar_main/kmCalendarMain.do?method=addEvent','add','event');" name="{operation.create}" target="_self" type="create" align="right"></ui:operation>
       </portal:portlet>
      </ui:nonepanel> 
      <div style="height: 10px;" data-lui-type="lui/vspace!VSpace"> 
      </div> 
      <table width="285" style="table-layout: fixed;" data-lui-type="lui/portal!VBox">
       <script type="text/config">{"column":1,"boxWidth":285,"boxStyle":""}</script> 
       <tbody> 
        <tr> 
         <td valign="top" width="285" data-lui-type="lui/portal!Container"><script type="text/config">{"columnProportion":"1","columnWidth":285,"hSpacing":0,"vSpacing":"0","columnStyle":"","columnLock":false}</script>  
          <ui:nonepanel layout="sys.ui.nonepanel.default" height="46" scroll="false" var-style="" id="p_9084446e38da5552f4e4">
           <portal:portlet title="装饰" subtitle="" titleicon="">
            <ui:dataview format="sys.portal.decorate">
             <ui:source ref="sys.portal.decorate.source"></ui:source>
             <ui:render ref="portal.decorate.simpleTitle" var-mainTitle="快捷方式" var-height="46" var-bg="" var-style="border-radius:6px 6px 0 0;"></ui:render>
             <ui:var name="showNoDataTip" value="true"></ui:var>
             <ui:var name="showErrorTip" value="true"></ui:var>
            </ui:dataview>
           </portal:portlet>
          </ui:nonepanel> 
          <div style="height: 0px;" data-lui-type="lui/vspace!VSpace"> 
          </div> 
          <ui:nonepanel layout="sys.ui.nonepanel.transparent" height="318" scroll="false" var-style="background-color:#fff;
border-radius:0 0 6px 6px;" id="p_00cad993f268df155ec3">
           <portal:portlet title="快捷方式" subtitle="" titleicon="" cfg-extClass="lui_panel_ext_padding" var-fdId="17a75cd4a2197a5e510838b4df88edeb">
            <ui:dataview format="sys.ui.picMenu">
             <ui:source ref="sys.portal.shortcut.source" var-fdId="17a75cd4a2197a5e510838b4df88edeb"></ui:source>
             <ui:render ref="sys.ui.picMenu.default" var-showMore="true" var-target="_blank"></ui:render>
             <ui:var name="showNoDataTip" value="true"></ui:var>
             <ui:var name="showErrorTip" value="true"></ui:var>
            </ui:dataview>
           </portal:portlet>
          </ui:nonepanel>  </td> 
        </tr> 
       </tbody> 
      </table> 
      <div style="height: 10px;" data-lui-type="lui/vspace!VSpace"> 
      </div> 
      <table width="285" style="table-layout: fixed;" data-lui-type="lui/portal!VBox">
       <script type="text/config">{"column":1,"boxWidth":285,"boxStyle":""}</script> 
       <tbody> 
        <tr> 
         <td valign="top" width="285" data-lui-type="lui/portal!Container"><script type="text/config">{"columnProportion":"1","columnWidth":"285","hSpacing":null,"vSpacing":"10","columnStyle":"","columnLock":false}</script>  
          <ui:panel toggle="false" layout="sys.ui.panel.default" height="302" scroll="true" var-style="" id="p_e29a00b5ac9f4c726be0">
           <portal:portlet title="常用资料" subtitle="" titleicon="" var-rowsize="7" var-cateid="">
            <ui:dataview format="sys.ui.classic">
             <ui:source ref="km.comminfo.content.source" var-rowsize="7" var-cateid=""></ui:source>
             <ui:render ref="sys.ui.classic.default" var-firstRowScroll="" var-highlight="" var-showCreator="" var-showCreated="" var-showCate="" var-showRank="no" var-cateSize="0" var-newDay="0" var-target="_blank" var-subjectSize="0"></ui:render>
             <ui:var name="showNoDataTip" value="true"></ui:var>
             <ui:var name="showErrorTip" value="true"></ui:var>
            </ui:dataview>
            <ui:operation href="/km/comminfo/?categoryId=!{cateid}" name="{operation.more}" type="more" align="right"></ui:operation>
            <ui:operation href="/km/comminfo/km_comminfo_main/kmComminfoMain.do?method=add&categoryId=!{cateid}" name="{operation.create}" type="create" align="right"></ui:operation>
           </portal:portlet>
          </ui:panel>  </td> 
        </tr> 
       </tbody> 
      </table>  </td> 
    </tr> 
   </tbody> 
  </table>  
 </template:replace>  
</template:include>