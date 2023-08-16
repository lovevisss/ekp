define( [ "dojo/_base/declare", "dojo/dom-style", "dojo/dom-construct", "dojo/dom-class", "dijit/_WidgetBase", "dijit/_Contained",
	"dijit/_Container", "dojo/_base/array","dojo/_base/lang", "mui/openProxyMixin"], 
	function(declare, domStyle, domConstruct, domClass, WidgetBase, Contained, Container, array, lang, openProxyMixin, ItemBase) {
	var header = declare("km.imeeting.Shortcut", [ WidgetBase, Container, Contained, openProxyMixin], {
		//默认自适应
		width : "100%",

		height : "",

		baseClass : "imeetingShortcut",

		buildRendering : function() {
			
			this.inherited(arguments);
			if (this.width != '100%') {
				domStyle.set(this.domNode,{"width" : this.width});
			}
			if (this.height != '') {
				domStyle.set(this.domNode,{"height" : this.height});
			}
			var shortcutArray = this.shortcuts;
			
			var domNode = this.domNode;
			
			var me = this;
			
			// 构建豆腐块dom元素
			shortcutArray.forEach(function(item, index) {
				
				var itemDomNode  = domConstruct.create("div", {className: "imeetingShortcutItem" }, domNode);
					
				var shortcutItem = domConstruct.create("div", {className: "shortcutItemup" }, itemDomNode);
				
				var shortcutImg = domConstruct.create("img", {src: item.shortcutImg, className: "shortcutImg"}, shortcutItem);
				
				var shortcutTitle = domConstruct.create("div", {className: "shortcutTitle"}, shortcutItem);
				
				shortcutTitle.innerHTML =  item.shortcutName;
				// 绑定点击事件
				me.proxyClick(shortcutItem, item.href, '_blank');
				
			})
			
		},
		//加载
		startup : function() {
			this.inherited(arguments);
		},

	});
	return header;
});