<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
<%@ page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmImissiveSendMainForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-imissive:kmImissiveSendMain.create.title') } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmImissiveSendMainForm.docSubject} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<%@ include file="/km/imissive/script.jsp"%>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;" count="6"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
				<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
					<c:choose>
						<%--签收单转发文 --%>
						<c:when test="${not empty fddetaiId or not empty param.fdReceiveId}">
							<ui:button text="${lfn:message('button.savedraft') }" order="2"
								onclick="commitMethod('saveSend','true');">
							</ui:button>
							<ui:button text="${lfn:message('button.submit') }" order="2"
								onclick=" commitMethod('saveSend','false');">
							</ui:button>
						</c:when>
						<c:otherwise>
							<ui:button text="${lfn:message('button.savedraft') }" order="2"
								onclick="commitMethod('save','true');">
							</ui:button>
							<ui:button text="${lfn:message('button.submit') }" order="2"
								onclick=" commitMethod('save','false');">
							</ui:button>
						</c:otherwise>
					</c:choose>

				</c:if>
				<c:if test="${kmImissiveSendMainForm.method_GET=='edit'}">
					<c:if test="${kmImissiveSendMainForm.docStatus=='10'}">
						<ui:button text="${lfn:message('button.savedraft') }" order="2"
							onclick=" commitMethod('update','true');">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus<'20'}">
						<ui:button text="${lfn:message('button.submit') }" order="2"
							onclick=" commitMethod('update','false');">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus=='20'}">
						<ui:button text="${lfn:message('button.submit') }" order="2"
							onclick=" submitOrUpdateDoc(document.kmImissiveSendMainForm, 'update');">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus>='30'}">
						<ui:button text="${lfn:message('button.submit') }" order="2"
							onclick=" submitOrUpdateDoc(document.kmImissiveSendMainForm, 'update');">
						</ui:button>
					</c:if>
				</c:if>
				<%-- 套红附加选项 --%>
				<c:if test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on' }">
					<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
						<ui:button text="${lfn:message('km-imissive:kmImissive.saveRedhead') }"
							order="2" onclick="saveDraft4RedHead();">
						</ui:button>
					</c:if>
					<ui:button text="${lfn:message('km-imissive:kmImissive.redhead') }"
						order="2" onclick="doRedHead();">
					</ui:button>
				</c:if>
				<ui:button text="${ lfn:message('button.close') }" order="5"
					onclick="Com_CloseWindow()">
				</ui:button>
			</ui:toolbar>
		</c:if>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" id="categoryId">
			<ui:menu-item text="${ lfn:message('home.home') }"
				icon="lui_icon_s_home"></ui:menu-item>
			<ui:menu-item
				text="${ lfn:message('km-imissive:module.km.imissive') }"></ui:menu-item>
			<ui:menu-item
				text="${ lfn:message('km-imissive:kmImissive.nav.SendManagement') }"></ui:menu-item>
			<ui:menu-source autoFetch="false">
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&categoryId=${kmImissiveSendMainForm.fdTemplateId}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
	<!-- 软删除配置 -->
	<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
		<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
	</c:import>	
	<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
		<script type="text/javascript">
			window.changeDocTemp = function(modelName,url,canClose){
				if(modelName==null || modelName=='' || url==null || url=='')
					return;
		 		seajs.use(['sys/ui/js/dialog'],function(dialog) {
				 	dialog.categoryForNewFile(modelName,url,false,null,function(rtn) {
						// 无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
						if (!rtn)
							window.close();
					},'${param.categoryId}','_self',canClose);
			 	});
		 	};
		 	
			if('${param.fdTemplateId}'==''){
				window.changeDocTemp('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}&fdModelId=${param.fdModelId}&fdModelName=${param.fdModelName}',true);
			}
		</script>
	</c:if>
	<script type="text/javascript">
	//解决非ie下控件高度问题
		$(document).ready(function(){
			//checkEditType("${kmImissiveSendMainForm.fdNeedContent}", null);
			var obj = document.getElementById("JGWebOffice_editonline");
			if(obj){
				obj.setAttribute("height", "550px");
			}
		});
	</script>
	<script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/base64.js"></script>
    <script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/jquery.min.js"></script>
	<script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/checkwps.js"></script>
    <script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/launchwps.js"></script>
    <script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/wps.js"></script>
    <script>

        var strBookmarkDataPath = "http://dev.wpseco.cn/bookmark/getAllBookmark";
        var templatePath = "http://dev.wpseco.cn/wps-oa/template/paging";
        var docId = "c2de1fcd1d3e4ac0b3cda1392c36c9e2";
        var excelId = "bad28416fa554a2b824caa7874a3f415";
        var pptId = "586bad086e14463ab2bdb0d144b2b177"
        var uploadPath = "http://dev.wpseco.cn/file/upload?id=";
        var fileName = "http://dev.wpseco.cn/file/download/"
        function newDoc() {
            _wps.openDoc({
                "uploadPath": "http://localhost:8080/file/uploadFromWps", //保存文档接口
                "strBookmarkDataPath": strBookmarkDataPath,//书签列表接口
                "templatePath": templatePath,//正文模板列表接口
                "buttonGroups": "",//btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate
                "disableBtns": "ReviewTrackChangesMenu,FileSaveAsMenu,FileSaveAs",
                "suffix": ".ofd",
            })
        }

        function openDoc() {
            _wps.openDoc({
                "docId": "${mobileEditAttId}",
                "fileName":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attdownloadWps.jsp?fdId=${mobileEditAttId}",
                "uploadPath":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attuploadWps.jsp?fdId=${mobileEditAttId}",
                "buttonGroups": "btnOpenRevision,btnShowRevision,btnAcceptAllRevisions,btnRejectAllRevisions",
                "revisionCtrl": {
                    "bOpenRevision": true,
                    "bShowRevision": false
                }
            });
        }

        function protectOpen() {
            _wps.openDoc({
                "docId": docId, //文档ID
                "uploadPath": "http://dev.wpseco.cn/file/place?id=" + docId + "&type=1", //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "buttonGroups": "btnChangeToPDF,btnChangeToUOT,btnChangeToUOF",
                "openType": { //文档打开方式
                    //文档保护类型，-1：不启用保护模式，0：只允许对现有内容进行修订，1：只允许添加批注，2：只允许修改窗体域(禁止拷贝功能)，3：只读
                    "protectType": 3,
                    "password": "123456"
                }
            });
        }

        function revisionCtrlOpen() {
            _wps.openDoc({
                "docId": docId, //文档ID
                "uploadPath": uploadPath + docId, //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "buttonGroups": "btnOpenRevision,btnShowRevision,btnAcceptAllRevisions,btnRejectAllRevisions",
                "userName": 'wangyifei',//用户名
                "revisionCtrl": {
                    "bOpenRevision": true,
                    "bShowRevision": true
                }
            });
        }

        function onlineEdit() {
            _wps.onlineEditDoc({
                "docId": docId, //文档ID
                "uploadPath": uploadPath + docId, //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "strBookmarkDataPath": "123456",//书签列表接口
                "templatePath": "1233456",//正文模板列表接口
                "buttonGroups": "btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate",
                "userName": '王五',//用户名
                "revisionCtrl": {
                    "bOpenRevision": false,
                    "bShowRevision": true
                }
            })
        }

        function fillRedhead() {
            _wps.insertRedHeadDocFromWeb({
                "docId": docId, //文档ID
                "uploadPath": uploadPath + docId, //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "buttonGroups": "btnInsertRedHeader",
            }, "http://dev.wpseco.cn/file/download/b528ce0b140d46879c9c8576ffbc3e98", "Content");//红头模板中填充正文的位置书签名
        }

        function fillTemplate() {
            _wps.openDoc({
                "docId": docId, //文档ID
                "fileName": "http://dev.wpseco.cn/wps-oa/template/getFileData/98",
                "uploadPath": uploadPath + docId, //保存文档接口
            }, [
                    {
                        "fillTemplate": {
                            "dataFromWeb": [{ "name": "FirstTitle", "text": "web" }, {
                                "name": "TopTitle1",
                                "text": "军参谋-web"
                            }, { "name": "TopTitle2", "text": "通信-web" }, {
                                "name": "ContentTitle",
                                "text": "空军内部使用办文助手-web"
                            }, { "name": "Company", "text": "空军参谋部-web" }, {
                                "name": "Contactor",
                                "text": "李四-web"
                            }, {
                                "name": "table_index",
                                "text": ["zhangsan", "18", "nan", "lis", "19", "nan", "wangwu", "20", "nan", "zhaoliu", "21", "nv", "sunqi", "22", "nv"],
                                "type": "table"
                            }],
                            // "dataFromServer": "http://dev.wpseco.cn/wps-oa/document/getData"
                        }
                    },
                    {
                        "closeActiveDocument": {}
                    },
                ])
        }
        function checkwps() {
            checkWPSProtocol(scb, fcb);
        }

        var json = {
            "bookmark": [
                {
                    "type": "gotofield",
                    "docfield": "办公室审签"
                },
                {
                    "type": "insertDocField",
                    "docfield": "标题",
                    "value": "测试文件套红",
                    "attrs": {
                        "fontFamily": "仿宋_GB2312",
                        "fontSize": "12",
                        "maxRow": 1,
                        "maxRowLength": 29,
                        "lastrow": true
                    }
                },
                {
                    "type": "gotofield",
                    "docfield": "处审核"
                },
                {
                    "type": "insertText",
                    "value": "戴纲 2018-11-21  "
                },
                {
                    "type": "insertDocField",
                    "docfield": "电话",
                    "value": "13522115420"
                },
                {
                    "type": "insertDocField",
                    "docfield": "主办单位",
                    "value": "办公室信息档案处  信息档案处"
                },
                {
                    "type": "gotofield",
                    "docfield": "附件名称"
                },
                {
                    "type": "insertDocField",
                    "docfield": "公开范围",
                    "value": "不公开"
                },
                {
                    "type": "gotofield",
                    "docfield": "核稿"
                },
                {
                    "type": "insertDocField",
                    "docfield": "缓急",
                    "value": "普通"
                },
                {
                    "type": "gotofield",
                    "docfield": "领导审核"
                },
                {
                    "type": "insertText",
                    "value": "张柱 2018-11-21  "
                },
                {
                    "type": "insertDocField",
                    "docfield": "拟稿",
                    "value": "史丛"
                },
                {
                    "type": "insertDocField",
                    "docfield": "年度",
                    "value": "〔2018〕"
                },
                {
                    "type": "gotofield",
                    "docfield": "签发"
                },
                {
                    "type": "insertDocField",
                    "docfield": "文件类型",
                    "value": "中气发"
                },
                {
                    "type": "gotofield",
                    "docfield": "局内会签"
                },
                {
                    "type": "insertDocField",
                    "docfield": "主送单位",
                    "value": "人事司、法规司,天津市气象局、北京市气象局",
                    "attrs": {
                        "fontFamily": "仿宋_GB2312",
                        "fontSize": "12",
                        "maxRow": 1,
                        "maxRowLength": 29,
                        "lastrow": true
                    }
                }
            ],
            "downLoadFile": "http://localhost:8082/ezweb/action?PublicOfficeAction=2&mnr=1372567488347545",
            "attrs": {
                "fileName": "中国气象局发文稿纸（新）.doc",
                "canSaveAs": null,
                "readOnly": "false",
                "title": "中国气象局综合办公系统",
                "userName": "康为",
                "funcType": "4"
            }
        }

        function fillTemplate2() {
            // 打开模板
            _wps.openDoc({
                "uploadPath": "http://dev.wpseco.cn/file/uploadFromWps", //保存文档接口
                "fileName": "C:\\1372567488347545.doc", //根据文档id获取服务器文档接口
                "buttonGroups": ""
            }, [
                    {
                        "insertDocumentMarks": {  // 填充数据
                            "dataFromServer": "./naturalResources.json",
                            "dataFromWeb": json.bookmark,
                        }
                    },
                    {
                        "insertWatermark": {   // 插入水印
                            "text": "WPS保密文档"
                        }
                    },
                    {
                        "setOpenType": {   // 设置文档只读
                            "protectType": 3,
                            "password": "123456",
                            "readonly": 1      //1-文档为只读模式，不能编辑。2，文档为只读模式，能编辑，但禁止上传
                        }
                    }
               ]);
        }

        var content = {
            "functions": [{
                "insertBookmarks": {
                    "bookmarks": [
                        {
                            "type": "common",
                            "value": "123",
                            "key": "B0001"
                        },
                        {
                            "type": "macro",
                            "value": "fn_Enter",
                        },
                        {
                            "type": "common",
                            "value": "bbbb",
                        },
                        {
                            "type": "macro",
                            "value": "toRight",
                        },
                        {
                            "type": "file",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\附件1.doc",
                            "key": "正文文件"
                        },

                        {
                            "type": "file",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\附件2.doc"
                        },
                        {
                            "type": "file",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\附件3.doc"
                        },
                        {
                            "type": "file",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\附件4.doc"
                        },
                        {
                            "type": "file",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\附件5.doc"
                        },
                        {
                            "type": "img",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\1.png",
                            "key": "图片"
                        }, {
                            "type": "img",
                            "value": "D:\\金山文档\\8、自然资源部\\梦创双杨\\2.png",
                        }
                    ]
                },
            }
            ],
            "command": {
                "datas": {
                    "fileName": "D:\\金山文档\\8、自然资源部\\梦创双杨\\模板文件.doc",
                    "buttonGroups": "",
                    "docId": "1599858497080853",
                    "uploadPath": "http://localhost:8080/DreamWeb/ctrl/office/wpsUpload?infoId=190226160701nq4AYGBJzbksLoQASwP&fileId=190226163050vaa2jHEHOK6af2L9y5c&moduleId=180622094325aHAq8EaMYvmZyMGdjQx&unitId=180505162656YILYYOzw1FnE5OzzNxm&fileType=2&extension=doc&userId=180627211146fDIBx82HM37tBb4PtOo&deptId=1806272111467Eo6LAam0ISFm6mawTY",
                    "revisionCtrl": {
                        "bOpenRevision": false,
                        "bShowRevision": true
                    },
                    "buttonGroups": "",
                    "userName": "倪国强**"
                },
                "templateMode": "word"
            }
        }, command = content.command || {};

        function runWord(command, functions) { //这个以后统一处理
            _wps.openDoc(command, functions);
        };

        function fillTemplate3() {
            if (command["templateMode"] == "word") {
                runWord(command["datas"], content["functions"] || {});
            }
        }
    </script>
	<%@ include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_editScript.jsp"%>
		<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=save&isWps=true">
			<html:hidden property="docStatus" />
			<html:hidden property="fdId" />
			<html:hidden property="fdDetailId" />
			<html:hidden property="fdMainId" />
			<html:hidden property="fdModelId" />
			<html:hidden property="fdModelName" />
			<html:hidden property="fdReadSendOpinion" />
			<kmss:showWfPropertyValues var="nodevalue"
				idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
			<div class="lui_form_content_frame" style="padding-top: 5px" id="kmImissiveSendXform">
				<c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="messageKey"
						value="km-imissive:kmImissiveSendMain.baseinfo" />
					<c:param name="useTab" value="false" />
				</c:import>
			</div>
			<div class="lui_form_content_frame" style="padding-top: 10px">
				<table class="tb_normal" width="100%">
					<html:hidden property="fdNeedContent" value="1"/>
					
					<tr>
						<td colspan="4">
							<ui:button id="ok_xj" text="编辑正文" order="2"  onclick="openDoc();">
							</ui:button>
						</td>
					</tr>
				</table>
			</div>
			<div class="lui_form_content_frame" style="padding-top: 10px">
				<div style="padding-left:9px;padding-top: 5px;padding-bottom: 15px;">
					<div class="lui_form_subhead">
						<img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">
						${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }
					</div>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="uploadAfterSelect" value="true" />  
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
					</c:import>
				</div>
			</div>
			<ui:tabpage expand="false">
				<!-- 以下代码为嵌入流程模板标签的代码 -->
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="method" value="add" />
				</c:import>
				<!-- 以上代码为嵌入流程模板标签的代码 -->
				<!--发布机制开始-->
				<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="isShow" value="true" />
				</c:import>
				<!--发布机制结束-->
				<!-- 权限机制  -->
				<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
					<table class="tb_normal" width=100%>
						<tr>
							<td class="td_normal_title" width="15%"><bean:message key="kmImissiveSendMain.authAppRecReaderIds" bundle="km-imissive" /></td>
							<td width="85%" colspan='3'>
								<xform:address textarea="true" mulSelect="true" propertyId="authAppRecReaderIds" 	propertyName="authAppRecReaderNames" style="width:97%;height:90px;"></xform:address> <br>
								<span class="com_help">
									<bean:message bundle="sys-right" key="right.read.authReaders.note1" />
								</span>
							</td>
						</tr>
						<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSendMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						</c:import>
					</table>
				</ui:content>
				<!-- 权限机制 -->
			</ui:tabpage>
			<html:hidden property="method_GET" />
		</html:form>
		<script language="JavaScript">
			var validation = $KMSSValidation(document.forms['kmImissiveSendMainForm']);
		</script>
	</template:replace>
	<template:replace name="nav">
		<!-- 关联机制 -->
		<c:import url="/sys/relation/import/sysRelationMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendMainForm" />
		</c:import>
		<!-- 关联机制 -->
	</template:replace>
</template:include>
