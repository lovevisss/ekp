<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  	<list:criteria id="sendCriteria">
	  		 <list:cri-ref key="doc_subject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>
	  		 <list:cri-criterion title="文号" key="fd_doc_num">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入文号'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		     <list:cri-criterion title="拟稿人" key="fd_drafter">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入拟稿人'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		    <list:cri-criterion title="拟稿日期" multi="false" expand="false" key="fd_draft_time">
				<list:varDef name="title"></list:varDef>
				<list:varDef name="selectBox">
				<list:box-select>
					<list:item-select type="lui/criteria/criterion_calendar!CriterionDateDatas" >
					</list:item-select>
				</list:box-select>
				</list:varDef>
			</list:cri-criterion>
		     <list:cri-criterion title="紧急程度" key="fd_emergency">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入紧急程度'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		     <list:cri-criterion title="密级程度" key="fd_secret">
		      <list:box-select> 
		        <list:item-select type="lui/criteria/criterion_input!TextInput"> 
			        <ui:source type="Static">
			           [{placeholder:'请输入密级程度'}]
			        </ui:source>
		        </list:item-select>
		      </list:box-select>
		    </list:cri-criterion>
		</list:criteria>
		<div class="lui_list_operation">
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count="3" id="Btntoolbar">
						
					 	<ui:button text="${lfn:message('km-imissive:kmImissive.printBatch')}" id="batchPrint" onclick="batchPrint();" order="4" ></ui:button>
					
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain')" order="2" ></ui:button>
					
					    <ui:button id="del" text="${lfn:message('button.deleteall')}" order="2" onclick="delDoc()"></ui:button>
						   
					</ui:toolbar>
				  </div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview_send">
			<ui:source type="AjaxJson">
					{url:'/km/imissive/km_imissive_main/kmImissiveMain.do?method=listDoc&mydoc=${param.mydoc}'}
			</ui:source>
			<list:colTable  isDefault="false" layout="sys.ui.listview.columntable" rowHref="/km/imissive/km_imissive_main/kmImissiveMain.do?method=view&fdId=!{fdId}&fdType=!{fdType}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	</template:replace>	 
</template:include>