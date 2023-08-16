/**
 * 
 */
define(['dojo/_base/declare',"dijit/_WidgetBase", "dojo/dom-class", "dojo/dom-construct", "mui/openProxyMixin", "mui/util", 
		"sys/modeling/main/resources/js/mobile/homePage/common/_IndexMixin", "dojo/dom-class","mui/i18n/i18n!sys-modeling-main"],
		function(declare, WidgetBase, domClass, domConstruct, openProxyMixin, util, _IndexMixin, domClass,modelingLang){
	
	return declare('sys.modeling.main.resources.js.mobile.homePage.default.statistics', [WidgetBase, openProxyMixin, _IndexMixin] , {
		
		url : "",

		listViewUrl : "/sys/modeling/main/mobile/modelingAppMainMobileListView.do?method=listViewIndex&listViewId=!{listViewId}&arrIndex=!{arrIndex}&fdMobileId=!{fdMobileId}&area=statistics#path=!{tabIndex}",
		
		DATALOAD : "/sys/modeling/mobile/index/load",
		
		fixNum : 6,	// 收缩的时候，最多展示的方块

		fdMobileId:"",
		
		postCreate : function() {
			this.inherited(arguments);
			this.subscribe(this.DATALOAD, 'onComplete');
		},
		
		buildRendering : function() {
			this.inherited(arguments);
			domClass.add(this.domNode, "mportal-statistics");
		},
		
		onComplete : function(data){
			domConstruct.empty(this.domNode)

			var attrs = data.statistics.attr;
			if(attrs.title && attrs.title.value){
				this.createTitleDom(attrs.title.value);
			}
			this.createContent(attrs.listViews.value);
		},
		
		createTitleDom : function(title){
			var html = "";
			html += "<div class='block-title'><p>"+ title +"</p></div>";
			domConstruct.place(domConstruct.toDom(html), this.domNode, "last");
		},
		
		createContent : function(items){
			items = this.filterByAuth(items);
			if(items.length === 0){
				// 没有展示项时
				this.contentDom = domConstruct.create("div", {
					className : "mportal-collapse shrink"
				}, this.domNode);
				this.showNoAuth(this.contentDom);
			}else{
				var staticsHtml = "";
				// 当方块大于fixNum个时，出现伸缩
				var topSize = items.length > this.fixNum ? this.fixNum : items.length;
				this.contentDom = domConstruct.create("div", {
					className : "mportal-collapse shrink"
				}, this.domNode);
				var collapseTopWrapDom = domConstruct.create("div", {
					className : "mportal-collapse-wrap top"
				}, this.contentDom);
				
				var width = topSize < 3 ? (parseInt(100/topSize) + "%") : "";
				
				for(var i = 0;i < topSize;i++){
					var item =  this.getItemDom(items[i], width);
					domConstruct.place(item, collapseTopWrapDom, "last");
					var tabIndex = this.getTabIndex(items[i].countLv, items[i].lvCollection);
					this.proxyClick(item, util.urlResolver(this.listViewUrl, {listViewId: items[i].listView,arrIndex: i,fdMobileId:this.fdMobileId,tabIndex:tabIndex}), '_self');
				}
				
				// 出现伸展按钮
				if(items.length > this.fixNum){
					var collapseBottomWrapDom = domConstruct.create("div", {
						className : "mportal-collapse-wrap bottom"
					}, this.contentDom);
					for(var i = this.fixNum;i < items.length;i++){
						var item =  this.getItemDom(items[i]);
						domConstruct.place(item, collapseBottomWrapDom, "last");
						var tabIndex = this.getTabIndex(items[i].countLv, items[i].lvCollection);
						this.proxyClick(item, util.urlResolver(this.listViewUrl, {listViewId: items[i].listView, tabIndex:tabIndex}), '_self');
					}
					// 伸展按钮
					var collapseBtnDom = domConstruct.create("div", {
						className : "mportal-collapse-btn"
					}, this.contentDom);
					this.connect(collapseBtnDom, "click", function(){
						domClass.toggle(this.contentDom, "shrink");
					});	
				}
			}

		},
		
		// 根据后台的权限进行数组的过滤
		filterByAuth : function(items){
			var rs = [];
			for(var i = 0;i < items.length;i++){
				if(items[i].auth === "true"){
					rs.push(items[i]);
				}
			}
			return rs;
		},
		
		getItemDom : function(item, width){
			var itemHtml = "<div class='mportal-collapse-item'";
			if(width){
				itemHtml += " style='width:"+ width +"'";
			}
			itemHtml += ">";
			itemHtml += "<div class='mportal-collapse-item-wrap'>";
			itemHtml += "<div>" + (item.count || "0") + "</div>";
			itemHtml += "<p>"+ (item.title || modelingLang['mui.modeling.undefind']) +"</p>";
			itemHtml += "</div>";
			itemHtml += "</div>";
			return domConstruct.toDom(itemHtml);
		}
		
		
	});
});