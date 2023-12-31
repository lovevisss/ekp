<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
<c:when test="${'true' eq param.isSimpleCategory}">
	<c:set var="search_placeholder" value="${lfn:message('sys-category:sysCategory.search.placeholder.simple') }"></c:set>
</c:when>
<c:otherwise>
	<c:set var="search_placeholder" value="${lfn:message('sys-category:sysCategory.search.placeholder') }"></c:set>
</c:otherwise>
</c:choose>

	<div class="lui-cate-panel-search">
		<div class="lui_category_search_box">
			<a href="javascript:;" id="searchBackBtn" class="search-back" onclick="Qsearch_rtn();"></a>
			<div class="search-input" >
				<input  id="searchTxt" class="lui_category_search_input" type="text" placeholder="${search_placeholder}" onkeyup="searchCate();"/>
			</div>
			<a href="javascript:void(0);" class="search-btn" onclick="Qsearch();"></a>
		</div>
	</div>
	
	<div id="CateSearchDiv" style="display: none">
		<ui:dataview id="CateSearch">
			<ui:source type="AjaxJson">
				{url: ''}
			</ui:source>
			<ui:render type="Template">
				
				if(data.length > 0){
					{$
						<div>
						<ul class="zj-cate-panel-list">
					$} 
						var _data = data[0];
						if(_data.length > 0){
							for(var i=0;i < _data.length;i++){
								{$
									<li class="zj-cate-item">
										<div class="link-box-heading">
											<div class="zj-cate-title">
												<div class="zj-cate-c"><span>{%env.fn.formatText(_data[i].text)%}</span></div>
											</div>
											<div class="link-footer">
												<ul>
													<li>文号：</li>
													<li>签发人：</li>
												</ul>
												<a href="javascript:;" class="btn-add" onclick="javascript:openCreate('{%_data[i].value%}');" title="{%env.fn.formatText(_data[i].text)%}"><bean:message key="button.add" /></a>
											</div>
										</div>
									</li>
								$}
							}
						
						}else{
							{$
								<div class="lui-cate-simple-panel-noresult">
									<bean:message bundle="sys-category" key="sysCategory.search.noResult" />
								</div>
							$}
						}
					{$
						</div>
						</ul>
					$}
				}else{
					{$
						<div class="lui-cate-simple-panel-noresult">
							<bean:message bundle="sys-category" key="sysCategory.search.noResult" />
						</div>
					$}
				}
			</ui:render>
		</ui:dataview>
	</div>
    <script type="text/javascript">
    seajs.use(['lui/jquery','lui/util/str','lui/dialog'], function($,str,dialog) {
    	
    	window.searchCate = function(evt){
    		var event = event || window.event;
    		if ( (evt && evt.keyCode == 13) || (event && event.keyCode == 13) ){
    			Qsearch();
    		}
    	};
    	
	    window.Qsearch = function(){
			var searchTxt = $("#searchTxt").val();
			if(searchTxt !="" && $.trim(searchTxt) != ""){
				if($("#favouriteCateDiv")){
					$("#favouriteCateDiv").hide();
				}
				if($("#usualCateDiv")){
					$("#usualCateDiv").hide();
				}
				$("#searchBackBtn").css({'display':'inline-block'});
				$("#CateSearchDiv").show();
				if(LUI("CateSearch")){
					if("${JsParam.isSimpleCategory}" == 'false'){
						LUI("CateSearch").source.setUrl('/sys/category/criteria/sysCategoryCriteria.do?method=select&modelName=${param.modelName}&searchText='+encodeURIComponent(searchTxt)+'&type=03&getTemplate=1&authType=2&qSearch=true');
					}else{
						LUI("CateSearch").source.setUrl('/sys/simplecategory/criteria/sysSimpleCategoryCriteria.do?method=select&modelName=${param.modelName}&searchText='+encodeURIComponent(searchTxt)+'&type=03&authType=2&qSearch=true');
					}
					LUI("CateSearch").source.get();
				}
			}else{
				dialog.alert('<bean:message bundle="sys-category" key="sysCategory.search.keyword" />');
			}
		};
		window.Qsearch_rtn = function(){
			$("#searchTxt").val("");
			$("#CateSearchDiv").hide();
			$("#searchBackBtn").css({'display':'none'});
			if($("#favouriteCateDiv")){
				$("#favouriteCateDiv").show();
			}
			if($("#usualCateDiv")){
				$("#usualCateDiv").show();
			}
		};
    });
    </script>
