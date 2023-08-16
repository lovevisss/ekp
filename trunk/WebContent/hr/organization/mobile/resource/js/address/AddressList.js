define( [ 
	"dojo/_base/declare", 
	"dojo/_base/lang", 
	"dojo/_base/array",
	"dojo/dom-construct",
	"dojo/dom-class", 
	"dojox/mobile/viewRegistry",
	"mui/category/CategoryList", 
	"mui/category/CategoryAllSelectMixin",
	"mui/util",
	"mui/i18n/i18n!sys-mobile"
	], function(declare, lang, array, domConstruct, domClass, viewRegistry, CategoryList, CategoryAllSelectMixin, util, Msg) {
	return declare("mui.address.AddressList", [ CategoryList, CategoryAllSelectMixin ], {
		//组织架构数据请求URL
		dataUrl : '/hr/organization/mobile/address.do?method=addressList&parentId=!{parentId}&orgType=!{selType}&deptLimit=!{deptLimit}',
		
		//搜索请求地址
		searchUrl : "/hr/organization/mobile/address.do?method=searchList&keyword=!{keyword}&orgType=!{orgType}",
		
		// 头像地址
		iconUrl : '/hr/organization/image.jsp?orgId=!{orgId}',
		
		// 无数据显示图标
		nodataImg: util.formatUrl('/sys/mobile/css/themes/default/images/address-empty.png'),
		
		//不能参与选择的id
		exceptValue : "",
		
		//标示是否处于搜索.（#21860，全局路径只需要在搜索状态下才显示）
		searching : false,
		
		buildRendering: function() {
			this.inherited(arguments);
			domClass.add(this.domNode, 'muiAddressList')
		},
		
		generateList: function(list){
			if(this.searchCountNode){
				domConstruct.destroy(this.searchCountNode);
				this.searchCountNode = null;
			}
			array.forEach(list, function(item){
				if(item.id){
					item.id = this.channel + item.id
				}
			},this);
			this.inherited(arguments);
			if(this.searching){
				var searchCount = 0;
				array.forEach(list, function(item){
					if(item.header != 'true'){
						searchCount++;
					}
				});
				this.searchCountNode  = domConstruct.create('div',{
					className: 'muiAddressSearchCount',
					innerHTML: Msg['mui.mobile.address.search.count'].replace('%count%', searchCount)
				});
				domConstruct.place(this.searchCountNode, this.domNode, 'first');
			}
		},
		
		buildQuery:function(){
			var params = this.inherited(arguments);
			return lang.mixin(params , {
				exceptValue : this.exceptValue
			});
		},
		
		postCreate : function() {
			this.inherited(arguments);
			// 接受到搜索事件后，可见视图标记searching=true，loaded结束后searching=false
			this.subscribe("/mui/address/search/submit",lang.hitch(this,function(){
				var view = viewRegistry.getEnclosingView(this.domNode);
				if(view && view.isVisible()){
					this.searching = true;
				}
			}));
			this.subscribe("/mui/list/loaded",lang.hitch(this,function(){
				this.searching = false;
			}));
		}
		
	});
});