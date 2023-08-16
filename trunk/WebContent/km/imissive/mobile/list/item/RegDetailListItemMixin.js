define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"dojo/query",
   	"mui/dialog/Tip",
   	"dojo/topic",
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, query,Tip,topic) {
	var item = declare("mui.list.item.RegDetailListItemMixin", [ItemBase], {
		tag:"li",
		baseClass:"",
		buildRendering:function(){
			this.domNode = domConstruct.create('li', {className : 'muiCateItem'}, this.containerNode);
			this.inherited(arguments);
			this.buildInternalRender();
		},
		buildInternalRender : function() {
			var html = '<div class="muiCateInfoItem"><div class="muiCateContainer"><div class="muiCateSelArea"><div class="muiCateSel"></div></div><div class="muiCateIcon"><i title="null" class="mui mui-organization"></i></div><div class="muiCateInfo"><div class="muiCateName">' + util.formatText(this.text) + '</div></div></div></div>';
			this.record = domConstruct.toDom(html);
			domConstruct.place(this.record,this.domNode);
			this.connect(this.record,"click","_afterSelectCate");
		},
	
		_afterSelectCate:function(){
			console.log(this.getParent());
			topic.publish("/mui/regDetailList/selected" , this);
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