define([ "dojo/_base/declare",
         "dojo/_base/lang",
         "dojo/dom-construct",
         "dojo/query",
         "dojo/request",
         "dojo/dom-style",
         "dojo/html",
         "dojo/dom",
         "dojox/mobile/viewRegistry",
         "mui/util",
         "mui/dialog/Dialog",
         "mui/tabbar/TabBarButton",
         "mui/i18n/i18n!sys-circulation:sysCirculationMain.mobile"
         ],
         function(declare, lang, domConstruct, query, request, domStyle, html, dom, viewRegistry, util, Dialog, TabBarButton, Msg){
	var button = declare("sys.circulation.CirculationNewButton", [TabBarButton], {
		
		icon1:"",
		
		modelName:"",
		
		modelId:"",
		
		fdKey: null,
		
		addCirculate:"false",
		
		fdSpreadScope:"",
		
		extOptUrl: "/sys/circulation/mobile/js/circulation.jsp",
		
		_onClick: function(){
			var view = null;
			view = viewRegistry.getEnclosingView(this.domNode);
	        view = viewRegistry.getParentView(view) || view;
			
	        var _extView = viewRegistry.hash["circulationView"]
	        if (_extView == null) {
	        	 var url = util.formatUrl(this.extOptUrl);
	             url = util.setUrlParameter(url, "modelName", this.modelName);
	             url = util.setUrlParameter(url, "modelId", this.modelId);
	             if(this.addCirculate=="true"){
	            	 url = util.setUrlParameter(url, "fdSpreadScope", this.fdSpreadScope);
		             url = util.setUrlParameter(url, "fdFromParentId", this.fdFromParentId);
		             url = util.setUrlParameter(url, "fdFromOpinionId", this.fdFromOpinionId);
		             url = util.setUrlParameter(url, "fdOtherSpreadScopeIds", this.fdOtherSpreadScopeIds);
	             }
	             var _selfObj = this
	           	 url = "dojo/text!" + url;
	           	 this.viewNode = domConstruct.create('div');
	           	 domConstruct.place(this.viewNode,view.domNode.parentNode,'last');
	           	 require([url], function(tmplStr) {
					var dhs = new html._ContentSetter({
					  node: _selfObj.viewNode,
					  parseContent: true,
					  cleanContent: false
					})
					
					dhs.set(tmplStr)
					dhs.parseDeferred.then(function(results) {
						_selfObj.defer(function(){
							//初始化完数据后显示弹窗
					    	_selfObj.showCirculationDialog();
						},300);
					});
					dhs.tearDown();
	           	})
	        }else{
	        	this.showCirculationDialog();
	        }
		},
		showCirculationDialog:function(){
			this.operationView = dom.byId("circulationView");
			this.dialogContentNode = domConstruct.create('div');
			domConstruct.place(dom.byId("circulationContent"),this.dialogContentNode,'first');
			var buttons = [];
			this.dialog = Dialog.element({
				title:(this.addCirculate=="true"?Msg['sysCirculationMain.mobile.continue']:"")+Msg['sysCirculationMain.mobile.circulated'],
				canClose : false,
				element : this.dialogContentNode,
				buttons : buttons,
				position:'bottom',
				appendTo:this.operationView,
				'scrollable' : false,
				'parseable' : false,
				showClass : 'muiLbpmDialog',
				callback : lang.hitch(this, function(win,evt) {
					domStyle.set(this.operationView,{
						"display":"none",
						"position":"",
						"z-index":""
					})
					domStyle.set(query("body")[0],{
						"overflow-y":""
					})
					domConstruct.place(query("#circulationContent",evt.element)[0],this.operationView,'first');
					this.lastDialog = this.dialog;
					this.dialog = null;
				}),
				onDrawed:lang.hitch(this, function(evt) {
					domStyle.set(this.operationView,{
						"display":"block",
						"position":"fixed",
						"bottom":"0",
						"z-index":"100"
					})
					domStyle.set(query(".mblScrollableViewContainer",this.operationView)[0] ,{
						"display":"none"
					})
					query(".muiValidate",this.operationView).forEach(function(node){
						domStyle.set(node,{
							"display":"none"
						});
					});
					domStyle.set(query("body")[0],{
						"overflow-y":"hidden"
					})
					var contentHeight = document.documentElement.clientHeight*0.9;
					 if(evt.privateHeight){
						 contentHeight=evt.privateHeight
					 }
					 //减去头部高度
					 if(evt.divNode){
						contentHeight = contentHeight - evt.divNode.offsetHeight;
					 }
					 //减去按钮栏高度
					 if(evt.buttonsNode){
						contentHeight = contentHeight - evt.buttonsNode.offsetHeight;
					 }
					 domStyle.set(evt.contentNode, {
						   'max-height' : contentHeight + 'px',
						   "overflow-x":"hidden"
					 });
					 evt.scrollViewNode = evt.contentNode;
				})
			});
		},
		_destroyDialog:function(evt){
			if (this.dialog && this.dialog.callback)
				this.dialog.callback(window, this.dialog);
			this.lastDialog.hide();
			this.lastDialog = null;
		},
		postCreate: function() {
			this.inherited(arguments);
			this.subscribe("/sys/circulation/cancel","_destroyDialog");
		},
		startup: function() {
			this.inherited(arguments);
		},
		buildRendering : function() {
			this.inherited(arguments);
			if(this.addCirculate=="true"){
				this.extOptUrl = "/sys/circulation/mobile/js/addCirculation.jsp";
				var self = this;
				var url = util.formatUrl('/sys/circulation/sys_circulation_main/sysCirculationMain.do?method=getCirculationInfo');
				url = util.setUrlParameter(url, "fdModelId", this.modelId);
	            url = util.setUrlParameter(url, "fdModelName", this.modelName);
				request.get(url, {handleAs:'json',sync:true}).then(function(json) {
					if(json){
						self.fdSpreadScope = json.fdSpreadScope;
						self.fdFromParentId = json.fdFromParentId;
						self.fdFromOpinionId = json.fdFromOpinionId;
						self.fdOtherSpreadScopeIds = json.fdOtherSpreadScopeIds;
					}
				});
			}
		}
	});
	return button;
});
