<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%> 
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%> 
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="_isWpsCloudEnable" value="<%=ImissiveUtil.isEnableWpsCloud()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<script language="JavaScript">
 Com_IncludeFile("jquery.js");
</script>
<script type="text/javascript">

function getHost(){
	var host = location.protocol.toLowerCase()+"//" + location.hostname;
	if(location.port!='' && location.port!='80'){
		host = host+ ":" + location.port;
	}
	return host;
}
function postDownLoadFile(url, param){
	var form = null;
	var params= {};
	try{
		var tmpParams = param.split("&");
		for ( var i = 0; i < tmpParams.length; i++) {
			var tIndex = tmpParams[i].indexOf("=");
			if(tIndex>-1){
				params[tmpParams[i].substring(0,tIndex)] = tmpParams[i].substring(tIndex+1);
			}
		}
		form = $("<form></form>").attr({'action':url,'method':'POST','target':'_top'});
		for ( var key in params) {
			form.append($("<input type='hidden' name='" + key +"'/>").val(params[key]));
		}
		form.css({'display':'none'});
		form.appendTo($(document.body));
		form.submit();
		form.remove();
	}catch(e){
		if(form!=null){
			form.remove();
		}
	}
}

function doDownLoadFiles(docIds){
	if(docIds.length <= 0){
		alert(Attachment_MessageInfo["msg.noChoice"]);
	}else{
		docIds = docIds.substring(1, docIds.length);
		var url = getHost() + Com_Parameter.ContextPath+ "sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=" + docIds;
		url += "&downloadType=manual&downloadFlag="+(new Date()).getTime(); //记录下载日志标识
		if(url.length<2000){
			window.open(url, "_blank");
		}else{	//url超长处理
			postDownLoadFile(url.substring(0,url.indexOf("?")),url.substring(url.indexOf("?")+1));
		}
	}
}
function downloadFile(){
	var docIds = "";
	$("#previewAttContainer").find("input[name^='List_FilePreview_Selected_']:checked").each(function(){
		docIds += ";" + $(this).val();
	});
	doDownLoadFiles(docIds);
}

// $(document).on("alterName", function(event, data) {
// 	console.log("$(document).on - alterName");
// 	var fdFileId = data.fdId;
// 	var fdFileName = data.fileName;
// 	$("#previewAttContainer").find('tr[id='+fdFileId+']').each(function(){
// 		$(this).find(".upload_list_filename_view").html(fdFileName);
// 	});
// });

seajs.use(['lui/topic'], function(topic) {
	// 接收附件重命名事件
	topic.subscribe('alterName-topic', function(data) {
		console.info("触发alterName事件，附件名修改");
		var fdFileId = data.fdId;
		var fdFileName = data.fileName;
		$("#previewAttContainer").find('tr[id='+fdFileId+']').each(function() {
			$(this).find(".upload_list_filename_view").html(fdFileName);
		});
	});
})

function downloadAllFile(){
	var docIds = "";
	$("#previewAttContainer").find("input[name^='List_FilePreview_Selected_']").each(function(){
		docIds += ";" + $(this).val();
	});
	doDownLoadFiles(docIds);
}
</script>
<div class="lui_form_content_frame" style="padding-top: 10px">
	<iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="previewAttListFrame" src=""></iframe>
	<div class="groupDivHead" id="groupDivHead" style="display:none">
		<div  class="groupDivHead_left">
			附件汇总
		</div>
		<div class="groupDivHead_right">
			<a class="title" onclick="downloadFile();">下载</a>
			<a class="title" onclick="downloadAllFile();">下载全部</a>
		</div>
	</div>
	<div id="previewAttContainer">
	</div>
</div>
<%
  boolean isJGPDFEnabled = false;
  if(JgWebOffice.isJGPDFEnabled()){
	  isJGPDFEnabled = true;
  }
  request.setAttribute("isJGPDFEnabled", isJGPDFEnabled);
