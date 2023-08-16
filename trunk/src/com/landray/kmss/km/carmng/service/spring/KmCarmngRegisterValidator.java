package com.landray.kmss.km.carmng.service.spring;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.sys.authentication.intercept.IAuthenticationValidator;
import com.landray.kmss.sys.authentication.intercept.ValidatorRequestContext;
import com.landray.kmss.util.UserUtil;

public class KmCarmngRegisterValidator implements IAuthenticationValidator {
	private IKmCarmngApplicationService kmCarmngApplicationService;

	public void setKmCarmngApplicationService(IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}

	private Logger logger = org.slf4j.LoggerFactory.getLogger(KmCarmngRegisterValidator.class);

	@Override
    public boolean validate(ValidatorRequestContext validatorContext) throws Exception {
		Boolean flag = false;
		String fdAppId = validatorContext.getParameter("fdAppId");
		String[] idArr = fdAppId.split(";");
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(
				" kmCarmngApplication.docCreator.fdId = :docCreatorId and kmCarmngApplication.fdId in(:idList)");
		hqlInfo.setParameter("docCreatorId", UserUtil.getUser().getFdId());
		hqlInfo.setParameter("idList", Arrays.asList(idArr));
		List l = kmCarmngApplicationService.findList(hqlInfo);
		if (l.size() > 0) {
			flag = true;
		}
		return flag;
	}
}
