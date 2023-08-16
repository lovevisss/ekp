<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  	<list:criteria>
	  		<list:tab-criterion title="" key="missiveType"> 
				<list:box-select>
					<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
						<ui:source type="Static">
							[{text:'发文', value:'1'},
							 {text:'收文',value:'2'},
							 {text:'签报',value:'3'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
		</list:criteria>
		<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_main/index_include_toread.jsp?mydoc=${param.mydoc}"></ui:iframe> 
		
		<script type="text/javascript">
			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
				topic.subscribe('criteria.spa.changed',function(evt){
					for(var i=0;i<evt['criterions'].length;i++){
					 	 //获取分类id和类型
	             	  	if(evt['criterions'][i].key=="missiveType"){
	             		  alert(evt['criterions'][i].value[0]);
	                 	
	             	  	}
					}
				});
			});
		</script>	
	</template:replace>	 
</template:include>