%>
<script>
var FILE_EXT_OFFICE = "All Files (*.*)|*.*|Office Files|*.doc;*.xls;*.ppt;*.vsd;*.rtf;*.csv";
var FILE_EXT_PIC = "Picture Files|*.gif;*.jpg;*.jpeg;*.bmp;*.png;*.tif|All Files (*.*)|*.*";
var File_EXT_READ = ".doc;.xls;.ppt;.xlc;.docx;.xlsx;.mppx;.pptx;.xlcx;.wps;.et;.vsd;.rtf";
if("${isJGPDFEnabled}" == 'true' || "${_isWpsCloudEnable}" == 'true'){
	File_EXT_READ += ";.pdf";
}
var File_EXT_READDOWNLOAD = ".pdf;.ofd;.html";
var File_EXT_EDIT = ".doc;.xls;.ppt;.xlc;.docx;.xlsx;.mppx;.pptx;.xlcx;.wps;.et;.vsd;.rtf";
var File_EXT_PIC_READ = ".gif;.jpg;.jpeg;.bmp;.png;.tif";
var File_EXT_VIDEO = ".flv;.mp4;.f4v;.mp4;.m3u8;.webm;.ogg;.theora;.mp4;.avi;.mpg;.wmv;.3gp;.mov;.asf;.asx;.wmv9;.rm;.rmvb;.wrf;.m4v" ;
var File_EXT_MP3 = ".mp3";
var File_EXT_NO_PRINT = ".ppt;.pptx";//不可打印的文件后缀
var File_EXT_NO_READ = ".mpp;.mppx";//不可在线阅读的文件
var _reads = File_EXT_READ.split(";");
var _videos = File_EXT_VIDEO.split(";");
var _mp3s = File_EXT_MP3.split(";");
var _edits = File_EXT_EDIT.split(";");
var _noPrints = File_EXT_NO_PRINT.split(";");
var _noReads = File_EXT_NO_READ.split(";");
var _pics = File_EXT_PIC_READ.split(";");
var _read_downloads = File_EXT_READDOWNLOAD.split(";");
var readDocShowId = "";
var firstTimeOpen = true;


function attachmentPreview(swfObj,attId){

	var xin = '${xinChuangWps}';
	if(xin == "true"){
		var url = swfObj.getUrl("view", attId);
		window.open(url,"_blank");
		return;
	}

	var previewIframeContainer = "attachment_preview ";
	if("${param.previewIframeContainer}" != ""){
		previewIframeContainer = "${param.previewIframeContainer}";
	}


	var panel=LUI('tabpanelDiv');
	for(var i=0;i<panel.contents.length;i++){
		if(panel.contents[i].id == "attPreview"){
			panel.setSelectedIndex(i);
			firstTimeOpen = false;
		}
	}
	var contentH = $('.content').height();
	//新上传的附件，如果已经未生成attMain，则给出预览提示
	if(attId.indexOf("WU_FILE") >=0){
		var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain_preview_noDataS.jsp"
		$('#'+previewIframeContainer+'iframe').attr('src', url).load(function() {
			$('#'+previewIframeContainer+'iframe').css('height', (contentH-70)+'px');
		});

	}else{
		$('#'+previewIframeContainer).css('height', (contentH-50)+'px').show();
		var url = swfObj.getUrl("view", attId);
		var jg_height = contentH-150; //金格的高度
		if(url){
			url += "&inner=yes&showBar=false&attHeight="+jg_height;
			$('#'+previewIframeContainer+'iframe').attr('src', url).load(function() {
				$('#'+previewIframeContainer+'iframe').css('height', (contentH-70)+'px');
			});
		}
	}
}
function initAttPreview(url){
	var previewIframeContainer = "attachment_preview ";
	var contentH = $('.content').height();
	$('#'+previewIframeContainer).css('height', (contentH-50)+'px').show();
	var jg_height = contentH-150; //金格的高度
	if(url){
		url += "&inner=yes&showBar=false&attHeight="+jg_height;
		$('#'+previewIframeContainer+'iframe').attr('src', url).load(function() {
			$('#'+previewIframeContainer+'iframe').css('height', (contentH-70)+'px');
		});
	}
}

$(window).resize(function(){
	if($('.content')&&$('.content').height()){
		var contentH = $('.content').height();
		$('#attachment_preview iframe').css('height', (contentH-70)+'px');
	}
});

