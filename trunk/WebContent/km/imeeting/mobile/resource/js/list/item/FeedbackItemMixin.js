define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/i18n/i18n",
   	"mui/list/item/_ListLinkItemMixin",
   	"mui/i18n/i18n!km-imeeting:mobile"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n, _ListLinkItemMixin,msg) {
	
	var item = declare("km.imeeting.list.item.FeedbackItemMixin", [ItemBase], {
		
		tag:"li",
		
		baseClass:"muiMeetingListItem",
		
		//发布时间
		created:"",
		
		//参与人
		creator:"",
		
		// 参与人部门
		creatorParent: "",
		
		//实际参与人
		attend:"",
		
		//参与人头像
		icon:"",
		
		//
		opt:"",
		
		buildRendering:function() {
			
			this.inherited(arguments);
			domAttr.set(this.domNode, "fdId", this.fdId);
			//左侧头像
			var figure=domConstruct.create("div",{className:"figure"},this.containerNode);
			var _a=domConstruct.create("a", { }, figure);
			domConstruct.create("span", {className: "muiFeedbackImg",style:{background:'url('+ util.formatUrl(this.icon) +') center center no-repeat',backgroundSize:'cover',display:'inline-block'}}, _a);
			var optBoxClassName="",
				optTextClassName = "",
				optBaseClassName = "muiImeetingFSText",
				optName="",
				optIcon="";
			switch(this.opt){
				case "01":
					optBoxClassName = "muiImeetingFSBAttend";
					optTextClassName = "muiImeetingFSTAttend";
					optName = msg['mobile.kmImeetingMainFeedback.type.attend'];
//					optIcon="mui-meeting_attend";
					break;
				case "02":
					optBoxClassName = "muiImeetingFSBUnAttend";
					optTextClassName = "muiImeetingFSTUnAttend";
					optName = msg['mobile.kmImeetingMainFeedback.type.unattend'];
//					optIcon="mui-meeting_unAttend";
					break;
				case "07":
					optBoxClassName = "muiImeetingFSBSign";
					optTextClassName = "muiImeetingFSTSign";
					optName = msg['mobile.kmImeetingMainFeedback.type.signed'];
//					optIcon="mui-meeting_attend";
					break;
				default:
					optBoxClassName = "muiImeetingFSBNoOpt";
					optTextClassName = "muiImeetingFSTNoOpt";
					optName = msg['mobile.kmImeetingMainFeedback.type.noopt'];
//					optIcon="mui-meeting_noOpt";
			}
//			var _span=domConstruct.create("span", { className: "figureTag "+optClassName}, _a);
//			domConstruct.create("i", { className: "mui "+optIcon}, _span);
			
			//右侧内容
			var content=domConstruct.create("div",{className:"muiFeedBackContent"},this.containerNode);
			var creatorInfoDom = domConstruct.create("div", {className:"name"}, content);
			domConstruct.create("div", {className:"feebackPersonName", innerHTML:this.creator}, creatorInfoDom);//参与人
			if (this.creatorParent) {
				domConstruct.create("div", {className:"feebackPersonParent", innerHTML:this.creatorParent}, creatorInfoDom);
			}
//			if(this.fdReason){
//				domConstruct.create("p", {className:"info",innerHTML:this.fdReason }, content);//回执留言
//			}
			
			if (window.isShowFeedbackStatusTag) {
				//回执类型
				var optBaseBoxDom = domConstruct.create("div", {className: "optBaseBox"}, content);
				var optBoxDom = domConstruct.create("div", {className: optBoxClassName}, optBaseBoxDom);
				domConstruct.create("div", {className: optBaseClassName, innerHTML:optName }, optBoxDom);
			}
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
	});
	return item;
});