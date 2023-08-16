define([
    "dojo/_base/declare",
	"mui/util",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/js/selectdialog/DialogItemMixin"
	], function(declare, util, _TemplateItemMixin, DialogItemMixin) {
	
	return declare("mui.selectdialog.DialogItemListMixin", [_TemplateItemMixin], {

		itemRenderer : DialogItemMixin,

		buildRendering: function() {
			this.inherited(arguments)
			this.subscribe("/mui/search/submit", "_onRelod")
		},

		// 搜索刷新面板
		_onRelod: function(srcObj, evt) {
			if (srcObj.key == this.key) {
				this.keyword = evt.keyword
				if(this.dataUrl.indexOf("keyword") == -1){
					this.dataUrl += "&keyword=!{keyword}";
				}
				this.url = util.urlResolver(util.formatUrl(this.dataUrl), this)
				this.buildLoading()
				this.reload()
			}
		}
		
	});
});