<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%
	pageContext.setAttribute("_isDisplayMode", new String(KmImissiveConfigUtil.getDisplayMode()));
%>
<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
<%--初始化参数--%>
<c:choose>
	<c:when test="${param.formBeanName eq 'kmImissiveSendMainForm'}">
		<c:set var="modelFlag" value="send" />
	</c:when>
	<c:when test="${param.formBeanName eq 'kmImissiveReceiveMainForm'}">
		<c:set var="modelFlag" value="receive" />
	</c:when>
	<c:otherwise>
		<c:set var="modelFlag" value="sign" />
	</c:otherwise>
</c:choose>
<div id="missiveButtonDiv" >
	<c:if test="${empty param.newFlag}">
		<a href="javascript:void(0);" class="attswich"
		   onclick="enableRevisionStart();">
			打开修订
		</a>
		<a href="javascript:void(0);" class="attswich"
		   onclick="enableRevisionEnd();">
			关闭修订
		</a>
		<c:if test="${('true' eq param.redhead || 'true' eq param.cleardraft || 'true' eq param.saveRevisions || 'true' eq param.canEdit || 'true' eq param.editStatus || 'true' eq  param.editDocContent)}">
			<a href="javascript:void(0);" class="attswich"
			   onclick="showRevisionStart();">
				原始修订
			</a>
			<a href="javascript:void(0);" class="attswich"
			   onclick="showRevisionEnd();">
				最终修订
			</a>
			<a href="javascript:void(0);" class="attswich"
			   onclick="acceptAllRevisions();">
				接受所有修订
			</a>
			<a href="javascript:void(0);" class="attswich"
			   onclick="rejectAllRevisions();">
				拒绝所有修订
			</a>
		</c:if>
		<c:choose>
			<c:when test="${param.formBeanName eq 'kmImissiveSendMainForm'}">
				<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include.jsp"></jsp:include>
			</c:when>
			<c:when test="${param.formBeanName eq 'kmImissiveReceiveMainForm'}">
				<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_btn_include.jsp"></jsp:include>
			</c:when>
			<c:otherwise>
				<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_include.jsp"></jsp:include>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if  test="${param.redhead =='true'}">
		<a href="javascript:void(0);" class="attswich"
		   onclick="InsertRedHeadDoc();">
			正文套红
		</a>
	</c:if>
	<c:if  test="${param.cleardraft =='true'}">
		<a href="javascript:void(0);" class="attswich"
		   onclick="cleardraftByWpsOaaXc();">
			清稿
		</a>
	</c:if>
	<c:if  test="${param.saveRevisions =='true'}">
		<a href="javascript:void(0);" class="attswich"
		   onclick="saveRevisionsWpsOa();">
			保存痕迹稿
		</a>
	</c:if>
	<c:if test="${not empty param.newFlag}">
		<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
			<c:param name="formName" value="${param.formBeanName}" />
			<c:param name="fdTemplateId" value="${param.fdTemplateId}" />
		</c:import>
		<a href="javascript:void(0);" class="attbook"
		   onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_${modelFlag}_main/bookMarks.jsp');">
			<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
		</a>
	</c:if>
