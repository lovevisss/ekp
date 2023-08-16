require({cache:{"sys/evaluation/mobile/myEvaluation/js/MyEvaluationListMixin":function(){define(["dojo/_base/declare","dojo/_base/array","dojo/topic","./MyEvaluationListItem"],function(c,d,b,a){return c("sys.evaluation.myEvaluationmixin",null,{lazy:false,rowsize:10,itemRenderer:a,url:"/sys/evaluation/sys_evaluation_main/sysEvaluationMain.do?method=getMyEvaluations",formatDatas:function(e){return e}})})},"sys/evaluation/mobile/myEvaluation/js/Loading":function(){define(["dojo/_base/declare","mui/dialog/Tip"],function(c,b){var a=c("mui.sys.evaluation.Loading",null,{loading_working:false,loading_processing:null,loading_error:function(d){b.fail({text:d})},loading_success:function(d){b.success({text:d})},showLoading:function(){window._alert=window.alert;this.loading_processing=b.processing();if(this.loading_working){return false}this.loading_working=true;window.alert=this.loading_Alert;this.loading_processing.show();return true},hideLoading:function(){this.loading_working=false;window.alert=window._alert;this.loading_processing.hide(false)}});return a})},"sys/evaluation/mobile/myEvaluation/js/MyEvaluationListItem":function(){define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-class","dojo/dom-style","mui/util","dojo/html","dojo/dom","dojo/on","dojo/_base/array","mui/i18n/_i18n!sys/evaluation/mobile/myEvaluation/js/mui-sys-evaluation-myEvaluation","dojox/mobile/_ItemBase","./MyEvaluationChildItem"],function(e,c,l,h,g,f,d,j,i,b,k,a){return e("sys.evaluation.myEvaluation.list.item",[k],{fdId:"",fdModelId:"",fdModelName:"",fdModelDocSubject:"",fdModelModuleName:"",fdEvaluationScore:"",evalList:[],showMaxEvalNum:2,baseClass:"muiMyEvaluationListItem",buildRendering:function(){this.inherited(arguments);this.biludItem()},biludItem:function(){c.create("div",{className:"modelDocSubject",innerHTML:this.fdModelDocSubject},this.domNode);var t=c.create("div",{className:"topBottomContainer"},this.domNode);var p="/sys/evaluation/mobile/myEvaluation/img/tag-background.png";p=g.formatUrl(p,true);c.create("div",{className:"modelModuleName",innerHTML:this.fdModelModuleName},t);this.buildEvalScoreNode(t);var n=c.create("div",{className:"evalContainer"},this.domNode);this.showMore=false;this.childItemNode=[];var m=this.evalList.length;var o=this;for(var q=0;q<this.evalList.length;q++){var s=this.evalList[q];s.reHandleByDelete=function(u){o.reHandleByDelete(u)};if(q<this.showMaxEvalNum){s.isShow=true}if(q<(m-1)){s.showHr=true}s.index=q;var r=new a(s);r.placeAt(n);this.childItemNode.push(r)}this.buildShowOrHideMoreNode(n,m)},buildEvalScoreNode:function(m){var p=5-this.fdEvaluationScore;var o={};for(var n=1;n<=p;n++){o["evalStar"+n]="muiRatingOn"}for(var n=p+1;n<=5;n++){o["evalStar"+n]="muiRatingOff"}var q="<div class='muiRating' style='width:auto !important;'><div class='muiRatingArea'>";for(var n=1;n<=5;n++){q+="<i class='mui mui-star-on mui-2 "+o["evalStar"+n]+"'></i>"}q+="</div></div>";c.create("div",{style:"margin-left:1rem;",innerHTML:q},m)},buildShowOrHideMoreNode:function(n,m){this.childShowHideButtonContainer=c.create("div",{},n);var p="/sys/evaluation/mobile/myEvaluation/img/arrow-down.svg";p=g.formatUrl(p,true);this.showMoreHTML="<img class='arrrow-down' src='"+p+"'/>"+b["mobile.msg.moreEval"];this.hideMoreHTML="<img class='arrrow-up' src='"+p+"'/>"+b["mobile.msg.packUpEval"];if(m>this.showMaxEvalNum){this.childShowHideButtonNode=c.create("div",{className:"showHideButton",innerHTML:this.showMoreHTML},this.childShowHideButtonContainer);var o=this;j(this.childShowHideButtonNode,"click",function(){if(o.doningClick){return}o.doningClick=true;setTimeout(function(){o.doningClick=false},50);o.showOrHideMoreChilds()})}},showOrHideMoreChilds:function(){if(!this.showMore){for(var m=0;m<this.childItemNode.length;m++){var n=this.childItemNode[m];n.show(m)}this.childShowHideButtonNode.innerHTML=this.hideMoreHTML;this.showMore=true}else{for(var m=0;m<this.childItemNode.length;m++){var n=this.childItemNode[m];if(m<this.showMaxEvalNum){n.show(m)}else{n.hide(m)}}this.childShowHideButtonNode.innerHTML=this.showMoreHTML;this.showMore=false}},reHandleByDelete:function(s){var p=s.index;var o=[];var r=null;for(var q=0;q<this.childItemNode.length;q++){var t=this.childItemNode[q];if(q!=p){o.push(t)}else{r=t}}this.childItemNode=o;if(r){r.destroyRecursive()}if(s.isAddition){for(var q=0;q<this.childItemNode.length;q++){var t=this.childItemNode[q];if(q<this.showMaxEvalNum){t.show(q)}else{t.hide(q)}}if(this.childItemNode.length<=this.showMaxEvalNum){h.set(this.childShowHideButtonContainer,{display:"none"})}}if(this.childItemNode.length==0||!s.isAddition){var n=this.getParent();var m=n.getChildren();if(m.length<=1){n.reload()}else{if(m.length<=6&&!m._loadOver){n.loadMore()}}this.destroyRecursive()}},_setLabelAttr:function(m){if(m){this._set("label",m)}}})})},"sys/evaluation/mobile/myEvaluation/js/MyEvaluationChildItem":function(){define(["dojo/_base/declare","dojo/dom-construct","dojo/dom-class","dojo/dom-style","mui/util","dojo/html","dojo/dom","dojo/on","dojo/_base/array","mui/i18n/_i18n!sys/evaluation/mobile/myEvaluation/js/mui-sys-evaluation-myEvaluation","dojox/mobile/_ItemBase","dojo/request","mui/dialog/Confirm","./Loading"],function(e,b,n,h,g,f,d,j,i,a,m,c,l,k){return e("sys.evaluation.myEvaluation.list.childItem",[m,k],{fdId:"",fdEvaluationContent:"",fdEvaluationTime:"",fdEvaluationIntervalTime:"",isAddition:false,index:"",isShow:false,showHr:false,baseClass:"muiMyEvaluationListChildItem",buildRendering:function(){this.inherited(arguments);this.biludItem();if(!this.isShow){h.set(this.domNode,{display:"none"})}},biludItem:function(){var o=b.create("div",{},this.domNode);if(this.isAddition){b.create("div",{className:"evalAddition",innerHTML:a["mobile.msg.additionEval"]},o)}b.create("div",{className:"evalContent",innerHTML:this.fdEvaluationContent},o);var r=b.create("div",{className:"evalBottom"},o);b.create("div",{className:"evalTime",innerHTML:a["mobile.msg.publishedIn"]+this.fdEvaluationTime},r);var q="/sys/evaluation/mobile/myEvaluation/img/delete.svg";q=g.formatUrl(q,true);var s=b.create("div",{className:"deleteDiv"},r);var r=b.create("img",{className:"deleteImg",src:q},s);var p=this;j(s,"click",function(){if(p.isDoingClick){return}p.isDoingClick=true;setTimeout(function(){p.isDoingClick=false},50);p.onDeleteClick()});if(this.showHr){b.create("div",{className:"hr"},o)}},_setLabelAttr:function(o){if(o){this._set("label",o)}},show:function(o){if(o!=undefined){this.index=o}this.isShow=true;h.set(this.domNode,{display:"block"})},hide:function(o){this.isShow=false;if(o!=undefined){this.index=o}h.set(this.domNode,{display:"none"})},onDeleteClick:function(){var o=this;if(this.click_doing){return}this.click_doing=true;new l(a["mobile.confirm.delete.content"],a["mobile.confirm.delete.title"],function(p,q){if(p){o.startToDelete()}});setTimeout(function(){o.click_doing=false},100)},startToDelete:function(){var p="/sys/evaluation/sys_evaluation_main/sysEvaluationMain.do?method=deleteByMobile&fdId="+this.fdId;p=g.formatUrl(p);var o=this;o.showLoading();var q=c.get(p,{data:{},handleAs:"json"});q.response.then(function(r){var s=r.data;o.hideLoading();if(s.success){o.loading_success(a["mobile.msg.deleteSuccess"]);if(o.reHandleByDelete){o.reHandleByDelete(o.index)}}else{o.loading_error(s.errMsg)}},function(r){o.hideLoading();o.loading_error(r);console.log(r)})}})})}}});