seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/contentUtil','lui/framework/module','lang!km-imissive'],
		function($, strutil, dialog, topic,contentUtil, Module,lang){
	
	// 分页改变后刷新数字
	topic.subscribe('spa.paging.changed', function(evt) {
		if(evt && evt.key){
			var contentId = evt.key;
			contentUtil.setContentCount(contentId,evt.totalSize);
		}
	});
	
	// 分页改变后刷新数字
	topic.channel('listview_cir').subscribe('spa.paging.changed', function(evt) {
		if(evt && evt.key){
			var contentId = evt.key;
			contentUtil.setContentCount(contentId,evt.totalSize);
		}
	});
	
	
	var module = Module.find('kmImissive');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : $var.modeStart,
			routes : [{
				path : '/exchange', //公文交换
				children : [{
					path : '/mydistribute', //我分发的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeContent : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: '/exchange/mydistribute' }, cri :{'j_path':'/exchange/mydistribute'} , selected : true },
								kmImissiveMyReportContent : { title : lang['kmImissive.tree.reportRecord'],route:{ path: '/exchange/myreport' } , cri:{'j_path':'/exchange/myreport'} },
								kmImissiveMySignContent : { title : lang['kmImissive.tree.mysign'],route:{ path: '/exchange/mysign' }, cri:{'j_path':'/exchange/mysign'} },
								kmImissiveMyReceiveContent : { title : lang['kmImissive.tree.myreceivein'],route:{ path: '/exchange/myreceive' }, cri:{'j_path':'/exchange/myreceive'} },
								kmImissiveMyReceiveOuterContent : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: '/exchange/myreceiveout' }, cri:{'j_path':'/exchange/myreceiveout'}}
							}
						}
					}
				},{
					path : '/myreport',//我上报的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeContent : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: '/exchange/mydistribute' }, cri :{'j_path':'/exchange/mydistribute'}  },
								kmImissiveMyReportContent : { title : lang['kmImissive.tree.reportRecord'],route:{ path: '/exchange/myreport' } , cri:{'j_path':'/exchange/myreport'} , selected : true},
								kmImissiveMySignContent : { title : lang['kmImissive.tree.mysign'],route:{ path: '/exchange/mysign' }, cri:{'j_path':'/exchange/mysign'} },
								kmImissiveMyReceiveContent : { title : lang['kmImissive.tree.myreceivein'],route:{ path: '/exchange/myreceive' }, cri:{'j_path':'/exchange/myreceive'} },
								kmImissiveMyReceiveOuterContent : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: '/exchange/myreceiveout' }, cri:{'j_path':'/exchange/myreceiveout'}}
							}
						}
					}
				},{
					path : '/mysign',//我会签的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeContent : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: '/exchange/mydistribute' }, cri :{'j_path':'/exchange/mydistribute'}  },
								kmImissiveMyReportContent : { title : lang['kmImissive.tree.reportRecord'],route:{ path: '/exchange/myreport' } , cri:{'j_path':'/exchange/myreport'} },
								kmImissiveMySignContent : { title : lang['kmImissive.tree.mysign'],route:{ path: '/exchange/mysign' }, cri:{'j_path':'/exchange/mysign'} , selected : true},
								kmImissiveMyReceiveContent : { title : lang['kmImissive.tree.myreceivein'],route:{ path: '/exchange/myreceive' }, cri:{'j_path':'/exchange/myreceive'} },
								kmImissiveMyReceiveOuterContent : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: '/exchange/myreceiveout' }, cri:{'j_path':'/exchange/myreceiveout'}}
							}
						}
					}
				},{
					path : '/myreceive',//我接收的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeContent : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: '/exchange/mydistribute' }, cri :{'j_path':'/exchange/mydistribute'}  },
								kmImissiveMyReportContent : { title : lang['kmImissive.tree.reportRecord'],route:{ path: '/exchange/myreport' } , cri:{'j_path':'/exchange/myreport'} },
								kmImissiveMySignContent : { title : lang['kmImissive.tree.mysign'],route:{ path: '/exchange/mysign' }, cri:{'j_path':'/exchange/mysign'} },
								kmImissiveMyReceiveContent : { title : lang['kmImissive.tree.myreceivein'],route:{ path: '/exchange/myreceive' }, cri:{'j_path':'/exchange/myreceive'}, selected : true },
								kmImissiveMyReceiveOuterContent : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: '/exchange/myreceiveout' }, cri:{'j_path':'/exchange/myreceiveout'}}
							}
						}
					}
				},{
					path : '/myreceiveout',//我接收的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeContent : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: '/exchange/mydistribute' }, cri :{'j_path':'/exchange/mydistribute'}  },
								kmImissiveMyReportContent : { title : lang['kmImissive.tree.reportRecord'],route:{ path: '/exchange/myreport' } , cri:{'j_path':'/exchange/myreport'} },
								kmImissiveMySignContent : { title : lang['kmImissive.tree.mysign'],route:{ path: '/exchange/mysign' }, cri:{'j_path':'/exchange/mysign'} },
								kmImissiveMyReceiveContent : { title : lang['kmImissive.tree.myreceivein'],route:{ path: '/exchange/myreceive' }, cri:{'j_path':'/exchange/myreceive'}},
								kmImissiveMyReceiveOuterContent : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: '/exchange/myreceiveout' }, cri:{'j_path':'/exchange/myreceiveout'}, selected : true }
							}
						}
					}
				}]
			},{
				path : 'simpleGw/exchangeSend', //公文交换(普通模式)
				children : [{
					path : '/mydistribute', //我分发的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeModel : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: 'simpleGw/exchangeSend/mydistribute' }, cri :{'j_path':'simpleGw/exchangeSend/mydistribute'} , selected : true },
								kmImissiveMyReportModel : { title : lang['kmImissive.tree.reportRecord'],route:{ path: 'simpleGw/exchangeSend/myreport' } , cri:{'j_path':'simpleGw/exchangeSend/myreport'} }
							}
						}
					}
				},{
					path : '/myreport',//我上报的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyDistributeModel : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: 'simpleGw/exchangeSend/mydistribute' }, cri :{'j_path':'simpleGw/exchangeSend/mydistribute'}},
								kmImissiveMyReportModel : { title : lang['kmImissive.tree.reportRecord'],route:{ path: 'simpleGw/exchangeSend/myreport' } , cri:{'j_path':'simpleGw/exchangeSend/myreport'} ,selected : true },
							}
						}
					}
				}]
			},{
				path : '/listCreate', //我拟稿的(填此路径默认会加载`我拟稿的-我拟稿的发文`)
				children : [{
					path : '/send', //我拟稿的发文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listCreate/send' }, cri :{'mydoc':'create','j_path':'/listCreate/send'} , selected : true },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listCreate/receive' } , cri:{'mydoc':'create','j_path':'/listCreate/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listCreate/sign' }, cri:{'mydoc':'create','j_path':'/listCreate/sign'} }
							}
						}
					}
				},{
					path : '/receive', //我拟稿的收文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listCreate/send' }, cri :{'mydoc':'create','j_path':'/listCreate/send'}  },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listCreate/receive' } , cri:{'mydoc':'create','j_path':'/listCreate/receive'}, selected : true },
								kmImissiveSignContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listCreate/sign' }, cri:{'mydoc':'create','j_path':'/listCreate/sign'} }
							}
						}
					}
				},{
					path : '/sign', //我拟稿的签报
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listCreate/send' }, cri :{'mydoc':'create','j_path':'/listCreate/send'}  },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listCreate/receive' } , cri:{'mydoc':'create','j_path':'/listCreate/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listCreate/sign' }, cri:{'mydoc':'create','j_path':'/listCreate/sign'}, selected : true }
							}
						}
					}
				}]
			},{
				path : 'simpleGw/exchangeReceive', //公文交换（收文）
				children : [{
					path : '/myreceive',//我接收的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyReceiveReceive : { title : lang['kmImissive.tree.myreceivein'],route:{ path: 'simpleGw/exchangeReceive/myreceive' }, cri:{'j_path':'simpleGw/exchangeReceive/myreceive'}, selected : true },
								kmImissiveMyReceiveOuterReceive : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: 'simpleGw/exchangeReceive/myreceiveout' }, cri:{'j_path':'simpleGw/exchangeReceive/myreceiveout'}}
							}
						}
					}
				},{
					path : '/myreceiveout',//我接收的
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveMyReceiveReceive : { title : lang['kmImissive.tree.myreceivein'],route:{ path: 'simpleGw/exchangeReceive/myreceive' }, cri:{'j_path':'simpleGw/exchangeReceive/myreceive'}},
								kmImissiveMyReceiveOuterReceive : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: 'simpleGw/exchangeReceive/myreceiveout' }, cri:{'j_path':'simpleGw/exchangeReceive/myreceiveout'}, selected : true }
							}
						}
					}
				}]
			},{
				path : '/mydistribute', //我分发的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveMyDistributeContent : { title : lang['kmImissive.tree.distributeRecord'], route:{ path: '/mydistribute' }, cri :{'j_path':'/mydistribute'} , selected : true }
						}
					}
				}
			},{
				path : '/myreport', //我上报的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveMyReportContent : { title : lang['kmImissive.tree.reportRecord'],route:{ path: '/myreport' } , cri:{'j_path':'/myreport'}, selected : true }
						}
					}
				}
			},{
				path : '/mysign', //我会签的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveMySignContent : { title : lang['kmImissive.tree.mysign'],route:{ path: '/mysign' } , cri:{'j_path':'/mysign'}, selected : true }
						}
					}
				}
			},{
				path : '/myreceive', //我接收的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveMyReceiveContent : { title : lang['kmImissive.tree.myreceive'],route:{ path: '/myreceive' } , cri:{'j_path':'/myreceive'}, selected : true }
						}
					}
				}
			},{
				path : '/myreceiveout', //我接收的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveMyReceiveOuterContent : { title : lang['kmImissive.tree.myreceiveout'],route:{ path: '/myreceiveout' } , cri:{'j_path':'/myreceiveout'}, selected : true }
						}
					}
				}
			},{
				path : '/listAll', //公文库(填此路径默认会加载`公文库-发文`)
				children : [{
					path : '/send', //公文库-发文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listAll/send' }, cri :{'j_path':'/listAll/send'} , selected : true },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listAll/receive' } , cri:{'j_path':'/listAll/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listAll/sign' }, cri:{'j_path':'/listAll/sign'} }
							}
						}
					}
				},{
					path : '/receive',//公文库-收文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listAll/send' }, cri :{'j_path':'/listAll/send'} },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listAll/receive' } , cri:{'j_path':'/listAll/receive'} , selected : true },
								kmImissiveSignContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listAll/sign' }, cri:{'j_path':'/listAll/sign'} }
							}
						}
					}
				},{
					path : '/sign',//公文库-签报
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listAll/send' }, cri :{'j_path':'/listAll/send'} },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listAll/receive' } , cri:{'j_path':'/listAll/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listAll/sign' }, cri:{'j_path':'/listAll/sign'} , selected : true }
							}
						}
					}
				}]
			},{
				path : 'simpleGw/list', //公文库(填此路径默认会加载`公文库-发文`)
				children : [{
					path : '/send', //公文库-发文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendMessage : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/list/send' }, cri :{'j_path':'simpleGw/list/send'} , selected : true }
							}
						}
					}
				},{
					path : '/receive',//公文库-收文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveReceiveMessage : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/list/receive' } , cri:{'j_path':'simpleGw/list/receive'} , selected : true }
							}
						}
					}
				},{
					path : '/sign',//公文库-签报
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSignMessage : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/list/sign' }, cri:{'j_path':'simpleGw/list/sign'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : 'simpleGw/listAllPublish',
				children : [{
					path : '/send', 
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendPGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/listAllPublish/send' }, cri :{'flag':'finished','j_path':'simpleGw/listAllPublish/send'} , selected : true },
								kmImissiveReceivePGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/listAllPublish/receive' } , cri:{'flag':'finished','j_path':'simpleGw/listAllPublish/receive'} },
								kmImissiveSignPGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/listAllPublish/sign' }, cri:{'flag':'finished','j_path':'simpleGw/listAllPublish/sign'} }
							}
						}
					}
				},{
					path : '/receive',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendPGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/listAllPublish/send' }, cri :{'flag':'finished','j_path':'simpleGw/listAllPublish/send'}  },
								kmImissiveReceivePGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/listAllPublish/receive' } , cri:{'flag':'finished','j_path':'simpleGw/listAllPublish/receive'}, selected : true },
								kmImissiveSignPGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/listAllPublish/sign' }, cri:{'flag':'finished','j_path':'simpleGw/listAllPublish/sign'} }
							}
						}
					}
				},{
					path : '/sign',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendPGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/listAllPublish/send' }, cri :{'flag':'finished','j_path':'simpleGw/listAllPublish/send'}  },
								kmImissiveReceivePGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/listAllPublish/receive' } , cri:{'flag':'finished','j_path':'simpleGw/listAllPublish/receive'}},
								kmImissiveSignPGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/listAllPublish/sign' }, cri:{'flag':'finished','j_path':'simpleGw/listAllPublish/sign'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : '/listOffLine', //线下公文
				children : [{
					path : '/send', 
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendOContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listOffLine/send' }, cri :{'fdIsOffLine':'1','j_path':'/listOffLine/send'} , selected : true },
								kmImissiveReceiveOContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listOffLine/receive' } , cri:{'fdIsOffLine':'1','j_path':'/listOffLine/receive'} },
								kmImissiveSignOContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listOffLine/sign' }, cri:{'fdIsOffLine':'1','j_path':'/listOffLine/sign'} }
							}
						}
					}
				},{
					path : '/receive', 
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendOContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listOffLine/send' }, cri :{'fdIsOffLine':'1','j_path':'/listOffLine/send'}  },
								kmImissiveReceiveOContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listOffLine/receive' } , cri:{'fdIsOffLine':'1','j_path':'/listOffLine/receive'}, selected : true },
								kmImissiveSignOContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listOffLine/sign' }, cri:{'fdIsOffLine':'1','j_path':'/listOffLine/sign'} }
							}
						}
					}
				},{
					path : '/sign',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendOContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listOffLine/send' }, cri :{'fdIsOffLine':'1','j_path':'/listOffLine/send'}  },
								kmImissiveReceiveOContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listOffLine/receive' } , cri:{'fdIsOffLine':'1','j_path':'/listOffLine/receive'}},
								kmImissiveSignOContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listOffLine/sign' }, cri:{'fdIsOffLine':'1','j_path':'/listOffLine/sign'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : 'simpleGw/listOffLine', //线下公文（普通模式）
				children : [{
					path : '/send',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendSGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/listOffLine/send' }, cri :{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/send'} , selected : true },
								kmImissiveReceiveSGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/listOffLine/receive' } , cri:{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/receive'} },
								kmImissiveSignSGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/listOffLine/sign' }, cri:{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/sign'} }
							}
						}
					}
				},{
					path : '/receive',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendSGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/listOffLine/send' }, cri :{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/send'}  },
								kmImissiveReceiveSGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/listOffLine/receive' } , cri:{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/receive'}, selected : true },
								kmImissiveSignSGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/listOffLine/sign' }, cri:{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/sign'} }
							}
						}
					}
				},{
					path : '/sign',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendSGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/listOffLine/send' }, cri :{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/send'}  },
								kmImissiveReceiveSGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/listOffLine/receive' } , cri:{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/receive'}},
								kmImissiveSignSGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/listOffLine/sign' }, cri:{'fdIsOffLine':'1','j_path':'simpleGw/listOffLine/sign'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : '/listAllPublish',
				children : [{
					path : '/send', 
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendPContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listAllPublish/send' }, cri :{'flag':'finished','j_path':'/listAllPublish/send'} , selected : true },
								kmImissiveReceivePContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listAllPublish/receive' } , cri:{'flag':'finished','j_path':'/listAllPublish/receive'} },
								kmImissiveSignPContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listAllPublish/sign' }, cri:{'flag':'finished','j_path':'/listAllPublish/sign'} }
							}
						}
					}
				},{
					path : '/receive', 
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendPContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listAllPublish/send' }, cri :{'flag':'finished','j_path':'/listAllPublish/send'}  },
								kmImissiveReceivePContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listAllPublish/receive' } , cri:{'flag':'finished','j_path':'/listAllPublish/receive'}, selected : true },
								kmImissiveSignPContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listAllPublish/sign' }, cri:{'flag':'finished','j_path':'/listAllPublish/sign'} }
							}
						}
					}
				},{
					path : '/sign',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendPContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/listAllPublish/send' }, cri :{'flag':'finished','j_path':'/listAllPublish/send'}  },
								kmImissiveReceivePContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/listAllPublish/receive' } , cri:{'flag':'finished','j_path':'/listAllPublish/receive'}},
								kmImissiveSignPContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/listAllPublish/sign' }, cri:{'flag':'finished','j_path':'/listAllPublish/sign'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : '/listApproval', //待我审的(填此路径默认会加载`待我审的-待我审的发文`)
				children : [{
					path : '/send',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.myapproval.MySend'], route:{ path: '/listApproval/send' }, cri :{'mydoc':'approval','j_path':'/listApproval/send'}, selected : true  },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.myapproval.MyReceive'],route:{ path: '/listApproval/receive' } , cri:{'mydoc':'approval','j_path':'/listApproval/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.myapproval.MySign'],route:{ path: '/listApproval/sign' }, cri:{'mydoc':'approval','j_path':'/listApproval/sign'} }
							}
						}
					}
				},{
					path : '/receive',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.myapproval.MySend'], route:{ path: '/listApproval/send' }, cri :{'mydoc':'approval','j_path':'/listApproval/send'}  },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.myapproval.MyReceive'],route:{ path: '/listApproval/receive' } , cri:{'mydoc':'approval','j_path':'/listApproval/receive'}, selected : true },
								kmImissiveSignContent : { title : lang['kmImissive.tree.myapproval.MySign'],route:{ path: '/listApproval/sign' }, cri:{'mydoc':'approval','j_path':'/listApproval/sign'} }
							}
						}
					}
				},{
					path : '/sign',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.myapproval.MySend'], route:{ path: '/listApproval/send' }, cri :{'mydoc':'approval','j_path':'/listApproval/send'} },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.myapproval.MyReceive'],route:{ path: '/listApproval/receive' } , cri:{'mydoc':'approval','j_path':'/listApproval/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.myapproval.MySign'],route:{ path: '/listApproval/sign' }, cri:{'mydoc':'approval','j_path':'/listApproval/sign'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : '/myApproval',
				children : [{
					path : '/todo',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								myApprovalTodoContent : { title : '办件', route:{ path: '/myApproval/todo' }, cri :{'j_path':'/myApproval/todo'}, selected : true  },
								myApprovalToReadContent : { title : '阅件',route:{ path: '/myApproval/toread' } , cri:{'j_path':'/myApproval/toread'} }
							}
						}
					}
				},{
					path : '/toread',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								myApprovalTodoContent : { title : '办件', route:{ path: '/myApproval/todo' }, cri :{'j_path':'/myApproval/todo'} },
								myApprovalToReadContent : { title : '阅件',route:{ path: '/myApproval/toread' } , cri:{'j_path':'/myApproval/toread'}, selected : true }
							}
						}
					}
				}]
			},
			
			{
				path : '/myApproved',
				children : [{
					path : '/done',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								myApprovedDoneContent : { title : '办件', route:{ path: '/myApproved/done' }, cri :{'j_path':'/myApproved/done'}, selected : true  },
								myApprovedReadedContent : { title : '阅件',route:{ path: '/myApproved/readed' } , cri:{'j_path':'/myApproved/readed'} }
							}
						}
					}
				},{
					path : '/readed',
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								myApprovedDoneContent : { title : '办件', route:{ path: '/myApproved/done' }, cri :{'j_path':'/myApproved/done'} },
								myApprovedReadedContent : { title : '阅件',route:{ path: '/myApproved/readed' } , cri:{'j_path':'/myApproved/readed'} , selected : true }
							}
						}
					}
				}]
			},
			{
				path : '/listCreateDoc', // 公文登记簿
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/imissive/import/createDoc.jsp',
						target : '_rIframe'
					}
				}
			},{
					path : '/sys/subordinate', // 下属公文
					action : {
						type : 'pageopen',
						options : {
							url : $var.$contextPath + '/sys/subordinate/moduleindex.jsp?moduleMessageKey=km-imissive:module.km.imissive',
							target : '_rIframe'
						}
					}
				},
			{
				path : 'simpleGw/listApproved', //已办流程 （普通模式）
				children : [{
					path : '/send', //我已审的发文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.myapproved.MySend'], route:{ path: 'simpleGw/listApproved/send' }, cri :{'mydoc':'approved','j_path':'simpleGw/listApproved/send'} , selected : true},
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.myapproved.MyReceive'],route:{ path: 'simpleGw/listApproved/receive' } , cri:{'mydoc':'approved','j_path':'simpleGw/listApproved/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.myapproved.MySign'],route:{ path: 'simpleGw/listApproved/sign' }, cri:{'mydoc':'approved','j_path':'simpleGw/listApproved/sign'}  }
							}
						}
					}
				},{
					path : '/receive', //我已审的收文
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.myapproved.MySend'], route:{ path: 'simpleGw/listApproved/send' }, cri :{'mydoc':'approved','j_path':'simpleGw/listApproved/send'} },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.myapproved.MyReceive'],route:{ path: 'simpleGw/listApproved/receive' } , cri:{'mydoc':'approved','j_path':'simpleGw/listApproved/receive'} , selected : true},
								kmImissiveSignContent : { title : lang['kmImissive.tree.myapproved.MySign'],route:{ path: 'simpleGw/listApproved/sign' }, cri:{'mydoc':'approved','j_path':'simpleGw/listApproved/sign'}  }
							}
						}
					}
				},{
					path : '/sign', //我已审的签报
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendContent : { title : lang['kmImissive.tree.myapproved.MySend'], route:{ path: 'simpleGw/listApproved/send' }, cri :{'mydoc':'approved','j_path':'simpleGw/listApproved/send'} },
								kmImissiveReceiveContent : { title : lang['kmImissive.tree.myapproved.MyReceive'],route:{ path: 'simpleGw/listApproved/receive' } , cri:{'mydoc':'approved','j_path':'simpleGw/listApproved/receive'} },
								kmImissiveSignContent : { title : lang['kmImissive.tree.myapproved.MySign'],route:{ path: 'simpleGw/listApproved/sign' }, cri:{'mydoc':'approved','j_path':'simpleGw/listApproved/sign'}, selected : true  }
							}
						}
					}
				}]
			},{
				path : '/myWorkbench', // 公文工作台
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/imissive/kmImissive_workBench.jsp?rwd=true&bodyClass=lui_list_content_body',
						target : '_rIframe'
					}
				}
			},{
				path : '/listAllSend', //发文库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSendContent : { title : lang['kmImissive.tree.allSend'], route:{ path: '/listAllSend' },cri :{'cri.q':'docStatus:30','j_path':'/listAllSend'}, selected : true }
						}
					}
				}
			},
			{
				path : '/stat_docStatus20', //发文库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSendContent : { title : lang['kmImissive.tree.allSend'], route:{ path: '/listAllSend' },cri :{'cri.q':'docStatus:20','j_path':'/listAllSend'}, selected : true }
						}
					}
				}
			},
			{
				path : '/stat_docStatus30', //发文库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSendContent : { title : lang['kmImissive.tree.allSend'], route:{ path: '/listAllSend' },cri :{'cri.q':'docStatus:30','j_path':'/listAllSend'}, selected : true }
						}
					}
				}
			},
			{
				path : '/stat_docStatus41', //发文
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSendContent : { title : lang['kmImissive.tree.fillingBox.Send'], route:{ path: '/filing/send' }, cri :{'fdIsFiling':'1','j_path':'/filing/send'} , selected : true},
						}
					}
				}
			},
			{
				path : '/stat_docStatus00', //发文库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSendContent : { title : lang['kmImissive.tree.discardBox.Send'], route:{ path: '/discard/send' }, cri :{ 'docStatus':'00','j_path':'/discard/send' } , selected : true},
						}
					}
				}
			},
			{
				path : '/listAllReceive', //收文库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveReceiveContent : { title : lang['kmImissive.tree.allReceive'], route:{ path: '/listAllReceive' },cri :{'cri.q':'docStatus:30','j_path':'/listAllReceive'}, selected : true }
						}
					}
				}
			},{
				path : '/listAllSign', //签报库
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSignContent : { title : lang['kmImissive.tree.allSign'], route:{ path: '/listAllSign' },cri :{'cri.q':'docStatus:30','j_path':'/listAllSign'}, selected : true }
						}
					}
				}
			},{
				path : 'simpleGw/createSend', //发文拟稿
				action : function(){
					var mainModelName = 'com.landray.kmss.km.imissive.model.KmImissiveSendMain',
						modelName = 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate';
					createDoc(mainModelName,modelName,'send','simpleGw/createSend');
				}
			},{
				path : 'simpleGw/listApprovalSend', //待办发文 （普通模式）
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSendGwContent : { title : lang['setting.navigationModel.dealtSend'], route:{ path: 'simpleGw/listApprovalSend' } , cri :{'mydoc':'approvalSend','j_path':'simpleGw/listApprovalSend' }, selected : true }
						}
					}
				}
			},{
				path : '/searchSend', //发文查询
				action : function(){
					var modelName = 'com.landray.kmss.km.imissive.model.KmImissiveSendMain';
					openSearch(modelName,'send');
				}
			},{
				path : 'simpleGw/createReceive', //收文拟稿
				action : function(){
					var mainModelName = 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain',
						modelName = 'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate';
					createDoc(mainModelName,modelName,'receive','simpleGw/createReceive');
				}
			},{
				path : 'simpleGw/listApprovalReceive', //待办收文
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveReceiveGwContent : { title : lang['setting.navigationModel.dealtReceive'], route:{ path: 'simpleGw/listApprovalReceive' }, cri :{'mydoc':'approvalReceive','j_path':'simpleGw/listApprovalReceive' }, selected : true }
						}
					}
				}
			},{
				path : '/searchReceive', //收文查询
				action : function(){
					var modelName = 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain';
					openSearch(modelName,'receive');
				}
			},{
				path : 'simpleGw/createSign', //签报拟稿
				action : function(){
					var mainModelName = 'com.landray.kmss.km.imissive.model.KmImissiveSignMain',
						modelName = 'com.landray.kmss.km.imissive.model.KmImissiveSignTemplate';
					createDoc(mainModelName,modelName,'sign','simpleGw/createSign');
				}
			},{
				path : 'simpleGw/listApprovalSign', //待办签报
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveSignGwContent : { title : lang['setting.navigationModel.dealtSign'], route:{ path: 'simpleGw/listApprovalSign' }, cri :{'mydoc':'approvalSign','j_path':'simpleGw/listApprovalSign' }, selected : true }
						}
					}
				}
			},{
				path : '/searchSign', //签报查询
				action : function(){
					var modelName = 'com.landray.kmss.km.imissive.model.KmImissiveSignMain';
					openSearch(modelName,'sign');
				}
			},{
				path : '/filing', //归档箱
				children : [{
					path : '/send', //发文归档箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendFContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/filing/send' }, cri :{'j_path':'/filing/send'} , selected : true},
								kmImissiveReceiveFContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/filing/receive' } , cri :{'j_path':'/filing/receive'} },
								kmImissiveSignFContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/filing/sign' }, cri:{'j_path':'/filing/sign'}  }
							}
						}
					}
				},{
					path : '/receive', //收文归档箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendFContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/filing/send' }, cri :{'j_path':'/filing/send'} },
								kmImissiveReceiveFContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/filing/receive' } , cri :{'j_path':'/filing/receive'}, selected : true },
								kmImissiveSignFContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/filing/sign' }, cri:{'j_path':'/filing/sign'}  }
							}
						}
					}
				},{
					path : '/sign', //签报归档箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendFContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/filing/send' }, cri :{'j_path':'/filing/send'}},
								kmImissiveReceiveFContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/filing/receive' } , cri :{'j_path':'/filing/receive'}},
								kmImissiveSignFContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/filing/sign' }, cri:{'j_path':'/filing/sign'}, selected : true  }
							}
						}
					}
				}]
			},
			{
				path : 'simpleGw/filing', //归档箱 （普通模式）
				children : [{
					path : '/send', //发文归档箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendFGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/filing/send' }, cri :{'j_path':'simpleGw/filing/send'} , selected : true},
								kmImissiveReceiveFGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/filing/receive' } , cri :{'j_path':'simpleGw/filing/receive'} },
								kmImissiveSignFGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/filing/sign' }, cri:{'j_path':'simpleGw/filing/sign'}  }
							}
						}
					}
				},{
					path : '/receive', //收文归档箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendFGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/filing/send' }, cri :{'j_path':'simpleGw/filing/send'} },
								kmImissiveReceiveFGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/filing/receive' } , cri :{'j_path':'simpleGw/filing/receive'}, selected : true },
								kmImissiveSignFGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/filing/sign' }, cri:{'j_path':'simpleGw/filing/sign'}  }
							}
						}
					}
				},{
					path : '/sign', //签报归档箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendFGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/filing/send' }, cri :{'j_path':'simpleGw/filing/send'}},
								kmImissiveReceiveFGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/filing/receive' } , cri :{'j_path':'simpleGw/filing/receive'}},
								kmImissiveSignFGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/filing/sign' }, cri:{'j_path':'simpleGw/filing/sign'}, selected : true  }
							}
						}
					}
				}]
			},{
				path : '/discard', //废弃
				children : [{
					path : '/send', //发文废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendDContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/discard/send' }, cri :{ 'docStatus':'00','j_path':'/discard/send' } , selected : true},
								kmImissiveReceiveDContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/discard/receive' } , cri :{ 'docStatus':'00','j_path':'/discard/receive' } },
								kmImissiveSignDContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/discard/sign' }, cri:{ 'docStatus':'00','j_path':'/discard/sign' }  }
							}
						}
					}
				},{
					path : '/receive', //收文废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendDContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/discard/send' }, cri :{ 'docStatus':'00','j_path':'/discard/send' } },
								kmImissiveReceiveDContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/discard/receive' } , cri :{ 'docStatus':'00','j_path':'/discard/receive' } , selected : true},
								kmImissiveSignDContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/discard/sign' }, cri:{ 'docStatus':'00','j_path':'/discard/sign' }  }
							}
						}
					}
				},{
					path : '/sign', //签报废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendDContent : { title : lang['kmImissive.tree.Send'], route:{ path: '/discard/send' }, cri :{ 'docStatus':'00','j_path':'/discard/send' } },
								kmImissiveReceiveDContent : { title : lang['kmImissive.tree.Receive'],route:{ path: '/discard/receive' } , cri :{ 'docStatus':'00','j_path':'/discard/receive' } },
								kmImissiveSignDContent : { title : lang['kmImissive.tree.Sign'],route:{ path: '/discard/sign' }, cri:{ 'docStatus':'00','j_path':'/discard/sign' }, selected : true  }
							}
						}
					}
				}]
			},
			{
				path : 'simpleGw/discard', //废弃 (普通模式)
				children : [{
					path : '/send', //发文废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendDGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/discard/send' }, cri :{ 'docStatus':'00','j_path':'simpleGw/discard/send' } , selected : true},
								kmImissiveReceiveDGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/discard/receive' } , cri :{ 'docStatus':'00','j_path':'simpleGw/discard/receive' } },
								kmImissiveSignDGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/discard/sign' }, cri:{ 'docStatus':'00','j_path':'simpleGw/discard/sign' }  }
							}
						}
					}
				},{
					path : '/receive', //收文废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendDGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/discard/send' }, cri :{ 'docStatus':'00','j_path':'simpleGw/discard/send' } },
								kmImissiveReceiveDGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/discard/receive' } , cri :{ 'docStatus':'00','j_path':'simpleGw/discard/receive' } , selected : true},
								kmImissiveSignDGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/discard/sign' }, cri:{ 'docStatus':'00','j_path':'simpleGw/discard/sign' }  }
							}
						}
					}
				},{
					path : '/sign', //签报废弃箱
					action : {
						type : 'tabpanel',
						options : {
							panelId : 'kmImissivePanel',
							contents : {
								kmImissiveSendDGwContent : { title : lang['kmImissive.tree.Send'], route:{ path: 'simpleGw/discard/send' }, cri :{ 'docStatus':'00','j_path':'simpleGw/discard/send' } },
								kmImissiveReceiveDGwContent : { title : lang['kmImissive.tree.Receive'],route:{ path: 'simpleGw/discard/receive' } , cri :{ 'docStatus':'00','j_path':'simpleGw/discard/receive' } },
								kmImissiveSignDGwContent : { title : lang['kmImissive.tree.Sign'],route:{ path: 'simpleGw/discard/sign' }, cri:{ 'docStatus':'00','j_path':'simpleGw/discard/sign' }, selected : true  }
							}
						}
					}
				}]
			},
	   		{
	        	path : '/preview', //负荷分析
	        	action : function(){
					openOverview();
				}
	   		},
			{
				path : '/previewReceive', //负荷分析
				action : function(){
					openOverviewReceive();
				}
			},
	   		{
	        	path : '/deliver', //收发统计
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveStatContent : { title : lang['tree.deliver'], route:{ path: '/deliver' }, cri :{'type':'2'} , selected : true }
						}
					}
				}
	   		},
	   		{
	        	path : '/trend', //趋势统计
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveStatContent : { title : lang['tree.trend'], route:{ path: '/trend' }, cri :{'type':'3'} , selected : true }
						}
					}
				}
	   		},
	   		{
	        	path : '/type', //文种统计
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmImissivePanel',
						contents : {
							kmImissiveStatContent : { title :lang['tree.type'], route:{ path: '/type' }, cri :{'type':'1'} , selected : true }
						}
					}
				}
	   		},
	   		{
				path : '/recover',
				action : function(){
					LUI.pageOpen( $var.$contextPath + '/km/imissive/import/sysRecycleBox.jsp','_rIframe');
				}
			},
			{
				path : '/management',//后台管理
				action : function(){
					LUI.pageOpen( $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/imissive/tree.jsp','_rIframe');
				}
			}
	   		]
		});
		
		
		//新建文档
		function createDoc(mainModelName, modelName, type,path){
			var url = $var.$contextPath + '/km/imissive/km_imissive_'+type+'_main/createDoc_'+type+'.jsp';
			url = Com_SetUrlParameter(url, 'mainModelName', mainModelName);
			url = Com_SetUrlParameter(url, 'modelName', modelName);
			url = Com_SetUrlParameter(url, 'isSimpleCategory', 'false');
			url = Com_SetUrlParameter(url,'j_path', path);
			LUI.pageOpen(url, '_rIframe');
		}
		
		//查询
		function openOverview(){
			url = $var.$contextPath + '/km/imissive/km_imissive_stat/kmImissiveStat_overview.jsp';
			
			LUI.pageOpen(url, '_rIframe');
		}

		//收文视图
		function openOverviewReceive(){
			url = $var.$contextPath + '/km/imissive/km_imissive_stat/kmImissiveStat_countview.jsp';

			LUI.pageOpen(url, '_rIframe');
		}
		
		//查询
		function openSearch(modelName, type){
			var title = null,
				url = $var.$contextPath + '/sys/search/ui/nav_search_new.jsp';
			url = Com_SetUrlParameter(url, 'modelName', modelName);
			switch(type){
				case 'send' :
					title = $lang.kmImissiveNavSend;
					break;
				case 'receive' :
					title = $lang.kmImissiveNavReceive;
					break;
				case 'sign' :
					title = $lang.kmImissiveNavSign;
					break;
			}
			url = Com_SetUrlParameter(url, 'searchTitle',encodeURIComponent(title));
			
			LUI.pageOpen(url, '_rIframe');
		}
		
		$function.createDoc = createDoc;
		$function.openSearch = openSearch;
		
	});
});