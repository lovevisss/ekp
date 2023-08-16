define([ "dojo/_base/declare", "mui/form/Category","dojo/_base/lang","dojo/query","dojo/topic","dojox/mobile/viewRegistry", "dojox/mobile/TransitionEvent"],
	function(declare, Category, lang, query, topic,viewRegistry,TransitionEvent) {
		var PlaceComponent = declare("km.imeeting.PlaceComponent",[ Category ], {
			
			isMul : false,

			templURL : "km/imeeting/mobile/resource/tmpl/place.jsp" ,
			
			validateInputName: 'fdPlaceUserTime',
			
			required: true,
			
			postCreate : function(){
				this.inherited(arguments);
				topic.subscribe("/km/imeeting/place/submit",lang.hitch(this,"setPlaceUserTime"));
				//topic.subscribe("/km/imeeting/otherPlace/changed",lang.hitch(this,"validatePlaceEmpty"));
				topic.subscribe("/mui/category/tmploaded",lang.hitch(this,"handleTmpLoaded"));
			},
			
			startup : function(){
				this.inherited(arguments);
				this.backview = viewRegistry.getEnclosingView(this.domNode);
			},
			
			/**
			 * 选择完会议地点后设置地点最长可使用时长字段，并校验
			 */
			setPlaceUserTime : function(srcObj , evt){
				
				var self = this;
				
				if(evt) {
					if(srcObj.key == this.key){
						var userTime = query('[name="' + self.validateInputName + '"]')[0];
						userTime.value = evt.fdUserTime || '';
						if(this.validate!='' && this.edit ){
							if(this.validation)this.validation.validateElement(this);
						}
					}
				}
			},
			
			// 输入外部地点后会议室不是必填
			validatePlaceEmpty : function(fdOtherPlaceValue) {
				/*var me = this;
				if(fdOtherPlaceValue) {
					if(this.validate !='' && this.edit ){
						console.log(this);
						this.validation.removeElements(this, "required");
						console.log(this.validation.getValidator("required"));
						return true;
						
					}
				}*/
			},
			
			handleTmpLoaded : function(evt){
				//this.connect(query('.muiCateHeaderReturn',evt.dom)[0],'click',lang.hitch(this,"backOpt"));
			},
			
			backOpt : function(){
				this.closeDialog(this);
			}
			
		});
		return PlaceComponent;
});