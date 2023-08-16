var userAgent = navigator.userAgent, 
				rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
				rFirefox = /(firefox)\/([\w.]+)/, 
				rOpera = /(opera).+version\/([\w.]+)/, 
				rChrome = /(chrome)\/([\w.]+)/, 
				rSafari = /version\/([\w.]+).*(safari)/;
				var browser;
				var version;
				var ua = userAgent.toLowerCase();
				function uaMatch(ua) {
					var match = rMsie.exec(ua);
					if (match != null) {
						return { browser : "IE", version : match[2] || "0" };
					}
					var match = rFirefox.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rOpera.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rChrome.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rSafari.exec(ua);
					if (match != null) {
						return { browser : match[2] || "", version : match[1] || "0" };
					}
					if (match != null) {
						return { browser : "", version : "0" };
					}
				}
				var browserMatch = uaMatch(userAgent.toLowerCase());
				if (browserMatch.browser) {
					browser = browserMatch.browser;
					version = browserMatch.version;
				}

var ActiveHtml = '';
var copyright='金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAJ8BAACgAQAALAAAAPfx4cnr7n2wjo/4SpF61QY7nXOgBBDO6Jy5KlTSFqJqypb3pQghCXHbaaTyOX9kkpOrk0VkKiZ4ZmVvyEagEkyVHA3sgitPuGyLdLq5XNAqPAwBDPlZRT6JuiBALojluntS9ePtB9NO5fDsv5b1vUbeHm0RAYW47UKyppnYZ/v7k9HEdSlTmM+04FexHI7fJU89x3hySglu/pQyWmskSsDcxqLLiWNJ1Lt6HnBTTmbfqBGImQndkAPMz4UIDLUc0KrrVyrlx4SEPxUrN4HshfKKn4N6haPZsDX9L6R7bGS3MBkRArFJ+mUcGZPyx+V0N5ZQHugbl9XiBB9ry/ldP3oh8FdRHu8QCnkT7oAymJ6b98ujQh8nLFe3drQM2r3dPt0I8UUMQgOGvGHNDT72tl5ylusGNeXf2pg5W3ViOvPSwNiGseZ+A8PD6BPIl+MOw9mP+pebfqDYLUhUmrDFg67PoNbHxMrKTYBDfm1VnwdN534EhtKh0T/+LYNWukWDg5o2xuhMDKzpozs+FpOouApA2egseM1izQLLViFa6D7YPVXJ1mbb29W5raldlhhU9g==';
var ofd = {};

//7.1插件初始化window.init=function(divID, width, height) {
function init_ofdcy(divID, width, height) {
	
	if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window)
	{
		ActiveHtml+="<object id='surread' WIDTH='"+width+"' HEIGHT='"+height+"'";
		ActiveHtml += " CLASSID='CLSID:5a22176d-118f-4185-9653-9f98958a6df8'";
		ActiveHtml += ">";
		ActiveHtml += "<param name='Copyright' value='" + copyright + "'>";
	
	}
	else if (browser == "chrome") 
	{
		if(navigator.platform=="Win32"){
			ActiveHtml +="<object id='surread' WIDTH='"+width+"' HEIGHT='"+height+"'";
			ActiveHtml += " clsid='CLSID:5a22176d-118f-4185-9653-9f98958a6df8'";        
			ActiveHtml += " type='application/kg-plugin'";   //KGChromePlugin插件件type
			ActiveHtml += "OnOpen='OnOpen'"
			ActiveHtml += "OnClose='OnClose'"
			ActiveHtml += "OnAddSignature='OnAddSignature'"
			ActiveHtml += "OnDelSignature='OnDelSignature'"
			ActiveHtml += "OnModSignature='OnModSignature'"
			ActiveHtml += "OnPageNoChange='OnPageNoChange'"
			ActiveHtml += "OnPrintStart='OnPrintStart'"
			ActiveHtml += "OnPluginLoadFinished='OnPluginLoadFinished'"
			ActiveHtml += " Copyright='" + copyright + "'";
			ActiveHtml += ">";

		}else{
			ActiveHtml +="<object id='surread' WIDTH='"+width+"' HEIGHT='"+height+"'";
			ActiveHtml += " clsid='CLSID:5a22176d-118f-4185-9653-9f98958a6df8'";        
			ActiveHtml += " type='application/surread'";   //KGChromePlugin插件件type
			ActiveHtml += " Copyright='" + copyright + "'";
			ActiveHtml += ">";
		}

	}
	else if (browser == "firefox") 
	{
		ActiveHtml+="<object id='surread' WIDTH='"+width+"' HEIGHT='"+height+"'";
		ActiveHtml += " clsid='CLSID:5a22176d-118f-4185-9653-9f98958a6df8'";  
		ActiveHtml += ' type="application/surread"';
		ActiveHtml += " Copyright='" + copyright + "'";
		ActiveHtml += ">";
	}
	ActiveHtml += "</object>";	
	document.getElementById(divID).innerHTML=ActiveHtml;
    ofd.surread = document.getElementById("surread");
    return ofd;
};


//7.2获取插件版本信息 string getPluginVersion()
ofd.onGetPluginVersion=function()
{
		
	return surread.getPluginVersion();//返回值包含日期信息（YYYYMMDD）
}

