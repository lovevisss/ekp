<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>

<c:set var="editStatus" value="view" />
<c:if test="${isFeedBackDeadline eq false}">
	<c:set var="editStatus" value="edit" />
</c:if>

<script type="text/javascript">Com_IncludeFile("doclist.js");</script>
<input type="hidden"  id="fdSelectedAgendaIds">
<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DetailList">
	<tr data-dojo-type="mui/form/Template"  KMSS_IsReferRow="1" style="display:none;" border='0' class="feedback-content feedback-sign-status-edit">
		<td class="detail_wrap_td">
			<table class="muiSimple">
				<tr celltr-title="true">
					<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
						<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
						<span class="index feedback-topic-index" onclick="expandRow(this);" style="color: #4285F4;">
							回执 !{index}
						</span>
						<span class="detailTitle" onclick="expandRow(this);">
						</span>
						<xform:editShow>
							<div class="muiDetailTableDel" onclick="deleteRow(this);" style="color: #4285F4;">
								<bean:message key="button.delete" />
							</div>
						</xform:editShow>
					</td>
				</tr>
				<!-- 参会单位 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						${lfn:message('km-imeeting:kmImeetingMainFeedback.attendUnit')}
					</td>
					<td>
						<div class="meetingRightBox">
							<span class="td_subject">
								<c:out value="${kmImeetingMainFeedbackForm.fdUnitName}"></c:out>
							</span>
						</div>
						<input name="fdDetailForms[!{index}].fdUnitId" value="${kmImeetingMainFeedbackForm.fdUnitId}" type="hidden">
						<input name="fdDetailForms[!{index}].fdUnitName" value="${kmImeetingMainFeedbackForm.fdUnitName}" type="hidden">
					</td>
				</tr>
				<!-- 选择议题 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						${lfn:message('km-imeeting:mobile.selectTopic')}
					</td>
					<td>
						<div class="muiAddressForm feedbackTopicBox">
							<input type="hidden" name="fdDetailForms[!{index}].fdAgendaNames" id="fdDetailAgendaNames_!{index}" class="fdDetailAgendaNames">
							<div id="fdTopicName_!{index}"></div>
							<c:if test="${editStatus eq 'edit'}">
								<div class="muiCategoryAdd fontmuis muis-new muiNewAdd selectButton"  onclick="selectTopic(this, '!{index}')"></div>
							</c:if>
							<div  class="fdAgendaIdsBox">
								<xform:text property="fdDetailForms[!{index}].fdAgendaIds"   className="fdAgendaIdsClass fdDetailAgendaIds_!{index}"   showStatus="edit" mobile="true" subject="议题" required="true"></xform:text>
								<c:if test="${editStatus eq 'edit'}">
									<div class="feedbackTopicRequired">*</div>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
				<!-- 参会人 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						<bean:message key="mobile.attendPerson" bundle="km-imeeting"/>
					</td>
					<td>
						<xform:address
							showStatus="${editStatus}"
							propertyName="fdDetailForms[!{index}].docAttendName"
							propertyId="fdDetailForms[!{index}].docAttendId"
							orgType="ORG_TYPE_PERSON"
							subject="${lfn:message('km-imeeting:mobile.attendPerson')}"
							mobile="true"
							onValueChange="changeAttend(this, !{index});"
							required="true" />
					</td>
				</tr>
				<!-- 职务 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						职务
					</td>
					<td>
						<div class="meetingRightBox">
							<span id="fdStaffingLevelIdSpan_!{index}"></span>
						</div>
						<input name="fdDetailForms[!{index}].fdStaffingLevelId" type="hidden" >
					</td>
				</tr>
				<!-- 手机号 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						<bean:message key="mobile.mobileNum" bundle="km-imeeting"/>
					</td>
					<td>
						<xform:text property="fdDetailForms[!{index}].fdMobileNo" subject="手机号" validators="phoneNumber" required="true" mobile="true"  showStatus="${editStatus}"/>
					</td>
				</tr>
				<!-- 回执结果 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						<bean:message key="mobile.feedbackResult" bundle="km-imeeting"/>
					</td>
					<td>
						<xform:select property="fdDetailForms[!{index}].fdOperateType" showPleaseSelect="false" mobile="true" showStatus="${editStatus}" required="true" subject="回执结果">
							<xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type" />
						</xform:select>
					</td>
				</tr>
				<!-- 回执备注 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						${lfn:message('km-imeeting:mobile.feedbackDesc')}
					</td>
					<td>
						<xform:textarea property="fdDetailForms[!{index}].fdReason" style="width:95%" mobile="true" subject="回执备注" showStatus="${editStatus}" htmlElementProperties="class='fdReasonBox'"/>
					</td>
				</tr>
				<!-- 请假附件 -->
				<tr data-celltr="true">
					<td class="muiTitle">
						${lfn:message('km-imeeting:mobile.feedbackAtt')}
					</td>
					<td>
						<c:if test="${editStatus eq 'edit'}">
						    <c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
						    	<c:param name="dtable" value="true" />
						    	<c:param name="dTableType" value="nonxform" />
								<c:param name="fdAttType" value="byte" />
								<c:param name="fdMulti" value="true" />
								<c:param name="fdShowMsg" value="true" />
								<c:param name="fdInDetail" value="true" />
								<c:param name="fdKey" value="TABLE_DetailList.fdLeaveAttKey" />
								<c:param name="fdFiledName" value="fdDetailForms[!{index}].fdLeaveAttKey" />
								<c:param name="formBeanName" value="kmImeetingMainFeedbackForm" />
								<c:param name="formName" value="kmImeetingMainFeedbackForm" />
								<c:param name="formListAttribute" value="fdDetailForms" />
								<c:param name="idx" value="!{index}" />
								<c:param name="fdName" value="TABLE_DetailList.!{index}.fdLeaveAttKey" />
							</c:import>
						</c:if>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<c:forEach items="${kmImeetingMainFeedbackForm.fdDetailForms}" var="fdDetailForm" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" data-celltr="true" class="feedback-content">
			<td class="detail_wrap_td">
				<table class="muiSimple">
					<tr celltr-title="true">
						<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
							<div class="muiDetailDisplayOpt muiDetailDown"   onclick="expandRow(this);"></div>
							<span class="index feedback-topic-index" onclick="expandRow(this);" style="color: #4285F4;">
								回执 ${vstatus.index+1}
							</span>
							<span class="detailTitle" onclick="expandRow(this);">
							</span>
						</td>
					</tr>

					<!-- 参会单位 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:kmImeetingMainFeedback.attendUnit')}
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdId" value="${fdDetailForm.fdId}">
							<input type="hidden" name="fdDetailForms[${vstatus.index}].docCreatorId" value="${fdDetailForm.docCreatorId}">
							<html:hidden property="fdDetailForms[${vstatus.index}].fdUnitId" value="${kmImeetingMainFeedbackForm.fdUnitId}"/>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdUnitName" value="${fdDetailForm.fdUnitName}">
							<c:out value="${kmImeetingMainFeedbackForm.fdUnitName}"></c:out>
						</td>
					</tr>
					<!-- 选择议题 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:mobile.selectTopic')}
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdAgendaIds" value="${fdDetailForm.fdAgendaIds}">
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdAgendaNames" value="${fdDetailForm.fdAgendaNames}" id="detailTopicNames">
							<c:out value="${fdDetailForm.fdAgendaNames}"></c:out>
						</td>
					</tr>
					<!-- 参会人 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:mobile.attendPerson')}
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].docAttendId" value="${fdDetailForm.docAttendId}">
							<xform:address propertyName="fdDetailForms[${vstatus.index}].docAttendName"
								propertyId="fdDetailForms[${vstatus.index}].docAttendId"
								orgType="ORG_TYPE_PERSON"
								onValueChange="changeAttend(this, ${vstatus.index});"
								showStatus="view"
								mobile="true"/>
						</td>
					</tr>
					<!-- 职务 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							职务
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdStaffingLevelId" value="${fdDetailForm.fdStaffingLevelId}">
							<span id="fdDetailForms[${vstatus.index}].fdStaffingLevelSpan">${fdDetailForm.fdStaffingLevelName}</span>
						</td>
					</tr>
					<!-- 手机号 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:mobile.mobileNum')}
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdMobileNo" value="${fdDetailForm.fdMobileNo}">
							<xform:text property="fdDetailForms[${vstatus.index}].fdMobileNo" showStatus="view" mobile="true"/>
						</td>
					</tr>
					<!--回执结果 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							<bean:message key="mobile.feedbackResult" bundle="km-imeeting"/>
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdOperateType" value="${fdDetailForm.fdOperateType}">
							<xform:select property="fdDetailForms[${vstatus.index}].fdOperateType" showPleaseSelect="false" showStatus="view" mobile="true">
								<xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type" />
							</xform:select>
						</td>
					</tr>
					<!-- 回执备注 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:mobile.feedbackDesc')}
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdReason" value="${fdDetailForm.fdReason}">
							<xform:textarea property="fdDetailForms[${vstatus.index}].fdReason" style="width:98%" showStatus="view" mobile="true" />
						</td>
					</tr>
					<!-- 请假附件 -->
					<tr data-celltr="true">
						<td class="muiTitle">
							${lfn:message('km-imeeting:mobile.feedbackAtt')}
						</td>
						<td>
							<input type="hidden" name="fdDetailForms[${vstatus.index}].fdLeaveAttKey" value="${fdDetailForm.fdLeaveAttKey}">
						    <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						    	<c:param name="dtable" value="true" />
						    	<c:param name="dTableType" value="nonxform" />
								<c:param name="fdAttType" value="byte" />
								<c:param name="fdMulti" value="true" />
								<c:param name="fdShowMsg" value="true" />
								<c:param name="fdInDetail" value="true" />
								<c:param name="fdKey" value="TABLE_DetailList.fdLeaveAttKey" />
								<c:param name="fdImgHtmlProperty" />
								<c:param name="fdFiledName" value="TABLE_DetailList.${vstatus.index}.fdLeaveAttKey" />
								<c:param name="formBeanName" value="kmImeetingMainFeedbackForm" />
								<c:param name="formName" value="kmImeetingMainFeedbackForm" />
								<c:param name="formListAttribute" value="fdDetailForms" />
								<c:param name="idx" value="${vstatus.index}" />
							</c:import>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</c:forEach>
