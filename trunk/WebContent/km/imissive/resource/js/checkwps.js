function getIEVersion() {
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
        ieVersion = 0;
    }
    return ieVersion;
}

// 检测本地wps版本是否带有指定的flag
function checkWPSFlag(flag, successcb, failcb, i) {
    jQuery.support.cors = true;
    $.ajax({
        type: 'get',
        url: 'http://localhost:58890/kso/productinfo?product=CustomerFlag',
        cache: false,
        async: false,
        dataType: 'json',
        success: function (data) {
            try {
                if (data.result == flag)
                    successcb();
                else
                    failcb();
            }
            catch (e) {
                failcb();
            }
        },
        error: function (xhr, status, error) {
            i--;
            if (i > 0) {
                checkWPSFlag(flag, successcb, failcb, i)
            }
            else {
                failcb();
            }
        }
    });
}

function checkWPSFlagInNewWindowHack(uri, flag, successcb, failcb) {
    var myWindow = window.open('', '', 'width=0,height=0');

    myWindow.document.write("<iframe src='" + uri + "'></iframe>");

    setTimeout(function () {
        try {
            myWindow.location.href;
            myWindow.setTimeout("window.close()", 1000);
            checkWPSFlag(flag, successcb, failcb, 2);
        } catch (e) {
            myWindow.close();
            failcb();
        }
    }, 1000);
}

function checkWPSFlagInNewWindowHackIE9(uri, flag, successcb, failcb) {
    var myWindow = window.open('', '', 'width=0,height=0');

    myWindow.document.write("<iframe src='" + uri + "'></iframe>");

    var timer;
    var IfWindowClosed = function () {
        if (myWindow.closed == true) {
            checkWPSFlag(flag, successcb, failcb, 2);
            window.clearInterval(timer)
        }
    }

    timer = window.setInterval(IfWindowClosed, 300);
    setTimeout(function () {
        try {
            myWindow.location.href;
            myWindow.setTimeout("window.close()", 300);
        } catch (e) {
            myWindow.close();
            failcb();
        }
    }, 300);
}

function checkWPSFlagDelay(uri, flag, successcb, failcb) {
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
    setTimeout(function () {
        checkWPSFlag(flag, successcb, failcb, 2);
    }, 1000);
}

function checkWPSVersion(flag, successcb, failcb) {
    if (getIEVersion() == 8) {
        checkWPSFlagInNewWindowHack("ksoWPSCloudSvr://start=RelayHttpServer", flag, successcb, failcb);
    } else if (getIEVersion() == 9 || getIEVersion() == 10 || getIEVersion() == 11) {
        checkWPSFlagInNewWindowHackIE9("ksoWPSCloudSvr://start=RelayHttpServer", flag, successcb, failcb);
    }
    else {
        checkWPSFlagDelay("ksoWPSCloudSvr://start=RelayHttpServer", flag, successcb, failcb)
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 检测本地是否支持wps协议
function checkWPSProtocolInner(successcb, failcb, i) {
    jQuery.support.cors = true;
    $.ajax({
        type: 'get',
        url: 'http://localhost:58890/kso/protocolcheck?protocol=KsoWebStartupWPS',
        cache: false,
        async: false,
        dataType: 'json',
        success: function (data) {
            try {
                if (data.result == "true")
                    successcb();
                else
                    failcb();
            }
            catch (e) {
                failcb();
            }
        },
        error: function (xhr, status, error) {
            i--;
            if (i > 0) {
                checkWPSProtocolInner(successcb, failcb, i)
            }
            else {
                failcb();
            }
        }
    });
}

function checkWPSProtocolInNewWindowHack(uri, successcb, failcb) {
    var myWindow = window.open('', '', 'width=0,height=0');

    myWindow.document.write("<iframe src='" + uri + "'></iframe>");

    setTimeout(function () {
        try {
            myWindow.location.href;
            myWindow.setTimeout("window.close()", 1000);
            checkWPSProtocolInner(successcb, failcb, 2);
        } catch (e) {
            myWindow.close();
            failcb();
        }
    }, 1000);
}

function checkWPSProtocolInNewWindowHackIE9(uri, successcb, failcb) {
    var myWindow = window.open('', '', 'width=0,height=0');

    myWindow.document.write("<iframe src='" + uri + "'></iframe>");

    var timer;
    var IfWindowClosed = function () {
        if (myWindow.closed == true) {
            checkWPSProtocolInner(successcb, failcb, 2);
            window.clearInterval(timer)
        }
    }

    timer = window.setInterval(IfWindowClosed, 300);
    setTimeout(function () {
        try {
            myWindow.location.href;
            myWindow.setTimeout("window.close()", 300);
        } catch (e) {
            myWindow.close();
            failcb();
        }
    }, 300);
}

function checkWPSProtocolDelay(uri, successcb, failcb) {
    jQuery.support.cors = true;
    window.location.href = uri;
    //防止检测的时候触发 window.onbeforeunload 事件
    // $.ajax({
    //     type: 'get',
    //     url: uri,
    //     cache: false,
    //     dataType: 'json',
    //     success: function (data) {
    //     }
    // })
    setTimeout(function () {
        checkWPSProtocolInner(successcb, failcb, 2);
    }, 1000);
}

function checkWPSProtocol(successcb, failcb) {
    if (getIEVersion() == 8) {
        checkWPSProtocolInNewWindowHack("ksoWPSCloudSvr://start=RelayHttpServer", successcb, failcb);
    } else if (getIEVersion() == 9 || getIEVersion() == 10 || getIEVersion() == 11) {
        checkWPSProtocolInNewWindowHackIE9("ksoWPSCloudSvr://start=RelayHttpServer", successcb, failcb);
    }
    else {
        checkWPSProtocolDelay("ksoWPSCloudSvr://start=RelayHttpServer", successcb, failcb)
    }
}
//协议检测失败回调
function fcb() {
    alert("您的WPS版本未集成OA助手，请打开【下载中心】页面下载安装\"");
    return;
}
//协议检测成功回调
function scb() {
    console.log("Support WPS");
}