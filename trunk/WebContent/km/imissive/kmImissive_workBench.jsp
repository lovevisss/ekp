<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="com.landray.kmss.sys.notify.service.ISysNotifyTodoService"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveStatService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.common.dao.HQLInfo"%>
<%@page import="java.util.Date"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	IKmImissiveStatService statService = (IKmImissiveStatService) SpringBeanUtil.getBean("kmImissiveStatService");
	ISysNotifyTodoService todoService = (ISysNotifyTodoService) SpringBeanUtil.getBean("sysNotifyTodoService");
	HQLInfo hqlInfo = statService.buildMyTodoHql("todo", null);
	int todoCount = todoService.findList(hqlInfo).size();
	pageContext.setAttribute("todoCount", todoCount);
	hqlInfo = statService.buildMyTodoHql("todo", 1);
	int todoUrgentCount = todoService.findList(hqlInfo).size();
	pageContext.setAttribute("todoUrgentCount", todoUrgentCount);
	hqlInfo = statService.buildMyTodoHql("toview", null);
	int toviewCount = todoService.findList(hqlInfo).size();
	pageContext.setAttribute("toviewCount", toviewCount);
	pageContext.setAttribute("beginDayOfWeek", DateUtil.convertDateToString(DateUtil.getBeginDayOfWeek(), DateUtil.TYPE_DATE, request.getLocale()));
	pageContext.setAttribute("endDayOfWeek", DateUtil.convertDateToString(DateUtil.getEndDayOfWeek(), DateUtil.TYPE_DATE, request.getLocale()));
	pageContext.setAttribute("beginDayOfMonth", DateUtil.convertDateToString(DateUtil.getBeginDayOfMonth(), DateUtil.TYPE_DATE, request.getLocale()));
	pageContext.setAttribute("endDayOfMonth", DateUtil.convertDateToString(DateUtil.getEndDayOfMonth(), DateUtil.TYPE_DATE, request.getLocale()));
	pageContext.setAttribute("beginDayOfYear", DateUtil.convertDateToString(DateUtil.getBeginDayOfYear(), DateUtil.TYPE_DATE, request.getLocale()));
	pageContext.setAttribute("endDayOfYear", DateUtil.convertDateToString(DateUtil.getEndDayOfYear(), DateUtil.TYPE_DATE, request.getLocale()));
