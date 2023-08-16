seajs.use(['lui/framework/module','lui/jquery','lui/dialog','lui/topic','lang!km-imeeting','lui/util/env','km/imeeting/resource/js/dateUtil'],
		function(Module, $, dialog, topic ,lang,env,dateUtil){

	var module = Module.find('kmImeeting');

	/**
	 * 内置参数: $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router :
	 * 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		// 路由配置
		$router.define({
			startpath : $var.startpath,
			routes : [{
				path : '/mycalendar',  // 我的日历
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'mycalendar' : { title : '我的日历', route:{ path: '/mycalendar' }, selected : true }
						}
					}
				}
			}, {
				path : '/mainBoard',  // 我的日历
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'mainBoard' : { title : '会议看板', route:{ path: '/mainBoard' }, selected : true }
						}
					}
				}
			}, {
				path : '/myWorkbench',  // 个人工作台
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'myWorkbench' : { title : '个人工作台', route:{ path: '/myWorkbench' }, selected : true }
						}
					}
				}
			}, {
				path : '/topicDraft',  // 议题申报
				action : function(){
					var mainModelName = 'com.landray.kmss.km.imeeting.model.KmImeetingTopic',
						modelName = 'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory';
					createTopic(mainModelName, modelName, 'topic','/topicDraft');
				}
			}, {
				path : '/topicApproval',
				children : [{
				path:'/topicMyTodo',   // 待我审的议题
				action : {
					type : 'tabpanel',
					options : {
							panelId : 'kmImeetingPanel',
							contents : {
								'topicMyTodo' : { route:{ path: '/topicApproval/topicMyTodo' }, cri :{'docType':'myApproval','j_path':'/topicApproval/topicMyTodo'}, selected : true },
								'topicMyDone' : { route:{ path: '/topicApproval/topicMyDone' }, cri :{'docType':'myApprovaled','j_path':'/topicApproval/topicMyDone'}}
							}
						}
					}
				},{
					path:'/topicMyDone', // 我已审的议题
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'topicMyTodo' : { route:{ path: '/topicApproval/topicMyTodo' }, cri :{'docType':'myApproval','j_path':'/topicApproval/topicMyTodo'}},
									'topicMyDone' : { route:{ path: '/topicApproval/topicMyDone' }, cri :{'docType':'myApprovaled','j_path':'/topicApproval/topicMyDone'}, selected : true}
								}
							}
						}
				}]
			}, {
				path : '/allTopic',  // 议题库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'allTopic' : { title : '议题库', route:{ path: '/allTopic' }, cri : buildCriParam($var.isCurAdmin, 'allTopic', '/allTopic', false, false), selected : true }
						}
					}
				}
			},{
				path : '/schemeDrafted',  // 方案申报
				action : function(){
					var mainModelName = 'com.landray.kmss.km.imeeting.model.KmImeetingScheme',
						modelName = 'com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate';
					createDoc(mainModelName, modelName, 'scheme','/schemeDrafted');
				}
			},

			{
				path : '/schemeApproval',
				children : [{
				path:'/schemeMyTodo',   // 待我审的方案
				action : {
					type : 'tabpanel',
					options : {
							panelId : 'kmImeetingPanel',
							contents : {
								'schemeMyTodo' : { route:{ path: '/schemeApproval/schemeMyTodo' }, cri :{'docType':'myApproval','j_path':'/schemeApproval/schemeMyTodo'}, selected : true },
								'schemeMyDone' : { route:{ path: '/schemeApproval/schemeMyDone' }, cri :{'docType':'myApprovaled','j_path':'/schemeApproval/schemeMyDone'}}
							}
						}
					}
				},{
					path:'/schemeMyDone', // 我已审的方案
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'schemeMyTodo' : { route:{ path: '/schemeApproval/schemeMyTodo' }, cri :{'docType':'myApproval','j_path':'/schemeApproval/schemeMyTodo'}},
									'schemeMyDone' : { route:{ path: '/schemeApproval/schemeMyDone' }, cri :{'docType':'myApprovaled','j_path':'/schemeApproval/schemeMyDone'}, selected : true}
								}
							}
						}
				}]
			},{
				path : '/allScheme',  // 方案库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'allScheme' : { title : '方案库', route:{ path: '/allScheme' }, cri : buildCriParam($var.isCurAdmin, 'allScheme', '/allScheme', false, false), selected : true }
						}
					}
				}
			}, {
				path : '/imeetingDraft',  // 通知起草
				action : function() {
					var mainModelName = 'com.landray.kmss.km.imeeting.model.KmImeetingMain',
						modelName = 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate';
					createDoc(mainModelName, modelName, 'main','/mainDraft');
				}
			}, {
				path : '/mainApproval',
				children : [{
				path:'/mainMyTodo',   // 待我审的通知
				action : {
					type : 'tabpanel',
					options : {
							panelId : 'kmImeetingPanel',
							contents : {
								'mainMyTodo' : { route:{ path: '/mainApproval/mainMyTodo' }, cri :{'docType':'myApproval','j_path':'/mainApproval/mainMyTodo'}, selected : true },
								'mainMyDone' : { route:{ path: '/mainApproval/mainMyDone' }, cri :{'docType':'myApprovaled','j_path':'/mainApproval/mainMyDone'}}
							}
						}
					}
				},{
					path:'/mainMyDone', // 我已审的通知
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'mainMyTodo' : { route:{ path: '/mainApproval/mainMyTodo' }, cri :{'docType':'myApproval','j_path':'/mainApproval/mainMyTodo'}},
									'mainMyDone' : { route:{ path: '/mainApproval/mainMyDone' }, cri :{'docType':'myApprovaled','j_path':'/mainApproval/mainMyDone'}, selected : true}
								}
							}
						}
				}]
			}, {
				path : '/mainView', // 通知查看
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'mainView' : { title : '通知查看', route:{ path: '/mainView' }, cri : buildCriParam($var.isCurAdmin, 'all', '/mainView', false, true), selected : true }
						}
					}
				}
			},{
				path : '/summaryDrafted',  // 起草纪要
				action : function(){
					var mainModelName = 'com.landray.kmss.km.imeeting.model.KmImeetingSummary',
						modelName = 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate';
					createDoc(mainModelName, modelName, 'summary','/summaryDrafted');
				}
			},

			{
				path : '/summaryApproval',
				children : [{
				path:'/summaryMyTodo',   // 待我审的纪要
				action : {
					type : 'tabpanel',
					options : {
							panelId : 'kmImeetingPanel',
							contents : {
								'summaryMyTodo' : { route:{ path: '/summaryApproval/summaryMyTodo' }, cri :{'docType':'myApproval', 'j_path':'/summaryApproval/summaryMyTodo'},selected : true},
								'summaryMyDone' : { route:{ path: '/summaryApproval/summaryMyDone' }, cri :{'docType':'myApproved', 'j_path':'/summaryApproval/summaryMyDone'}}
							}
						}
					}
				},{
					path:'/summaryMyDone', // 我已审的纪要
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'summaryMyTodo' : { route:{ path: '/summaryApproval/summaryMyTodo' }, cri :{'docType':'myApproval','j_path':'/summaryApproval/summaryMyTodo'}},
									'summaryMyDone' : { route:{ path: '/summaryApproval/summaryMyDone' }, cri :{'docType':'myApproved','j_path':'/summaryApproval/summaryMyDone'},selected : true}
								}
							}
						}
				}]
			}, {
				path : '/summaryView', // 纪要查看
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImeetingPanel',
						contents : {
							'summaryView' : { title : '纪要查看', route:{ path: '/summaryView' }, cri : buildCriParam($var.isCurAdmin, 'allSummary', '/summaryView', false, false), selected : true }
						}
					}
				}
			}, {
				path : '/sys/subordinate', // 下属工作
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/subordinate/moduleindex.jsp?moduleMessageKey=km-imeeting:module.km.imeeting',
						target : '_rIframe'
					}
				}
			},

			{
				path : '/discard', // 废弃
				children : [{
					path : '/topicDiscard', // 议题废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImeetingPanel',
							contents : {
								"topicDiscard" : {title :'议题废弃箱', route:{ path: '/discard/topicDiscard' }, cri :{ 'docStatus':'00','j_path':'/discard/topicDiscard' }, selected : true},
								"schemeDiscard" : {title :'方案废弃箱',route:{ path: '/discard/schemeDiscard' } , cri :{ 'docStatus':'00','j_path':'/discard/schemeDiscard' } },
								"mainDiscard" : {title :'通知废弃箱',route:{ path: '/discard/mainDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/mainDiscard' }  },
								"summaryDiscard" : {title :'纪要废弃箱',route:{ path: '/discard/summaryDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/summaryDiscard' }  }
							}
						}
					}
				},{
					path : '/schemeDiscard', // 方案废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImeetingPanel',
							contents : {
								"topicDiscard" : {title :'议题废弃箱', route:{ path: '/discard/topicDiscard' }, cri :{ 'docStatus':'00','j_path':'/discard/topicDiscard' } },
								"schemeDiscard" : {title :'方案废弃箱',route:{ path: '/discard/schemeDiscard' } , cri :{ 'docStatus':'00','j_path':'/discard/schemeDiscard' }, selected : true},
								"mainDiscard" : {title :'通知废弃箱',route:{ path: '/discard/mainDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/mainDiscard' }},
								"summaryDiscard" : {title :'纪要废弃箱',route:{ path: '/discard/summaryDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/summaryDiscard' }}
							}
						}
					}
				}, {
					path : '/mainDiscard', // 通知废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImeetingPanel',
							contents : {
								"topicDiscard" : {title :'议题废弃箱', route:{ path: '/discard/topicDiscard' }, cri :{ 'docStatus':'00','j_path':'/discard/topicDiscard' }},
								"schemeDiscard" : {title :'方案废弃箱',route:{ path: '/discard/schemeDiscard' } , cri :{ 'docStatus':'00','j_path':'/discard/schemeDiscard' }},
								"mainDiscard" : {title :'通知废弃箱',route:{ path: '/discard/mainDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/mainDiscard'}, selected : true},
								"summaryDiscard" : {title :'纪要废弃箱',route:{ path: '/discard/summaryDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/summaryDiscard' }}
							}
						}
					}
				},

				{
					path : '/summaryDiscard', // 纪要废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImeetingPanel',
							contents : {
								"topicDiscard" : {title :'议题废弃箱', route:{ path: '/discard/topicDiscard' }, cri :{ 'docStatus':'00','j_path':'/discard/topicDiscard' }},
								"schemeDiscard" : {title :'方案废弃箱',route:{ path: '/discard/schemeDiscard' } , cri :{ 'docStatus':'00','j_path':'/discard/schemeDiscard' }},
								"mainDiscard" : {title :'通知废弃箱',route:{ path: '/discard/mainDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/mainDiscard' }},
								"summaryDiscard" : {title :'纪要废弃箱',route:{ path: '/discard/summaryDiscard' }, cri:{ 'docStatus':'00','j_path':'/discard/summaryDiscard'}, selected : true}
							}
						}
					}
				}]
			},{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/imeeting/tree.jsp',
						target : '_rIframe'
					}
				}
			},
			{
				path : '/dept_stat',
				children : [{
					path:'/dept_stat',
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'deptStat' : { title : lang['kmImeetingStat.dept.stat'], route:{ path: '/dept_stat/dept_stat' }, selected : true },
									'deptStatMon' : { title : lang['kmImeetingStat.dept.statMon'], route:{ path: '/dept_stat/dept_statMon' }}
								}
							}
						}
					},{
						path:'/dept_statMon',
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'deptStat' : { title : lang['kmImeetingStat.dept.stat'], route:{ path: '/dept_stat/dept_stat' } },
									'deptStatMon' : { title : lang['kmImeetingStat.dept.statMon'], route:{ path: '/dept_stat/dept_statMon' },selected : true }
								}
							}
						}
					}]
			},
			{
				path : '/person_stat',
				children : [{
					path:'/person_stat',
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'personStat' : { title : lang['kmImeetingStat.person.stat'], route:{ path: '/person_stat/person_stat' }, selected : true },
									'personStatMon' : { title : lang['kmImeetingStat.person.statMon'], route:{ path: '/person_stat/person_statMon' }}
								}
							}
						}
					},{
						path:'/person_statMon',
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'personStat' : { title : lang['kmImeetingStat.person.stat'], route:{ path: '/person_stat/person_stat' } },
									'personStatMon' : { title : lang['kmImeetingStat.person.statMon'], route:{ path: '/person_stat/person_statMon' },selected : true }
								}
							}
						}
					}]
			},
			{
				path : '/resource_stat',
				children : [{
					path:'/resource_stat',
					action : {
						type : 'tabpanel',
						options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'resourceStat' : { title : lang['kmImeetingStat.resource.stat'], route:{ path: '/resource_stat/resource_stat' }, selected : true },
									'resourceStatMon' : { title : lang['kmImeetingStat.resource.statMon'], route:{ path: '/resource_stat/resource_statMon' }}
								}
							}
						}
					},{
						path:'/resource_statMon',
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'kmImeetingPanel',
								contents : {
									'resourceStat' : { title : lang['kmImeetingStat.resource.stat'], route:{ path: '/resource_stat/resource_stat' } },
									'resourceStatMon' : { title : lang['kmImeetingStat.resource.statMon'], route:{ path: '/resource_stat/resource_statMon' },selected : true }
								}
							}
						}
					}]
				}
			]
		});

		$function.openHref=function(href){
			window.location.href=href;
		};
		$function.openSearch=function(url){
			LUI.pageOpen(url,'_rIframe');
		};

		// 切换菜单栏
		$function.switchMenuItem = function(obj, panel,menuType){
				 LUI.pageHide("_rIframe");
				var tabpanel = LUI(panel);
				switch(menuType){
					case 'myCalendar' :
					tabpanel.setSelectedIndex(0);
					tabpanel.props(0,{
						visible : true
					});
					topic.publish('spa.change.add', {
						target : obj
					});
					break;
					case 'other' :
						tabpanel.setSelectedIndex(0);
						tabpanel.props(0,{
							visible : true
						});
						topic.publish('spa.change.add', {
							target : obj
						});
						break;
				}
			};

			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				setTimeout(function(){
					if(typeof LUI('____calendar____imeeting')!='undefined'){
					LUI('____calendar____imeeting').refreshSchedules();
					}
				}, 100);
			});


			// 新建会议
			$function.addDoc = function() {
					dialog.categoryForNewFile(
							'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
							'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{id}',false,null,null,'${JsParam.categoryId}');
		 	};

			// 数据初始化
		 	$function.transformData=function(datas){
				var main=datas.main;
				for(var key in main){
					for(var i=0;i<main[key].list.length;i++){
						var item=main[key].list[i];
						if(checkStatus(item)==-1){
							item.color=$('.meeting_calendar_label_unhold').css('background-color');
						}
						if(checkStatus(item)==0){
							item.color=$('.meeting_calendar_label_holding').css('background-color');
						}
						if(checkStatus(item)==1){
							item.color=$('.meeting_calendar_label_hold').css('background-color');
						}
					}
				}
				return datas;
			};

			// 当前会议状态
			var checkStatus=function(item){
				var startDate=dateUtil.parseDate(item.start),endDate=dateUtil.parseDate(item.end);
				var now=new Date(parseFloat('${now}'));
				// 未召开
				if(now.getTime()<startDate.getTime()){
					return -1;
				}
				// 进行中
				if(now.getTime()>=startDate.getTime() && now.getTime()<=endDate.getTime()){
					return 0;
				}
				// 已召开
				if(now.getTime()>endDate.getTime()){
					return 1;
				}
			};

			// 定位
			var getPos=function(evt,obj){
				var sWidth=obj.width();var sHeight=obj.height();
				x=evt.pageX;
				y=evt.pageY;
				if(y+sHeight>$(window).height()){
					y-=sHeight;
				}
				if(x+sWidth>$(document.body).outerWidth(true)){
					x-=sWidth;
				}
				return {"top":y,"left":x};
			};

			// 新建
			topic.subscribe('calendar.select',function(arg){
				$('.meeting_calendar_dialog').hide();
				var addDialog=$('#meeting_calendar_add');
				// 时间格式2014-7-11~2014-7-12
				var date=dateUtil.formatDate(dateUtil.parseDate(arg.start),'${dateFormatter}');
				if(arg.start!=arg.end){
					date+="~"+arg.end;
				}
				var start = dateUtil.formatDate( dateUtil.parseDate(arg.start,'YYYY-MM-hh'),'${dateFormatter}'),
					end = dateUtil.formatDate( dateUtil.parseDate(arg.end,'YYYY-MM-hh'),'${dateFormatter}');
				addDialog.find('.date').html(date);// 时间字符串
				addDialog.find('.fdHoldDate').html(start);// 召开时间
				addDialog.find('.fdFinishDate').html(end);// 结束时间
				addDialog.find('.resId').html(arg.resId);// 地点ID
				addDialog.find('.resName').html(env.fn.formatText(arg.resName) );// 地点
				addDialog.css(getPos(arg.evt,addDialog)).fadeIn("fast");
				var nowdate = dateUtil.formatDate(new Date(),'${dateFormatter}');
				var startDate = dateUtil.formatDate(dateUtil.parseDate(arg.start),'${dateFormatter}');
				if(nowdate>startDate){
					$('#book_add_btn').hide();
					$('#meeting_add_btn').hide();
				}else{
					$('#book_add_btn').show();
					$('#meeting_add_btn').show();
				}
			});

			// 查看
			topic.subscribe('calendar.thing.click',function(arg){
				$('.meeting_calendar_dialog').hide();
				var viewDialog;// 弹出框
				if(arg.data.type =="book"){
					viewDialog=$("#meeting_calendar_bookview");// 会议室预约弹出框
					viewDialog.find(".fdRemark").html(env.fn.formatText( textEllipsis(arg.data.fdRemark) ));// 备注
				}else{
					viewDialog=$("#meeting_calendar_mainview");// 会议安排弹出框
					viewDialog.find(".fdHost").html(arg.data.fdHost);// 主持人
				}
				// 时间格式2014-7-11~2014-7-12
				var date=dateUtil.formatDate(arg.data.start,"${dateTimeFormatter}");
				if(arg.data.start!=arg.data.end){
					date+=" ~ "+dateUtil.formatDate(arg.data.end,"${dateTimeFormatter}");
				}
				viewDialog.find(".fdId").html(arg.data.fdId);// fdId
				viewDialog.find(".fdName").html( env.fn.formatText(arg.data.title) );// 会议题目
				viewDialog.find(".fdPlace").html( env.fn.formatText(arg.data.fdPlaceName) );// 地点
				viewDialog.find(".fdHoldDate").html(date);// 召开时间

				var creator=arg.data.creator;
				if(arg.data.dept){
					creator+="("+arg.data.dept+")";// （部门）
				}
				viewDialog.find(".docCreator").html(creator);// 人员（部门）

				if(arg.data.type=="book"){// 会议预约按钮权限检测
					$('#book_delete_btn,#book_edit_btn').hide();
					$.ajax({
						url: $var.$contextPath +"/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=checkAuth",
						type: 'POST',
						dataType: 'json',
						data: {fdId: arg.data.fdId},
						success: function(data, textStatus, xhr) {// 操作成功
							if(data.canEdit){
								$('#book_edit_btn').show();
							}
							if(data.canDelete){
								$('#book_delete_btn').show();
							}
						}
					});
				}else{// 会议安排查看按钮权限检测
					$('#meeting_view_btn').hide();
					$.ajax({
						url: $var.$contextPath +"/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=checkViewAuth",
						type: 'POST',
						dataType: 'json',
						data: {fdId: arg.data.fdId},
						success: function(data, textStatus, xhr) {// 操作成功
							if(data.canView){
								$('#meeting_view_btn').show();
							}
						}
					});
				}
				var today = new Date();
				if($('#book_change_btn').length > 0 ){
					if(today.getTime() > arg.data.start.getTime() || '${userId}' != arg.data.creatorId){
						$('#book_change_btn').hide();
					}else{
						$('#book_change_btn').show();
					}
				}
				viewDialog.find(".type").html(arg.data.type);
				viewDialog.css(getPos(arg.evt,viewDialog)).fadeIn("fast");
			});

			// 字符串截取
			function textEllipsis(text){
				text = text || '';
				if(text && text.length>200){
					text=text.substring(0,200)+"......";
				}
				return text;
			}

			// 新建文档
			function createTopic(mainModelName, modelName, type, path){
				var url = $var.$contextPath + '/km/imeeting/km_imeeting_' + type + '/createDoc_' + type + '.jsp';
				url = Com_SetUrlParameter(url, 'mainModelName', mainModelName);
				url = Com_SetUrlParameter(url, 'modelName', modelName);
				url = Com_SetUrlParameter(url, 'isSimpleCategory', 'true');
				url = Com_SetUrlParameter(url,'j_path', path);
				LUI.pageOpen(url, '_rIframe');
			}

			// 新建文档
			function createDoc(mainModelName, modelName, type, path){
				var url = $var.$contextPath + '/km/imeeting/km_imeeting_' + type + '/createDoc_' + type + '.jsp';
				url = Com_SetUrlParameter(url, 'mainModelName', mainModelName);
				url = Com_SetUrlParameter(url, 'modelName', modelName);
				url = Com_SetUrlParameter(url, 'isSimpleCategory', 'false');
				url = Com_SetUrlParameter(url,'j_path', path);
				LUI.pageOpen(url, '_rIframe');
			}

			function buildCriParam(isAdmin, docType, jPath, isSummary, isMain) {
				var criInfo;
				if ("true" == isAdmin) {
					criInfo = {
						'cri.q' : 'docStatus:30',
						'j_path' : jPath
					}
				} else {
					criInfo = {
						'docType' : docType,
						'j_path' : jPath
					}
				}
				if (isSummary) {
					criInfo.fdModelName = 'com.landray.kmss.km.imeeting.model.KmImeetingMain';
				}
				return criInfo;
			}
	});
});