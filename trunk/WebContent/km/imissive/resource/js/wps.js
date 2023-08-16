(function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined' ? factory(exports) :
        typeof define === 'function' && define.amd ? define(['exports'], factory) :
            (factory((global._wps = {})));
}(this, (function (exports) {
    'use strict';

    /**
     * 启动参数
     */
    var startData = {
        "name": "oaassist",
        "function": "dispatcher",     //wps插件包方法入口
        "info": {
            "fucns": []
        }
    };

    /**
     * 检测WPS，需传入成功和失败的回调函数
     *
     * @param {*} scb
     * @param {*} fcb
     */
    function _checkWPS(scb, fcb) {
        //协议检测
        checkWPSProtocol(scb, fcb);
    }


    /**
     * 启动WPS
     *
     * @param {*} startData
     */
    function _runParams(suffix,params) {
        switch (suffix) {
            case "wps":
            startData.name = "oaassist"
            break;
            case "et":
            startData.name = "etoa";
            break;
            case "wpp":
            startData.name = "wppoa";
            break;
        }
        // _checkWPS(scb, fcb);
        startData.info.fucns = params;
        var data = JSON.stringify(startData);
        var result = base64.encode(data);
        launchwps(suffix, result);
    }

    function _inArray(suffix, array) {
        for (var i = 0; i < array.length; i++) {
            if (suffix.indexOf(array[i]) != -1)
                return true;
        }
        return false;
    }

    // 通过后缀返回组件名
    function getWpsComponentBySuffix(suffix) {
        var wpsSuffix = ["doc", "docx", "wps", "wpsx"];
        var etSuffix = ["xls", "xlsx", "et", "etx"];
        var wppSuffix = ["ppt", "pptx", "dps", "dpsx"];
        suffix = suffix.toLowerCase();
        if (_inArray(suffix, wpsSuffix)) {
            return "wps";  //文字
        }
        else if (_inArray(suffix, etSuffix)) {
            return "et";  //表格
        }
        else if (_inArray(suffix, wppSuffix)) {
            return "wpp";  //演示
        }
        else {
            alert("无效后缀");
        }
    }


    /**
     * 定义一个变量 用于apiGroup 因为不支持直接输入中文
     * @apiDefine doc 文档相关
     */
    /**
     * 定义一个变量 用于apiGroup 因为不支持直接输入中文
     * @apiDefine et 表格相关
     */
    /**
     * 定义一个变量 用于apiGroup 因为不支持直接输入中文
     * @apiDefine ppt PPT相关
     */

    /**
     * @apiDeprecated 新的直接使用OpenDoc()
     * @api _wps.newDoc(params) 新建文档
     * @apiVersion 3.1.0
     * @apiName newDoc
     * @apiDescription 新建文档，直接调用newDoc即可，传参参考下面说明
     * @apiExample {js} 新建文档
     * _wps.newDoc({
     *     "uploadPath": "http://dev.wpseco.cn/file/uploadFromWps", //保存文档接口
     *     "strBookmarkDataPath": strBookmarkDataPath,//书签列表接口
     *     "templatePath": templatePath,//正文模板列表接口
     *     "buttonGroups": "btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate"
     * })
     * @apiGroup doc
     *
     * @apiParam {Object} params 请求的JSON，具体参数说明看下面数据
     * @apiParam {string} params.uploadPath 文档保存路径(必传)
     * @apiParam {string} params.strBookmarkDataPath 书签列表 (可不传，可以在OA助手config.js中配置)
     * @apiParam {string} params.templatePath 模板列表 (可不传，可以在OA助手config.js中配置)
     * @apiParam {string} params.buttonGroups 自定义按钮组 （可不传，不传显示所有按钮）
     */
    function newDoc(params) {
        _runParams("wps",[{"OpenDoc": params}])
    }

    /**
     * @api _wps.openDoc(params) 打开指定文档
     * @apiVersion 3.1.0
     * @apiName openDoc
     * @apiDescription 打开指定文档，可以通过参数控制打开文档格式，格式转换保存，禁止复制粘贴等，参照下面实例，也可一起配合调用。
     * @apiExample {js} 新建文档
     * _wps.openDoc({
     *     "docId": "文档ID",
     *     "uploadPath": "保存文档接口",
     *   //"fileName": "不传fileName即为新建空文档",
     * });
     * @apiExample {js} 打文指定文档
     * _wps.openDoc({
     *     "docId": "文档ID",
     *     "uploadPath": "保存文档接口",
     *     "fileName": "获取服务器文档接口",
     * });
     * @apiExample {js} 保护模式打开
     * _wps.openDoc({
     *     "docId": "文档ID",
     *     "uploadPath": "保存文档接口",
     *     "fileName": "获取服务器文档接口",
     *     "openType": {       //文档打开方式 ，不传正常打开
     *         "protectType": 3, //文档保护类型，-1：不启用保护模式，0：只允许对现有内容进行修订，1：只允许添加批注，2：只允许修改窗体域，3：只读
     *         "password": "123456"
     *     }
     * });
     * @apiExample {js} 控制痕迹打开
     * _wps.openDoc({
     *     "docId": "文档ID",
     *     "uploadPath": "保存文档接口",
     *     "fileName": "获取服务器文档接口",
     *     "userName": "用于更改显示修改人的用户名",
     *     "revisionCtrl":{  //痕迹控制 ，不传正常打开
     *         "bOpenRevision":true, //true(打开)false(关闭)修订
     *         "bShowRevision":true  //true(显示)/false(关闭)痕迹
     *     }
     * });
     * @apiExample {js} 保存文档转为pdf、UOT、UOF等
     * _wps.openDoc({
     *     "docId": "文档ID",
     *     "uploadPath": "保存文档接口",
     *     "fileName": "获取服务器文档接口",
     *     "suffix": ".pdf|.uot" //可传多个，用“|”分割，保存时会按照所传的值转成对应的格式文档并上传
     * });
     * @apiGroup doc
     *
     * @apiParam {Object} params 请求的JSON，具体参数说明看下面数据
     * @apiParam {String} params.docId 文档ID
     * @apiParam {String} params.uploadPath 保存文档接口
     * @apiParam {String} params.fileName 获取服务器文档接口（不传即为新建空文档）      
     * @apiParam {String} params.suffix ".pdf|.uot"，可传多个，用“|”分割，保存时会按照所传的值转成对应的格式文档并上传
     * @apiParam {String} params.userName 用于更改显示修改人的用户名
     * @apiParam {string} params.strBookmarkDataPath 书签列表 (可不传，可以在OA助手config.js中配置)
     * @apiParam {string} params.templatePath 模板列表 (可不传，可以在OA助手config.js中配置)
     * @apiParam {string} params.buttonGroups 自定义按钮组 （可不传，不传显示所有按钮）
     * @apiParam {String} params.revisionCtrl 痕迹控制 ，不传正常打开
     * @apiParam {String} params.revisionCtrl.bOpenRevision true(打开)false(关闭)修订
     * @apiParam {String} params.revisionCtrl.bShowRevision true(显示)/false(关闭)痕迹
     * @apiParam {String} params.openType 文档打开方式 ，不传正常打开
     * @apiParam {String} params.openType.protectType 文档保护类型，-1：不启用保护模式，0：只允许对现有内容进行修订，1：只允许添加批注，2：只允许修改窗体域，3：只读
     * @apiParam {String} params.openType.password 密码
     */
    var openDoc = function openDoc(params, funcs) {
        var data = [];
        data.push({"OpenDoc": params});
        if (funcs && funcs.length > 0) {
            for (var i = 0; i < funcs.length; i++) {
                data.push(funcs[i])
            }
        }
        _runParams("wps",data)
    };

    /**
     * @api _wps.onlineEditDoc(params) 在线编辑文档（文档不落地）
     * @apiVersion 3.1.0
     * @apiName onlineEditDoc
     * @apiDescription 从OA系统打开一个指定文档进行编辑时，采用文档不落地的方式打开文档，可以保证文档的安全性，并且不会在本地留有文件的缓存数据
     * @apiExample {js} 文档不落地
     * _wps.onlineEditDoc({
     *      "docId": docId, //文档ID
     *      "uploadPath": url + this.getPath("file/upload?id=" + docId), //保存文档接口
     *      "fileName": url + this.getPath("file/download/" + docId), //根据文档id获取服务器文档接口
     *      "strBookmarkDataPath": url + this.getPath("bookmark/getAllBookmark"),//书签列表接口
     *      "templatePath": url + this.getPath("template/paging"),//正文模板列表接口
     *      "buttonGroups": "btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate",
     *      "userName": '王五'//用户名
     *  })
     * @apiGroup doc
     *
     * @apiParam {Object} params 请求的JSON，具体参数说明看下面数据
     * @apiParam {string} params.docId 文档ID
     * @apiParam {string} params.uploadPath 文档保存路径(必传)
     * @apiParam {string} params.fileName 文档下载路径(必传)
     * @apiParam {string} params.strBookmarkDataPath 书签列表 (可不传，可以在OA助手config.js中配置)
     * @apiParam {string} params.templatePath 模板列表 (可不传，可以在OA助手config.js中配置)
     * @apiParam {string} params.buttonGroups 自定义按钮组 （可不传，不传显示所有按钮）
     */
    var onlineEditDoc = function onlineEditDoc(params) {
        _runParams("wps",[{"onlineEditDoc": params}])
    };

    /**
     * @api _wps.insertRedHeadDocFromWeb(params,templateURL,replaceBookMark) 套红头
     * @apiVersion 3.1.0
     * @apiName insertRedHeadDocFromWeb
     * @apiDescription 1.从WPS的OA助手菜单上点击【套红头】，在弹出的红头列表对话框中选择一个指定的红头模板，点击【选择模板】按钮，就会将红头文件插入到当前文档的顶部 <br?>
     * 2.从OA系统界面点击【套红头】，其中，红头模板通过参数templateURL传入，模板中的书签通过参数replaceBookMark传入，若模板中存在对应书签，则会将当前文档的正文插入到书签所在位置；若不存在对应书签，则会弹出提示信息
     * (支持多次点击套后按钮，和重复套红头)
     * @apiExample {js} 套红头
     * _wps.insertRedHeadDocFromWeb({
     *     "docId": fileId, //文档ID
     *     "uploadPath": url + dispatch.getPath("file/upload?id=" + fileId), //保存文档接口
     *     "fileName": url + dispatch.getPath("file/download/" + fileId), //根据文档id获取服务器文档接口
     *     "buttonGroups": "btnInsertRedHeader",
     * },url + dispatch.getPath("file/download/" + templateId),"Content");//红头模板中填充正文的位置书签名
     * @apiGroup doc
     *
     * @apiParam {Object} params 请求的JSON，具体参数说明看下面数据
     * @apiParam {string} params.docId 文档ID
     * @apiParam {string} params.uploadPath 文档保存路径(必传)
     * @apiParam {string} params.fileName 文档下载路径(必传)
     * @apiParam {string} params.buttonGroups 自定义按钮组 （可不传，不传显示所有按钮）
     * @apiParam {string} templateURL 红头文件的获取路径
     * @apiParam {string} replaceBookMark 正文你换的书签名
     */
    var insertRedHeadDocFromWeb = function insertRedHeadDocFromWeb(params, templateURL, replaceBookMark) {
        var data = [];
        data.push({"OpenDoc": params});
        if (templateURL && replaceBookMark) {
            data.push({"insertRedHeadDocFromWeb": {"templateURL": templateURL, "replaceBookMark": replaceBookMark}})
        }
        _runParams("wps",data)
    };

    /**
     * @api _wps.fillTemplate(params) 填充模板
     * @apiVersion 3.1.0
     * @apiName fillTemplate
     * @apiDescription <P>说明：dataFromWeb 和 dataFromServer 都传的话，dataFromServer中数据会覆盖dataFromWeb中的数据。填充模板的逻辑也是先打开文档，再根据数据源，匹配书签一一插入数据。
     * 填充的数据格式：name: 书签的名称 ， text：填充的内容， type: 填充内容的格式，（link : 从链接获取内容，比如说直接下载文档，text 或者不填都为文本，pic: 图片地址,table：填充表格数据）
     * @apiExample {js} 填充模板
     *_wps.openDoc({
     *      "docId": docId, //文档ID
     *      "fileName": "http://dev.wpseco.cn/wps-oa/template/getFileData/98",
     *      "uploadPath": uploadPath + docId, //保存文档接口
     *  }, [
     *          {
     *              "fillTemplate": {
     *                  "dataFromWeb": [{"name": "FirstTitle", "text": "web"}, {
     *                      "name": "TopTitle1",
     *                      "text": "军参谋-web"
     *                  }, {"name": "TopTitle2", "text": "通信-web"}, {
     *                      "name": "ContentTitle",
     *                      "text": "空军内部使用办文助手-web"
     *                  }, {"name": "Company", "text": "空军参谋部-web"}, {
     *                      "name": "Contactor",
     *                      "text": "李四-web"
     *                  }, {"name": "Telephone", "text": "26874"}, {
     *                      "name": "Content",
     *                      "text": fileName,
     *                      "type": "link"
     *                  }, {"name": "table_index",
     *                      "text": ["zhangsan", "18", "nan", "lis", "19", "nan", "wangwu", "20", "nan", "zhaoliu", "21", "nv", "sunqi", "22", "nv"],
     *                      "type": "table"
     *                  }], 
     *                  // "dataFromServer": "http://dev.wpseco.cn/wps-oa/document/getData"   //后台获取数据的接口,
     *              } 
     *          }
     *      ])
     *  }
     * @apiGroup doc
     *
     * @apiParam {Object} fillTemplate 填充模板传递的数据
     * @apiParam {string} params.dataFromWeb 从web页面传递的数据
     * @apiParam {string} params.dataFromServer 从服务器获取的数据
     */
    var fillTemplate = function fillTemplate(params) {
        _runParams("wps",[{"UseTemplate": params}])
    };

    /**
     * @api _wps.openET(params) 打开表格文档
     * @apiVersion 2.0.0
     * @apiName openET
     * @apiDescription 打开表格类文档
     * @apiExample {js} 新建文档
     * _wps.openET({
     *      "uploadPath":"http://dev.wpseco.cn/wps-oa/document/saveFile?docId=4257",
     *      "fileName":"http://dev.wpseco.cn/wps-oa/document/getFileData/4257",
     *      "buttonGroups": "btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate",
     *  })
     * @apiGroup et
     *
     * @apiParam {Object} params 请求的JSON，具体参数说明看下面数据
     * @apiParam {string} params.uploadPath 文档保存路径(必传)
     * @apiParam {string} params.fileName 获取服务器文档接口
     * @apiParam {string} params.buttonGroups 自定义按钮组 （可不传，不传显示所有按钮）
     */
    var openET = function openET(params){
        _runParams("et",[{"OpenDoc": params}])
    }

    /**
     * @api _wps.openWpp(params) 打开PPT文档
     * @apiVersion 2.0.0
     * @apiName openWpp
     * @apiDescription 打开PPT文档
     * @apiExample {js} 新建文档
     * _wps.openWpp({
     *      "uploadPath":"http://dev.wpseco.cn/wps-oa/document/saveFile?docId=4257",
     *      "fileName":"http://dev.wpseco.cn/wps-oa/document/getFileData/4257",
     *      "buttonGroups": "btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate",
     *  })
     * @apiGroup ppt
     *
     * @apiParam {Object} params 请求的JSON，具体参数说明看下面数据
     * @apiParam {string} params.uploadPath 文档保存路径(必传)
     * @apiParam {string} params.fileName 获取服务器文档接口
     * @apiParam {string} params.buttonGroups 自定义按钮组 （可不传，不传显示所有按钮）
     */
    var openWpp = function openWpp(params){
        _runParams("wpp",[{"OpenDoc": params}])
    }
    exports.openDoc = openDoc;
    exports.newDoc = newDoc;
    exports.onlineEditDoc = onlineEditDoc;
    exports.insertRedHeadDocFromWeb = insertRedHeadDocFromWeb;
    exports.fillTemplate = fillTemplate;
    exports.openET = openET;
    exports.openWpp = openWpp;
    Object.defineProperty(exports, '__esModule', {value: true});

    // 签章使用
    // 选择书签
    // 转pdf
    // 定制按钮组合
    // 打开关闭修订
    // 打印
    // 文档校对
    /**
     * "picturesPath":"展示所有图片路径",
     "redHeadsPath":"展示所有红头路径",
     "getPicturePath":"获得某张图片路径，插件会在后面拼接上图片id", // json数据格式    [{tempId:1,tempName:图片名称1},{tempId:2,tempName:图片名称2}]


     "originWidthHeight":1,//1 为采用原始宽高,不需要传递picHeight，picWidth  ，0为不采用原始宽高，为0可以设置picHeight，picWidth
     "picHeight":200,  //图片高度
     "picWidth":200, //图片宽度

     //是否有图片权限认证 validatePath有值是， 如果不需要，则不传这个数据
     //拼接用户名密码，盖章的时候   validatePath+"?userName="+userName+"password="+password;
     "validatePath":"http://dev.wpseco.cn/wps-oa/redHead/paging",//验证盖章权限url  通过，返回字符串"auth"，不通过，返回空
     "getRedHeadPath":"http://dev.wpseco.cn/wps-oa/redHead/getFileData/" ,    //获得某个红头路径，红头模板里面有zhengwen书签 // json数据格式    [{tempId:1,tempName:红头名称1},{tempId:2,tempName:红头名称2}]

     //searchPath + "?content=" + document.getElementById("content").value;
     "searchPicturePath":"http://dev.wpseco.cn/wps-oa/redHead/paging" , //图片用查询条件搜索过滤的路径,如果不需要，则不传这个数据
     // searchPath + "?content=" + document.getElementById("content").value;
     "searchRedHeadPath":"http://dev.wpseco.cn/wps-oa/redHead/paging"  //红头用查询条件搜索过滤的路径,如果不需要，则不传这个数据
     */
})));
