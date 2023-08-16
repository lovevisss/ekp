define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/device/adapter",
   	"dojo/_base/lang",
   	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,adapter,lang,openProxyMixin) {
	var item = declare("km.imissive.list.item.AttTrackItemMixin", [ItemBase,openProxyMixin], {
		tag:"li",
		
		baseClass:"muiProcessItem",
		
		//流程简要信息
		summary:"",
		
		//创建时间
		created:"",
		
		//创建者
		creator:"",
		
		//创建人图像
		icon:"",
		
		buildRendering:function(){
			this.inherited(arguments);
			this.contentNode = domConstruct.create(
					this.tag, {
						className : 'muiListItem'
					});
			this.buildInternalRender();
			
			domConstruct.place(this.contentNode,this.containerNode);
			
		},
		buildInternalRender : function() {
			var rightArea = domConstruct.create("div",{className:"muiProcessRight"},this.contentNode);
			domConstruct.create("span", { className: "muiProcessImg",style:{background:'url(' + util.formatUrl(this.icon) +') center center no-repeat',backgroundSize:'cover',display:'inline-block'}}, rightArea);
			domConstruct.create("a", { className: "muiProcessCreator muiAuthor",innerHTML:this.creator}, rightArea);
			
			
			var leftArea = domConstruct.create("a",{className:"muiProcessLeft"},this.contentNode);
			var title = domConstruct.create("h3",{className:"muiProcessTitle muiSubject"},leftArea);
			
			if(this.label){
				title.appendChild(domConstruct.toDom(this.label));
			}
			
			var summary = domConstruct.create("p",{className:"muiProcessSummary muiListSummary"},leftArea);
			domConstruct.create("span", { className: "muiProcessCreated muiListSummary", 
				innerHTML:this.created}, summary);
			if(this.summary){
				domConstruct.create("i",{className:"muiProcessSign mui mui-flowlist"},summary);
				domConstruct.create("span",{className:"muiProcessSummary muiListSummary",innerHTML:this.summary},summary);
				
			}
			
			leftArea.dojoClick = true;
			this.connect(leftArea, 'click', lang.hitch(this, function() {

				adapter.download({
					fdId : this.fileId,
					name : this.label,
					type : 'doc',
					href : this.href
				});

			}));
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
	});
	return item;
});