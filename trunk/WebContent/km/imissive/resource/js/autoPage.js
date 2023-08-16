define(function(require, exports, module) {
	
	var AutoPage = {
		    header: null,//页面顶部显示的信息
		    tableObj: null,//页面正文TableID
		    footer: null,//页面底部
		    totalHeight: null,//总的高度
		    totalWidth:null,
		    //extHeignt:{},
		    sourceDivId:null,
		    targetDivID:null,//全文divID
		    init: function (header, tableObj, footer,totalWidth,totalHeight,sourceDivId,targetDivID) {
		        AutoPage.header = header;
		        AutoPage.tableObj = tableObj;
		        AutoPage.footer = footer;
		        AutoPage.totalHeight = totalHeight;
		        AutoPage.totalWidth = totalWidth;
		        AutoPage.sourceDivId = sourceDivId;
		        AutoPage.targetDivID = targetDivID;
		        $("#" + AutoPage.sourceDivId).show();
		       
		        AutoPage.initPageSingle();
		       
		        $("#" + AutoPage.sourceDivId).hide();
		    },
		    //分页 重新设定HTML内容(单行)
		    initPageSingle: function () {
		    	var tmpRows = AutoPage.tableObj.rows; //表格正文
		        var height_tmp = 0; //一页总高度
		        var html_tmp = "";  //临时存储正文
		        var  className = $(AutoPage.tableObj).attr("class");
		        var fd_type = $(AutoPage.tableObj).attr("fd_type");
		        var layout2col = $(AutoPage.tableObj).attr("layout2col");
		        var tablestyle = $(AutoPage.tableObj).attr("tablestyle");
		        var html_header = "<table class='"+className+"' fd_type='" +fd_type+"'  layout2col='" +layout2col+"'  tablestyle='" +tablestyle+"'";
		        var html_foot = "</table>";
		        var page = 0; //页码
		        var headline = 4;
		        var Hheight=0;
		        var Hhtml="";
		        for(var m=0 ;m<headline;m++){
		        	Hheight += tmpRows[m].clientHeight; //table标题高度
		        	Hhtml +=  "<tr style='height:"+tmpRows[m].clientHeight+"px'>" + tmpRows[m].innerHTML + "</tr>";//table标题内容
		        }
		        var Fheight = $("#" + AutoPage.footer).height(); //table标题高度
		        var Fhtml =  $("#" + AutoPage.footer).prop("outerHTML");//table标题内容
		        
		        height_tmp = Hheight+Fheight;
		        for (var i = headline; i < tmpRows.length ; i++) {
		            var trHtmp = tmpRows[i].clientHeight;//第i行高度
		            var trMtmp = "<tr style='height:"+tmpRows[i].clientHeight+"px'>" + tmpRows[i].innerHTML + "</tr>";//第i行内容
		            height_tmp += trHtmp;
		            if (height_tmp < AutoPage.totalHeight) {
		            	//LHeight = trHtmp;
		                if (height_tmp == Hheight+Fheight + trHtmp) {
		                	html_tmp += "<div style='width:"+AutoPage.totalWidth +";height:"+AutoPage.totalHeight+"'>"+ html_header +" id=tbPage"+page+">"+ Hhtml;
		                    page++;//页码
		                }
		                html_tmp += trMtmp;
		                if (i == tmpRows.length - 1) {
		                	if(Fhtml){
			            		html_tmp += html_foot + Fhtml+"</div>";
			            	}else{
			            		html_tmp += html_foot+"</div>";
			            	}
		                }
		            }else {
		            	height_tmp -= trHtmp;
		            	if(Fhtml){
		            		html_tmp += html_foot + Fhtml +"</div>"+ AutoPage.addPageBreak();
		            	}else{
		            		html_tmp += html_foot +"</div>" + AutoPage.addPageBreak();
		            	}
		                i--;
		                height_tmp = Hheight+Fheight;
		            }
		        }
		        $("#" + AutoPage.targetDivID).html(html_tmp);
		        setTimeout(function(){
		        	 $('[id^="tbPage"]').each(function(index){
		        		   // $('#tbPage'+index).css({max-height:AutoPage.totalHeight});
		        		   /*
		        		   $(this).find("td").each(function(){
		        			   $(this).removeAttr("width");
		        			   $(this).css("width","35%");
		        		   });
		        		   */
				        	var tobj = $('#tbPage'+index+ ' tr:last');
				        	var tbH = AutoPage.totalHeight -Fheight;
				        	console.log("tbh:"+tbH);
				        	var nnTbH = tbH-$(this).height();
				        	console.log("nowtbh:"+$(this).height());
				        	var oldH = tobj.height();
				        	console.log("oldH:"+oldH);
				        	var extH = oldH+nnTbH;
				        	if(index == 0){
				        		tobj.css("height",(extH-21)+"px");
				        	}else{
				        		tobj.css("height",(extH-21)+"px");
				        	}
				       });
		        	 //window.print();
		        },500);
		    },
		 
		    //分页 重新设定HTML内容(双行)
		    initPageDouble: function () {
		        var tmpRows = $("#" + AutoPage.content)[0].rows; //表格正文
		        var height_tmp = 0; //一页总高度
		        var html_tmp = "";  //临时存储正文
		        var html_header = "<table class='" + AutoPage.tableCss + "'>";
		        var html_foot = "</table>";
		        var page = 0; //页码
		        var tr0Height = tmpRows[0].clientHeight+tmpRows[1].clientHeight; //table标题高度
		        var tr0Html = "<tr>" + tmpRows[0].innerHTML + "</tr>" + "<tr>" + tmpRows[1].innerHTML + "</tr>";//table标题内容
		        height_tmp = tr0Height;
		        for (var i = 1; i < tmpRows.length ; i++) {
		            var trHtmp = tmpRows[(i - 1) * 2].clientHeight + tmpRows[(i - 1) * 2+ 1].clientHeight;//第i行高度
		            var trMtmp = "<tr>" + tmpRows[(i - 1) * 2].innerHTML + "</tr>" + "<tr>" + tmpRows[(i - 1) * 2 + 1].innerHTML + "</tr>";//第i行内容
		            height_tmp += trHtmp;
		            if (height_tmp < AutoPage.totalHeight) {
		                if (height_tmp == tr0Height + trHtmp) {
		                    html_tmp += AutoPage.header + html_header + tr0Html;
		                    page++;//页码
		                }
		                html_tmp += trMtmp;
		                if (i == tmpRows.length - 1) {
		                    html_tmp += html_foot + AutoPage.footer;
		                }
		            }
		            else {
		                html_tmp += html_foot + AutoPage.footer + AutoPage.addPageBreak();
		                i--;
		                height_tmp = tr0Height;
		            }
		        }
		        $("#" + AutoPage.targetDivID).html(html_tmp);
		    },
		 
		    //隐藏原来的数据
		    hidenContent: function () {
		        $(AutoPage.header).hide();
		        $(AutoPage.content).hide();
		        $(AutoPage.footer).hide();
		    },
		    
		    ////添加分页符
		    addPageBreak: function () {
		        return "<p style='page-break-before:always;'></p>";
		    },
		    
		};
	module.exports = AutoPage;
});
