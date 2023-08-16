<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.simple">
    <template:replace name="head">

    </template:replace>
    <template:replace name="title">公文管理对接交换平台restful接口服务文档说明</template:replace>
    <template:replace name="body">
        <table class="tb_normal" cellpadding="0" cellspacing="0" style="width:85%;text-align: center;margin-top: 20px">
            <tr>
                <td class="td_normal_title">KmImissiveRestController参数信息说明如下</td>
            </tr>
            <tr>
                <td style="padding: 0px;">
                    <div style="margin: 8px;"><b>JSON</b>格式</div>
                    <table class="tb_normal" cellpadding="0" cellspacing="0" width=100% style="text-align: center">
                        <tr class="tr_normal_title">
                            <td align="center" width="20%"><b>参数</b></td>
                            <td align="center" width="20%"><b>参数类型</b></td>
                            <td align="center" width="10%"><b>是否必填</b></td>
                            <td align="center" width="50%"><b>说明</b></td>
                        </tr>
                        <tr>
                            <td>fdBizId</td>
                            <td>String</td>
                            <td>是</td>
                            <td>信号回调ID，对应业务系统中的业务ID</td>
                        </tr>
                        <tr>
                            <td>fdReqType</td>
                            <td>String</td>
                            <td>是</td>
                            <td>请求类型</td>
                        </tr>
                        <tr>
                            <td>fdFromType</td>
                            <td>String</td>
                            <td>是</td>
                            <td>模块类型</td>
                        </tr>
                        <tr>
                            <td>docSubject</td>
                            <td>String</td>
                            <td>否</td>
                            <td>对应标题</td>
                        </tr>
                        <tr>
                            <td>bizData</td>
                            <td>JSONObject</td>
                            <td>否</td>
                            <td>业务数据，短报文时可能有内容，如退回（Return）、退文（ReturnDoc）</td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div style="margin: 8px;">bizData说明</div>
                                <table class="tb_normal" cellpadding="0" cellspacing="0" width=100%>
                                    <tr class="tr_normal_title">
                                        <td align="center" width="20%"><b>参数</b></td>
                                        <td align="center" width="20%"><b>参数类型</b></td>
                                        <td align="center" width="10%"><b>是否必填</b></td>
                                        <td align="center" width="50%"><b>说明</b></td>
                                    </tr>
                                    <tr>
                                        <td>fdDesc</td>
                                        <td>String</td>
                                        <td>否</td>
                                        <td>退回（Return）、退文（ReturnDoc）的“意见”内容</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align: left"><p>例：</p>
                                {"fdBizId":"33","fdReqType":"Return","fdFromType":"km-imissive","docSubject":"公文标题测试","bizData":{"fdDesc":
                                "退回意见测试"}}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td style="padding: 0px;">
                    <div style="margin: 8px;"><b>XML</b>格式</div>
                    <table class="tb_normal" cellpadding="0" cellspacing="0" width=100%>
                        <tr class="tr_normal_title">
                            <td align="center" width="20%"><b>参数</b></td>
                            <td align="center" width="20%"><b>参数类型</b></td>
                            <td align="center" width="10%"><b>是否必填</b></td>
                            <td align="center" width="50%"><b>说明</b></td>
                        </tr>
                        <tr>
                            <td>fdBizId</td>
                            <td>String</td>
                            <td>是</td>
                            <td>信号回调ID，对应业务系统中的业务ID</td>
                        </tr>
                        <tr>
                            <td>fdReqType</td>
                            <td>String</td>
                            <td>是</td>
                            <td>请求类型</td>
                        </tr>
                        <tr>
                            <td>fdFromType</td>
                            <td>String</td>
                            <td>是</td>
                            <td>模块类型</td>
                        </tr>
                        <tr>
                            <td>docSubject</td>
                            <td>String</td>
                            <td>否</td>
                            <td>对应标题</td>
                        </tr>
                        <tr>
                            <td>retEnvelope</td>
                            <td>Xml</td>
                            <td>是</td>
                            <td>传输内容</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: left"><p>例：</p>
                    &lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
                    &lt;callback&gt;
                    &lt;fdBizId&gt;176d0665c670d6426b1541644dc828c6&lt;/fdBizId&gt;
                    &lt;fdReqType&gt;Distribute&lt;/fdReqType&gt;
                    &lt;fdFromType&gt;km-imissive&lt;/fdFromType&gt;
                    &lt;docSubject&gt;发文01053&lt;/docSubject&gt;
                    &lt;retEnvelope version=&quot;1.0&quot; reqType=&quot;Return&quot; fromType=&quot;km-imissive&quot;&gt;
                    &lt;封装实体&gt;
                    &lt;报文标识&gt;176d039e308fb7d00a49252420b96f02&lt;/报文标识&gt;
                    &lt;明文报文&gt;
                    &lt;类型&gt;RET&lt;/类型&gt;
                    &lt;内容&gt;
                    &lt;意见&gt;退回意见&lt;/意见&gt;
                    &lt;意见类型&gt;4&lt;/意见类型&gt;
                    &lt;/内容&gt;
                    &lt;/明文报文&gt;
                    &lt;/封装实体&gt;
                    &lt;/retEnvelope&gt;
                    &lt;/callback&gt;
                </td>
            </tr>
        </table>
    </template:replace>

</template:include>