<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">   
		<list:criteria id="opinionQu">
	        <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>
			<list:cri-criterion title="状态" key="fdStatus" expand="true"> 
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-imissive:kmImissiveOpinionOutQu_status.tosend')}', value:'-1'},
							 {text:'${ lfn:message('km-imissive:kmImissiveOpinionOutQu_status.success')}',value:'1'},
							 {text:'${ lfn:message('km-imissive:kmImissiveOpinionOutQu_status.fail')}',value:'0'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
		</list:criteria>
		<div class="lui_list_operation">
			<div style='color: #979797;float: left;padding-top:1px;'> 
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
				<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					<list:sortgroup>
						<list:sort property="docCreateTime" text="${lfn:message('km-imissive:kmImissiveOpinionOutQu.docCreateTime')}" group="sort.list" value="down"></list:sort>
					</list:sortgroup>
				</ui:toolbar>
				</div>
			</div>
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>	
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count="3" id="Btntoolbar">
						 <ui:button text="重新发送" id="trySend" onclick="trySendToDec();"></ui:button>
					</ui:toolbar>
				</div>
			</div>	
		</div>
		<%--数据记录--%>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/imissive/km_imissive_opinion_out_qu/kmImissiveOpinionOutQu.do?method=list'}
			</ui:source>
			<list:colTable  isDefault="false" layout="sys.ui.listview.columntable"   name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging></list:paging>
	 	<script type="text/javascript">
			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
				window.trySendToDec = function(){
					var url = '<c:url value="/km/imissive/km_imissive_opinion_out_qu/kmImissiveOpinionOutQu.do?method=updateTrySendToDec"/>'
					var values = [];
				    $("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}	
					window.file_load = dialog.loading();
					$.ajax({     
			    	     type:"post",     
			    	     url:url,     
			    	     data: $.param({"List_Selected":values},true),    
			    	     async:true,    //用同步方式
			    	     dataType : 'json',
			    	     error: function(data){
							if(window.file_load!=null){
								window.file_load.hide(); 
							}
							dialog.failure("发送失败，失败原因请查看后台日志！");
						},
			    	     success:function(data){
			    	    	 if(window.file_load!=null){
								window.file_load.hide(); 
							 }
			    	    	 topic.publish("list.refresh");
			    	    	 dialog.success("发送成功");
					    }     
			        });
				};
				
				topic.subscribe('criteria.spa.changed',function(evt){
					if(LUI('trySend')){
              	    	LUI('Btntoolbar').removeButton(LUI('trySend'));
              	    	LUI('trySend').destroy();
              	    }
					for(var i=0;i<evt['criterions'].length;i++){
						console.log(evt['criterions']);
		             	 if(evt['criterions'][i].key=="fdStatus" && evt['criterions'][i].value.length==1) {
							if(evt['criterions'][i].value[0] !='1'){
								 if(!LUI('trySend')){ 
			                 		 var trySendBtn = toolbar.buildButton({id:'trySend',order:'1',text:'重新发送',click:'trySendToDec()'});
			    					 LUI('Btntoolbar').addButton(trySendBtn);
		                 		}	
							}
						 }
					}
				});
			});
	 	</script>
	</template:replace>
</template:include>