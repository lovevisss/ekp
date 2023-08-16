define([ "dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
		"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
		 "mui/util", "mui/list/item/_ListLinkItemMixin", "mui/i18n/i18n!km-imeeting:mobile"],
		function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase,
				util, _ListLinkItemMixin, msg) {
			var item = declare("km.imeeting.mobile.resource.js.MeetingItemMixin", [ ItemBase, _ListLinkItemMixin], {

				// 标题
				label : '',
				
				status : '',
				
				meetingStatus: '',
				
				// 标签默认样式
				tagClass : 'kmImeetingIndexItemTag',
				
				// 创建时间
				created : '',
				
				// 创建者
				creator : '',
				
				// 创建时间
				holdTime : '',
				
				// 结束时间
				endTime : '',
				
				tag : 'li',
				
				buildTag : function (domNode) {
					
					if(domNode && this.tagType == "drafed") {
						domConstruct.create('span', {
							className : this.getMeetingStatusClassName(this.meetingStatus),
							innerHTML : this.tagType == 'coming' ? msg['mobile.comingImeeting'] : this.status
						}, domNode);
					}
				},

				buildRendering : function() {
					this._templated = !!this.templateString;
					if (!this._templated) {
						this.domNode = this.containerNode = this.srcNodeRef || domConstruct.create(this.tag, {
							className : 'kmImeetingIndexItem kmImeetingIndexItemCard'
						});
					}
					this.inherited(arguments);

					this.buildInternalRender();

				},

				buildLabel : function () {

					// 应该不存在没有标题的情况吧？
					if(this.label) {
						
						this.muiTextItemTitle = domConstruct.create('div', {
							className : 'muiTextItemTitle muiFontSizeM kmImeetingIndexItemTitle'
						}, this.domNode);

						this.buildTag(this.muiTextItemTitle);
						
						this.muiTextItemTitle.innerHTML = this.muiTextItemTitle.innerHTML + this.label;
						
					}
					
				},
				
				buildStatus : function () {
					if (this.status) {
						
					}
				},
				
				buildMessage : function () {
					
					this.messageDomNode = domConstruct.create('ul', {
						className : 'muiTextItemInfo'
					});
					
					this.buildHoldTime();

					this.buildEndTime();
					
					if(this.buildMessage)
						domConstruct.place(this.messageDomNode, this.domNode, 'last');
					
				},
				
				buildHoldTime : function () {

					if(this.holdTime){
						
						var holdTimeNode = domConstruct.create('div',{
							className : 'kmImeetingIndexItemHTime'
						}, this.messageDomNode);
						
						domConstruct.create('div', {
							className:'itemHoldTimeTitle',
							innerHTML : '开始时间'
						}, holdTimeNode);
						
						domConstruct.create('span', {
							className : 'meetingHoldTime',
							innerHTML : this.getDateTimeMessage(this.holdTime, "HH:mm")
						}, holdTimeNode);
						
						domConstruct.create('span', {
							className : 'meetingHoldDate',
							innerHTML : this.getDateTimeMessage(this.holdTime, "MM:dd:D")
						}, holdTimeNode);
						
						this.buildMessage = true;
					}
				},
				
				buildEndTime : function () {

					if(this.endTime){
						
						var isCrossDays = this.checkIsCrossDays();
						
						var holdTimeNode = domConstruct.create('div',{
							className : 'kmImeetingIndexItemETime'
						}, this.messageDomNode);
						
						domConstruct.create('div', {
							className:'itemEndTimeTitle',
							innerHTML : '结束时间'
						}, holdTimeNode);
						
						var meetingEndTime = domConstruct.create('span', {
							className : 'meetingEndTime',
							innerHTML : this.getDateTimeMessage(this.endTime, "HH:mm")
						}, holdTimeNode);
						
						if (isCrossDays) {
							domConstruct.create('span', {
								className : 'meetingCrossDaysPlus',
								innerHTML : "+"
							}, meetingEndTime);
							
							domConstruct.create('span', {
								className : 'meetingCrossDaysCounts',
								innerHTML :  isCrossDays + "天"
							}, meetingEndTime);
						}
						
						domConstruct.create('span', {
							className : 'meetingEndDate',
							innerHTML : this.getDateTimeMessage(this.endTime, "MM:dd:D")
						}, holdTimeNode);
						
						this.buildMessage = true;
					}
					
				},
				
				buildInternalRender : function() {
					
					if (this.href) {
						this.makeLinkNode(this.domNode);
					}

					this.buildLabel();
					
					this.buildMessage();
					
				},
				
				getMeetingStatusClassName : function(meetingStatus) {
					
					if ("00" == meetingStatus) {
						
						return "kmImeetingStatusDiscard";
						
					} else if ("10" == meetingStatus) {
						
						return "kmImeetingStatusDraft";
						
					} else if ("11" == meetingStatus) {
						
						return "kmImeetingStatusRefuse";
						
					} else if ("20" == meetingStatus) {
						
						return "kmImeetingStatusExamine";
						
					} else if ("unHold" == meetingStatus) {
						
						return "kmImeetingStatusUnhold";
						
					} else if ("holding" == meetingStatus) {
						
						return "kmImeetingStatusHolding";
						
					} else if ("holded" == meetingStatus) {
						
						return "kmImeetingStatusHolded";
						
					} else if ("cancel" == meetingStatus) {
						
						return "kmImeetingStatusCancel";
						
					}
				},
				
				getDateTimeMessage: function(timeStr, type) {
					var fdTime = util.parseDate(timeStr, "yyyy-MM-dd HH:mm");
					
					// 小时分钟
					if ("HH:mm" == type) {
						
						// 小时
						var hour =  fdTime.getHours() < 10 ? "0" + fdTime.getHours() : fdTime.getHours();
						
						// 分钟
						var min = fdTime.getMinutes() < 10 ? "0" + fdTime.getMinutes() : fdTime.getMinutes();
						
						return hour + ":" + min;
					}
					
					// 月份日期带周几
					if ("MM:dd:D" == type) {
						
						var week = new Array("周日", "周一", "周二", "周三", "周四", "周五", "周六");
						
						// 月份
						var month = fdTime.getMonth();
						
						// 号
						var date = fdTime.getDate();
						
						// 礼拜几
						var day = fdTime.getDay();
						
						return "/ " + (month + 1) + "月" + date + "号" + " " + week[day];
					}
				},
				
				checkIsCrossDays : function () {
					var fdHoldDate = util.parseDate(this.holdTime, "yyyy-MM-dd").getTime();
					var fdEndDate = util.parseDate(this.endTime, "yyyy-MM-dd").getTime();
					
					var dayCount = (fdEndDate - fdHoldDate) / (24 * 60 * 60 * 1000);
					if (dayCount > 0) {
						return parseInt(dayCount);
					} else {
						return false;
					}
				},

				startup : function() {
					if (this._started) {
						return;
					}
					this.inherited(arguments);
				},

				_setLabelAttr : function(text) {
					if (text)
						this._set("label", text);
				}
			});
			return item;
		});