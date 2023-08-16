define(["dojo/_base/declare", "dojo/store/Memory" , "dojo/topic", "dijit/registry"], function(declare, Memory,topic,registry) {
  return declare("km.imeeting.mobile.topic.TopicEditNavMixin", null, {
	    store: new Memory({
	      data: [
	        {
	          text: "议题信息",
	          'moveTo' : 'scrollView',
	          'selected' : true
	        },
	        {
	          text: "流程操作",
	          'moveTo' : 'lbpmView'
	        }
	      ]
	    })
	  });
})