%>
<template:include  ref="default.simple" sidebar="no" spa="true">
	<template:replace name="body">
	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/common.css?s_cache=${LUI_Cache}"/>
	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/custom.css?s_cache=${LUI_Cache}"/>
	
		
		<!-- 公文工作台 Starts -->
    <div class="lui_imissive_platform_container">
        <!-- 头部 -->
        <div id="notice_container" class="lui_imissive_platform_top">
            <!-- 公告 -->
            <div class="lui_imissive_platform_component lui_imissive_notice_bar">
                <i class="lui_imissive_icon icon_notice"></i>${ lfn:message('km-imissive:workbench.tip1') }<em>${todoCount }</em>${ lfn:message('km-imissive:workbench.tip2') }<em
					class="status_urgent">${todoUrgentCount }</em>${ lfn:message('km-imissive:workbench.tip3') }<em><span id="toviewCount">${toviewCount }</span></em>${ lfn:message('km-imissive:workbench.tip4') }
            	<i class="lui_imissive_btn_close"></i>
            </div>
        </div>
        <!-- 内容区域 -->
        <div class="lui_imissive_platform_content">
            <!-- 左边 -->
            <div class="lui_imissive_platform_contentL">
                <!-- 多标签 待办公文、待阅公文 -->
                <div class="lui_imissive_tabpanel_frame lui_imissive_platform_component">
                    <ui:tabpanel id="kmImissivePanelWorkBench" layout="sys.ui.tabpanel.list" >
						<ui:content id="todoImissive" title="${ lfn:message('km-imissive:workbench.imissive.todo') }">
						    <ui:dataview id="todoImissive-view">
								<ui:source type="AjaxJson">	 
									{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchData&type=todo&rowsize=5"}
								</ui:source>
								<ui:render type="Template">
									<c:import url="/km/imissive/tmpl/workbench_tabpanel.jsp?dataType=todo" charEncoding="UTF-8"></c:import>
								</ui:render>
							</ui:dataview>
						</ui:content>
						<ui:content id="toviewImissive" title="${ lfn:message('km-imissive:workbench.imissive.toview') }">
						    <ui:dataview id="toviewImissive-view">
								<ui:source type="AjaxJson">	 
									{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchData&type=toview&rowsize=5"}
								</ui:source>
								<ui:render type="Template">
									<c:import url="/km/imissive/tmpl/workbench_tabpanel.jsp?dataType=toview" charEncoding="UTF-8"></c:import>
								</ui:render>
							</ui:dataview>
						</ui:content>
					</ui:tabpanel>
                </div>
                <!-- 公文数据  -->
                <div class="lui_imissive_platform_component lui_imissive_panel_frame">
                    <div class="lui_imissive_panel_nav">
                        <span class="lui_imissive_panel_title"><i class="lui_text_primary"></i>${ lfn:message('km-imissive:workbench.imissive.data') }</span>
                        <!-- 操作区域 -->
                        <div class="lui_imissive_panel_opt">
                            <div id="docDataDiv" class="lui_imissive_panel_opt_item lui_imissive_panel_opt_item_dropdown">${ lfn:message('km-imissive:workbench.date.week') }<ul>
                                    <li onclick="docDataChange('month')">${ lfn:message('km-imissive:workbench.date.month') }</li>
                                    <li onclick="docDataChange('year')">${ lfn:message('km-imissive:workbench.date.year') }</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="lui_imissive_panel_content" style="padding-top:10px;padding-bottom:10px;">
                    	<ui:dataview id="imissiveDataView">
                    		<ui:source type="AjaxJson">
                    			{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchFlowCount&date=week"}
                    		</ui:source>
                    		<ui:render type="Template">
		                        {$<ul class="lui_imissive_data_iconList">
		                            <li><a href="javascript:openImissive('/listCreate');">
		                                    <i class="lui_imissive_icon data_imissive_launch"></i>
		                                    <div class="lui_imissive_data_content">
		                                        <em>{%data[0].value%}</em>
		                                        <p>{%data[0].name%}</p>
		                                    </div>
		                                </a></li>
		                            <li><a href="javascript:openImissive('/listApproval');">
		                                    <i class="lui_imissive_icon data_imissive_pending"></i>
		                                    <div class="lui_imissive_data_content">
		                                        <em>{%data[1].value%}</em>
		                                        <p>{%data[1].name%}</p>
		                                    </div>
		                                </a></li>
		                            <li><a href="javascript:openImissive('/listCreate', 'docStatus:10');">
		                                    <i class="lui_imissive_icon data_imissive_temporary"></i>
		                                    <div class="lui_imissive_data_content">
		                                        <em>{%data[2].value%}</em>
		                                        <p>{%data[2].name%}</p>
		                                    </div>
		                                </a></li>
		                            <li><a href="javascript:openImissive('/listAllSend','docStatus:30');">
		                                    <i class="lui_imissive_icon data_outgoing_done"></i>
		                                    <div class="lui_imissive_data_content">
		                                        <em>{%data[3].value%}</em>
		                                        <p>{%data[3].name%}</p>
		                                    </div>
		                                </a></li>
		                            <li><a href="javascript:openImissive('/listAllReceive','docStatus:30');">
		                                    <i class="lui_imissive_icon icon_incoming_done"></i>
		                                    <div class="lui_imissive_data_content">
		                                        <em>{%data[4].value%}</em>
		                                        <p>{%data[4].name%}</p>
		                                    </div>
		                                </a></li>
		                            <li><a href="javascript:openImissive('/listAllSign','docStatus:30');">
		                                    <i class="lui_imissive_icon icon_report_done"></i>
		                                    <div class="lui_imissive_data_content">
		                                        <em>{%data[5].value%}</em>
		                                        <p>{%data[5].name%}</p>
		                                    </div>
		                                </a></li>
		                        </ul>$}
                    		</ui:render>
                    	</ui:dataview>
                        
                    </div>
                </div>
                <!-- 已办理文种   -->
                <div class="lui_imissive_platform_component lui_imissive_panel_frame">
                    <div class="lui_imissive_panel_nav">
                        <span class="lui_imissive_panel_title"><i class="lui_text_primary"></i>${ lfn:message('km-imissive:workbench.apply.language') }</span>
                        <!-- 操作区域 -->
                        <div class="lui_imissive_panel_opt">
                            <div id="chartOrgDataDiv" class="lui_imissive_panel_opt_item lui_imissive_panel_opt_item_dropdown">${ lfn:message('km-imissive:workbench.org.person') }<ul>
                                    <li onclick="chartDataChange('dept',null)">${ lfn:message('km-imissive:workbench.org.dept') }</li>
                                </ul>
                            </div>
                            <div id="chartDateDataDiv" class="lui_imissive_panel_opt_item lui_imissive_panel_opt_item_dropdown">${ lfn:message('km-imissive:workbench.date.week') }<ul>
                                    <li onclick="chartDataChange(null,'month')">${ lfn:message('km-imissive:workbench.date.month') }</li>
                                    <li onclick="chartDataChange(null,'year')">${ lfn:message('km-imissive:workbench.date.year') }</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="lui_imissive_panel_content" align="center">
						<ui:chart var-themeName="landrayblue" id="main_chart" width="600" height="320">
							<ui:source type="AjaxJson">
								{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchTypeCount&date=week"}
							</ui:source>
						</ui:chart>
                    </div>
                </div>
            </div>
            <!-- 右边 -->
            <div class="lui_imissive_platform_contentR">
            	<c:set var="linkBtnCount" value="0" />
            	<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
            		<c:set var="linkBtnCount" value="${linkBtnCount+1 }" />
            	</kmss:authShow>
            	<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
            		<c:set var="linkBtnCount" value="${linkBtnCount+1 }" />
            	</kmss:authShow>
                <!-- 快捷 发文拟稿、收文登记 -->
                <div class="lui_imissive_platform_component lui_imissive_shortcut_iframe" style="${('0' eq linkBtnCount)?'display:none':''}">
                	<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
	                    <div style="width:${('1' eq linkBtnCount)?'100%':'50%'}" class="lui_imissive_shortcut_item" onclick="addSendMain();">
	                        <i class="lui_imissive_shortcut_icon shortcut_create"></i>
	                        <div class="lui_imissive_shortcut_content">${ lfn:message('km-imissive:kmImissiveSendMain.create.title') }</div>
	                    </div>
	                </kmss:authShow>
	                <kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
	                    <div style="width:${('1' eq linkBtnCount)?'100%':'50%'}" class="lui_imissive_shortcut_item" onclick="addReceiveMain();">
	                        <i class="lui_imissive_shortcut_icon shortcut_register"></i>
	                        <div class="lui_imissive_shortcut_content">${ lfn:message('km-imissive:kmImissiveReceiveMain.create.title') }</div>
	                    </div>
	                </kmss:authShow>
                </div>
                <!-- 常用模板 -->
                <div class="lui_imissive_platform_component lui_imissive_panel_frame">
                    <div class="lui_imissive_panel_nav">
                        <span class="lui_imissive_panel_title"><i class="lui_text_primary"></i>${ lfn:message('km-imissive:workbench.template.often') }</span>
                    </div>
                    <ui:dataview>
                    	<ui:source type="AjaxJson">
                    		{"url":"/sys/lbpmperson/SysLbpmPersonCreate.do?method=listUsual&mainModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain"}
                    	</ui:source>
                    	<ui:render type="Template">
                    		{$
                    		<div class="lui_imissive_panel_content">
		                        <ul class="lui_imissive_templateList">$}
		                        	var list = data.list;
		                        	var size = 6;
									if(list!=null){
										if(list.length < 6) {
										size = list.length;
										}
										for(var i=0;i < size;i++) {
										{$<li><a href="${LUI_ContextPath}/{%list[i].addUrl%}" target="_blank"><i
												class="lui_imssive_icon"></i><span>{%list[i].templateName%}</span></a></li>
										$}
										}
									}
		                        {$</ul>
		                    </div>
                    		$}
                    	</ui:render>
                    </ui:dataview>
                </div>
                <!-- 最新公文 -->
                <div class="lui_imissive_platform_component lui_imissive_panel_frame">
                    
                    <ui:tabpanel id="kmImeetingLatestPanel" layout="sys.ui.tabpanel.list" >
						<ui:content title="${ lfn:message('km-imissive:kmImissiveSend.portlet.latest') }">
							<ui:dataview id="sendDataView" format="sys.ui.classic">
								<ui:source type="AjaxJson">	 
									{"url":"/sys/common/datajson.jsp?s_bean=kmImissiveSendMainPortlet&rowsize=6"}
								</ui:source>
								<ui:render type="Template">
									<c:import url="/km/imissive/tmpl/workbench_latest.jsp" charEncoding="UTF-8"></c:import>
								</ui:render>
							</ui:dataview>
						</ui:content>
						
						<ui:content title="${ lfn:message('km-imissive:kmImissiveReceive.portlet.latest') }">
							<ui:dataview id="receiveDataView" format="sys.ui.classic">
								<ui:source type="AjaxJson">	 
									{"url":"/sys/common/datajson.jsp?s_bean=kmImissiveReceiveMainPortlet&rowsize=6"}
								</ui:source>
								<ui:render type="Template">
									<c:import url="/km/imissive/tmpl/workbench_latest.jsp" charEncoding="UTF-8"></c:import>
								</ui:render>
							</ui:dataview>
						</ui:content>
						
						<ui:content title="${ lfn:message('km-imissive:kmImissiveSign.portlet.latest') }">
							<ui:dataview id="signDataView" format="sys.ui.classic">
								<ui:source type="AjaxJson">	 
									{"url":"/sys/common/datajson.jsp?s_bean=kmImissiveSignMainPortlet&rowsize=6"}
								</ui:source>
								<ui:render type="Template">
									<c:import url="/km/imissive/tmpl/workbench_latest.jsp" charEncoding="UTF-8"></c:import>
								</ui:render>
							</ui:dataview>
						</ui:content>
					</ui:tabpanel>
					<div class="lui_imissive_panel_footer">
						<!-- 操作区域 -->
						<div class="lui_imissive_panel_opt" style="float:left;margin-left:15px;">
						    <!-- 搜索 -->
						    <div class="lui_imissive_search_bar" style="margin-right:10px;">
						        <input id="imissiveSearchInput" type="text" placeholder="${ lfn:message('km-imissive:button.searchList') }">
						        <i onclick="searchImissive(true);"></i>
						    </div>
						</div>
						<a href="javascript:searchImissive(false);" style="float:left">${lfn:message('operation.more') }</a>
					</div>
                </div>
            </div>
        </div>
    </div>
	<script>
		this.tobiewSum = 0;
		window.refreshToview=function(type){
			if(type =="toview"){
				setTimeout(function(){
					var dataview = LUI("toviewImissive-view");
					dataview.source.url="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchData&type=toview&rowsize=5";
					dataview.erase();
					dataview.load();
					++tobiewSum;
					var toviewCount = '${toviewCount}';
					toviewCount = toviewCount-tobiewSum;
					$("#toviewCount").html(toviewCount);
				},500);
			}
		}

		setTimeout(function (){
			$('#kmImissivePanelWorkBench').find('.lui_tabpanel_list_navs_item_r').eq(0).on('click',function(){
				setTimeout(function(){
					var dataview = LUI("todoImissive-view");
					dataview.source.url="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchData&type=todo&rowsize=5";
					dataview.erase();
					dataview.load();
				},300);
			});
		},300);
	</script>
	<script>
    	var docDatas = [{'date':"week","name":"${ lfn:message('km-imissive:workbench.date.week') }"},{'date':"month","name":"${ lfn:message('km-imissive:workbench.date.month') }"},{'date':"year","name":"${ lfn:message('km-imissive:workbench.date.year') }"}]
    	var docDataSelected = 'week';
    	// 公文数据切换
    	function docDataChange(date) {
    		var dataview = LUI("imissiveDataView");
    		dataview.source.url="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchFlowCount&date="+date;
    		dataview.erase();
    		dataview.load();
    		$("#docDataDiv").children().remove();
    		var text = '';
    		var ul = $("<ul>");
    		for (var i = 0; i < docDatas.length; i++) {
				var data = docDatas[i];
				if(data.date == date) {
					text = data.name;
				} else {
					ul.append($("<li onclick=\"docDataChange('"+data.date+"')\">"+data.name+"</li>"));
				}
			}
    		$("#docDataDiv").html(text);
    		ul.appendTo($("#docDataDiv"));
    		$("#docDataDiv ul").hide();
    		docDataSelected = date;
    	}
    	
    	// 公文文种图表数据切换
    	var chartOrg = 'person';
    	var chartDate = "week";
    	function chartDataChange(org,date) {
    		var text = '';
    		var ul = $("<ul>");
    		if(org != null) {
    			chartOrg = org;
    			$("#chartOrgDataDiv").children().remove();
    			if(org == 'person') {
    				text = "${ lfn:message('km-imissive:workbench.org.person') }";
    				ul.append($("<li onclick=\"chartDataChange('dept')\">${ lfn:message('km-imissive:workbench.org.dept') }</li>"));
    			} else {
    				text = "${ lfn:message('km-imissive:workbench.org.dept') }";
    				ul.append($("<li onclick=\"chartDataChange('person')\">${ lfn:message('km-imissive:workbench.org.person') }</li>"));
    			}
    			$("#chartOrgDataDiv").html(text);
        		ul.appendTo($("#chartOrgDataDiv"));
    		} else {
    			chartDate = date;
    			$("#chartDateDataDiv").children().remove();
    			for (var i = 0; i < docDatas.length; i++) {
    				var data = docDatas[i];
    				if(data.date == date) {
    					text = data.name;
    				} else {
    					ul.append($("<li onclick=\"chartDataChange(null,'"+data.date+"')\">"+data.name+"</li>"));
    				}
    			}
        		$("#chartDateDataDiv").html(text);
        		ul.appendTo($("#chartDateDataDiv"));
    		}
    		var url = "/km/imissive/km_imissive_stat/kmImissiveStat.do?method=workbenchTypeCount&dataview=chart&org="+chartOrg+"&date="+chartDate;
    		var chart = LUI("main_chart");
    		chart.replaceDataSource({"url":url,"type":"AjaxJson"});
    	}
    	
    	var latestRoute = "/listAllSend";
    	LUI.ready(function() {
    		var tab = LUI("kmImeetingLatestPanel");
    		tab.on('indexChanged',function(evt) {
    			var idx = evt.index.after;
    			if(idx == 0) {
    				latestRoute = "/listAllSend";
    			} else if(idx == 1) {
    				latestRoute = "/listAllReceive";
    			} else {
    				latestRoute = "/listAllSign";
    			}
    		})
    	});
    	
    	seajs.use(['lui/dialog','lui/jquery','lui/framework/router/router-utils'],function(dialog,$,util) {
    		// 发文拟稿
    		window.addSendMain = function() {
    			dialog.categoryForNewFile(
      					'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
      					'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false);
    		};
    		// 收文登记
			window.addReceiveMain = function() {
				dialog.categoryForNewFile(
      					'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',
      					'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false);
    		};
    		
    		window.openImissive = function(href, other) {
    			var param = {cri:{'cri.q':'docCreateTime:${beginDayOfWeek};docCreateTime:${endDayOfWeek}'}};
    			if(docDataSelected == 'month') {
    				param = {cri:{'cri.q':'docCreateTime:${beginDayOfMonth};docCreateTime:${endDayOfMonth}'}};
    			} else if(docDataSelected == 'year') {
    				param = {cri:{'cri.q':'docCreateTime:${beginDayOfYear};docCreateTime:${endDayOfYear}'}};
    			}
    			if(other) {
    				param.cri['cri.q'] += ";" + other;
    			}
    			window.parent.newPageWithParam(href,param);
    		};
    		window.searchImissive = function(hasParam) {
    			if(hasParam) {
    				var param = {};
        			var search = $("#imissiveSearchInput").val();
        			if(search) {
        				param = {cri:{'cri.q':'docSubject:'+search}};
        			}
        			window.parent.newPageWithParam(latestRoute, param);
    			} else {
    				window.parent.newPageWithParam(latestRoute);
    			}
    		};
    		
    		$(document).ready(function() {
    			$("#notice_container .lui_imissive_btn_close").on("click",function() {
    				$("#notice_container").hide();
    				$('<div style="height:70px">').appendTo($(".lui_imissive_platform_container"));
    			});
    			$("#docDataDiv").hover(function() {
    				$("#docDataDiv ul").show();
    			},function() {
    				$("#docDataDiv ul").hide();
    			});
    			
    			$("#chartOrgDataDiv").hover(function() {
    				$("#chartOrgDataDiv ul").show();
    			},function() {
    				$("#chartOrgDataDiv ul").hide();
    			});
    			
    			$("#chartDateDataDiv").hover(function() {
    				$("#chartDateDataDiv ul").show();
    			},function() {
    				$("#chartDateDataDiv ul").hide();
    			});
    		});
    	});
    </script>
	</template:replace>
</template:include>
