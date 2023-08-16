<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
{$
<div class="lui_imissive_tabpanel_content">
	<div class="lui_imissive_doc_list">
	    <ul>$}
	    for(var i=0;i < data.length;i++){
	        {$<li onclick="refreshToview('${param.dataType }')"><a href="${LUI_ContextPath}{%data[i].href%}" target="_blank">
	                <h3><span class="status_item status_urgent" style="color:{%data[i].color%}">{%data[i].status%}</span>{%data[i].title%}
	                </h3>
	                <p><span>{%data[i].creator%}</span><span>{%data[i].dept%}</span><span class="lui_imissive_date">{%data[i].createTime%}</span></p>
	            </a>
	        </li>$}
	    }
	    {$</ul>
	</div>
</div>
<div class="lui_imissive_tabpanel_footer">
    <a onclick="window.parent.open('${LUI_ContextPath }/sys/notify/index.jsp?dataType=${param.dataType }')">${lfn:message('operation.more') }</a>
</div>$}