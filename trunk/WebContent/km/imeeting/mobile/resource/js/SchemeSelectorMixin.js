define( [ "dojo/_base/declare"], function(declare) {
	
	return declare("km.imeeting.mobile.js.SchemeSelectorMixin", null, {
		templURL : "/km/imeeting/mobile/resource/tmpl/topicselector.jsp",
		
		postCreate: function(){
			this.inherited(arguments);
			
			if(this.isMul) {
				// 暂无多选业务
			} else {
				this.templURL = "/km/imeeting/mobile/resource/tmpl/schemeSelector_s.jsp";
			}
			
		},
		
	});
	
});