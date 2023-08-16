<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
{$
<div class="lui_imissive_panel_content" style="padding-top:0px;">
	<div class="lui_imissive_doc_list">
	    <ul>$}
	    for(var i=0;i < data.length;i++){
	        {$<li><a href="${LUI_ContextPath}{%data[i].href%}" target="_blank">
	                <h3>{%data[i].text%}
	                </h3>
	                <p><span>{%data[i].creator%}</span><span>{%data[i].dept%}</span><span class="lui_imissive_date">{%data[i].created%}</span></p>
	            </a>
	        </li>$}
	    }
	    {$</ul>
	</div>
</div>
$}