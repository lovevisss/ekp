package com.landray.kmss.sys.util;

import DBstep.iDBManager2000;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.component.dbop.service.ICompDbcpService;
import com.landray.kmss.component.dbop.util.CompDbcpUtil;
import com.landray.kmss.group.sync.model.Role;
import com.landray.kmss.hr.staff.model.HrStaffPersonInfo;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.ClassUtils;
import com.landray.kmss.util.SpringBeanUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
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


    public static Role getRole(SysQuartzJobContext jobContext, HrStaffPersonInfo staff, IBaseService service) throws Exception {
        jobContext.logMessage("get role");
        iDBManager2000 iDBManager2000 = new iDBManager2000();
        iDBManager2000.OpenConnection();
//        String selSql = "select * "
//                + "from sys_org_element "
//                + "where fd_id = '"+ staff.getFdId() + " '";

        String selSql = "select * "
                + "from sys_org_post_person "
                + "where fd_personid = '"+ staff.getFdId() + " '";
        System.out.println(selSql);
        ResultSet result = iDBManager2000.ExecuteQuery(selSql);
        jobContext.logMessage("result" + result);
        Role role = new Role();
        while (result.next()){
            String postId = result.getString("fd_postid");
            role.setId(role.getId() + postId + ",");
            HQLInfo hqlInfo = new HQLInfo();
            String where = "fdId ='" +  postId + "'";
            hqlInfo.setWhereBlock(where);
            SysOrgElement lsstaff = (SysOrgElement) service.findFirstOne(hqlInfo);
            role.setName(role.getName() + lsstaff.getFdName() + ",");
        }

//            remove last comma check if it is not empty
        if(role.getId().length() > 0)
        {
            role.setId(role.getId().substring(role.getId().length()-1));
        }
        if(role.getName().length() > 0)
        {
            role.setName(role.getName().substring(role.getName().length()-1));
        }

        iDBManager2000.CloseConnection();
        return role;
    }

}