if(typeof window.previewEvn == "undefined"){
	top.window.previewEvn = {
		previewEventsCache :{},
		on:function(event, callback) {
		    if (!callback) return this;
		    var list = this.previewEventsCache[event] || (this.previewEventsCache[event] = []);
		    list.push(callback);
		    return this;
		},
		off :function(event, callback) {
		    if (!(event || callback)) {
		        this.previewEventsCache = {};
		        return this;
		    }
		    var list = this.previewEventsCache[event];
		    if (list) {
		        if (callback) {
		            for (var i = list.length - 1; i >= 0; i--) {
		                if (list[i] === callback) {
		                    list.splice(i, 1);
		                }
		            }
		        } else {
		            delete this.previewEventsCache[event];
		        }
		    }
		    return this;
		},
		emit :function(event, data) {
		    var list = this.previewEventsCache[event];
		    var fn;
		    if (list) {
		    	for(var i=0;i<list.length;i++ ){
		    		list[i](data);
		    	}
		    }
		    return this;
		}
	};
}

function doCheckAll(data,obj){
	var checkObj = $(obj).find("input[type='checkbox']")[0];
	var obr = data.fileList;
	for(var i = 0; i < obr.length; i++){
		var check =$("#preview_att_xtable_"+data.fdKey).find('input[name="List_FilePreview_Selected_'+obr[i].fdId+'"]')[0];
		//var check = document.getElementsByName("List_File_Selected_"+obr[i].fdId)[0];
		if(checkObj.checked){
			check.checked = true;
		}else{
			check.checked = false;
		}
	}
}

var attCount = 0;
LUI.ready(function(){
	var winObj;
	var top = Com_Parameter.top || window.top;
	try {
		if(top.window){
			winObj = top.window;
		}
	} catch (e) {
		winObj = window;
	}
	if (winObj.Attachment_ObjectInfo) {
		for (var key in winObj.Attachment_ObjectInfo) {
			winObj.previewEvn.emit("beforeShow", winObj.Attachment_ObjectInfo[key]);
		}
	}
	setAttListCount();
});

let hasDoneBeforeShow = false;
$(document).ready(function() {
	// 如果没有执行'beforeShow'的监听函数，则再发一次'beforeShow'事件
	if (!hasDoneBeforeShow) {
		console.log("发布beforeShow事件")
		var winObj;
		var top = Com_Parameter.top || window.top;
		try {
			if(top.window){
				winObj = top.window;
			}
		} catch (e) {
			winObj = window;
		}
		if(winObj.Attachment_ObjectInfo) {
			for (var item in winObj.Attachment_ObjectInfo) {
				winObj.previewEvn.emit("beforeShow", winObj.Attachment_ObjectInfo[item]);
			}
		}
	}
});


window.setAttListCount = function() {
	// 将seajs放进方法里是因为存在异步问题
	seajs.use(['lui/contentUtil'], function(contentUtil) {
		setTimeout(function(){
			if(LUI("attPreviewList")){
				contentUtil.setContentCount("attPreviewList",attCount);
			}
		}, 800);
	});
}


function createViewOperation(data,selectAll){
	var xtr = $("<tr class='tongleHead'></tr>");
	var xtd = $("<td colspan='3' class='upload_opt_td'></td>");
	if(data.canDownload && selectAll){
		xtd.append($("<div><input type='checkbox' name='List_FilePreview_Tongle_" + data.fdKey + "'></div>").bind("click",function() {
				doCheckAll(data,this);
			}
		));
	}
	xtd.append($("<div class='upload_opt_batchdown'>"+ data.fdLabel + "</div><div id='tongle_"+data.fdKey+"'></div>"));

	return xtr.append(xtd).click(function(evt){
		if(evt.target.type != 'checkbox'){
			$(this).toggleClass("unexpanded").siblings().toggle();  // 隐藏/显示所谓的子行
		}
	});
}

//设置标题颜色
function switchColourTitle(fdId){
	$("#previewAttContainer").find(".upload_list_filename_view").removeClass("lui_text_primary");
	if(fdId){
		$("#"+fdId).find(".upload_list_filename_view").addClass("lui_text_primary");
	}
}

