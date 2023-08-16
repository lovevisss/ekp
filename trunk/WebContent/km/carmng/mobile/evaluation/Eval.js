define(
		[ "dojo/_base/declare", "mui/tabbar/TabBarButton","dojo/dom-construct", "dojo/dom-class",
				"dojo/dom-style", "dojo/dom-attr", "dijit/_WidgetBase",
				"mui/util", "mui/dialog/Tip", "dojo/html",
				"dojo/text!./eval.jsp", "dojo/query", "dojo/_base/lang",
				"dojo/dom", "dojo/_base/array", "dojo/request", "dojo/topic",
				"dijit/registry", "dojo/window", "mui/i18n/i18n!sys-evaluation"],
		function(declare, TabBarButton,domConstruct, domClass, domStyle, domAttr,
				widgetBase, util, tip, html, tmpl, query, lang, dom, array,
				request, topic, registry, win, msg) {

			return declare(
					'km.carmng.Eval',
					[ TabBarButton,widgetBase ],
					{

						mask : null,

						// 限制字数，默认140
						limitNum : 140,

						value : 4,

						lock : false,

						submitEnableClass : 'muiEvalSubmitEnable',

						SELECTED_EVENT : '/mui/rating/ratingSelected',

						// 点评等级
						grades : {
							'eval_grade_1' : msg['mui.sysEvaluation.mobile.oneStar.showText'],
							'eval_grade_2' : msg['mui.sysEvaluation.mobile.twoStar.showText'],
							'eval_grade_3' : msg['mui.sysEvaluation.mobile.threeStar.showText'],
							'eval_grade_4' : msg['mui.sysEvaluation.mobile.fourStar.showText'],
							'eval_grade_5' : msg['mui.sysEvaluation.mobile.oneStar.fiveText']
						},

						tips : {
							'eval_tip_1' : '很不满意',
							'eval_tip_2' : '不满意',
							'eval_tip_3' : '一般',
							'eval_tip_4' :  '满意',
							'eval_tip_5' :  '非常满意'
						},

						buildRendering : function() {
							this.domNode = this.containerNode;
							this.inherited(arguments);
						},

						startup : function() {
							this.inherited(arguments);
							this.connect(this.domNode, "onclick", 'evalClick');
							topic.publish('/sys/evaluation/loaded', [ this ]);

						},

						// 伪输入框点击事件
						evalClick : function(evt) {
							this.defer(this.showMask, 350);
						},

						bindInput : function() {
							var input = this.inputNode[0];
							this.connect(input, "onfocus", 'doFocus');
							this.connect(input, "onblur", 'doBlur');
							this.connect(input, "onkeyup", 'doKeyup');
							this.connect(input, "oninput", 'doInput');
						},

						bindSubmit : function() {
							this.submitHandle = this.connect(
									this.submitNode[0], "onclick", 'doSubmit');
						},

						bindHideMask : function() {
							this.hideMaskNode.on('click', lang.hitch(this, this.hideMask));
						},

						buildMask : function() {

							if (this.container) {
								this._showMask();
								return;
							}

							var dhs = new html._ContentSetter({
								parseContent : true,
								onBegin : function() {
									this.content = this.content
											.replace('!{starklass}',
													'mui/rating/Rating');
									this.inherited("onBegin", arguments);
								}
							});
							this.container = domConstruct.create('div', {
								'className' : 'muiDialogElement'
							}, document.body, 'last');

							dhs.node = this.container;
							dhs.set(tmpl);
							dhs.tearDown();
							var self = this;
							setTimeout(function() {
								self._showMask();
							}, 1);
							// 提交按钮
							this.submitNode = query('.muiEvalSubmit',
									this.container);
							this.bindSubmit();
							// 绑定输入框相关事件
							this.inputNode = query('.muiEvalMaskText',
									this.container);
							query('[name="fdEvaluationScore"]')[0].value =  parseInt(this.value);
							this.setInputValue(this.value);

							// 绑定收起按钮（收起按钮）
							this.hideMaskNode = query('.muiCarDialogCloseBtn', this.container);
							
							this.bindHideMask();

							// 监听星星改变事件
							this.subscribe(this.SELECTED_EVENT, lang.hitch(
									this, this.scoreSelected));
						},
						
						hideNode : function(evt) {
							// 点击下方黑色空白区域时关闭窗口
							if("muiDialogElement" == evt.target.className) {
								this.hideMask();
							}
						},

						setInputValue : function(value) {
							var tip = this.tips['eval_tip_' + value];
							query('.muiEvalLevelText', this.container)[0].innerHTML = tip;
						},

						scoreSelected : function(evt) {
							if (evt != null) {
								var val = evt.value;
								// 设置隐藏域分数值
								query('[name="fdEvaluationScore"]')[0].value =  parseInt(val);
								this.setInputValue(val);
							}
						},

						// 判断是否为默认点评内容
						isDefualt : function(val) {
							var isDefault = false;
							for ( var key in this.tips) {
								if (val == this.tips[key]) {
									isDefault = true;
									break;
								}
							}
							return isDefault;
						},

						_showMask : function() {
							domStyle.set(this.container, {
								'display' : 'block',
								'opacity' : 1
							});
						},

						_hideMask : function(fire) {
							this.defer(function() {
								domStyle.set(this.container, {
									'opacity' : 0
								});
								if (!fire) {
									topic.publish(this.SELECTED_EVENT, {
										value : this.value
									});
									registry.byId('eval_star_opt').set('value',
											this.value);
								}
							}, 500);
							this.defer(function() {
								domStyle.set(this.container, {
									'display' : 'none'
								});
							}, 700);

						},

						destroyMask : function(fire) {
							this._hideMask(fire);
						},

						// 显示遮罩
						showMask : function() {
							if (this.lock == true)
								return;
							this.set('lock', true);
							this.defer(function() {
								this.buildMask();
							}, 350);

						},

						// 隐藏遮罩
						hideMask : function(fire) {
							this.defer(function() {
								this.destroyMask(fire);
								this.set('lock', false);
							}, 350);
						},

						doFocus : function() {
							if (this.isDefualt(this.inputNode[0].value.trim()))
								this.inputNode[0].value = '';
							this.validate();
						},

						doBlur : function() {
							this.validate();
						},

						doKeyup : function() {
							this.validate();
						},

						doInput : function() {
							this.validate();
						},

						validate : function() {
							if (this._validate()) {
								this.submitNode
										.addClass(this.submitEnableClass);
							} else {
								this.submitNode
										.removeClass(this.submitEnableClass);
							}
						},

						// 点评发表提交
						doSubmit : function(evt) {
							if (this.submitLock)
								return;
							//if (!this._validate())
							//	return;
							this.set('submitLock', true);
							var fromData = {};
							var self = this;
							// 封装隐藏域数据
							array
									.forEach(
											query("#eval_formData input"),
											function(domNode) {
												fromData[domAttr.get(domNode,
														"name")] = domNode.value;
											});
							fromData['fdEvaluationContent'] = 
								util.formatText(this.inputNode[0].value);
							
							var fdAppId = query('[name="fdApplicationId"]')[0].value;
							var promise = request
									.post(
											util
													.formatUrl("/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do?method=save&fdAppId="+fdAppId),
											{
												data : fromData,
												timeout : 30000
											});
							promise.response
									.then(function(data) {
										if (data.status == 200
												&& data.getHeader("lui-status") == "true") {
											self.inputNode[0].value = "";
											tip.success({
														text : '评价成功！'
													});

											self.defer(function() {
													self.set('submitLock',false);
													domStyle.set(self.domNode, {
														'visibility' : 'hidden'
													});
													window.location.reload();
												}, 300);
										} else
											tip.fail({
														text : '评价失败！'
													});
									});
							this.hideMask();
						},

						// 校验字数，
						_validate : function() {
							var flag = false;
							var val = this.inputNode[0].value.trim();
							var leng = val.length;
							var l = 0;
							for (var i = 0; i < leng; i++) {
								if (val[i].charCodeAt(0) < 299)
									l++;
								else
									l += 2;
							}
							if (l <= 2 * this.limitNum && l > 0)
								flag = true;
							
							if (flag) {
								query('#contentLength', this.container)[0].innerHTML = "";
							} else if(l > 0) {
								query('#contentLength', this.container)[0].innerHTML = Math.ceil((this.limitNum * 2 - l) / 2);
							}
							return flag;
						}
					})
		});