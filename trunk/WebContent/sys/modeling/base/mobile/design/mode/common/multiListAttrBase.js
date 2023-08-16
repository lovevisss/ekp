/**
 * 多选的列表视图(属性面板)
 *
 * Statistics和ListView都继承该类
 */
define(function(require, exports, module) {

    var $ = require("lui/jquery");
    var base = require("lui/base");
    var render = require("lui/view/render");
    var dialog = require("lui/dialog");
    var mobileBaseWidget = require("sys/modeling/base/mobile/design/mode/common/mobileBaseWidget");
    var topic = require('lui/topic');
    var modelingLang = require("lang!sys-modeling-base");
    var MultiListAttrBase = mobileBaseWidget.MobileBaseWidget.extend({

        renderHtml : "/sys/modeling/base/mobile/design/mode/common/multiListAttrBaseRender.html#",

        initProps: function($super,cfg) {
            $super(cfg);
            this.isCount = true;	// 是否需要设置总计页签
            // 属性面板的模板HTML，使用模板文件方便调整
            this.panelTempRender = new render.Template({
                parent : this,
                src : this.renderHtml
            });
        },

        startup : function($super,cfg){
            $super(cfg);
            this.panelTempRender.startup();
        },

        /****************** 属性配置 start ************************/

        // 画配置面板的属性标题
        panelTitleDraw : function(data, container){
            data = data || {
                attr : {
                    listViews : {}
                }
            };
            var $title = $("<div class='field_label'></div>").appendTo(container);
            $title.append('<div class="field_label_desc"><i class="'+ (data.iconClass || "") +'"></i><p>'+ data.text +'</p></div>');
            var self = this;
            var $addButton = $("<div class='item_icon form_item_add' />").appendTo($title);
            $addButton.on("click",function(){
                // 默认新增时，把其他li收起来
                self.contentBodyDom.find(".content_name").each(function(index, dom){
                    $(dom).parent().addClass("shrink");
                    $(dom).parent().addClass("multi_shrink");
                    $(dom).parent().find(".content_wrap").hide();
                });
                var $item = self.createFormItem(null, data.attr.listViews);
                self.updateData(true);
                // 往下滚动到最下面
                var $panelElement = self.contentBodyDom.closest(".mobileAttrPanelMain");
                $panelElement.animate({ scrollTop: $panelElement[0].scrollHeight},"normal");
            });
        },

        // 画配置面板的属性定义
        multiListViewDraw : function(key, info, container, fieldBody){
            this.contentBodyDom = fieldBody;

            // 首次初始化，需要等panelTempRender请求完之后再执行
            var self = this;
            this.panelTempRender.get(null,function(){
                for(var i = 0;i < info.value.length;i++){
                    var formData = info.value[i];
                    self.createFormItem(formData, info);
                }
                if(!self.warning){
                    // 非异常状态，默认只展示第一项，全部展开不美观
                    self.contentBodyDom.find(".content_name:gt(0)").each(function(index, dom){
                        $(dom).parent().addClass("shrink");
                        $(dom).parent().addClass("multi_shrink");
                        //	$(dom).parent().find(".content_wrap").hide();
                    });
                }
            });

            return this.contentBodyDom;
        },

        // area为当前属性框面板
        multiListViewGetValue : function(key, info, area){
            var datas = [];
            var self = this;
            var items = area.find(".multi-list-block");
            items.each(function(index, dom){
                var itemInfo = self.getMultiListViewBlockKeyData(dom) || {};
                datas.push(itemInfo);
            });
            return datas;
        },

        getMultiListViewBlockKeyData : function(dom){

            var itemInfo = {};
            itemInfo.title = $(dom).find("input[name*='formItemTitle']").val();
            var lvcondition = [];

            itemInfo.listViewAppId = $(dom).find("[name*='listViewAppId']").val();
            itemInfo.listViewText = $(dom).find("[name*='listViewText']").val();
            var tabs =  $(dom).find(".content_wrap");
            for (var i=0;i<tabs.length;i++){
                var tab = $(tabs[i]);
                //为了统计第一个tab的数据总数，存第一个listviewId
                if (i==0){
                    itemInfo.listView = tab.find("[name*='listView']").val();
                    itemInfo.nodeType = tab.find("[name*='nodeType']").val();
                }
                var tabText = tab.find(".content_tab_name").val();
                var listviewValue =  tab.find("input[name *='listView']").val();
                var listviewText =  tab.find(".listViewText").html();
                var appId = tab.find("[name='listViewAppId']").val();
                var nodeType = tab.find("[name='nodeType']").val();
                lvcondition.push({tab : tabText, value : listviewValue,text:listviewText,appId:appId,nodeType:nodeType});
            }
            $(dom).find("input[name *='listviews']").val(JSON.stringify(lvcondition));
            itemInfo.newlistView = JSON.parse($(dom).find("input[name*='listviews']").val() || "[]");
            //	itemInfo.listView = $(dom).find("[name*='oldlistView']").val();
            //	itemInfo.listViewText = $(dom).find("[name*='oldlistViewText']").val();
            if(this.isCount){
                itemInfo.countLv = $(dom).find("input[name *='listView']").val() || "";
                itemInfo.lvCollection = JSON.parse($(dom).find("[name*='lvCollection']").val() || "[]");
            }
            return itemInfo;
        },

        createFormItem : function(formData, attr){
            var uuId = "fd_" + parseInt(((new Date().getTime()+Math.random())*10000)).toString(16);
            formData = formData || {};

            var self = this;
            var $formItem = $(this.panelTempRender.html({value: formData,info: attr, uuId: uuId})).appendTo(this.contentBodyDom);


            /************* 添加事件 start *****************/
            // 点击标题，收起和展开内容
            $formItem.find(".content_name").on("click",function(){
                var $itemMain = $formItem.find(".field_item_content");
                $itemMain.slideToggle("normal",function(){
                    //#123054 移动端首页功能区收缩后，间距太多
                    if($formItem.find(".field_item_body").css("display") == 'none'){
                        $formItem.find(".field_item_body").css({"display":"none"});
                    }else{
                        $formItem.find(".field_item_body").removeAttr("style");
                    }
                    $formItem.toggleClass('multi_shrink');
                });
                $formItem.toggleClass('shrink');
            });

            // 点击视图穿透设置，收起和展开内容
            $formItem.find(".content-through-button").on("click",function(){
                //$formItem.find(".content-through").css({"display":"none"});
                $formItem.find(".field_item_listTabs").css({"display":"block"});
                if ($formItem.find(".content_item_box").length==0){
                    $formItem.find(".field-item-throuth-add").trigger("click")
                }if($formItem.find(".content_item_box").length==1){
                    $formItem.find(".form_tab_delete").hide();
                }
            });
            //点击新增，增加页签
            $formItem.find(".field-item-throuth-add").on("click",function(){
                var $TitemTabs =$($formItem.find(".field_item_listTabs"))
                var tab = new MiltiListTab({parent: $TitemTabs,widgetKey:self.widgetKey});
                var TitemTab =tab.element;
                if ($formItem.find(".content_item_box").length==0){
                    $(TitemTab).find(".form_tab_delete").hide();
                }else {
                    $formItem.find(".form_tab_delete:first").show();
                }
                $TitemTabs.append(TitemTab);
            });

            //点击返回事件
            $formItem.find(".content-reback").on("click",function(){
                $formItem.find(".content_tab_name").trigger("change");
                $formItem.find("input[name *='listView']").trigger("change");
                var contentOptInfoes = $formItem.find(".field_item_listTabs").find(".content_opt_info");
                var pass = true;
                for (var i=0;i<contentOptInfoes.length;i++){
                    var contentOptInfo = contentOptInfoes[i];
                    if (contentOptInfo.innerHTML !=""){
                        pass = false;
                    }
                }
                if (pass){
                    $formItem.find(".field_item_listTabs").css({"display":"none"});
                    $formItem.find(".addTabButton").css({"display":"none"});
                    var lvcondition = [];
                    var tabs = $formItem.find(".content_wrap");
                    $formItem.find(".content-tabs").find("li").remove();
                    for (var i=0;i<tabs.length;i++){
                        var tab = $(tabs[i]);
                        var tabText = tab.find(".content_tab_name").val();
                        var tabValue =  $(tab.find("input[name *='listView']")).val();
                        lvcondition.push({text : tabText, value : tabValue});
                        $formItem.find(".content-tabs").append("<li title='"+ tabText+"'>"+tabText+"</li>")
                    }
                    $formItem.find("input[name *='listviews']").val(JSON.stringify(lvcondition));
                    $formItem.find(".content-through-tabs").css({"display":"block"});

                }
                $formItem.find("input[name *='listviews']").trigger("change");
            });

            // 删除该条记录
            $formItem.find(".form_item_delete").on("click",function(event){
                event.stopPropagation();
                event.preventDefault();
                if(self.data.attr.listViews.value.length <= 1){
                    dialog.alert(modelingLang['modeling.keep.lastone']);
                }else{
                    $formItem.remove();
                    self.updateData(true);
                }
            });

            // 标题失焦时，同步标题
            $formItem.find("[name*='formItemTitle']").on("input",function(){
                var val = $(this).val();
                val = val || modelingLang['modeling.Undefined'] ;
                $formItem.find(".form_item_title").html(val);
            });
            // 添加列表视图点击事件
            $formItem.find(".listVieElement").on("click",function(){
                // ___appId：在edit.jsp定义的全局变量
                var url = "/sys/modeling/base/resources/js/dialog/leftNav/leftNavDialog.jsp?isTodo=false";
                var appId = $formItem.find("[name*='listViewAppId']").val();
                dialog.iframe(url,modelingLang["table.modelingAppMobileListView"],function(rtn){
                    if(rtn && rtn.data){
                        self.setValuesAfterListViewDialog(uuId, rtn, $formItem);
                    }
                },{
                    width : 800,
                    height : 500,
                    params : {
                        "cateBean" : "modelingAppModelService",
                        "fdAppId" : appId || ___appId,
                        "dataBean" : "modelingAppMobileListViewService&modelId=!{value}",
                        "isShowCalendar":true
                    }
                });
            });


            /************* 添加事件 end *****************/
            /*	if(this.isCount){
                    self.updateCountBlock(formData.lvCollection, formData.countLv, uuId, $formItem);
                }*/
            self.buildTabItem(formData, attr,$formItem);
            return $formItem;
        },

        buildTabItem   :function(formData, attr,$formItem){

            var listviews = formData.listView;
            var newlistviews = formData.newlistView;
            if (newlistviews instanceof Array  ) {
                if (newlistviews.length > 0) {
                    for (var i = 0; i < newlistviews.length; i++) {
                        var listview = newlistviews[i];
                        var tab = new MiltiListTab({parent: $formItem,widgetKey:this.widgetKey});
                        var $TitemTabs = $($formItem.find(".field_item_listTabs"))
                        $TitemTabs.append(tab.element);
                        $(tab.element).find(".content_tab_name").val(listview.tab);
                        $(tab.element).find("input[name *='listView']").val(listview.value);
                        $(tab.element).find(".listViewText").html(listview.text);
                        $(tab.element).find(".listViewText").attr("title",listview.text);
                        $(tab.element).find(".form_tab_title").html(listview.tab);
                        $(tab.element).find("[name='listViewAppId']").val(listview.appId);
                        $(tab.element).find(".field_item_listTabs").css({"display":"block"});
                        $(tab.element).find("[name='nodeType']").val(listview.nodeType);
                    }
                    $formItem.find(".field_item_listTabs").css({"display":"none"});
                    $formItem.find(".addTabButton").css({"display":"none"});
                    var lvcondition = [];
                    var tabs = $formItem.find(".content_wrap");
                    $formItem.find(".content-tabs").find("li").remove();
                    for (var i=0;i<tabs.length;i++){
                        var tab = $(tabs[i]);
                        var tabText = tab.find(".content_tab_name").val();
                        var tabValue =  $(tab.find("input[name *='listView']")).val();
                        lvcondition.push({text : tabText, value : tabValue});
                        $formItem.find(".content-tabs").append("<li title='"+ tabText+"'>"+tabText+"</li>")
                    }
                    $formItem.find("input[name *='listviews']").val(JSON.stringify(lvcondition));
                    $formItem.find(".content-through-tabs").css({"display":"block"});
                }
            }else if (typeof listviews=='string') {
                //兼容旧数据
                var tab = new MiltiListTab({parent: $formItem,widgetKey:this.widgetKey});
                var $TitemTabs = $($formItem.find(".field_item_listTabs"))
                $TitemTabs.append(tab.element);
                $(tab.element).find(".content_tab_name").val(formData.title);
                $(tab.element).find("input[name *='listView']").val(formData.listView);
                $(tab.element).find(".listViewText").html(formData.listViewText);
                $(tab.element).find(".listViewText").attr("title",formData.listViewText);
                $(tab.element).find(".form_tab_title").html(formData.title);
                $(tab.element).find("[name='listViewAppId']").val("");
                $(tab.element).find(".field_item_listTabs").css({"display":"block"});
                $(tab.element).find("[name='nodeType']").val(formData.nodeType);
                $formItem.find(".field_item_listTabs").css({"display":"none"});
                $formItem.find(".addTabButton").css({"display":"none"});
                var lvcondition = [];
                var tabs = $formItem.find(".content_wrap");
                $formItem.find(".content-tabs").find("li").remove();
                for (var i=0;i<tabs.length;i++){
                    var tab = $(tabs[i]);
                    var tabText = tab.find(".content_tab_name").val();
                    var tabValue =  $(tab.find("input[name *='listView']")).val();
                    lvcondition.push({text : tabText, value : tabValue});
                    $formItem.find(".content-tabs").append("<li title='"+ tabText+"'>"+tabText+"</li>")
                }
                $formItem.find("input[name *='listviews']").val(JSON.stringify(lvcondition));
                $formItem.find(".content-through-tabs").css({"display":"block"});
            }

        },

        setValuesAfterListViewDialog : function(uuId, rtn, $formItem){
            if(this.isCount){
                var views = this.transStrToJson(rtn.data.viewsjson);
                views = this.formatViews(views);
                this.updateCountBlock(views, "", uuId, $formItem);
            }

            $formItem.find(".listViewText").html(rtn.data.text);
            $formItem.find(".listViewText").attr("title",rtn.data.text);
            $formItem.find("[name='"+ uuId +"_listViewText']").val(rtn.data.text);
            $formItem.find("[name='"+ uuId +"_listViewAppId']").val(rtn.appId || ___appId);
            $formItem.find("[name='"+ uuId +"_nodeType']").val(rtn.data.nodetype || rtn.data.nodeType);
            // 此处添加主动触发，是为了更新data
            $formItem.find("[name='"+ uuId +"_listView']").val(rtn.data.value).trigger($.Event("change"));
        },

        // 去除views多余的字段属性
        formatViews : function(views){
            var rs = [];
            for(var i = 0;i < views.length;i++){
                var view = views[i];
                rs.push({text : view.text, value : view.value});
            }
            return rs;
        },

        // 设置总计页签对应哪个页签
        updateCountBlock : function(views, value, uuId, area){
            views = views || [];
            if(views.length > 0){
                area.find(".lvCountWrap").html(this.createCustomSelect(views,value, uuId));
                area.find("[name*='lvCollection']").val(JSON.stringify(views));
            }else{
                area.find(".lvCountWrap").html(this.createCustomSelect(views,value, uuId));
            }
        },

        createCustomSelect : function(views,value, uuId){
            var text = "===请选择===";
            var lvCountHtml = "";
            lvCountHtml += "<div class='model-mask-panel-table-select' style='margin-left:0px'>";
            lvCountHtml += "<p class='model-mask-panel-table-select-val'></p>";
            lvCountHtml += "<div class='model-mask-panel-table-option'>";
            for(var i = 0;i < views.length;i++){
                var lvTab = views[i];
                lvCountHtml += "<div option-value='"+ lvTab.value +"'";
                if(lvTab.value === value){
                    text = lvTab.text;
                }
                lvCountHtml += ">"+ lvTab.text +"</div>";
            }
            lvCountHtml += "</div>";

            lvCountHtml += "<input name='"+ uuId +"_countLv' data-update-event='change' type='hidden' value='"+ value +"' data-validate='countLvRequired'/>";

            lvCountHtml += "</div>";
            var $select = $(lvCountHtml);
            $select.find(".model-mask-panel-table-select-val").html(text);
            // 添加事件
            $select.on("click", function(event) {
                event.stopPropagation();
                $(this).toggleClass("active")
            });
            $select.find(".model-mask-panel-table-option div").on("click", function () {
                var $tableSelect = $(this).closest(".lvCountWrap");
                var $p = $tableSelect.find(".model-mask-panel-table-select-val");
                $p.html($(this).html());

                var selectVal = $(this).attr("option-value");
                $tableSelect.closest(".content_item_form_element").find("[name*='countLv']").val(selectVal).trigger($.Event("change"));
            });
            return $select;
        },
        /****************** 属性配置 end ************************/

        /************** 校验函数 start *******************/
        // 每个校验器必须含有元素的校验和数据的校验
        countLvRequiredValidate : function(dom){
            if(this.isCount){
                this.requiredValidate(dom);
            }
        },

        countLvRequiredDataValidate : function(v){
            if(this.isCount){
                return this.requiredDataValidate(v);
            }
            return true;
        },
        /************** 校验函数 end *******************/
        //获取多语言资源
        getModelingLang :function (){
            return modelingLang;
        },
    });
    var MiltiListTab =  mobileBaseWidget.MobileBaseWidget.extend({

        tempHtml:""+
            "<div class=\"content_wrap\" data-lui-position='fdTag-!{index}'>"+
            "<div class='content_tab'>"+
            "<p class=\"form_tab_title\">"+modelingLang['modeling.bookmark']+"</p>"+
            "<i class=\"form_tab_delete\"></i>"+
            "</div>"+
            "<div class=\"content_item_box\">"+
            "<div class=\"content_item_form_element content_input\">"+
            "<p class=\"content_body_title\">"+modelingLang['modeling.bookmark.name']+"</p>"+
            "<div class=\"content_opt\">"+
            "<input class=\"content_tab_name\" name='{%data.uuId%}_formTabTitle' title='"+modelingLang['modeling.bookmark']+"' type=\"text\" placeholder=\""+modelingLang["modeling.please.enter"]+"\"  data-validate=\"required\" data-update-event='input' data-updateView=\"true\"/>"+
            "</div>"+
            "<p class=\"content_opt_info\"></p>"+
            "</div>"+
            "<div class=\"content_item_form_element content_choose\">"+
            "<p class=\"content_body_title\">"+modelingLang['modeling.Page.content']+"</p>"+
            "<input name=\"listView\" title=\""+modelingLang["table.modelingCollectionView"]+"\"  type=\"hidden\" data-update-event='change' data-validate=\"required\"/>"+
            "<input name=\"listViewText\"  type=\"hidden\" />"+
            "<input name=\"listViewAppId\"  type=\"hidden\" />"+
            "<input name=\"nodeType\"  type=\"hidden\" />"+
            "<div class=\"content_opt listVieElement\">"+
            "<p class=\"listViewText\">"+modelingLang['modeling.page.choose']+"</p>"+
            "<i></i>"+
            "</div>"+
            "<p class=\"content_opt_info\"></p>"+
            "</div>"+
            "</div>"+
            "</div>",

        initProps: function ($super, cfg) {
            $super(cfg);
            this.parent = cfg.parent;
            //初始化1

            this.element =$(this.tempHtml);

            this.widgetKey = cfg.widgetKey;
            this.bindEvent();
        },


        /**
         * 事件绑定
         */
        bindEvent: function () {
            var uuId = "fd_" + parseInt(((new Date().getTime()+Math.random())*10000)).toString(16);
            var $formItem = this.element;
            var self = this;
            // 点击页签，收起和展开内容
            this.element.find(".content_tab").on("click",function(){
                var $itemMain = $formItem.find(".content_item_box");

                $itemMain.slideToggle("normal",function(){
                    //#123054 移动端首页功能区收缩后，间距太多
                    if($itemMain.find(".content_item_box").css("display") == 'none'){
                        $itemMain.find(".content_item_box").css({"display":"none"});
                    }else{
                        $itemMain.find(".content_item_box").removeAttr("style");
                    }
                    $itemMain.toggleClass('multi_shrink');
                });
                $formItem.toggleClass('shrink');
            });
            //删除页签
            this.element.find(".form_tab_delete").on("click",function(){
                $(this).closest(".content_wrap").remove();
                var num = $(self.parent).find(".content_item_box");
                if (num.length==1){
                    self.parent.find(".form_tab_delete").hide();
                }else {
                    $formItem.find(".form_tab_delete:first").show();
                }
            });
            // 页签名字失焦时，同步页签
            this.element.find("[name*='formTabTitle']").on("input",function(){
                var val = $(this).val();
                val = val || modelingLang['modeling.Undefined'];
                $formItem.find(".form_tab_title").html(val);
            });
            var self = this;
            // 添加列表视图点击事件
            this.element.find(".listVieElement").on("click",function(){
                // ___appId：在edit.jsp定义的全局变量
                var url = "/sys/modeling/base/resources/js/dialog/leftNav/leftNavDialog.jsp?isTodo=false";
                var appId = $formItem.find("[name*='listViewAppId']").val();
                dialog.iframe(url,modelingLang["table.modelingAppMobileListView"],function(rtn){
                    if(rtn && rtn.data){
                        self.setValuesAfterListViewDialog(uuId, rtn, $formItem);
                    }
                },{
                    width : 800,
                    height : 500,
                    params : {
                        "cateBean" : "modelingAppModelService",
                        "fdAppId" : appId ||___appId,
                        "dataBean" : "modelingAppMobileListViewService&modelId=!{value}",
                        "isShowCalendar":self.widgetKey === "listView"
                    }
                });
            });

        },
        setValuesAfterListViewDialog : function(uuId, rtn, $formItem){
            if(this.isCount){
                var views = this.transStrToJson(rtn.data.viewsjson);
                views = this.formatViews(views);
                this.updateCountBlock(views, "", uuId, $formItem);
            }

            $formItem.find(".listViewText").html(rtn.data.text);
            $formItem.find(".listViewText").attr("title",rtn.data.text);
            $formItem.find("[name ='listViewText']").val(rtn.data.text);
            $formItem.find("[name ='listViewText']").attr("title",rtn.data.text);
            $formItem.find("[name ='listView']").val(rtn.data.value);
            $formItem.find("[name='listViewAppId']").val(rtn.appId || ___appId);
            $formItem.find("[name='nodeType']").val(rtn.data.nodetype || rtn.data.nodeType);
            // 此处添加主动触发，是为了更新data
            $formItem.find("[name ='listView']").val(rtn.data.value).trigger($.Event("change"));
        }
    })
    exports.MultiListAttrBase = MultiListAttrBase;
})