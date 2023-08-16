var self = this;
var _reads = File_EXT_READ.split(";");
var _videos = File_EXT_VIDEO.split(";");
var _mp3s = File_EXT_MP3.split(";");
var _edits = File_EXT_EDIT.split(";");
var _noPrints = File_EXT_NO_PRINT.split(";");
var _noReads = File_EXT_NO_READ.split(";");
var _pics = File_EXT_PIC_READ.split(";");
var _read_downloads = File_EXT_READDOWNLOAD.split(";");

var xtable = $("<table style='border:none' id='att_xtable_"+this.fdKey+"'></table>");
if(this.fdViewType.indexOf('missive') > -1) { 
	if(this.editMode=='view'){
		//查看视图
		if(this.fileList.length > 0){
			if(this.fileList.length > 1){
				xtable.append(createViewOperation());
			}
			for (var i=0;i<this.fileList.length;i++){
				xtable.append(createViewFileTr(this.fileList[i]));
			}
		}
	}else{
		//编辑视图
		for (var i=0;i<this.fileList.length;i++){
			xtable.append(createEditFileTr(this.fileList[i]));
		}
	}
	//植入阅读代码
	this._readDoc = this.readDoc;
	this.readDoc = function(docId) {
		if(window.imissiveAttachmentPreview) {
			imissiveAttachmentPreview(this, docId);
		} else {
			this._readDoc.call(this, docId);
		}
	};
}
done(xtable);
/** 查看视图 开始 **/
function createViewOperation(){
	var xtr = $("<tr ></tr>"); 
	var xtd = $("<td colspan='5' class='upload_opt_td'></td>");
	
	xtd.append($("<div><input type='checkbox' name='List_File_Tongle_" + self.fdKey + "'></div>").click(
		function() {
			self.checkAll();
		}));
	
	if (self.canDownload) {
		xtd.append($("<div class='upload_opt_batchdown'>"
				+ Attachment_MessageInfo["button.batchdown"] + "</div>").click(
				function() {
					self.downloadFiiles();
				}));
	}else{
		xtd.css('display','none');
	}
	return xtr.append(xtd);
}

function _canRead(fileExt){
    fileExt = fileExt.toLowerCase();
	if($.inArray(fileExt,_noReads) >= 0){
		return "";
	}
	var text = ""; 
	if ($.inArray(fileExt,_reads) > -1 
		|| $.inArray(fileExt,_pics) > -1 
		|| $.inArray(fileExt,['.txt']) > -1
		|| $.inArray(fileExt,_read_downloads) > -1){
		text = Attachment_MessageInfo["button.read"];
	} else if ($.inArray(fileExt,_videos) > -1 || $.inArray(fileExt,_mp3s) > -1){
		if(self.editMode=='view'){
			text = ""+Attachment_MessageInfo["button.play"]+"";
		} 
	}
	
	return text;
}

function createViewFileTr(file){
	var fileIcon = window.GetIconNameByFileName(file.fileName);
	var xtr = $("<tr id='"+file.fdId+"' class='upload_list_tr'></tr>");
	
	if(self.fileList.length > 1 && self.canDownload){
		var xtd = $("<td class='upload_list_icon'></td>");
		var xdiv = $("<div style='display: inline-block;min-width:40px'></div>");
		//	xtr.append("<td class='upload_list_icon'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;' /></td>");
		xdiv.append($("<input type='checkbox' name='List_File_Selected_" + file.fdId + "' value='" + file.fdId + "'>").click(
				function() {
					self.checkSelected();
				}));
		xdiv.append("<img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;margin-left:3px' /></div></td>");
		xtd.append(xdiv);
		xtr.append(xtd);
	}else{
		xtr.append("<td class='upload_list_icon'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;' /></td>");
	}
	// 默认执行第一个操作按钮的点击事件
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
	xtr
			.append($("<td class='upload_list_filename_view' style='cursor: pointer'>" + file.fileName
					+ "</td>").click(function() {
						if (self.canRead) {
							var text = _canRead(fileExt);
							if(text) {
								readDoc(file);
							}
							return;
						}
						if (self.canDownload) {
							self.downDoc(file.fdId);
							return;
						}
						if (self.canEdit) {
							if ($.inArray(fileExt.toLowerCase(),_edits) > -1) {
								self.editDoc(file.fdId);
								return;
							}
						}
						if (self.canPrint) {
							self.printDoc(file.fdId);
							return;
						}
					}));  
	//加入操作列
	xtr.append("<td class='upload_list_size'>("+self.formatSize(file.fileSize)+")</td>");
	xtr.append(createFileOpers(file));
	if (self.isShowDownloadCount){
		xtr.append("<td class='upload_list_download_count' style='color:#9e9e9e;'>"+Attachment_MessageInfo["show.downloadCount"]+": "+file.fileDownloadCount+"</td>");
	}
	return xtr;
}