//7.3.1打开本地文档 boolean openFile（strURL，readOnly）
//strURL：文件名，可以是本地文件，也可以是远程文件
//readOnly：是否以只读方式打开，true：只读方式，false：可编辑（注释或盖章）方式打开
ofd.onOpenFile=function(strURL,mode)
{
	return  ofd.surread.openFile(strURL, mode);//true：只读方式，false：读写方式

}
//7.3.2保存文档 boolean saveFile（strURL）
//strURL：文件名，可以是本地文件
ofd.onSaveFile=function(strURL)
{
	return ofd.surread.saveFile(strURL);

}
//7.3.3打印文件void printFile（docName bGray）
// docName：发送到打印机的打印任务名称
//bGray：是否灰度打印，true表示灰度打印,false表示正常打印
ofd.onPrintFile=function(docName,bGray)
{
	var surread = document.getElementById("surread");	
	return surread.printFile(docName,bGray);

}
// 7.3.4关闭文档 boolean closeFile()
ofd.onCloseFile=function()
{
	var ret = ofd.surread.closeFile();
}
//7.4.1显示/隐藏组件 void setCompositeVisible(CompName, bVisible)
//CompName：按钮或组件标识,具体如下：
//显示/隐藏菜单栏：w_menu 
//显示/隐藏工具栏：w_tool 
//显示/隐藏底部工具栏： w_ statusbar
//显示/隐藏导航栏（文档结构图）：w_navigator
//bVisible：是否可见，true可见，false不可见
ofd.onSetCompositeVisible=function(CompName,bVisible)
{
	ofd.surread.setCompositeVisible(CompName, bVisible);
}
//7.4.2启用/禁用组件 void setCompositeEnable(ComName，bEnable)
//ComName：界面元素标识
//打开：f_open   
//导入文件：f_import 
//导出文件：f_export  
//保存：f_save 
//另存为：f_saveas 
//打印：f_print 
//关闭：f_close 
//盖章：d_sealsign  
//盖骑缝章：d_crosssign  
//验章：d_verifysign 
//删除签章：d_deletesign 
ofd.onSetCompositeEnable=function(ComName,bEnable)
{

	ofd.surread.setCompositeEnable(ComName, bEnable);
	
}
//7.4.3设置视图首选项 void setViewPreference(key,val)
//key：表示首选项名称 navigator
//val：表示首选项值 
//none:不显示导览；
//outline:显示大纲导览； 
//thumbnail:显示缩略图导览；
//semanteme:显示语义导览；
ofd.onSetViewPreference=function(val)
{	
	ofd.surread.setViewPreference("navigator", val); //none outline thumbnail semanteme
}
//7.4.4设置页面显示比例 void setZoomRadio(zoomValue)
//zoomValue页面显示比例值
ofd.onSetZoomRadio=function(zoomValue)
{
	ofd.surread.setZoomRadio(zoomValue);
}
//7.4.5获取页面显示比例 float getZoomRadio()
//返回页面显示比例值
ofd.onGetZoomRadio=function()
{
	return  ofd.surread.getZoomRadio();
	
}
//7.5.1设置用户名 boolean setUserName(userName)
//userName:用户名
ofd.onSetUserNam=function(username)
{
	return ofd.surread.setUserName(username);

}
//7.5.2获取用户名 string getUserName()
ofd.onGetUserName=function()
{
	return ofd.surread.getUserName();
	
}
//7.5.3设置印章标识 vold setSealId(selid)
//selid：印章的标识
ofd.onSetSealId=function(selid)
{
	ofd.surread.setSealId(selid);
}
//7.5.4设置文档元数据 vold setMetaData(id, val)
//id:元数据的名称
//val:元数据的值
ofd.onSetMetaData=function(id,val)
{
	ofd.surread.setMetaData(id,val);
}
//7.5.5获取文档元数据 string getMetaData(id)
//id:元数据的名称
ofd.onGetMetaData=function(id)
{
	return ofd.surread.getMetaData(id);

}
//7.5.6设置日志服务地址 vold setLogSvrURL(url)
//url：日志服务地址
ofd.onSetLogSvrURL=function(url)
{
	ofd.surread.setLogSvrURL(url);
}

ofd.onAddTrackInfo=function()
{
	ofd.surread.addTrackInfo("<setinfo type=\"barinfo\"><parameter name=\"type\" value=\"0\"/><parameter name=\"pages\" value=\"1\"/><parameter name=\"rotate\" value=\"0\"/><parameter name=\"printable\" value=\"0\"/><parameter name=\"alignMode\" value=\"1\"/><parameter name=\"offsetY\" value=\"1\"/><parameter name=\"offsetX\" value=\"5\"/><parameter name=\"alpha\" value=\"50\"/><parameter name=\"fontName\" value=\"宋体\"/><parameter name=\"fontSize\" value=\"28\"/><parameter name=\"color\" value=\"#00FFFF\"/><parameter name=\"text\" value=\"KINGGRID\"/></setinfo>");
}
//7.6.2清除追踪水印 void clearTrackInfo()
ofd.onClearTrackInfo=function()
{
	ofd.surread.clearTrackInfo();
}
//7.7获取语义内容 string getTaggedText(tagid)
//tagid:语义标引的唯一定位符
ofd.onGetTaggedText=function(tagid)
{
	return ofd.surread.getTaggedText(tagid);
	
}
//7.8获取日志文件路径 string getLogFilePath()
//成功返回日志文件的路径，失败反馈null
ofd.onGetLogFilePath=function()
{
	return ofd.surread.getLogFilePath();
	
}


