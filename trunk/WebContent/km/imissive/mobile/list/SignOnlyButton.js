define(["dojo/_base/declare", "mui/tabbar/TabBarButton", "dojo/dom-construct", "dojo/dom-style", "dojo/dom-class",
        "mui/dialog/Dialog", "mui/device/adapter","dojo/_base/lang","mui/util", "dojo/dom-attr","dojo/request","mui/dialog/Tip","mui/i18n/i18n!km-imissive" ],
		function(declare, TabBarButton, domConstruct,domStyle,domClass, Dialog, adapter,lang, util, domAttr,req,Tip,Msg) {
	
			return declare("mui.tabbar.SignOnlyButton", [ TabBarButton ], {
				
				editTip :Msg['mui.kmImissiveRegDetailList.updateSignOnly.confirm'],
				
				url:'',
				
				buildRendering:function(){
					this.inherited(arguments);
					
					domAttr.set(this.domNode, 'title', Msg['mui.kmImissiveReg.updateSignOnly']);
					this.labelNode.innerHTML = Msg['mui.kmImissiveReg.updateSignOnly'];
				},
				
				startup: function(){
					this.inherited(arguments);
				},
				
				_onClick : function(evt) {
					this.defer( function() {
						// 校验是否撤回
						req(util.formatUrl("/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt"), {
							handleAs : 'json',
							method : 'post',
							data : {
								fdDetailId: this.fdDetailId,
								justCheckCancel: "true"
							}
						}).then(lang.hitch(this, function(results) {
							if (results){
						    	 if(results['cancel'] == 'true'){
						    		 Tip.tip({icon:'mui mui-warn', text:'该签收单已经撤回，无法进行此操作',width:'260',height:'120'});
						    	 } else {
									// 执行直接签收-------------------
						    		 var contentNode = domConstruct.create('div', {
										className : 'muiBackDialogElement',
										innerHTML : '<div>' + util.formatText(this.editTip) +'<div>'
									});
									Dialog.element({
										'title' : Msg["mui.dialog.tips"],
										'showClass' : 'muiBackDialogShow',
										'element' : contentNode,
										'scrollable' : false,
										'parseable': false,
										'buttons' : [{
											title : Msg["mui.kmImissiveRegDetailList.updateSignOnly.cancel"],
											fn : function(dialog) {
												dialog.hide();
											}
										}, {
											title : Msg["mui.kmImissiveRegDetailList.updateSignOnly.ok"],
											fn : lang.hitch(this,function(dialog) {
												req(util.formatUrl(this.url), {}).then(lang.hitch(this, function(data) {
													Tip.tip({text: "直接签收成功!"})
													location.reload();
												}));
												dialog.hide();
											})
										}]
									});
									// 执行直接签收-------------------
						    	 }
							}
						}));
					}, 450);// 延时处理原因：手机端延时300毫秒问题导致返回多次（iphone4发现问题）
			}
			});
		});