function readDoc(file) {
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf(".")).toLowerCase();
	var attId = file.fdTemplateAttId || file.fdId;
	
	if ($.inArray(fileExt,_reads) > -1) {
		self.readDoc(attId);
		// pdf特殊处理下
	} else if($.inArray(fileExt,_read_downloads) > -1){ 
		self.openDoc(attId);
	} else if($.inArray(fileExt,_videos) > -1) {
		if (self.editMode == 'view') {
			self.startVideo(attId);
		}
	} else if ($.inArray(fileExt,_mp3s) > -1) {
		if (self.editMode == 'view' ) {
			self.startMp3(attId);
		}
	} else {
		self.openDoc(attId);
	}
}

function createFileOpers(file){	
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
	var xtd = $("<td class='upload_list_operation'></td>");
	var attId = file.fdTemplateAttId || file.fdId;
	if (self.canRead) {
		var text = _canRead(fileExt);
	
		if (text){
			if(file.fdIsCreateAtt){
				xtd.append($("<div class='upload_opt_view' title='"+text+"'></div>").click(function(){
					readDoc(file);
				}));
			}
		}
	}
	if(!file.isNew){
		if (self.canDownload) {
			xtd.append($("<div class='upload_opt_down' title='"+Attachment_MessageInfo["button.download"]+"'></div>").click(function(){
				self.downDoc(attId);
			}));
		}
		if (self.canEdit && !file.fdTemplateAttId) {
			if ($.inArray(fileExt.toLowerCase(),_edits) > -1){
				xtd.append($("<div class='upload_opt_edit' title='"+Attachment_MessageInfo["button.edit"]+"'></div>").click(function(){
					self.editDoc(attId);
				}));
			}
		}
		if (self.canPrint) {
			if ($.inArray(fileExt.toLowerCase(),_noPrints) < 0){
				if ($.inArray(fileExt.toLowerCase(),_reads) > -1){
					xtd.append($("<div class='upload_opt_print' title='"+Attachment_MessageInfo["button.print"]+"'></div>").click(function(){
						self.printDoc(attId);
					}));
				}
			}
		}
	}

	if (self.canMove) {
		if(self.fdMulti){
			xtd.append($("<div class='upload_opt_move_up' title='"+Attachment_MessageInfo["button.moveup"]+"'></div>").click(function(){
				self.moveUpDoc(attId);
			}));
			xtd.append($("<div class='upload_opt_move_down' title='"+Attachment_MessageInfo["button.movedown"]+"'></div>").click(function(){
				self.moveDownDoc(attId);
			}));
		}
		if(file.fdIsCreateAtt){
			if (typeof(seajs) != 'undefined') {
				xtd.append($("<div class='upload_opt_alter_name' title='"+Attachment_MessageInfo["button.rename"]+"'></div>").click(function(){
					window.alterName(attId,self);
				}));
			}
		}
	}	
	
	return xtd;
}
/** 查看视图 结束 **/



/** 编辑视图 开始 **/
function createEditFileTr(file){
	if(file.fileStatus==-1)
		return;
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
	var fileIcon = window.GetIconNameByFileName(file.fileName);
	var xtr = $("<tr id='"+file.fdId+"' class='upload_list_tr'></tr>");
	xtr.append("<td class='upload_list_icon'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;' /></td>");
	xtr.append("<td class='upload_list_filename_edit'>"+Com_HtmlEscape(file.fileName)+"</td>");  
	xtr.append("<td class='upload_list_progress_img' style='display:none'></td>");
	xtr.append("<td class='upload_list_progress_text' style='display:none'></td>");
	xtr.append("<td class='upload_list_size'>("+self.formatSize(file.fileSize)+")</td>");
	//加入操作列
	xtr.append(createFileOpers(file));
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
							file.fileStatus = -1;
							//$("#"+file.fdId).remove();
							self.delFileList(file.fdId);
							// 编辑状态下删除发送事件
							self.emit('editDelete',{"file":file});
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
							self.uploadObj.cancelFile(file.fdId);
							self.delFileList(file.fdId);
							// 编辑状态下删除发送事件
							self.emit('editDelete',{"file":file});							
						}
					});
				});
		});
	}
}