//有参数是edit页面
function openOnePreview(str){
	if(str == "edit"){
		var upload_list_tr = $(".upload_list_tr");
		if($(upload_list_tr)[0]){
			var showId = $(upload_list_tr)[0].id;
			if(showId !="" && showId!=null && showId!="undifend"){
				var viewFlag = queryExistView(showId);
				if(viewFlag =="true"){
					readDocShowId = showId;
				}
			}
		}
	}
	if(readDocShowId && firstTimeOpen){
        firstTimeOpen = false;
		//金格or云文档不需要转换成功也可以打开
		switchColourTitle(readDocShowId);
		if ('${wpsoaassist}'!='true') {
			var url = getHost() + Com_Parameter.ContextPath+"sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId="+readDocShowId;
			initAttPreview(url);
			return;
		}
		var viewFlag = queryExistView(readDocShowId);
		if('${wpsoaassist}'=='true' && viewFlag == "true"){
			var url = getHost() + Com_Parameter.ContextPath+"sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId="+readDocShowId;
			initAttPreview(url);
		}
	}else{
		var previewIframeContainer = "attachment_preview ";
		if("${param.previewIframeContainer}" != ""){
			previewIframeContainer = "${param.previewIframeContainer}";
		}
		if($('#'+previewIframeContainer+'iframe').attr('src') == ""){
			var url = getHost() + Com_Parameter.ContextPath+"sys/attachment/sys_att_main/sysAttMain_preview_noDataB.jsp";
			$('#'+previewIframeContainer+'iframe').attr('src',url);
			var contentH = $('.content').height();
			$('#'+previewIframeContainer+'iframe').css("height",(contentH-90) + "px");
		}
	}
};

//查询是否转换成功
function queryExistView(readDocShowId){
	var viewFlag="false";
	if(readDocShowId){
		var urlImssive =getHost() + Com_Parameter.ContextPath+'km/imissive/km_imissive_main/kmImissiveMain.do?method=queryIsExistViewPath';
		$.ajax({
		    type:"post",
		    url:urlImssive,
		    data:{"fdAttMainId":readDocShowId},
		    dataType:"json",
		    async:false,
		    success:function(data){
		    	if(data.existViewPath == "true"){
		    		viewFlag = "true";
		    	}
			}
		 });
	}
	return viewFlag;
}

function openByWpsOAAssit(file,swfObj){
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf(".")).toLowerCase();
	var attId = file.fdTemplateAttId || file.fdId;
	if(fileExt.toLowerCase()==".xlsx"||fileExt.toLowerCase()==".xls"||fileExt.toLowerCase()==".et"){
		openExcelOAAssit(attId);
		return;
	}
	if(fileExt.toLowerCase()==".docx"||fileExt.toLowerCase()==".doc"||fileExt.toLowerCase()==".wps"){
		openWpsOAAssit(attId,"");
		return;
	}
	readDocClass(file,swfObj);
}

function readDoc(file,swfObj) {	
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf(".")).toLowerCase();
	var attId = file.fdTemplateAttId || file.fdId;
	if ('${wpsoaassist}'=='true' && '${xinChuangWps}' !=='true') {
		var viewFlag = queryExistView(attId);
		if(viewFlag == "true"){
			attachmentPreview(swfObj,attId);
			return;
		}else{
			openByWpsOAAssit(file,swfObj);
		}
		return;
	} 
	readDocClass(file,swfObj);
}

function readDocClass(file,swfObj) {
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf(".")).toLowerCase();
	var attId = file.fdTemplateAttId || file.fdId;
	if ($.inArray(fileExt,_reads) > -1) {
		attachmentPreview(swfObj,attId);
	} else if($.inArray(fileExt,_read_downloads) > -1){
		swfObj.openDoc(attId);
	} else if($.inArray(fileExt,_videos) > -1) {
		if (swfObj.editMode == 'view' ) {
			swfObj.startVideo(attId);
		}
	} else if ($.inArray(fileExt,_mp3s) > -1) {
		if (swfObj.editMode == 'view' ) {
			swfObj.startMp3(attId);
		}
	} else {
		//新上传不支持预览的附件，如果已经未生成attMain，则给出预览提示
		if(attId.indexOf("WU_FILE") >=0){
			attachmentPreview(swfObj,attId);
		}else{
			//新上传不支持预览的附件，如果已经生成了attMain，则走下载
			swfObj.openDoc(attId);
		}
	}
}

window.previewEvn.on("editDelete",function(data){
	var fdId = data.file.fdId;
	$("#"+fdId).remove();
	if($("#"+fdId).length > 0){
		attCount --;
		setAttListCount();
	}
});

