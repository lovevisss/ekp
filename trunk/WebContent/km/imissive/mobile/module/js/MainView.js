/**
 * 主面板
 */
define(["mui/createUtils", "mui/i18n/i18n!km-imissive:mobile"], function(createUtils, msg) {
  var _buttons = [];
  
  if(window.buttons){
	  for(var i=0;i<window.buttons.length;i++){
          var buttonType = window.buttons[i];
		  if(buttonType=="send_create"){
			  _buttons.push({
			    	icon:"muis-pop-send",
		   	    	text:"新建发文",
		   	    	click:function(){
		   				require(["mui/syscategory/SysCategoryUtil"], function(SysCategoryUtil){
		   					SysCategoryUtil.create({
		   						  key: "sendAdd",
		   		                  createUrl: "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{curIds}&mobile=true",
		   		                  modelName: "com.landray.kmss.km.imissive.model.KmImissiveSendTemplate",
		   		                  mainModelName: "com.landray.kmss.km.imissive.model.KmImissiveSendMain"
		   		            });
		   				});
		   	    	}
		   	  });			  
		  }else if(buttonType=="receive_create"){
			  _buttons.push({
			    	icon:"muis-missive-new-accept",
			    	text:"新建收文",
			    	click:function(){
						require(["mui/syscategory/SysCategoryUtil"], function(SysCategoryUtil){
							SysCategoryUtil.create({
		   						  key: "receiveAdd",
		   		                  createUrl: "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=!{curIds}&mobile=true",
		   		                  modelName: "com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate",
		   		                  mainModelName: "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"
				            });
						});
			    	}
			  });			  
		  }else if(buttonType=="sign_create"){
			  _buttons.push({
			    	icon:"muis-missive-new-report",
			    	text:"新建签报",
			    	click:function(){
						require(["mui/syscategory/SysCategoryUtil"], function(SysCategoryUtil){
							SysCategoryUtil.create({
		   						  key: "signAdd",
		   		                  createUrl: "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=add&fdTemplateId=!{curIds}&mobile=true",
		   		                  modelName: "com.landray.kmss.km.imissive.model.KmImissiveSignTemplate",
		   		                  mainModelName: "com.landray.kmss.km.imissive.model.KmImissiveSignMain"
				            });
						});
			    	}
			  });			  
		  }
	  }
  }
  
  return {
    createView: function() {
      return {
        header: {
          tmpl: createUtils.createTemplate(
            null,
            {
              dojoType: "sys/mportal/module/mobile/containers/Header",
              dojoProps: {
                userName: dojoConfig.CurrentUserName
              }
            },
            createUtils.createTemplate(null, {
              dojoType: "sys/mportal/module/mobile/elements/Statistical",
              dojoMixins: "km/imissive/mobile/module/js/main/Statistical"
            })
          )
        },
        button: {
        	icon: "muis-new",
        	datas: _buttons||[]
        },
        cards: [
                {
                    contents: [
                      {
                        tmpl: createUtils.createTemplate(null, {
                          dojoType: "sys/mportal/module/mobile/elements/Functional",
                          dojoMixins: "km/imissive/mobile/module/js/main/Functional"
                        })
                      }
                    ]
                },
                {
                    title: {text: msg['mobile.kmImissive.doneStat']},
                    contents: [
                               {
                                 tmpl: createUtils.createTemplate(null, {
                                   dojoType: "sys/mportal/module/mobile/elements/TabsChart",
                                   dojoMixins: "km/imissive/mobile/module/js/main/TabsChart"
                                 })
                               }
                    ]
                }
        ]
      }
    }
  }
})