if(this.editMode=='view'){
	
	//查看时不需要绑定上传时间
}else{
	//this.off();
	this.on("uploadCreate",function(data){
		var file = data.file;
		$('#att_xtable_'+self.fdKey+'').append(createEditFileTr(file));
	});
	this.on("uploadStart", function(data){
		var file = data.file; 
		$("#"+file.fdId).find(".upload_list_progress_img,.upload_list_progress_text").show();
		$("#"+file.fdId).find(".upload_list_size,.upload_list_operation").hide();
		$("#"+file.fdId).find(".upload_list_progress_img").append("<div class='upload_progress_border'><div class='upload_progress_val'></div></div>");
		$("#"+file.fdId).find(".upload_list_progress_text").append("<div class='upload_progress_text'>"+Attachment_MessageInfo["button.progress"]+"0%</div>");
		$("#"+file.fdId).find(".upload_list_status").html(getStatus(file));
	});

	this.on("uploadMD5", function(data){
		var file = data.file; 
		$("#"+file.fdId).find(".upload_progress_text").html(Attachment_MessageInfo['button.md5']);
	});
		
	this.on("uploadProgress", function(data){
		var file = data.file;
		var percent = data.totalPercent;
		if(percent==null){
			var bytesLoaded = data.bytesLoaded;
			var bytesTotal = data.bytesTotal;
			percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		}else{
			percent = Math.ceil(percent*100);
		}
		$("#"+file.fdId).find(".upload_progress_val").css("width", percent + "%");
		$("#"+file.fdId).find(".upload_progress_text").html(Attachment_MessageInfo["button.progress"] + parseInt(percent) + "%");
	});
	this.on("uploadSuccess", function(data){
		var file = data.file;
		var serverData = data.serverData; 
		if(file._fdId != file.fdId){
			$("#"+file._fdId).attr("id",file.fdId);
		}		
		$("#"+file.fdId).find(".upload_list_progress_img,.upload_list_progress_text").hide();
		$("#"+file.fdId).find(".upload_list_size,.upload_list_operation").show();
		$("#"+file.fdId).find(".upload_list_operation").empty();
		var read="";
		var moveup = "";
		var movedown = "";
		var alterName = "";
		if(data.uploadAfterSelect){
			read = $("<div class='upload_opt_view' title='"+Attachment_MessageInfo["button.read"]+"'></div>").click(function(){
					readDoc(file);
			});
		}
		if (self.canMove) {
			if(self.fdMulti){
				moveup = $("<div class='upload_opt_move_up' title='"+Attachment_MessageInfo["button.moveup"]+"'></div>").click(function(){
					self.moveUpDoc(file.fdId);
				});
				movedown = $("<div class='upload_opt_move_down' title='"+Attachment_MessageInfo["button.movedown"]+"'></div>").click(function(){
					self.moveDownDoc(file.fdId);
				});
			}
		}
		if(data.uploadAfterSelect){
			if (typeof(seajs) != 'undefined') {
				alterName = $("<div class='upload_opt_alter_name' title='"+Attachment_MessageInfo["button.rename"]+"'></div>").click(function(){
					window.alterName(file.fdId,self);
				});
			}
		}
		
		var sucess = "<div style='vertical-align:top;height:25px;line-height:25px;'>"+Attachment_MessageInfo["msg.uploadSucess"]+"</div>";
		//$("#"+file.fdId).find(".upload_list_operation").html(read + moveup + movedown + alterName + sucess);
		$("#"+file.fdId).find(".upload_list_operation").append(read).append(moveup).append(movedown).append(alterName).append(sucess);
		$("#"+file.fdId).find(".upload_list_status").html(getStatus(file));
	});
	this.on("uploadFaied", function(data){
		var file = data.file;
		var serverData = data.serverData;	
		$("#"+file.fdId).find(".upload_list_progress_img,.upload_list_progress_text").hide();
		$("#"+file.fdId).find(".upload_list_size,.upload_list_operation").show();
		$("#"+file.fdId).find(".upload_list_operation").empty();
		$("#"+file.fdId).find(".upload_list_operation").html(Attachment_MessageInfo["msg.uploadFail"]);
		file.fileStatus = -1;
		$("#"+file.fdId).find(".upload_list_status").html(getStatus(file));
		alert(serverData);
	});
	
	this.on("error", function(data){
		var file = data.file;
		var serverData = data.serverData;	
		if("Q_EXCEED_SIZE_LIMIT"==serverData){
		    $("#"+file.fdId).remove();
			alert(Attachment_MessageInfo["error.exceedMaxSize"].replace("{0}", self.totalMaxSize+'MB'));
		}
		else if("Q_EXCEED_NUM_LIMIT"==serverData){
		   $("#"+file.fdId).remove();
		   alert(Attachment_MessageInfo["error.exceedNumber"].replace("{0}", data.max+"个"));
		}
		else if("F_EXCEED_SIZE"==serverData){
		    $("#"+file.fdId).remove();
			alert(Attachment_MessageInfo["error.smallMaxSize"].replace("{0}",self.singleMaxSize+' MB'));
		}
		else{
		    $("#"+file.fdId).remove();
			alert(Attachment_MessageInfo["error.enabledFileType"].replace("{0}", self.enabledFileType));
		}
			
		});
	this.on("uploadError", function(data){
		var file = data.file;
		var errorCode = data.errorCode;
		var message = data.message;
		$("#"+file.fdId).find(".upload_list_progress_img,.upload_list_progress_text").hide();
		$("#"+file.fdId).find(".upload_list_size,.upload_list_operation").show();
		$("#"+file.fdId).find(".upload_list_operation").empty();
		if(errorCode == -280){
			$("#"+file.fdId).find(".upload_list_operation").html(Attachment_MessageInfo["button.cancelupload"]);
		}else{
			$("#"+file.fdId).find(".upload_list_operation").html(Attachment_MessageInfo["msg.uploadFail"]);
		}
		$("#"+file.fdId).find(".upload_list_status").html(getStatus(file));
		file.fileStatus = -1;
		//alert($("#"+file.fdId).find(".upload_list_operation").html());
	});
}