</div>
<c:choose>
	<c:when test="${'true' eq param.redhead || 'true' eq param.cleardraft || 'true' eq param.saveRevisions || 'true' eq param.canEdit || 'true' eq param.editStatus || not empty param.newFlag}">
		<c:import url="/sys/attachment/sys_att_main/wps/oaassist/linux/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${param.fdKey}" />
			<c:param name="fdModelId" value="${param.fdModelId}" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
			<c:param name="formBeanName" value="${param.formBeanName}" />
			<c:param name="load" value="${param.load}" />
			<c:param name="newFlag" value="${param.newFlag}" />
			<c:param name="contentFlag" value="true"/>
			<c:param name="buttonDiv" value="missiveButtonDiv" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/sys/attachment/sys_att_main/wps/oaassist/linux/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${param.fdKey}" />
			<c:param name="fdModelId" value="${param.fdModelId}" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
			<c:param name="formBeanName" value="${param.formBeanName}" />
			<c:param name="load" value="${param.load}" />
			<c:param name="contentFlag" value="true"/>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript">
	Com_IncludeFile("att_dynamic.js","${KMSS_Parameter_ContextPath}km/imissive/wps/oaassist/","js",true);

	this.count ='0';

	window.onload=function(){
		var beanName = '${param.formBeanName}';
		var _isDisplayMode =  '${_isDisplayMode}';
		console.log(_isDisplayMode);
		if(beanName.indexOf("Template") == '-1' && 'flat' == _isDisplayMode){
			var fdKey = '${param.fdKey}';
			var wpsObject;
			if (fdKey == 'editonline' && wps_linux_editonline){
				wpsObject = wps_linux_editonline;
			}
			if (fdKey == 'mainonline' && wps_linux_mainonline){
				wpsObject = wps_linux_mainonline;
			}
			if(wpsObject) {
				setTimeout(function(){
					queryBook();
				}, 1000);
			}
		}
	}

	window.showWpsXinChuang=function(fdKey){
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			setTimeout(function(){
				wpsObject.load();
				if(this.count =='0'){
					queryBook();
					this.count ='1';
				}
			}, 2000);
		}
	}
	
	function rejectAllRevisions() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			wpsObject.reject();
		}
	}
	
	function acceptAllRevisions() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			wpsObject.accent();
		}
	}
	
	function showRevisionEnd() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			wpsObject.showRevision(2);
		}
	}
	
	function showRevisionStart() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			wpsObject.showRevision(0);
		}
	}
	
	function enableRevisionEnd() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			wpsObject.handleRevision(false);
		}
	}

	function enableRevisionStart() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		if(wpsObject){
			wpsObject.handleRevision(true);
		}
	}

	function cleardraftByWpsOaaXc(){
		dialog.confirm('清稿后，所有的留痕将被强制接受，是否继续？',function(flag){
			if(flag==true){
				var fdKey = '${param.fdKey}';
				var wpsObject;
				if (fdKey == 'editonline' && wps_linux_editonline){
					wpsObject = wps_linux_editonline;
				}
				if (fdKey == 'mainonline' && wps_linux_mainonline){
					wpsObject = wps_linux_mainonline;
				}
				var urlImssive = getHost() + Com_Parameter.ContextPath+'/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do?method=saveClearDraftAtt';
				$.ajax({
					type:"post",
					url:urlImssive,
					data:{"modelId":"${param.fdModelId}","nodevalue":"${param.nodevalue}","fdKey":"${param.fdKey}","fdModelName":"${param.fdModelName}"},
					dataType:"json",
					async:false,
					success:function(data){
						if(data.msg == "true"){
							wpsObject.submit();
							//接受所有修订
							wpsObject.accent();
							//保存
							saveClearDraftAttWps();


						}
					}
				});
			}
		},"warn");
	}
	
	function saveClearDraftAttWps() {
		var urlImssive = getHost() + Com_Parameter.ContextPath+'/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do?method=saveClearDraftInit';
		$.ajax({
			type:"post",
			url:urlImssive,
			data:{"modelId":"${param.fdModelId}","nodevalue":"${param.nodevalue}","fdKey":"${param.fdKey}","fdModelName":"${param.fdModelName}"},
			dataType:"json",
			async:false,
			success:function(data){
				console.log(data.msg);
			}
		});
	}
	
	function saveRevisionsWpsOa() {
		var fdKey = '${param.fdKey}';
		var wpsObject;
		if (fdKey == 'editonline' && wps_linux_editonline){
			wpsObject = wps_linux_editonline;
		}
		if (fdKey == 'mainonline' && wps_linux_mainonline){
			wpsObject = wps_linux_mainonline;
		}
		wpsObject.submit();
		var urlImssive = getHost() + Com_Parameter.ContextPath+'/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do?method=saveClearDraftInit';
		$.ajax({
			type:"post",
			url:urlImssive,
			data:{"modelId":"${param.fdModelId}","nodevalue":"${param.nodevalue}","fdKey":"${param.fdKey}","fdModelName":"${param.fdModelName}"},
			dataType:"json",
			async:false,
			success:function(data){
				var msgFlag = data.msg;
				if(msgFlag!="true"){
					alert("操作失败！");
				}else{
					//接受所有修订
					wpsObject.accent();
					//保存
					wpsObject.submit();
					dialog.alert("保存痕迹稿成功");
					// if (doc.Revisions.Count >= 1) {
					// 	doc.AcceptAllRevisions();
					// }
					// //去除所有批注
					// if (doc.Comments.Count >= 1) {
					// 	doc.RemoveDocumentInformation(wps.Enum.wdRDIComments);
					// }
					//
					// //删除所有ink墨迹对象
					// pDeleteAllInkObj(doc);
					// OnSaveToServerQg();
				}
			}
		});
	}

	function InsertRedHeadDoc(){
		var template = '';
		if('${param.formBeanName}' == 'kmImissiveSignMainForm'){
			template = 'com.landray.kmss.km.imissive.model.KmImissiveSignRedHeadTemplate';
		}else{
			template = 'com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate';
		}
		Dialog_SimpleCategoryForNewFile(template, "createUrl?&fdTemplateId=!{id}&fdTemplateName=!{name}", false, true, "02", function (rtnVal) {
			var selAttId = rtnVal[0].id;
			if (selAttId != null) {
				var book  = '${param.bookMarks}';
				var url=null;
				var bookmark=[];
				var urlRedHead = getHost() + Com_Parameter.ContextPath+'/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do?method=queryRedHeadUrl';
				$.ajax({
					type:"post",
					url:urlRedHead,
					data:{"redId":selAttId,"modelId":"${param.fdModelId}","nodevalue":"${param.nodevalue}","bookMarks":book,"fdKey":"${param.fdKey}","fdModelName":"${param.fdModelName}"},
					dataType:"json",
					async:false,
					success:function(data){
						for ( var i in data) {
							if (data[i].tempUrl!=null && data[i].tempUrl!=undefined && data[i].tempUrl!="") {
								url=data[i].tempUrl;
							}
							if (data[i].bookmark!=null && data[i].bookmark!=undefined && data[i].bookmark!="") {
								bookmark.push(data[i].bookmark);
							}
						}
					}
				});
				if (bookmark!=null && bookmark!=undefined && bookmark!="") {
				}else{
					bookmark = "redhead";
				}
				saveRedAttTracGw();
				insertRedHead(url,bookmark,${param.bookMarks});
			}
		}, true, '<bean:message bundle="km-imissive" key="kmImissiveRedheadset.select"/>');
	}

	//初始化书签
	function queryBook() {
		var bookmark=[];
		var url = getHost() + Com_Parameter.ContextPath+'/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do?method=queryBooksMsg';
		$.ajax({
			type:"post",
			url:url,
			data:{"modelId":"${param.fdModelId}","bookMarks":'${param.bookMarks}',"fdKey":"${param.fdKey}","fdModelName":"${param.fdModelName}"},
			dataType:"json",
			async:false,
			success:function(data){
				for ( var i in data) {
					if (data[i].bookmark!=null && data[i].bookmark!=undefined && data[i].bookmark!="") {
						bookmark.push(data[i].bookmark);
					}
				}
			}
		});
		var book1 = '${param.bookMarks}';
		book1 = JSON.parse(book1);
		//获取这个文档
		var doc = wpsLinuxPluginObj.ActiveDocument;
		//获取这个文档的所有书签
		var bookMarks = doc.Bookmarks;
		for (var key in bookmark) {
			var bookVal = bookmark[key];
			if(bookVal=="redhead"){
				var book= bookMarks.Item(bookVal);
				if(book!=null && book!=undefined){
					book.Range.Select(); //获取指定书签位置
					var s = wpsLinuxPluginObj.ActiveWindow.Selection;
					s.Paste();
				}
			}else{
				var valLeng = bookmark.indexOf(bookVal);
				if("-1" != valLeng){
					var book_ss= bookMarks.Item(bookVal);
					if(book_ss!=null && book_ss!=undefined){
						let bookStart = book_ss.Range.Start;
						let bookEnd = book_ss.Range.End;
						let start = doc.Range().End;
						if(book1[bookVal]!=null && book1[bookVal]!=undefined){
							book_ss.Range.Text=book1[bookVal];
						}
						let end = doc.Range().End;
						if (!bookMarks.Exists(bookVal)){
							var book=bookMarks.Add(bookVal,doc.Range(0,0));
							book.Start=bookStart;
							book.End= bookEnd + (end - start);
						}
					}
				}
			}
		}
	}

	function saveRedAttTracGw() {
		var urlImssive = getHost() + Com_Parameter.ContextPath+'/km/imissive/km_imissive_redhead_template/kmImissiveRedHeadTemplate.do?method=saveRedAttTrac';
		$.ajax({
			type:"post",
			url:urlImssive,
			data:{"modelId":"${param.fdModelId}","nodevalue":"${param.nodevalue}","fdKey":"${param.fdKey}","fdModelName":"${param.fdModelName}"},
			dataType:"json",
			async:false,
			success:function(data){
				console.log(data.msg);
			}
		});
	}

	function getHost(){
		var host = location.protocol.toLowerCase()+"//" + location.hostname;
		if(location.port!='' && location.port!='80'){
			host = host+ ":" + location.port;
		}
		return host;
	}
</script>