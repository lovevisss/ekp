function checkBrowser() {
    var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
    var isEdge = navigator.userAgent.indexOf("Edge") > -1; //判断是否IE的Edge浏览器
    var ua = navigator.userAgent.toLowerCase();
    var ieVersion = 6;
    var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
    reIE.test(navigator.userAgent);
    var fIEVersion = parseFloat(RegExp["$1"]);
    if (fIEVersion == 7) {
        ieVersion = 7;
    } else if (fIEVersion == 8) {
        ieVersion = 8;
    } else if (fIEVersion == 9) {
        ieVersion = 9;
    } else if (fIEVersion == 10) {
        ieVersion = 10;
    } else if (navigator.userAgent.toLowerCase().match(/rv:([\d.]+)\) like gecko/)) {
        ieVersion = 11;
    } else {
        ieVersion = 6;
    }

    return {
        isOpera: isOpera,
        isFirefox: typeof InstallTrigger !== 'undefined',
        isSafari: (~ua.indexOf('safari') && !~ua.indexOf('chrome')) || Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0,
        isIOS: /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream,
        isChrome: !!window.chrome && !isOpera,
        isIE: /*@cc_on!@*/ false || !!document.documentMode, // At least IE6
        isEdge: isEdge,
        ieVersion: ieVersion
    }
}

function getWPSRunUrl(appName) {
    appName = appName.toLowerCase();
    if (appName == "wps") {
        return "http://localhost:58890/wps/runParams";
    } else if (appName == "et") {
        return "http://localhost:58890/et/runParams";
    } else if (appName == "wpp") {
        return "http://localhost:58890/wpp/runParams";
    } else {
        alert("无效字符串");
    }
}

function getWPSWebStartupHead(appName) {
    appName = appName.toLowerCase();
    if (appName == "wps") {
        return "ksowebstartupwps://";
    } else if (appName == "et") {
        return "ksowebstartupet://";
    } else if (appName == "wpp") {
        return "ksowebstartupwpp://";
    } else {
        alert("无效字符串");
    }
}

function launchKsoWebStartup(uri, appname, data) {
    jQuery.support.cors = true;
    window.location.href = uri;
    // $.ajax({
    //     type: 'get',
    //     url: uri,
    //     cache: false,
    //     async: false,
    //     dataType: 'json',
    //     success: function (data) {
    //     }
    // })
    if (data.indexOf(getWPSWebStartupHead(appname)) == -1)
        data = getWPSWebStartupHead(appname)+ data
    setTimeout(function () {
        postData(getWPSRunUrl(appname), data, 5);
    }, 2000)
}

function postData(runUrl, data, i) {
    jQuery.support.cors = true;
    $.ajax({
        url: runUrl,
        async: false,
        data: data,
        method: "post",
        dataType: "text",
        success: function (response) {
        },
        error: function (msg) {
            i--;
            if (i > 0) {
                postData(runUrl, data, i)
            }
        }
    });
}

function launchwps(appname, data) {
    // window.onbeforeunload = null
    launchKsoWebStartup("ksoWPSCloudSvr://start=RelayHttpServer", appname, data);
}

