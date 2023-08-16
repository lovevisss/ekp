<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.landray.kmss.sys.ui.taglib.fn.LuiFunctions"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
JSONObject var = JSONObject.fromObject(request.getParameter("var"));
pageContext.setAttribute("luivar",var);
pageContext.setAttribute("luivarid","var_"+IDGenerator.generateID());
pageContext.setAttribute("luivarparam",StringUtil.isNotNull(var.getString("body")) ? JSONObject.fromObject(var.get("body")) : new JSONObject());
//out.print(request.getParameter("var"));
%>
<script>
${param['jsname']}.VarSet.push({
	"name":"${ luivar['key'] }",
	"getter":function(){
		var _wrap = $("#lui_varkind_padding_wrap_${ luivarid }");
		var _paddingVal_top = parseInt(_wrap.find(".lui_varkind_padding_top input").val()) ;
		var _paddingVal_right = parseInt(_wrap.find(".lui_varkind_padding_right input").val());
		var _paddingVal_down = parseInt(_wrap.find(".lui_varkind_padding_down input").val());
		var _paddingVal_left = parseInt(_wrap.find(".lui_varkind_padding_left input").val());
		$("#${ luivarid }").val([_paddingVal_top,_paddingVal_right,_paddingVal_down,_paddingVal_left])
		return [_paddingVal_top,_paddingVal_right,_paddingVal_down,_paddingVal_left].join("px ")+"px"
	},
	"setter":function(val){
		if((val.split("px").length-1) ===1){
			var _radius = $.trim(val.replace("px",""))
			var _wrap = $("#lui_varkind_padding_wrap_${ luivarid }");
			_wrap.find(".lui_varkind_padding_top input").val(_radius);
			_wrap.find(".lui_varkind_padding_right input").val(_radius);
			_wrap.find(".lui_varkind_padding_down input").val(_radius);
			_wrap.find(".lui_varkind_padding_left input").val(_radius);
		}
		else if((val.split("px").length-1)===2){
			var _radius = val.split("px")
			var _wrap = $("#lui_varkind_padding_wrap_${ luivarid }");
			_wrap.find(".lui_varkind_padding_top input").val($.trim(_radius[0]));
			_wrap.find(".lui_varkind_padding_right input").val($.trim(_radius[0]));
			_wrap.find(".lui_varkind_padding_down input").val($.trim(_radius[1]));
			_wrap.find(".lui_varkind_padding_left input").val($.trim(_radius[1]));
		}
		else if((val.split("px").length-1)===3){
			var _radius = val.split("px")
			var _wrap = $("#lui_varkind_padding_wrap_${ luivarid }");
			_wrap.find(".lui_varkind_padding_top input").val($.trim(_radius[0]));
			_wrap.find(".lui_varkind_padding_right input").val($.trim(_radius[1]));
			_wrap.find(".lui_varkind_padding_down input").val($.trim(_radius[3]));
			_wrap.find(".lui_varkind_padding_left input").val($.trim(_radius[1]));
		}
		else if((val.split("px").length-1)===4){
			var _radius = val.split("px")
			var _wrap = $("#lui_varkind_padding_wrap_${ luivarid }");
			_wrap.find(".lui_varkind_padding_top input").val($.trim(_radius[0]));
			_wrap.find(".lui_varkind_padding_right input").val($.trim(_radius[1]));
			_wrap.find(".lui_varkind_padding_down input").val($.trim(_radius[2]));
			_wrap.find(".lui_varkind_padding_left input").val($.trim(_radius[3]));
		}
		$("#${ luivarid }").val(val);
	},
	"validation":function(){
		var val = this['getter'].call();
		var requ = ${ luivar['require'] ? "true" : "false" };
		if(requ){
			if($.trim(val)==""){
				return "${ lfn:msg(luivar['name']) }不能为空";
			}
		}
	}
});

</script>
<tr>
	<td >
		<span>${ luivar['require'] ? "<i class='lui_varkind_require'>*</i>" : "" }${ lfn:msg(luivar['name']) }</span>
	</td>
	<td>
		<div class="lui_varkind_padding_wrap" id="lui_varkind_padding_wrap_${ luivarid }">
			<ul>
				<li class="lui_varkind_padding_top">
					<span class="varkind_padding_icon"></span>
					<input type="num" value="0" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
				</li>
				<li class="lui_varkind_horizontal">
					<div class="lui_varkind_padding_left">
						<span class="varkind_padding_icon"></span>
						<input type="num" value="0" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
					</div>
					<div class="lui_varkind_padding_right">
						<input type="num" value="0" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
						<span class="varkind_padding_icon"></span>
					</div>
				</li>
				<li class="lui_varkind_padding_down">
					<input type="num" value="0" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
					<span class="varkind_padding_icon" ></span>
				</li>
			</ul>
			<span class="lui_varkind_lock_icon" id="lock_${ luivarid }"></span>
		</div>
		<input style="width:95%" class="inputsgl" id="${ luivarid }_flag" type="hidden" value="true" />
		<input style="width:95%" class="inputsgl" id="${ luivarid }" type="hidden" value="${luivar['default']?luivar['default']:[0,0,0,0]}" />
		<p class="com_help">${ lfn:msg(luivarparam['help']) }</p>
	</td>
</tr>
<script>
	// 是否锁定
	var _flag_${ luivarid } = true;
	$('#lock_${ luivarid }').click(function(){
		_flag_${ luivarid } = !_flag_${ luivarid };
		$("#${ luivarid }_flag").val(_flag_${ luivarid })
		if(_flag_${ luivarid }){
			$(this).removeClass('unlock');
		}else{
			$(this).addClass('unlock');
		}
	})
	$("#lui_varkind_padding_wrap_${ luivarid } input").on('keyup',function(){
		var $this = $(this);
		// 锁定的情况，编辑一个同时改变四个
		if(_flag_${ luivarid }){
			$("#lui_varkind_padding_wrap_${ luivarid } input").val($this.val())
		}else{

		}
	})
</script>
