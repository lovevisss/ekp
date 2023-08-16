define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"dojo/on",
   	"mui/dialog/Tip", 
	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,on,Tip, openProxyMixin) {
	var item = declare("mui.list.item.MissiveItemMixin", [ItemBase, openProxyMixin], {
		
		tag:"li",
		
		//创建时间
		created:"",
		//创建者
		creator:"",
		//创建人图像
		icon:"",
		//链接
		href:"",
		//摘要
		summary:"",
		//发布时间
		docPublishTime:"",
		//所属部门
		docDeptName:"",
		//摘要
		summary:"",
		//阅读数
		docReadCount:"",
		//标签
		tagNames:"",
		
		buildRendering:function(){

			this.inherited(arguments);
			this.domNode = domConstruct.create(this.tag, {className : 'muiMissiveItemD'}, this.containerNode);
			this.buildInternalRender();
		},
		
		buildInternalRender : function() {
             
			// 对齐方式Class类名（只显示标题时，标题需与左侧图标垂直居中对齐，反之则垂直顶端对齐）
		    var verticalAlignClass = this.isJustShowSubject()?'muiMissiveItemDVerticalAlignMiddle':'muiMissiveItemDVerticalAlignTop';
			
			// 外层容器DOM
			var containerNode = domConstruct.create('div', { className:'muiMissiveItemDContainer' }, this.domNode);
			
			
			// 右侧容器DOM
			var rightNode = domConstruct.create('div', { className:'muiMissiveItemDRight '+verticalAlignClass }, containerNode);		
			
			// 标题
			var subject = domConstruct.create("div",{className:"muiMissiveItemDSubject muiFontSizeM muiFontColorInfo",innerHTML:this.label},rightNode);
			
			
			var summaryNode = domConstruct.create("div",{},rightNode);
			// 摘要文本
			if(this.summary){
				domConstruct.create("div",{className:'muiMissiveItemDSummary muiFontSizeS muiMissiveItemDSummaryLeft',innerHTML:'业务办理进度:&nbsp;'},summaryNode);
				domConstruct.create("div",{className:'muiMissiveItemDSummary muiFontSizeS muiMissiveItemDSummaryRight',innerHTML:this.summary},summaryNode);
			}
			
			if( this.creator || this.docDeptName || this.created || this.docPublishTime || this.docReadCount ){
				
				// 右侧底部footer DOM
				var rightFooterNode = domConstruct.create('div', { className:'muiMissiveItemDRightFooter muiFontSizeS muiFontColorMuted '+(this.docReadCount?'muiMissiveItemDHasReadCount':'') }, rightNode);
				
				// 创建人
				if(this.creator){
					domConstruct.create('div', { className:'muiMissiveItemDCreator', innerHTML:this.creator }, rightFooterNode);
				}
				
				// 部门名称（发文部门）
				if(this.docDeptName){
					domConstruct.create('div', { className:'muiMissiveItemDDocDeptName', innerHTML:this.docDeptName }, rightFooterNode);
				}
				
				// 创建时间
				if(this.created){
					domConstruct.create('div', { className:'muiMissiveItemDCreatedTime', innerHTML:this.created }, rightFooterNode);
				}
				
				// 发布时间
				if(this.docPublishTime){
					domConstruct.create('div', { className:'muiMissiveItemDPublishTime', innerHTML:this.docPublishTime }, rightFooterNode);
				}
				
				// 阅读数量
				if(this.docReadCount){
					domConstruct.create('div', { className:'muiMissiveItemDReadInfo', innerHTML:'<span class="muiMissiveItemDReadCount">'+this.docReadCount+'</span><span class="muiMissiveItemDViewText">浏览</span>' }, rightFooterNode);
				}				
			}

			if(this.href){
				// 绑定点击事件（跳转至详情查看页）
				this.proxyClick(this.domNode, this.href, '_blank');
			}else{
				// 背景锁（不支持移动端查看详情的数据添加一张半透明锁状背景图）
				var lockNode = domConstruct.create('div', { className:'muiMissiveItemDLock' }, this.domNode);
				// tip提醒（暂不支持移动访问）
				this.makeLockLinkTip(this.domNode);
			}
			
		},
		
		/**
		* 是否仅显示标题
		*  此方法的意义是提供给列表数据在不同场景下设置不同的CSS样式
		* （“摘要文本”、“创建人”、“部门名称”、“创建时间”、“发布时间”、“阅读数量” 这些全部都不显示时，标题与左侧图标垂直居中对齐，反之则垂直顶端对齐）
		* @return boolean
		*/
		isJustShowSubject:function(){
			return !(this.summary || this.creator || this.docDeptName || this.created || this.docPublishTime || this.docReadCount);
		},
		
		makeLockLinkTip:function(linkNode){
			this.href='javascript:void(0);';
			on(linkNode,'click',function(evt){
				Tip.tip({icon:'mui mui-warn', text:'暂不支持移动访问'});
			});
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