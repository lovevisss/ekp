package com.landray.kmss.km.carmng.service.spring;

import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.km.carmng.service.IKmCarmngEvaluationService;
import com.landray.kmss.sys.log.util.UserOperHelper;

public class KmCarmngEvaluationServiceImp extends BaseServiceImp implements IKmCarmngEvaluationService {

	private IKmCarmngApplicationService kmCarmngApplicationService = null;

	public void setKmCarmngApplicationService(IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}

	@Override
	public String add(IExtendForm form, RequestContext requestContext) throws Exception {
		UserOperHelper.logAdd(getModelName());
		IBaseModel model = convertFormToModel(form, null, requestContext);
		String id = super.add(model);
		KmCarmngEvaluation kmCarmngEvaluation = (KmCarmngEvaluation) model;

		KmCarmngApplication kmCarmngApplication = kmCarmngEvaluation.getFdApplication();
		kmCarmngApplication.setFdIsDispatcher(3);
		kmCarmngApplicationService.update(kmCarmngApplication);
		return id;
	}

	@Override
	public KmCarmngEvaluation findByApplication(
			KmCarmngApplication fdApplication) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(
				"kmCarmngEvaluation.fdApplication=:fdApplication");
		hqlInfo.setParameter("fdApplication", fdApplication);
		List<KmCarmngEvaluation> list = findList(hqlInfo);
		if (!list.isEmpty()) {
            return list.get(0);
        }
		return null;
	}
}
