package com.landray.kmss.km.carmng.service.spring;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.km.carmng.model.KmCarmngDispatchersLog;
import com.landray.kmss.km.carmng.service.IKmCarmngDispatchersLogService;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.SpringBeanUtil;

public class KmCarmngDispatchersLogServiceImp extends ExtendDataServiceImp implements IKmCarmngDispatchersLogService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    @Override
    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof KmCarmngDispatchersLog) {
            KmCarmngDispatchersLog kmCarmngDispatchersLog = (KmCarmngDispatchersLog) model;
        }
        return model;
    }

    @Override
    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        KmCarmngDispatchersLog kmCarmngDispatchersLog = (KmCarmngDispatchersLog) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
}