window.previewEvn.on("uploadSuccess",function(data){
	var swfObj = data.swfObj;
	if(swfObj.addToPreview != "false" && (swfObj.uploadAfterSelect != false || swfObj.uploadAfterSelect != 'false')){
		attCount ++;
		setAttListCount();
		$("#previewAttListFrame").hide();
		var file = data.file;
		var fileIcon = window.GetIconNameByFileName(file.fileName);
		var xtr = $("<tr id='"+file.fdId+"' class='upload_list_tr'></tr>");

		var xtd = $("<td class='upload_list_icon'></td>");
		var xdiv = $("<div style='display: inline-block;min-width:40px'></div>");
		xdiv.append("<img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />");
		xtd.append(xdiv);
		xtr.append(xtd);

		// 默认执行第一个操作按钮的点击事件
		var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
		xtr.append($("<td class='upload_list_filename_view' style='cursor: pointer'>" + file.fileName
						+ "</td>").click(function() {
							if (swfObj.canRead) {
								readDoc(file,swfObj);
								return;
							}
						}));

		var xx = $("<div class='upload_status com_btn_link'>"+Attachment_MessageInfo["button.delete"]+"</div>").click(function(){
			if(file.fileStatus != -1){
				seajs.use(['lui/dialog'], function(dialog) {
					dialog.confirm(""+Attachment_MessageInfo["button.confimdelte"]+"", function(value) {
						if(value) {
							window.previewEvn.emit('previewDelete',{"file":file,"fdKey":swfObj.fdKey});
							attCount --;
							setAttListCount();
						}
					});
				});
			}else{
				$("#"+file.fdId).remove();
			}
		});

		xtr.append($("<td class='upload_list_status'></td>").append(xx));
		if($("#preview_att_xtable_"+swfObj.fdKey).length > 0){
			$("#preview_att_xtable_"+swfObj.fdKey).append(xtr);
		}else{
			var attContaner =  $("<div class='grougDiv' data-group='"+swfObj.fdGroup+"' data-key='"+swfObj.fdKey+"' ></div>");
			var xtable = $("<table style='border:none' id='preview_att_xtable_"+swfObj.fdKey+"'></table>");
			xtable.append(createViewOperation(swfObj,false));
			xtable.append(xtr);
			attContaner.append(xtable);
			$("#previewAttContainer").append(attContaner);
		}
	}
});

