/**
 * Hash Mixin，作用如下:
 * 	1.根据初始hash设置排序组件默认值
 * 	2.列表视图切换后调整hash的query参数
 * 	3.排序后调整hash的query参数
 */
define([
	"dojo/_base/declare", 
	"dojo/topic", 
	"mui/hash",
	"mui/ChannelMixin"
], function(declare, topic, hash, ChannelMixin) {
  return declare("mui.sort.HashMixin", [ ChannelMixin ], {

	  postMixInProperties: function(){
		  this.inherited(arguments);
		  // 匹配路径的分类筛选器才需要初始化
		  if(hash.matchPath(this.key)){
			  var query = hash.getQuery()
			  if(!query || !query.orderby){
				  return;
			  }
		      if (query.orderby === this.name) {
		        this.value = query.ordertype;
		      }else{
		    	  this.value = '';
		      }
		  }
	  },
	  
	  postCreate: function(){
		  this.inherited(arguments);
		  // 列表视图切换时，更新地址栏hash的query参数
		  this.subscribe('/dojox/mobile/viewChanged', 'handleViewChanged');
	  },
	  
	  handleViewChanged: function(view){
		  if(!this.isSameChannel(view.key)){
			  return;
		  }
		  hash.replaceQuery({
			  orderby : this.name,
			  ordertype: this.value
		  });
	  },
	  
	  // 当前排序组件发生变化，设置hash
	  submit: function(){
		  this.inherited(arguments);
		  hash.replaceQuery({
			  orderby : this.name,
			  ordertype: this.value
		  });
	  }
	  
  });
})
