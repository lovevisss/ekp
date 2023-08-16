package com.landray.kmss.km.carmng.service;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.model.KmCarmngEvaluation;

public interface IKmCarmngEvaluationService extends IBaseService {

	KmCarmngEvaluation findByApplication(KmCarmngApplication fdApplication)
			throws Exception;
}