</table>

<c:if test="${isFeedBackDeadline == false  && fdIsShowOperateBtn eq 'true'}">
	<div id="feedbackSignButton" onclick="addRow(true)">
		+ <bean:message bundle="km-imeeting" key="kmImeetingAgenda.operation.addDetailTopic.mobile"/>
	</div>
</c:if>
<script type="text/javascript">DocList_Info.push('TABLE_DetailList');</script>
<script type="text/javascript">DocListFunc_Init();</script>
<script type="text/javascript">
	require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'mui/util',
			'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', 'dojo/parser', 'mui/pageLoading', 'mui/commondialog/DialogSelector'],
		function(ready, registry, topic, request, dom, domAttr, domStyle, util, domClass, query, Tip, parser, pageLoading, DialogSelector) {

		var fdAgendaIds =  "${kmImeetingMainFeedbackForm.fdAgendaIds}";  // 回执中所需要报名的议题Id
		var selectedAgendaIds = "";   // 已选择的议题Id
		var agendaIdArray = fdAgendaIds.split(";"); // 所有待选议题的数组

		var selectedArray = new Array(); // 已选择议题的数组


		window.onload = function () {

		}

		ready(function () {
			if(DocList_TableInfo['TABLE_DetailList'] == null) {
				DocListFunc_Init();
			}
			setTimeout(function () {
				getSelectedAgendaIdsAndCount();
				var detailRows = $('#TABLE_DetailList').find('.muiDetailTableNo');
				if (detailRows.length < 1) {
					addRow(false);
				}
			}, 300)
		});

		window.detail_fixNo = function() {
			$('#TABLE_DetailList').find('.muiDetailTableNo').each(function(i) {
				$(this).children('.index').text("回执 " + (i + 1));
			});
		};

		/* window.deleteRow = function (domNode) {
			var td = $(domNode).closest('.detail_wrap_td')[0];
			debugger;
			DocList_DeleteRow_ClearLast(td.parentNode);
			topic.publish("/mui/list/resize",td.parentNode);
			getSelectedAgendaIdsAndCount();
			detail_fixNo();
		}; */

		window.deleteRow = function(domNode) {
			var detailRows = $('#TABLE_DetailList').find('.muiDetailTableNo');
			if (detailRows.length <= 1) {
				var msg = "请至少填写一份报名信息！";
				Tip.tip({text:msg, icon:'mui mui-warn'});
			} else {
				var td = $(domNode).closest('.detail_wrap_td')[0];
				/* DocList_DeleteRow(td.parentNode); */
				DocList_DeleteRow_ClearLast(td.parentNode);
				topic.publish('/mui/form/valueChanged');
				topic.publish("/mui/list/resize",td.parentNode);
				getSelectedAgendaIdsAndCount();
				detail_fixNo();
			}
		};

		window.expandRow = function(domNode) {
			var domTable = $(domNode).closest('table')[0];
			var display = domAttr.get(domTable,'data-display'),
				newdisplay = (display == 'none' ? '' : 'none');
			domAttr.set(domTable,'data-display',newdisplay);
			var items = query('tr[data-celltr="true"],tr[statistic-celltr="true"]',domTable);
			for (var i = 0; i < items.length; i++) {
				if (newdisplay == 'none') {
					domStyle.set(items[i],'display','none');
				}else{
					domStyle.set(items[i],'display','');
				}
			}
			var opt = query('.muiDetailDisplayOpt',domTable)[0];
			var del = query('.muiDetailTableDel',domTable)[0];
			var title = query('.fdDetailAgendaNames',domTable)[0];
			if(newdisplay == 'none'){
				domClass.add(opt,'muiDetailUp');
				domClass.remove(opt,'muiDetailDown');
                if (del) {
                    domStyle.set(del, 'display','none');
                }
				if (title) {
					query('.detailTitle', domTable).html(title.value);
				}
			}else{
				domClass.add(opt,'muiDetailDown');
				domClass.remove(opt,'muiDetailUp');
                if (del) {
                    domStyle.set(del, 'display', '');
                }
				query('.detailTitle', domTable).html('');
			}
		};

		window.addRow = function (showTip, callbackFn) {
			// 如果所需要报名的议题已经选完，则无法添加row
			if (agendaIdArray.length <= selectedArray.length) {
				if (showTip) {
					var msg = '<bean:message bundle="km-imeeting" key="mobile.tips.signTopic"/>';
					Tip.tip({text:msg, icon:'mui mui-warn'});
				}
				return;
			}

			// 添加一行并返回新加的tr
			var newRow = DocList_AddRow("TABLE_DetailList");

			// dojo解析组件
			newRow.dojoClick = true;
			parser.parse(newRow).then(function(){
				var tabInfo = DocList_TableInfo["TABLE_DetailList"];
				if(tabInfo['_getcols']== null){
					tabInfo.fieldNames=[];
					tabInfo.fieldFormatNames=[];
					DocListFunc_AddReferFields(tabInfo, newRow, "INPUT");
					DocListFunc_AddReferFields(tabInfo, newRow, "TEXTAREA");
					DocListFunc_AddReferFields(tabInfo, newRow, "SELECT");
					tabInfo['_getcols'] = 1;
				}

				// 修正明细表前的索引序号
				detail_fixNo();

				// 重新调整容器高度
				topic.publish("/mui/list/resize",newRow);

				// 回调
				if(typeof callbackFn === 'function' && callbackFn()) {
					callbackFn(newRow);
				}
			});

		};

		window.selectTopic = function(domNode, index) {

			// 当前回执已选的agendaName
			var curNodeAgendaNames =  query("[name='fdDetailForms[" + index + "].fdAgendaNames']").val();

			// 当前回执已选的agendaId
			var curNodeAgendaIds =  query("[name='fdDetailForms[" + index + "].fdAgendaIds']").val();
			var curNodeAgendaIdArr = new Array();

			// 其他回执已选择的agendaId
			var otherSeAgendaIds = selectedAgendaIds;

			// 重新编辑当前的回执，可以看见之前所选的议题
			if (curNodeAgendaIds) {
				curNodeAgendaIdArr = curNodeAgendaIds.split(";");
				for (var i = 0; i < curNodeAgendaIdArr.length; i++) {
					var id = curNodeAgendaIdArr[i];
					if (otherSeAgendaIds.indexOf(id) > -1) {
						otherSeAgendaIds = otherSeAgendaIds.replace(id, "");
					}
				}
			}

			var fdTopicUrl = "/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=getTopicInfo"
						+ "&fdAgendaIds=${kmImeetingMainFeedbackForm.fdAgendaIds}&fdSelectedAgendaIds=" + otherSeAgendaIds;

			DialogSelector.select({
				isMul: true,
				key : '____topicSelect' + index, // 对外发布事件的唯一标识，加索引防止其触发所有明细的回调
				dataURL : fdTopicUrl,
				curIds : curNodeAgendaIds,
				curNames : curNodeAgendaNames,
				modelName:'com.landray.kmss.km.imeeting.model.KmImeetingTopic',
				callback : function(evt) {
					query("[name='fdDetailForms[" + index + "].fdAgendaIds']").val(evt.curIds);
					query("[name='fdDetailForms[" + index + "].fdAgendaNames']").val(evt.curNames);
					query("[id='fdTopicName_" + index + "']").innerHTML(evt.curNames);
					getSelectedAgendaIdsAndCount();
				}
			})
		};

		/**
		 * 议题选择弹出框下方展示已内容调整
		 */
		topic.subscribe('/mui/category/selChanged', function (dialog) {
			if (!dialog || dialog.key !== '____topicSelect0') {
				return;
			}
			let itemsWith = dialog.rightArea.offsetWidth / 2;
			let xPos = 0;
			query('.muiCateSecItems .muiCateSecItem').forEach(function (item, index) {
				itemsWith += item.offsetWidth;
				if (dialog.cateSelArr.length > 2 && index > 0) {
					if (index < dialog.cateSelArr.length - 1) {
						xPos += item.offsetWidth;
					}
				}
			});
			if (dialog.cateSelArr.length > 1) {
				xPos += 10;
			}
			domStyle.set(dialog.itemContainer, {'width': itemsWith.toString() + 'px'});
			dialog.view.scrollTo({y: 0, x: -xPos});
		});

		// 记录已选择的议题的Id和已选择议题的个数
		function getSelectedAgendaIdsAndCount() {
			selectedArray = new Array();
			selectedAgendaIds = "";
			var optTB = document.getElementById("TABLE_DetailList");
			var tbInfo = DocList_TableInfo[optTB.id];
			var feedbackIndex = tbInfo.lastIndex;
			for (var i = 0; i < feedbackIndex; i++) {
				var rowAgendaIds = query("input[name='fdDetailForms[" + i + "].fdAgendaIds']").val();
				var rowAgendaArr = rowAgendaIds.split(";");
				//
				if (rowAgendaArr.length == 1 && !rowAgendaArr[0]) {
					continue;
				}
				selectedAgendaIds += rowAgendaIds + ";";
				for (var j = 0; j < rowAgendaArr.length; j++) {
					selectedArray.push(rowAgendaArr[j]);
				}
			}
		}

		window.changeAttend = function(node, index) {
			if (node.value) {

				// 获取职务 和 手机号
				getPostInfo(node.value, index);

				// 电话号码
				data = new KMSSData();
	        	data.AddBeanData("kmImeetingFeedbackService&type=mobile&attendId="+node.value);
		    	data.PutToField("fdMobileNo","fdDetailForms["+index+"].fdMobileNo","",false);
			} else {
				query("[name='fdDetailForms[" + index + "].fdStaffingLevelId']").val("");
				query("#fdStaffingLevelIdSpan_" + index).text("");
				data = new KMSSData();
		    	data.PutToField("fdMobileNo","fdDetailForms["+index+"].fdMobileNo","",false);
			}
		}

		function getPostInfo(attendId, detailIndex) {
			var getPostUrl = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=getPostInfo";

			request(util.formatUrl("/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=getPostInfo"), {
				method : 'post', // dojo这里命名为method好奇怪
				data : {
					"attendId" : attendId
				}
			}).then(function(data) {
				dataJson = eval('(' + data + ')');
				query("[name='fdDetailForms[" + detailIndex + "].fdStaffingLevelId']").val(dataJson.fdId);
				query("#fdStaffingLevelIdSpan_" + detailIndex).text(dataJson.fdName);
			});

		}

	})
</script>