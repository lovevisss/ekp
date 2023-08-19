package com.landray.kmss.sys.util;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.DateUtil;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class SyncUtils {

    //部门更新
    public static final String DEPT_UPDATE = "dept_update";
    //部门新增
    public static final String DEPT_ADD = "dept_add";

    //人员新增接口
    public static final String ADD_PERSON_API = "/api/items/";

    //人员删除接口
    public static final String DEL_PERSON_API = "/api/items/?key=";


    private static final Logger logger = LoggerFactory.getLogger(SyncUtils.class);
    /**
     * @Description List按指定数量拆分成多个
     * @param list 原集合
     * @param len 指定数量
     */
    public static <T> List<List<T>> splitList(List<T> list, int len) {
        if (list == null || list.isEmpty() || len < 1) {
            return Collections.emptyList();
        }
        List<List<T>> result = new ArrayList<>();
        int size = list.size();
        int count = (size + len - 1) / len;
        for (int i = 0; i < count; i++) {
            List<T> subList = list.subList(i * len, ((i + 1) * len > size ? size : len * (i + 1)));
            result.add(subList);
        }
        return result;
    }

    /**
     * @Description 将部门集合转换为JsonArray
     * @param list 部门集合
     * @param operation 当操作为新增时，父部门编号为空；当操作为更新时，加上父部门编号
     */

    public static JSONArray deptListToJsonArray(List<SysOrgElement> list, String operation){
        JSONArray jsonArray = new JSONArray();
        for (SysOrgElement sysOrgElement : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("deptnumber",sysOrgElement.getFdNo());
            jsonObject.put("deptname",sysOrgElement.getFdName());
            String parentnumber = "1";
            if (operation.equals(DEPT_UPDATE)){
                parentnumber = sysOrgElement.getFdParent()!=null?sysOrgElement.getFdParent().getFdNo():"1";
            }
            jsonObject.put("parentnumber",parentnumber);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    /**
     * @Description 将人员集合转换为JsonArray
     * @param list 人员集合
     */

    public static JSONArray personListToJsonArray(List<SysOrgElement> list, Boolean isAvailable){
        JSONArray jsonArray = new JSONArray();
//        在职
        if (isAvailable){
            for (SysOrgElement sysOrgElement : list) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("ProductID",sysOrgElement.getFdId());
                jsonObject.put("Description",sysOrgElement.getFdOrgType());
                jsonObject.put("Price",sysOrgElement.getFdOrgType());
                jsonObject.put("Quantity",sysOrgElement.getFdOrgType());
                jsonObject.put("Name",sysOrgElement.getFdName());
                jsonObject.put("deptnumber",sysOrgElement.getFdParent()!=null?sysOrgElement.getFdParent().getFdNo():"");
                jsonArray.add(jsonObject);
            }
//            离职
        }else {
            for (SysOrgElement sysOrgElement : list) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("body",sysOrgElement.getFdOrgType());
                jsonObject.put("text",sysOrgElement.getFdName());
                jsonObject.put("leavedate", DateUtil.convertDateToString(sysOrgElement.getFdAlterTime(),"yyyy-MM-dd HH:mm"));
                jsonObject.put("leavetype",2);
                jsonArray.add(jsonObject);
            }
        }
        return jsonArray;
    }

    /**
     * @param jsonArray   json格式数据
     * @param url         接口地址
     * @Description 调用接口通用方法
     */
    public static String invokeApi(JSONArray jsonArray, String url) throws Exception {

        String body = "";

        //创建httpclient对象
        CloseableHttpClient client = HttpClients.createDefault();
        //创建post方式请求对象
        HttpPost httpPost = new HttpPost(url);
        //装填参数
        StringEntity s;
        if (jsonArray.size()==1){
            s = new StringEntity(jsonArray.get(0).toString(), "utf-8");
        }else {
            s = new StringEntity(jsonArray.toString(), "utf-8");
        }
        s.setContentEncoding(new BasicHeader("Content-Type",
                "application/json"));
        //设置参数到请求对象中
        logger.info("接口地址为："+url);
        httpPost.setEntity(s);
        httpPost.setHeader("Content-type", "application/json");
        httpPost.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

        //执行请求操作，并拿到结果（同步阻塞）
        CloseableHttpResponse response = client.execute(httpPost);
        //获取结果实体
        org.apache.http.HttpEntity entity = response.getEntity();
        if (entity != null) {
            //按指定编码转换结果实体为String类型
            body = EntityUtils.toString(entity, "UTF-8");
        }
        EntityUtils.consume(entity);
        //释放链接
        response.close();
        return body;
    }


    public static String invokeSingleApi(JSONObject jsonObject, String url) throws Exception {

        String body = "";

        //创建httpclient对象
        CloseableHttpClient client = HttpClients.createDefault();
        //创建post方式请求对象
        HttpPost httpPost = new HttpPost(url);
        //装填参数
        StringEntity s;
        s = new StringEntity(jsonObject.toString(), "utf-8");
        s.setContentEncoding(new BasicHeader("Content-Type",
                "application/json"));
        //设置参数到请求对象中
        logger.info("接口地址为："+url);
        httpPost.setEntity(s);
        httpPost.setHeader("Content-type", "application/json");
        httpPost.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

        //执行请求操作，并拿到结果（同步阻塞）
        CloseableHttpResponse response = client.execute(httpPost);
        //获取结果实体
        org.apache.http.HttpEntity entity = response.getEntity();
        if (entity != null) {
            //按指定编码转换结果实体为String类型
            body = EntityUtils.toString(entity, "UTF-8");
        }
        EntityUtils.consume(entity);
        //释放链接
        response.close();
        return body;
    }

}
