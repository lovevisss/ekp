package com.landray.kmss.km.carmng.service.spring;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.km.carmng.service.KmCarmngHrQuartzService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.SpringBeanUtil;

import java.util.List;

public class KmCarmngHrQuartzServiceImp implements KmCarmngHrQuartzService {

    private ISysOrgElementService sysOrgElementService;
    @Override
    public void runHrsync(SysQuartzJobContext jobContext) throws Exception {
        try{
            jobContext.logMessage("开始同步人员信息");
            HQLInfo hqlInfo = new HQLInfo();
            String where = "fdIsAvailable = 1";
            hqlInfo.setWhereBlock(where);

            ISysOrgElementService sysOrgElementService = (ISysOrgElementService) SpringBeanUtil.getBean("sysOrgElementService");
            List<SysOrgElement> lsstaff = sysOrgElementService.findList(hqlInfo);
            for (SysOrgElement staff : lsstaff) {
                jobContext.logMessage("同步人员信息" + staff.getFdName());
            }
        } catch (Exception e){
            jobContext.logError("同步人员信息失败" + e.getMessage());
        }



    }

    public void setSysOrgElementService(ISysOrgElementService sysOrgElementService) {
        this.sysOrgElementService = sysOrgElementService;

    }


}
