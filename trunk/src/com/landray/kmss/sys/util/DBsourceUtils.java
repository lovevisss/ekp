package com.landray.kmss.sys.util;

import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.component.dbop.service.ICompDbcpService;
import com.landray.kmss.component.dbop.util.CompDbcpUtil;
import com.landray.kmss.util.ClassUtils;
import com.landray.kmss.util.SpringBeanUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;

public class DBsourceUtils {

    public static CompDbcp getDBSource(String dbSourceName) throws Exception {
        //获取第三方数据库
        ICompDbcpService compDbcpService = (ICompDbcpService) SpringBeanUtil
                .getBean("compDbcpService");
        CompDbcp baseModel = (CompDbcp) compDbcpService
                .getCompDbcpByName(dbSourceName);
        return baseModel;

    }

    public static String prepareSQL(Map<String, Object> sqlmap, String tablename) throws Exception {
        String key_string = "";
        String value_string = "";
        String table_name = tablename;
        // sql prefix using table_name
        String sql_prefix = "replace into " + table_name + "(";
        String sql_suffix = ") values(";
        String sql_end = ")";
        String full_sql = "";
//        遍历sqlmap
        for (Map.Entry<String, Object> entry : sqlmap.entrySet()) {
//            System.out.println("key: " + entry.getKey() + " value: " + entry.getValue());
            key_string = key_string + entry.getKey() + ",";
            value_string = value_string + "'" + entry.getValue() + "',";

        }
        //remove last comma
        key_string = key_string.substring(0, key_string.length() - 1);
        value_string = value_string.substring(0, value_string.length() - 1);
        full_sql = sql_prefix + key_string + sql_suffix + value_string + sql_end;

//        System.out.println(full_sql);
        return full_sql;
    }


    public static Connection getConnection(CompDbcp dbcp) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        ClassUtils.forName(dbcp.getFdDriver()).newInstance();
        Connection con = DriverManager.getConnection(dbcp.getFdUrl(),
                dbcp.getFdUsername(),
                CompDbcpUtil.decryptPwd(dbcp.getFdPassword()));
        return con;
    }

}
