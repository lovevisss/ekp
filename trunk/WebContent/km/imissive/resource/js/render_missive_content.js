var self = this;
var _reads = File_EXT_READ.split(";");
var _videos = File_EXT_VIDEO.split(";");
var _mp3s = File_EXT_MP3.split(";");
var _edits = File_EXT_EDIT.split(";");
var _noPrints = File_EXT_NO_PRINT.split(";");
var _noReads = File_EXT_NO_READ.split(";");

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
				xtable.append(createFileOpers(this.fileList[i]));
			}
		}
	}
	// 植入阅读代码
	this._readDoc = this.readDoc;
	this.readDoc = function(docId) {
		if(window.imissiveAttachmentPreview) {
			imissiveAttachmentPreview(this, docId);
		}
	};
}
done(xtable);
/** 查看视图 开始 **/
function createViewOperation(){
	var xtr = $("<tr ></tr>"); 
	var xtd = $("<td colspan='5' class='upload_opt_td'></td>");
	return xtr.append(xtd);
}
function createViewFileTr(file){
	var fileIcon = window.GetIconNameByFileName(file.fileName);
	var xtr = $("<tr id='"+file.fdId+"' class='attachment_list_tr'></tr>");
	xtr.append("<td class='fileicon'><img src='"+Com_Parameter.ResPath+"style/common/fileIcon/"+fileIcon+"' height='16' width='16' border='0' align='absmiddle' style='margin-right:3px;' /></td>");
	// 默认执行第一个操作按钮的点击事件
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
	xtr
			.append($("<td style='cursor: pointer;'><div class='filename'>" + file.fileName+"</div><div class='filesize'>("+self.formatSize(file.fileSize)+")</div>"
					+ "</td>").click(function() {
						if (self.canRead) {
							readDoc(file);
							return;
						}
						
						if (self.canEdit) {
							if ($.inArray(fileExt.toLowerCase(),_edits) > -1) {
								self.editDoc(file.fdId);
								return;
							}
						}
					}));  
	//加入操作列
	//xtr.append("<td style='color:#9e9e9e;text-align:right;padding-top:10px;min-width:80px'>("+self.formatSize(file.fileSize)+")</td>");
	return xtr;
}

function readDoc(file) {
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
	var attId = file.fdTemplateAttId || file.fdId;
	if ($.inArray(fileExt.toLowerCase(),_reads) > -1) {
		self.readDoc(attId);
	} else if($.inArray(fileExt.toLowerCase(),_videos) > -1) {
		if (self.editMode == 'view') {
			self.startVideo(attId);
		}
	} else if ($.inArray(fileExt.toLowerCase(),_mp3s) > -1) {
		if (self.editMode == 'view' ) {
			self.startMp3(attId);
		}
	} else {
		self.openDoc(attId);
	}
}

function createFileOpers(file){	
	var xtr = $("<tr></tr>");
	var fileExt = file.fileName.substring(file.fileName.lastIndexOf("."));
	var xtd = $("<td class='attachment_operation' colspan='2'></td>");
	var attId = file.fdTemplateAttId || file.fdId;
	if (self.canRead) {
		var text = "";
		if ($.inArray(fileExt.toLowerCase(),_reads) > -1){
			text = (Attachment_MessageInfo["button.read"]);
		}else if($.inArray(fileExt.toLowerCase(),_videos) > -1){
			if(self.editMode=='view'){
				text = ""+Attachment_MessageInfo["button.play"]+"";
			} 
		}else if($.inArray(fileExt.toLowerCase(),_mp3s) > -1){
			if(self.editMode=='view' && self.fdModelName=='kmsMultimediaMain'){
				text = ""+Attachment_MessageInfo["button.play"]+"";
			}
		}else{
			text = (Attachment_MessageInfo["button.open"]);
		}
		if ($.inArray(fileExt.toLowerCase(),_noReads) < 0){
			xtd.append($("<div class='upload_opt_view' title='"+text+"'></div>").click(function(){
				readDoc(file);
			}));
		}
	}
	
	if (self.canEdit && !file.fdTemplateAttId) {
		if ($.inArray(fileExt.toLowerCase(),_edits) > -1){
			xtd.append($("<div class='upload_opt_edit' title='"+Attachment_MessageInfo["button.edit"]+"'></div>").click(function(){
				self.editDoc(attId);
			}));
		}
	}
	
	xtr.append(xtd);
	
	return xtr;
}
/** 查看视图 结束 **/