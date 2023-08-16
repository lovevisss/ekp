define(function(require, exports, module) {
	var $ = require("lui/jquery");
	var confg = {
		contentShow : true,
		contentWidth:null,
		rightShow : false,
		rightWidth:null,
		btnWidth:null,
		rightNavMode:null
	}
	
	
	function slideInit(cfg) {
		config = $.extend({}, cfg);
		var contentEle = $("[data-lui-silde-content]");
		var mainEle = $("[data-lui-mark-main]");
		var navWidth;
		var btn = $("[data-lui-slide-btn]");
		config["rightWidth"] = $(".bar-right").width();
		config["contentWidth"] = $(".content").width();
		if(!config["rightShow"]){
			config["btnWidth"] = 20;
		}else{
			config["btnWidth"] = $("#main").width()- $(".content").width() - $(".bar-right").width();
		}
		btn.on("click", function(evt) {
			var dir = $(evt.target).attr("data-lui-slide-btn");
			if(dir == "right"){
				if(config[dir + "Show"]) {
					var barRightPanel = LUI("barRightPanel");
					if(config["rightNavMode"] == "vertical" && barRightPanel){
						$("[data-lui-slide-btn='left']").hide();
						//收缩变展开
						mainEle.addClass("lui-slide-main-animate-ing");
						var barCfg = {};
						barCfg[dir] = (-(config["rightWidth"]-46) + "px");
						$("[data-lui-slide-bar='"+ dir +"']").animate(barCfg, 300);
						var contentCfg = {}
						contentCfg["margin-" + dir] = 46+config["btnWidth"];
						contentEle.animate(contentCfg, 300 , function() {
							mainEle.addClass("lui-slide-main-spread");
							mainEle.removeClass("lui-slide-main-animate-ing");
						});
						config[dir + "Show"] = false;
					}else{
						$("[data-lui-slide-btn='left']").hide();
						//收缩变展开
						mainEle.addClass("lui-slide-main-animate-ing");
						var barCfg = {};
						barCfg[dir] = (-(config["rightWidth"]) + "px");
						$("[data-lui-slide-bar='"+ dir +"']").animate(barCfg, 300);
						var contentCfg = {}
						contentCfg["margin-" + dir] = 0;
						contentEle.animate(contentCfg, 300 , function() {
							mainEle.addClass("lui-slide-main-spread");
							mainEle.removeClass("lui-slide-main-animate-ing");
						});
						config[dir + "Show"] = false;
					}
				} else {
					$("[data-lui-slide-btn='left']").show();
					//展开变收缩
					mainEle.removeClass("lui-slide-main-spread");
					mainEle.addClass("lui-slide-main-animate-ing");
					var barCfg = {};
					barCfg[dir] = 0;
					$("[data-lui-slide-bar='"+ dir +"']").animate(barCfg  , 300);
					var contentCfg = {}
					contentCfg["margin-" + dir] = (config["rightWidth"]+config["btnWidth"]) + "px";
					contentEle.animate(contentCfg,  300, function() {
						mainEle.removeClass("lui-slide-main-animate-ing");
					});
					config[dir + "Show"] = true;
				}
			}else{
				if(config["contentShow"]){
					$("[data-lui-slide-btn='right']").hide();
					var contentCfg = {}
					contentCfg["margin-right"] = ($("#main").width()) + "px";
					//contentEle.css("overflow","hidden");
					contentEle.animate(contentCfg,  300, function() {						
						$("[data-lui-slide-bar='right']").css("width","100%");
						$(".slide-btn-left-container").css("right","15px");
						$(".slide-btn-left-container").addClass("lui-slide-left-spread");
					});
					config["contentShow"] = false;
				}else{
					$("[data-lui-slide-btn='right']").show();
					var contentCfg = {}
					contentCfg["margin-right"] = (config["rightWidth"]+config["btnWidth"]) + "px";
					//contentEle.css("overflow","auto");
					contentEle.animate(contentCfg,  300, function() {
						$("[data-lui-slide-bar='right']").css("width",config["rightWidth"]);
						$(".slide-btn-left-container").css("right","0px");
						$(".slide-btn-left-container").removeClass("lui-slide-left-spread");
					});
					config["contentShow"] = true;
				}
			}
		}); 
	}
			

	module.exports = slideInit;
});
