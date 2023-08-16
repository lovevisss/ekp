define([
    "mui/tabbar/TabBarButton",
	"dojo/_base/declare",
	"dojo/dom-construct",
	"mui/util",
	"mui/dialog/Tip",
	"dojo/dom",
	'dojo/html',
    "dojox/mobile/_css3",
    "dojo/_base/lang",
    "dojo/dom-style",
    "dojo/dom-class",
    "dojo/touch",
    "dojo/_base/array",
    'dojo/topic',
	"dojo/request",
	], function(TabBarButton, declare, domConstruct, util, Tip,dom,html,css3,lang,domStyle,domClass,touch,array,topic,req) {
	
	return declare("mui.tabbar.CreateButton", [TabBarButton], {
		icon1 : "mui mui-create",
		
		type : "",
		
		fdDetailId:"",
		
		fdSendId:"",
		
		key:"",
		
		fdReceiveId :"",
		
		buildRendering:function(){
			this.inherited(arguments);
		},
		
		postCreate : function() {
			this.inherited(arguments);
			topic.subscribe("/mui/regDetailList/selected",lang.hitch(this,"createSignDoc"));
		},
		
		onClick : function(evt) {
			this.defer(function(){
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
				    		 Tip.tip({icon:'mui mui-warn', text:'该签收单已经撤回，无法签收',width:'260',height:'60'});
				    	 } else {
				    		 this._selectCate();
				    	 }
					}
				}));
			}, 350);
		},
		
		showAnimate :function() {
			domClass.add(this.dialogDiv,'fadeIn animated');
			domStyle.set(this.dialogDiv, 'display','block');
			domStyle.set(this.dialogDiv, 'background-color','rgba(0, 0, 0, 0.6)');
			domClass.add(this.dialogContainerDiv, 'fadeInRight animated');
			domStyle.set(this.dialogContainerDiv, 'display','block');
			this.defer(function(){
				//移除动画类名
				domClass.remove(this.dialogDiv, "fadeIn");
				domClass.remove(this.dialogContainerDiv, "fadeInRight");
			}, 800);
		},
		
		_selectCate: function() {
			if(!this._working){
				var templURL = "km/imissive/mobile/tmpl.jsp?type="+this.type+"&fdSendId="+this.fdSendId+"&fdReceiveId="+this.fdReceiveId+"&key="+this.key;
				var dialogId = "__cate_dialog__regDetailListSelect";
				this.dialogDiv = dom.byId(dialogId);
				if(this.dialogDiv == null){
					var _self = this;
					this._working = true;
					require(["dojo/text!" + util.urlResolver(templURL , this)], function(tmplStr){
						_self.dialogDiv = domConstruct.create("div" ,{id:dialogId, className:'muiCateDiaglog'},document.body,'last');
						_self.dialogContainerDiv = domConstruct.create("div" ,{ className:'muiCateDiaglogContainer '},_self.dialogDiv);
						_self.dialogDiv.focus();
						_self.connect(_self.dialogDiv,touch.press, 'closeDialog');
						util.disableTouch(_self.dialogDiv , touch.move);
						var dhs = new html._ContentSetter({
							node:_self.dialogContainerDiv,
							parseContent : true,
							cleanContent : true,
							onBegin : function() {
								this.content = lang.replace(this.content,{categroy:_self});
								this.inherited("onBegin",arguments);
							}
						});
						dhs.set(tmplStr);
						dhs.parseDeferred.then(function(results) {
							_self.parseResults = results;
							_self.showAnimate();
						});
						dhs.tearDown();
					});
				}
			}
		},
		
		createSignDoc:function(evt){
			if(evt.getParent() && evt.getParent().key == this.key){
				var idString = evt.value;
				var idArray = idString.split(";");
	            var fdTemplateId = idArray[0];
	            var fdCfgId =idArray[1];
	            var url = util.formatUrl("/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId="+this.fdDetailId+"&fdTemplateId="+fdTemplateId+"&fdCfgId="+fdCfgId)+"&mobile=true";
	           if("RS" == this.type){
	        	   url = util.formatUrl("/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fddetaiId="+this.fdDetailId+"&fdTemplateId="+fdTemplateId+"&fdCfgId="+fdCfgId)+"&mobile=true";
	           }
	           window.open(url, "_self");
			}
		},
		closeDialog : function(evt){
			var target = evt.target;
			if(this.dialogDiv && target === this.dialogDiv){
				domClass.add(this.dialogContainerDiv,'fadeOutRight animated');
				domClass.add(this.dialogDiv,'fadeOut animated');
				
				this.defer(function(){
					if(this.dialogContainerDiv){
						domStyle.set(this.dialogContainerDiv, 'display','none');
					}
					if(this.dialogDiv){
						domStyle.set(this.dialogDiv, 'display','none');
					}
				}, 800);
				
				this.defer(function(){
					if(this.parseResults && this.parseResults.length){
						array.forEach(this.parseResults, function(w){
							if(w.destroy){
								w.destroy();
							}
						});
						delete this.parseResults;
					}
					domConstruct.destroy(this.dialogDiv);
					this.dialogDiv = null;
					this._working = false;
				},410);
			}
		}
		
	});
});