function showGroupDivHead(){
	setTimeout(function(){
		var checkboxObj = $("#previewAttContainer").find("input[type='checkbox']");
		if(checkboxObj.length > 0){
			if(!$("#groupDivHead").is(':visible')){
				$("#groupDivHead").show();
			}
		}
	},100);
}

	window.previewEvn.on("beforeShow",function(data){
		if(data && data.fileList && data.fileList.length > 0 && data.addToPreview != "false"){
			try {
				console.log("on-beforeShow");
				showGroupDivHead();
				$("#previewAttListFrame").hide();
				var dataKey = $('[data-key="'+data.fdKey+'"]');
				var attContaner = $('[data-group="'+data.fdGroup+'"]');

				if(attContaner.length == 0 && data.fdViewType=="byte"){
					attContaner = $("<div  class='grougDiv' data-group='"+data.fdGroup+"' data-key='"+data.fdKey+"' ></div>");
				}

				if(data.fdViewType=="byte") {
					if(data.fileList.length > 0){
						var xtable = $("#preview_att_xtable_"+data.fdKey);
						if(xtable.length == 0){
							xtable = $("<table style='border:none' id='preview_att_xtable_"+data.fdKey+"'></table>");
							xtable.append(createViewOperation(data,true));
						}
						//点击附件查看页签展示获取showId
						if ('${wpsoaassist}'=='true' && '${xinChuangWps}' !=='true') {
							for (var i=0;i<data.fileList.length;i++){
								var fileName = data.fileList[i].fileName;
								var fileExt = fileName.substring(fileName.lastIndexOf("."));
								fileExt = fileExt.toLowerCase();
								var attId =  data.fileList[i].fdId;
								if($.inArray(fileExt,_reads) > -1 || fileExt ==".pdf"){
									var viewFlag = queryExistView(attId);
									if(viewFlag =="true"){
										readDocShowId = attId;
										break;
									}
								}
							}
						}else{
							for (var i=0;i<data.fileList.length;i++){
								var fileName = data.fileList[i].fileName;
								var fileExt = fileName.substring(fileName.lastIndexOf("."));
								fileExt = fileExt.toLowerCase();
								var attId =  data.fileList[i].fdId;
								if($.inArray(fileExt,_reads) > -1){
									readDocShowId = attId;
									break;
								}
							}
						}
						if(data.editMode=='view'){
							//查看视图
							for (var i=0;i<data.fileList.length;i++){
								xtable.append(createFileTr(data.fileList[i],"view"));
							}
						}else{
							//编辑视图
							for (var i=0;i<data.fileList.length;i++){
								xtable.append(createFileTr(data.fileList[i],"edit"));
							}
						}
					}
				}
				attContaner.append(xtable);
				$("#previewAttContainer").append(attContaner);

				hasDoneBeforeShow = true;

				function createFileTr(file,type){
					//附件不存在则添加
					if($("#"+file.fdId).length==0){
						attCount ++;
						setAttListCount();
						var fileIcon = window.GetIconNameByFileName(file.fileName);
						var xtr = $("<tr id='"+file.fdId+"' class='upload_list_tr'></tr>");
						if(data.canDownload){
							var xtd = $("<td class='upload_list_icon'></td>");
							var xdiv = $("<div style='display: inline-block;min-width:40px'></div>");
							xdiv.append($("<input type='checkbox' name='List_FilePreview_Selected_" + file.fdId + "' value='" + file.fdId + "'>").click(
									function() {
										data.checkSelected();
									}));
							xdiv.append("<img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' />");
							xtd.append(xdiv);
							xtr.append(xtd);
						}else{
							xtr.append("<td class='upload_list_icon'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;' /></td>");
						}
						var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
						xtr.append($("<td class='upload_list_filename_view' style='cursor: pointer'>" + Com_HtmlEscape(file.fileName)
										+ "</td>").click(function() {
											if (data.canRead) {
												readDoc(file,data);
												switchColourTitle(file.fdId);
												return;
											}
										}));
						if("edit" == type){
							xtr.append($("<td class='upload_list_status'></td>").append(getStatus(file)));
						}
						return xtr;
					}
				}

				function createEditFileTr(file){
					if(file.fileStatus==-1)
						return;
					var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
					var fileIcon = window.GetIconNameByFileName(file.fileName);
					var xtr = $("<tr id='"+file.fdId+"' class='upload_list_tr'></tr>");
					xtr.append("<td class='upload_list_icon'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;' /></td>");
					xtr.append("<td class='upload_list_filename_edit'>"+Com_HtmlEscape(file.fileName)+"</td>");
					//加入操作列
					//xtr.append(createFileOpers(file));
					xtr.append($("<td class='upload_list_status'></td>").append(getStatus(file)));
					return xtr;
				}
				function getStatus(file){
					if(file.fileStatus != 0){//上传成功,失败，错误
						return $("<div class='upload_status com_btn_link'>"+Attachment_MessageInfo["button.delete"]+"</div>").click(function(){
							if(file.fileStatus != -1){
								seajs.use(['lui/dialog'], function(dialog) {
									dialog.confirm(""+Attachment_MessageInfo["button.confimdelte"]+"", function(value) {
										if(value) {
											window.previewEvn.emit('previewDelete',{"file":file,"fdKey":data.fdKey});
											attCount --;
											setAttListCount();
										}
									});
								});
							}else{
								$("#"+file.fdId).remove();
							}
						});
					}else{
						return $("<div class='upload_status com_btn_link'>"+Attachment_MessageInfo["button.cancelAll"]+"</div>").click(function(){
							seajs.use(['lui/dialog'], function(dialog) {
								dialog.confirm(""+Attachment_MessageInfo["button.confirmCancel"]+"", function(value) {
									if(value) {
										file.fileStatus = -1;
										window.previewEvn.emit('previewDelete',{"file":file,"fdKey":data.fdKey});
									}
								});
							});
						});
					}
				}
			} catch (e) {
				console.log(e);
			}
		}
	});
</script>
