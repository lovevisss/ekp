package com.landray.kmss.km.carmng.dao.hibernate;

import java.util.Date;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.km.carmng.dao.IKmCarmngEvaluationDao;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;
import com.landray.kmss.util.UserUtil;

public class KmCarmngEvaluationDaoImp extends BaseDaoImp implements IKmCarmngEvaluationDao {

	@Override
    public String add(IBaseModel modelObj) throws Exception {
		KmCarmngEvaluation kmCarmngEvaluation = (KmCarmngEvaluation) modelObj;
		kmCarmngEvaluation.setFdEvaluator(UserUtil.getUser());
		kmCarmngEvaluation.setFdEvaluationTime(new Date());
		return super.add(kmCarmngEvaluation);
	}
}
