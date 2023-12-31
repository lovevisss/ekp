package com.landray.kmss.km.carmng.service.spring;

import com.alibaba.fastjson2.JSONObject;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.component.dbop.model.CompDbcp;
import com.landray.kmss.component.dbop.service.ICompDbcpService;
import com.landray.kmss.component.dbop.util.CompDbcpUtil;
import com.landray.kmss.km.carmng.service.KmCarmngHrQuartzService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.ClassUtils;
import com.landray.kmss.util.SpringBeanUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import static com.landray.kmss.sys.util.SyncUtils.*;

public class KmCarmngHrQuartzServiceImp implements KmCarmngHrQuartzService {

    private ISysOrgElementService sysOrgElementService;
    @Override
    public void runHrsync(SysQuartzJobContext jobContext) throws Exception {
        try{
            jobContext.logMessage("开始同步人员信息");
            HQLInfo hqlInfo = new HQLInfo();
            String where = "fdIsAvailable = 1";
            hqlInfo.setWhereBlock(where);

            //test connect to postgres
//            Class.forName("org.postgresql.Driver");


            ISysOrgElementService sysOrgElementService = (ISysOrgElementService) SpringBeanUtil.getBean("sysOrgElementService");
            List<SysOrgElement> lsstaff = sysOrgElementService.findList(hqlInfo);
            //获取第三方数据库
            ICompDbcpService compDbcpService = (ICompDbcpService) SpringBeanUtil
                    .getBean("compDbcpService");
            CompDbcp baseModel = (CompDbcp) compDbcpService
                    .getCompDbcpByName("mmall");


            String sql = "";
            Connection con = getConnection(baseModel);
            Statement stmt = con.createStatement();
//            rs = stmt.executeUpdate(sql);


            for (SysOrgElement staff : lsstaff) {

                jobContext.logMessage("同步人员信息" + staff.getFdName());
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("ProductID",staff.getFdId());
                jsonObject.put("Description",staff.getFdOrgType());
                jsonObject.put("Price",staff.getFdOrgType());
                jsonObject.put("Quantity",staff.getFdOrgType());
                jsonObject.put("Name",staff.getFdName());
                invokeSingleApi(jsonObject,"http://127.0.0.1:8000/products");
            }
//            invokeApi(personListToJsonArray((List<SysOrgElement>) lsstaff, true), "http://127.0.0.1:8000/products");
        } catch (Exception e){
            jobContext.logError("同步人员信息失败" + e.getMessage());
        }



    }

    public Connection getConnection(CompDbcp dbcp) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        ClassUtils.forName(dbcp.getFdDriver()).newInstance();
        Connection con = DriverManager.getConnection(dbcp.getFdUrl(),
                dbcp.getFdUsername(),
                CompDbcpUtil.decryptPwd(dbcp.getFdPassword()));
        return con;
    }



    public void setSysOrgElementService(ISysOrgElementService sysOrgElementService) {
        this.sysOrgElementService = sysOrgElementService;

    }


}
