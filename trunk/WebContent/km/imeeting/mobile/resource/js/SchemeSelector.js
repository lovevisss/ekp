define([ "dojo/_base/declare", "dojox/mobile/_ItemBase", "dojo/_base/lang", 
         "dojo/_base/array", "dojo/_base/config", "dojo/window", "dojo/dom", "dojo/_base/array",
         "dojo/dom-style", "dojo/dom-attr", "dojo/dom-class", "dojo/dom-construct", "dojo/query", "dojo/topic", 
         "dojo/on", "dojo/request", "dojo/touch", "./TopicSelectorListItem", 'dijit/registry',"mui/i18n/i18n!km-imeeting:mobile"], 
	
	function(declare, ItemBase, lang, array, config, win, dom, array, 
			domStyle, domAttr, domClass, domCtr,  query, topic, on, request, touch, 
			TopicSelectorListItem, registry,msg) {
	
	return declare("km.imeeting.mobile.js.SchemeSelector", [ ItemBase ], {

		key: '',
		
		itemRenderer: TopicSelectorListItem,
		
		TYPE_CERT: 0,
		TYPE_CAT: 1,
		
		isMul: false,
		
		catList: [],
		certList: [],
		
		selectedCerts: {},
		
		catDataUrl: 'sys/category/mobile/sysCategory.do?method=cateList&categoryId={categoryId}&getTemplate=1&modelName=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&authType=00',
		certDataUrl: 'km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&isDialog=0&q.docStatus=30&mainDialog=1&q.fdSchemeTemplate={categoryId}',
		
		postCreate: function(){
			var ctx = this;
			ctx.inherited(arguments);
			ctx.initialize();
		},
		
		initialize: function(){
			var ctx = this;
			
			ctx.catList = [];
			
			ctx.selectedCerts = {};
			topic.publish('km/imeeting/selectedScheme/get', function(selectedCerts) {
				array.forEach(selectedCerts, function(cert) {
					ctx.selectedCerts[cert.fdId] = true;
				});
			});
			
			ctx.title = dom.byId('schemeSelectorTitle');
			ctx.preBtn = dom.byId('schemeSelectorPreBtn');
			ctx.cancelBtn = dom.byId('schemeSelectorCalBtn');
			
			ctx.bindEvents();
			
			ctx.loadData();
			
		},
		
		bindEvents: function(){
			
			var ctx = this;
			
			on(ctx.cancelBtn, touch.press, function(e){
				topic.publish('/mui/category/cancel', {
					key: '_schemeSelect'
				});
			});
			
			on(ctx.preBtn, touch.press, function(e){
				ctx.catList.pop();
				
				if(ctx.catList.length < 1){
					domStyle.set(ctx.preBtn, 'display', 'none');	
					ctx.title.innerHTML = msg['mobile.imeeting.select'];
					ctx.loadData();
				}else {
					var t = ctx.catList[ctx.catList.length - 1];
					ctx.title.innerHTML = t.text;
					ctx.loadData(t.id);
				}
				
				
			});
			
			on(ctx.domNode, on.selector('.muiCateItem', 'click'), function(e){
				
				e.stopPropagation();
				e.cancelBubble = true;
				e.preventDefault();
				e.returnValue = false;
				
				var node = query(e.target).closest(".muiCateItem")[0];
				
				if(node) {
					node.dojoClick = true;
					var type = domAttr.get(node, 'data-type');
					var id = domAttr.get(node, 'data-id');
					var text = domAttr.get(node, 'data-text');
					
					if(type == ctx.TYPE_CAT) {
						
						ctx.catList.push({
							id: id,
							text: text
						});
						ctx.title.innerHTML = text;
						domStyle.set(ctx.preBtn, 'display', 'block');
						ctx.loadData(id);
						
					} else if(type == ctx.TYPE_CERT) {
						
						array.forEach(ctx.certList, function(d){
							
							if(d.fdId == id){
								
								
								if(ctx.isMul) {
									
									// 暂无多选业务
									
									
								} else {
									
									if(ctx.selectedCerts[d.cert.fdId]) {
										return;
									}
									
									domClass.add(node,'muiCateSeled');
									topic.publish('km.imeeting.schemeSelector.result', d.cert);
									query(".muiCateDiaglogN")[0].style.display = "none";
									console.log("dom", query(".muiCateDiaglogN")[0]);
//									topic.publish('/mui/category/cancel', {
//										key: '_schemeSelect'
//									});
									
								}
								
							}
							
						});
						
					}
					
				}
				
			});
			
			topic.subscribe('/mui/category/cancelSelected', function(_ctx, item) {
				
				if(ctx.key != _ctx.key) {
					return;
				}
				
				var node = query('.muiCateItem[data-id="' + item.fdId + '"]');
				ctx.selectedCerts[item.fdId] = false;
				if(node[0]) {
					domClass.remove(node[0], 'muiCateSeled');
				}
				
			});
			
			topic.subscribe('/mui/category/submit', function(_ctx, items) {
				
				if(ctx.key != _ctx.key) {
					return;
				}
				topic.publish('km.imeeting.schemeSelector.result', items);
			});
			
			topic.subscribe('/mui/search/submit', function(srcObj,evt) {
				domStyle.set(dom.byId('schemeSelectorUl'), 'display', 'none');
				domStyle.set(dom.byId('schemeSearchUl'), 'display', 'block');
				
				domStyle.set(ctx.preBtn, 'display', 'none');
				domStyle.set(dom.byId('schemeSelectorBackBtn'), 'display', 'inline-block');
				domStyle.set(dom.byId('schemeSelectorTitle'), 'display', 'none');
				domStyle.set(dom.byId('schemeSearchTitle'), 'display', 'inline-block');
			});
			
			topic.subscribe('/mui/search/cancel', function(srcObj,evt) {
				domStyle.set(dom.byId('schemeSelectorUl'), 'display', 'block');
				domStyle.set(dom.byId('schemeSearchUl'), 'display', 'none');
				
				if(ctx.catList.length < 1){
					domStyle.set(ctx.preBtn, 'display', 'none');
				} else {
					domStyle.set(ctx.preBtn, 'display', 'inline-block');
				}
				domStyle.set(dom.byId('schemeSelectorBackBtn'), 'display', 'none');
				domStyle.set(dom.byId('schemeSelectorTitle'), 'display', 'inline-block');
				domStyle.set(dom.byId('schemeSearchTitle'), 'display', 'none');
				registry.byNode(query('.schemeSearchType')[0])._setValueAttr('');
			});
			
			on(dom.byId('schemeSelectorBackBtn'), touch.press, function(e){
				domStyle.set(dom.byId('schemeSelectorUl'), 'display', 'block');
				domStyle.set(dom.byId('schemeSearchUl'), 'display', 'none');
				
				if(ctx.catList.length < 1){
					domStyle.set(ctx.preBtn, 'display', 'none');
				} else {
					domStyle.set(ctx.preBtn, 'display', 'inline-block');
				}
				domStyle.set(dom.byId('schemeSelectorBackBtn'), 'display', 'none');
				domStyle.set(dom.byId('schemeSelectorTitle'), 'display', 'inline-block');
				domStyle.set(dom.byId('schemeSearchTitle'), 'display', 'none');
				registry.byNode(query('.muiSearchBar')[0])._onCancel();
				registry.byNode(query('.schemeSearchType')[0])._setValueAttr('');
			});
			
		},
		
		loadData: function(catId) {
			
			var ctx = this;
			
			domCtr.empty(ctx.domNode);
			
			request.post(config.baseUrl + lang.replace(ctx.catDataUrl, {
				categoryId: catId || ''
			}), {
				handleAs: 'json'
			}).then(function(res){
				
				var t = [];
				
				array.forEach(res, function(d){
					
					t.push({
						type: ctx.TYPE_CAT,
						fdId: d.value,
						text: d.text
					});
				});
				
				ctx.renderData(t);
			});
			
			if(catId){
				
				request.post(config.baseUrl + lang.replace(ctx.certDataUrl, {
					categoryId: catId || ''
				}), {
					handleAs: 'json',
					data: {
						rowsize: 999999
					}
				}).then(function(res){
					
					var t = [];
					
					array.forEach(res.datas, function(d){
						var _t = {};
						array.forEach(d, function(_d){
							_t[_d.col] = _d.value;
						});
						t.push({
							type: ctx.TYPE_CERT,
							fdId: _t.fdId,
							text: _t.docSubject,
							cert: _t
						});
					});
					
					ctx.certList = t;
					ctx.renderData(t);
				});
			}
			
			topic.publish("/mui/view/scrollTo", ctx);
		},
		
		renderData: function(data) {
			
			var ctx = this;
			
			array.forEach(data, function(item, idx){
				
				var certItem = new ctx.itemRenderer(lang.mixin(item, {
					isMul: ctx.isMul
				}));
				
				if(ctx.selectedCerts[item.fdId]) {
					domClass.add(certItem.domNode, 'muiCateSeled');
				}
				
				certItem.placeAt(ctx.domNode);
				
			});
			
		}
		
	});
		
})