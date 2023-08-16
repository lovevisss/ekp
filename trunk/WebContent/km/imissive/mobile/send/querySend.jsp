<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="mui/query/QueryList" data-dojo-props="topHeight:!{topHeight}">
	<div data-dojo-type="mui/query/QueryListItem" 
		data-dojo-mixins="mui/syscategory/SysCategoryDialogMixin"
		data-dojo-props="label:'<bean:message  bundle="km-imissive" key="mui.send.category"/>',icon:'mui mui-Csort',
		    getTemplate:1,
		    selType: 0|1,
		    key:'send_cate',
			modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
			redirectURL:'/km/imissive/mobile/index.jsp?moduleName=!{curNames}&filter=1',
			filterURL:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.fdTemplate=!{curIds}&orderby=docCreateTime&ordertype=down'">
	</div>
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/search/SearchBarDialogMixin" 
		data-dojo-props="label:'<bean:message key="button.search" />',icon:'mui mui-search', modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain'">
	</div>
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/query/CommonQueryDialogMixin" 
		data-dojo-props="label:'<bean:message key="list.search" />',icon:'mui mui-query',
			redirectURL:'/km/imissive/mobile/send/index.jsp?moduleName=!{text}&filter=1',
			store:[{'text':'<bean:message bundle="km-imissive" key="kmImissive.tree.mydistribute" />','dataURL':'/km/imissive/km_imissive_reg/kmImissiveReg.do?method=list&q.fdDeliverType=1'},
			{'text':'<bean:message bundle="km-imissive" key="kmImissive.tree.myreport" />','dataURL':'/km/imissive/km_imissive_reg/kmImissiveReg.do?method=list&q.fdDeliverType=2'},
			{'text':'<bean:message bundle="km-imissive" key="kmImissive.tree.mysign" />','dataURL':'/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&owner=true&mySign=true'},
			{'text':'<bean:message bundle="km-imissive" key="kmImissive.tree.myreceive" />','dataURL':'/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&owner=true'}
			]">
	</div>
</div>
