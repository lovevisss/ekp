//新建分类选择框，给门户或二级页面调用
define(function(require, exports, module) {
	var dialog = require('lui/dialog');
	//参数为默认选中的分类
	function addDoc(categoryId) {
		dialog.categoryForNewFile(
				'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
				'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}',false,null,null,categoryId,null,null,true);
	}
	
	function openDoc(categoryId,myFlow){
		var url;
		if("approval" == myFlow){
			url = Com_Parameter.ContextPath+"km/imissive/#j_path=/listApproval/send&amp;cri.q=fdTemplate:"+categoryId+";mydoc:"+myFlow;
		}else if("approved" == myFlow){
			url = Com_Parameter.ContextPath+"km/imissive/#j_path=/listApproved/send&amp;cri.q=fdTemplate:"+categoryId+";mydoc:"+myFlow;
		}else if("create" == myFlow){
			url = Com_Parameter.ContextPath+"km/imissive/#j_path=/listCreate/send&amp;cri.q=fdTemplate:"+categoryId+";mydoc:"+myFlow;
		}
		window.open(url,"_blank");
	}
	exports.openDoc = openDoc;
	exports.addDoc = addDoc;
});