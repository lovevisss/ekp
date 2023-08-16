<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("optbar.js|list.js");
</script>
<script>
 function expandMethod(thisObj) {
	var isExpand=thisObj.getAttribute("isExpanded");
	if(isExpand==null)
		isExpand="0";
	var trObj=thisObj.parentNode;
	trObj=trObj.nextSibling;
	while(trObj!=null){
		if(trObj!=null && trObj.tagName=="TR"){
			break;
		}
		trObj = trObj.nextSibling;
	}
	var imgObj=thisObj.getElementsByTagName("IMG")[0];
	if(trObj.tagName.toLowerCase()=="tr"){
		if(isExpand=="0"){
			trObj.style.display="";
			thisObj.setAttribute("isExpanded","1");
			imgObj.setAttribute("src","${KMSS_Parameter_StylePath}icons/collapse.gif");
		}else{
			trObj.style.display="none";
			thisObj.setAttribute("isExpanded","0");
			imgObj.setAttribute("src","${KMSS_Parameter_StylePath}icons/expand.gif");
		}
	}
 }
</script>


<div id="optBarDiv"><input type="button"
	value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${param.name}接口说明</p>

<center>
<div style="width: 95%;text-align: left;">
</div>
<br/>

<table border="0" width="95%">
	<tr>
		<td><b>1、类别维护服务</b></td>
	</tr>
 	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;1.1&nbsp;&nbsp;类别维护服务接口 
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td class="td_normal_title" width="20%">参数信息</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;服务地址：http://localhost:8080/ekp/sys/webservice/kmsMultidocMaintainCategoryWSService?wsdl<br/>&nbsp;&nbsp;类别维护服务接口：IKmsMultidocMaintainCategoryWSServiceService</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 25%"><b>服务方法名</b></td>
								<td align="center" style="width: 25%"><b>描述</b></td>
								<td align="center" style="width: 25%"><b>返回值</b></td>
								<td align="center" style="width: 25%"><b>完整方法</b></td>
							</tr>
							<tr>
								<td>addCategories</td>
								<td>新增类别服务，支持批量新增</td>
								<td>KmsMaintainCategoryResponse包含警告信息和新增成功的类别名和ID的键值对</td>
								<td>KmsMaintainCategoryResponseaddCategories(List(KmsMultidocMaintainCategoryRequest) requests) throws KmsFaultException
								</td>
							</tr>
							<tr>
								<td>updateCategory</td>
								<td>更新列别，不支持批量</td>
								<td>Successful或者是Failed</td>
								<td>String updateCategory(KmsMultidocMaintainCategoryRequestrequest) throws KmsFaultException</td>
							</tr>
							<tr>
								<td>delCategory</td>
								<td>删除类别，不支持批量,删除的时候需要注意，删除不支持删除所有的依赖，如子分类，或者引用该分类的文档，所以需要将依赖转移到另外一个分类下,通过fdMoveToModelId指定，如果没有指定，则会将所有的依赖移动到名为“unclassified”分类下。Unclassified是系统创建的。</td>
								<td>Successful或者是Failed</td>
								<td>tring delCategory(KmsMultidocMaintainCategoryRequestrequest) throws KmsFaultException</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- <tr>
					<td class="td_normal_title" width="20%">返回信息</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;返回对象：Expert</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 30%"><b>字段名</b></td>
								<td align="center" style="width: 30%"><b>描述</b></td>
							</tr>
							<tr>
								<td>expertName</td>
								<td>专家名称</td>
							</tr>
							<tr>
								<td>deptName</td>
								<td>部门名</td>
							</tr>
							<tr>
								<td>familiArarea</td>
								<td>专家所属领域</td>
							</tr>
						</table>
					</td>
				</tr> -->
			</table>
		</td>
	</tr>
	
	<tr>
		<td><br/><b>2、请求对象</b></td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);" ><br/>&nbsp;&nbsp;2.1&nbsp;&nbsp;请求对象信息
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td class="td_normal_title" width="20%">基础请求对象</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;基础请求对象：KmsMaintainCategoryRequest</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 30%"><b>字段名</b></td>
								<td align="center" style="width: 30%"><b>描述</b></td>
								<td align="center" style="width: 30%"><b>取值说明</b></td>
							</tr>
							<tr>
								<td>fdName</td>
								<td>类别名称</td>
								<td>必填</td>
							</tr>
							<tr>
								<td>fdMoveToModelId</td>
								<td>删除类别，将关联的该类别的子类别以及文档移动指定的类别下</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>fdOrder</td>
								<td>排序号</td>
								<td>非必填</td>
							</tr>
							
							<tr>
								<td>fdParentId</td>
								<td>父ID</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>fdDocCreator</td>
								<td>类别创建者</td>
								<td>必填</td>
							</tr>
							<tr>
								<td>authTmpAttCopyIds</td>
								<td>附件可可拷贝者</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>authTmpAttDownloadIds</td>
								<td>附件可下载者</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>authTmpAttPrintIds</td>
								<td>附件可打印者</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>uthTmpReaderIds</td>
								<td>默认可阅读者</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>authTmpEditorIds</td>
								<td>默认可编辑者</td>
								<td>非必填</td>
							</tr>
							<tr>
								<td>docAlterorId</td>
								<td>修改者ID</td>
								<td>修改类别为必填项</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="20%">知识仓库请求对象</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;知识仓库请求对象：KmsMultidocMaintainCategoryRequest(继承基础请求对象)</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 30%"><b>字段名</b></td>
								<td align="center" style="width: 30%"><b>描述</b></td>
								<td align="center" style="width: 30%"><b>取值说明</b></td>
							</tr>
							<tr>
								<td>fdNumberPrefix</td>
								<td>编号前缀</td>
								<td>必填</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="20%">KmsAuthRequest</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;KmsAuthRequest</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 30%"><b>字段名</b></td>
								<td align="center" style="width: 30%"><b>描述</b></td>
								<td align="center" style="width: 30%"><b>取值说明</b></td>
							</tr>
							<tr>
								<td>priviledgeKey</td>
								<td>维护标识,作为第三方系统维护KM文档的一个权限标识</td>
								<td>如果业务系统会有更新的场景出现，建议在新增时该字段为必填字段</td>
							</tr>
							<tr>
								<td>relateId</td>
								<td>业务系统的文档ID，可以自行指定长度为36位的任意字符</td>
								<td>如果业务系统会有更新的场景出现，建议在新增时该字段为必填字段</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="20%">返回结果对象</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;返回结果对象：KmsMaintainCategoryResponse</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 30%"><b>字段名</b></td>
								<td align="center" style="width: 30%"><b>描述</b></td>
								<td align="center" style="width: 30%"><b>取值说明</b></td>
							</tr>
							<tr>
								<td>List<c:out value="<WranEntity>"/> errorMessage</td>
								<td>错误警告实体对象</td>
								<td>0个或者多个WranEntity对象</td>
							</tr>
							<tr>
								<td>result</td>
								<td>操作的结果状态</td>
								<td>返回”success”或者”fail”</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="20%">错误实体对象</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;错误实体对象：WranEntity</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 30%"><b>字段名</b></td>
								<td align="center" style="width: 30%"><b>描述</b></td>
								<td align="center" style="width: 30%"><b>场景例子</b></td>
							</tr>
							<tr>
								<td>wranSubject</td>
								<td>告警标题</td>
								<td>例如：用户新增了5个类别，但是其中有2个名称是相同的，其他三个会新增成功，并将对应的类别名和对应的主键ID对应，其他的2个重名，将会被封装成该对象，错误头：比如名字重复，而详细信息，会详细给出那些名字出现了重复。</td>
							</tr>
							<tr>
								<td>WranInfo</td>
								<td>告警信息详细描述</td>
								<td>同上</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td><br/><b>3、类别查询服务</b></td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);" ><br/>&nbsp;&nbsp;3.1&nbsp;&nbsp;类别查询服务接口
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td class="td_normal_title" width="20%">知识仓库类别查询</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;知识仓库类别查询服务地址：/sys/webservice/kmsMultidocSearchCategoryWSService<br/>&nbsp;&nbsp;类别查询服务接口：IKmsMultidocSearchCategoryWSService</div>
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 25%"><b>服务方法名</b></td>
								<td align="center" style="width: 25%"><b>描述</b></td>
								<td align="center" style="width: 25%"><b>返回值</b></td>
								<td align="center" style="width: 25%"><b>完整方法</b></td>
							</tr>
							<tr>
								<td>searchCategoryList</td>
								<td>查询用户可以访问的所有的类别,如果指定parentId,则返回该父类下所有的直属子类别</td>
								<td>返回可访问的类别列表</td>
								<td>List<c:out value="<CategoryEntry>"/> searchCategoryList(String parentId) throws KmsFaultException {</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td><br/><b>4、使用代码测试(通过对应的框架根据wsdl生成)</b></td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);" id="orgInfo"><br/>&nbsp;&nbsp;4.1&nbsp;&nbsp;新增功能
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;可以通过wsdl路径生成对应语言的客户端，也可以直接用SOAPUI,或者是fiddler发送SOAP请求直接测试，方便快捷。更新可以在此基础之上稍微修改一下，就可以测试！</p>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;批量新增类别的完整soap样例请求：</p>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Envelopexmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Header>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:RequestSOAPHeader xmlns:tns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:user xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>chenliang</tns:user>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:password xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>b700ba5df2e2d5a4fef24d020ab8c47e</tns:password>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:service	xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>kmsMultidocWebserviceService</tns:service>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</tns:RequestSOAPHeader>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Header>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Body>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<ns2:addCategories xmlns:ns2='http://service.category.webservice.multidoc.kms.kmss.landray.com/'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<arg0>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<priviledgeKey>abcldlllllllllllllllll</priviledgeKey>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<relateId>123445678</relateId>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value='<authTmpAttCopyIds>[{DeptNo:"5ttttttt"},{PostNo:"rrt444444"}]</authTmpAttCopyIds>'/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value='<authTmpAttDownloadIds>[{DeptNo:"5ttttttt"},{PostNo:"rrt444444"}]</authTmpAttDownloadIds>'/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value='<authTmpReaderIds>[{DeptNo:"5ttttttt"},{PostNo:"rrt444444"}]</authTmpReaderIds>'/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value='<fdDocCreator>{PersonNo:"1234567890"}</fdDocCreator>'/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<fdName>伤心太平培养:1</fdName>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<fdOrder>1</fdOrder>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<fdNumberPrefix>prefix10</fdNumberPrefix>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</arg0>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</ns2:addCategories>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Body>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Envelope>"/><br/>
		</td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;4.2&nbsp;&nbsp;更新功能
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Envelopexmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Header>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:RequestSOAPHeader xmlns:tns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:user xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>chenliang</tns:user>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:password xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>b700ba5df2e2d5a4fef24d020ab8c47e</tns:password>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:service	xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>kmsMultidocWebserviceService</tns:service>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</tns:RequestSOAPHeader>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Header>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Body>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<ns2:updateCategory xmlns:ns2='http://service.category.webservice.multidoc.kms.kmss.landray.com/'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<arg0>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<priviledgeKey>abcldlllllllllllllllll</priviledgeKey>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<relateId>123445678</relateId>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value='<docAlterorId>{PersonNo:"1234567890"}</docAlterorId>'/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<fdName>我的名字已经被人更新啦++++</fdName>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<fdNumberPrefix>update1111111111111</fdNumberPrefix>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</arg0>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</ns2:updateCategory>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Body>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Envelope>"/><br/>
		</td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;4.3&nbsp;&nbsp;删除功能
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Envelopexmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Header>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:RequestSOAPHeader xmlns:tns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:user xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>chenliang</tns:user>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:password xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>b700ba5df2e2d5a4fef24d020ab8c47e</tns:password>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<tns:service	xmlns='http://localhost:8080/ekp10.0_last_new/sys/webservice/kmsMultidocMaintainCategoryWSService'>kmsMultidocWebserviceService</tns:service>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</tns:RequestSOAPHeader>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Header>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<soap:Body>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<ns2:delCategory xmlns:ns2='http://service.category.webservice.multidoc.kms.kmss.landray.com/'>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<arg0>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<priviledgeKey>abcldlllllllllllllllll</priviledgeKey>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="<relateId>8fe64af1-dcb6-42e7-a2cc-6e4257f939a2</relateId>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</arg0>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</ns2:delCategory>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Body>"/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<c:out  value="</soap:Envelope>"/><br/>
		</td>
	</tr>
	
	<tr>
		<td><br/><b>5、错误描述</b></td>
	</tr>
 	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;5.1&nbsp;&nbsp;错误编号信息
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td style="padding: 0px;">
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 20%"><b>错误编号</b></td>
								<td align="center" style="width: 79%"><b>编号描述</b></td>
							</tr>
							<tr>
								<td>4000</td>
								<td>用户名在组织架构中不存在，拒绝访问</td>
							</tr>
							<tr>
								<td>4001</td>
								<td>用户对输入的类别无权访问</td>
							</tr>
							<tr>
								<td>200</td>
								<td>请求中的某个必填字段缺失</td>
							</tr>
							<tr>
								<td>300</td>
								<td>请求中的参数输入有误，逻辑存在问题，或者是为非法的格式</td>
							</tr>
							<tr>
								<td>5000</td>
								<td>服务端内部处理错误，如果出现该错误，表示服务端的代码处理逻辑有问题。</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;5.2&nbsp;&nbsp;异常对象：KmsFaultException
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td style="padding: 0px;">
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 20%"><b>字段名</b></td>
								<td align="center" style="width: 79%"><b>描述</b></td>
							</tr>
							<tr>
								<td>faultInfo</td>
								<td>包含faultCode和faultMessage的对象实体</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;5.3&nbsp;&nbsp;异常实体对象：KmsFault
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td style="padding: 0px;">
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 20%"><b>字段名</b></td>
								<td align="center" style="width: 79%"><b>描述</b></td>
							</tr>
							<tr>
								<td>faultMessage</td>
								<td>详细的错误信息</td>
							</tr>
							<tr>
								<td>faultCode</td>
								<td>错误编码（上述所给出的编码）</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td><br/><b>6、附录</b></td>
	</tr>
	<tr> 
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);"><br/>&nbsp;&nbsp;6.1&nbsp;&nbsp;组织架构字段同步
			<img src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr style="display: none">
		<td>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关于组织架构字段的同步方式，系统目前支持如下</p>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果某个字段是多个值组成则使用json数组[{{ID:”2343434”},{LoginName:”2343434”}}]</p>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td style="padding: 0px;">
						<table class="tb_normal" width=100%>
							<tr class="tr_normal_title">
								<td align="center" style="width: 20%"><b>Json参数串</b></td>
								<td align="center" style="width: 79%"><b>说明</b></td>
							</tr>
							<tr>
								<td>{ID:”2343434”}</td>
								<td>按照ID的方法对接</td>
							</tr>
							<tr>
								<td>{LoginName:”2343434”}</td>
								<td>按照登录名的方法对接</td>
							</tr>
							<tr>
								<td>{Keyword:”2343434”}</td>
								<td>按照关键字的方法对接</td>
							</tr>
							<tr>
								<td>{PersonNo:”2343434”}</td>
								<td>按照员工编号的方法对接</td>
							</tr>
							<tr>
								<td>{DeptNo:”2343434”}</td>
								<td>按照部门编号的方法对接</td>
							</tr>
							<tr>
								<td>{OrgNo:”2343434”}</td>
								<td>按照组织的方法对接</td>
							</tr>
							<tr>
								<td>{PostNo:”2343434”}</td>
								<td>按照岗位编号的方法对接</td>
							</tr>
							<tr>
								<td>{GroupNo:”2343434”}</td>
								<td>按照群组编号的方法对接</td>
							</tr>
							<tr>
								<td>{LdapDN:”2343434”}</td>
								<td>按照LDAP的方式对接</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</center>

<%@ include file="/resource/jsp/view_down.jsp"%>