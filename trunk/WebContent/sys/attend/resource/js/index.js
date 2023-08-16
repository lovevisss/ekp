seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/framework/module'],
		function($, strutil, dialog, topic, Module){
	var module = Module.find('sysAttend');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/attendCalendar',
			routes : [
			        {
			        	path : '/attendCalendar', //考勤日历
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysAttendPanel',
								contents : {
									'sysAttendContent' : { title : $lang.attendCalendar, route:{ path: '/attendCalendar' } , selected : true }
								}
							}
						}
			   		},{
			        	path : '/signCalendar', //签到日历
						action : function(){ 
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/sysAttendMain_calendar_sign.jsp');
						}
			   		},{
						path : '/myAbnormal', //我的异常
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/index_exc.jsp#cri.q=fdState:0');
						}
					},{
						path : '/approval', //待我审的
//						action : {
//							type : 'pageopen',
//							options : {
//								url : $var.$contextPath + '/sys/attend/sys_attend_main_exc/index.jsp#cri.q=mydoc:approval',
//								target : '_rIframe'
//							}
//						}
						action : function(){
							openPage($var.$contextPath + '/sys/attend/sys_attend_main_exc/index.jsp#cri.q=mydoc:approval');
						}
					},{
						path : '/listAll', //所有考勤记录
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/index.jsp?categoryType=attend');
						}
					},{
						path : '/statDetail', //每日汇总
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_stat_detail/sysAttendStatDetail_count.jsp');
						}
					},{
						path : '/statReport', //每月汇总
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_report/sysAttendReport_count.jsp');
						}
					},{
						path : '/listReport', //考勤报表
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_report/index.jsp');
						}
					},{
						path : '/listcheck', //数据检查
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/sysAttendMain_check.jsp');
						}
					},{
						path : '/listMySign', //我的签到记录
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/index.jsp?categoryType=custom&appKey=default&me=true');
						}
					},{
						path : '/listAllSign', //所有签到记录
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/index.jsp?categoryType=custom&appKey=default');
						}
					},{
						path : '/listMyMeetingSign', //我的会议签到记录
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_main/index.jsp?categoryType=custom&appKey=' + $var.appKey+ '&appName=' + $var.appName + '&me=true');
						}
					},{
						path : '/listAllMeetingSign', //会议签到统计
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_category/index.jsp?type=custom&appKey=' + $var.appKey+ '&appName=' + $var.appName);
						}
					},{
						path : '/listAttendCate', //考勤组
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_category/index.jsp?type=attend');
						}
					},{
						path : '/listSignCate', //签到组
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_category/index.jsp?type=custom');
						}
					},{
						path : '/listOrgin', //原始考勤记录
						action : function(){
							openPage($var.$contextPath +'/sys/attend/sys_attend_syn_ding/index.jsp');
						}
					},{
						path : '/management', // 后台管理
						action : {
							type : 'pageopen',
							options : {
								url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/sys/attend/tree.jsp',
								target : '_rIframe'
							}
						}
					}
			   ]
		});
	});
});