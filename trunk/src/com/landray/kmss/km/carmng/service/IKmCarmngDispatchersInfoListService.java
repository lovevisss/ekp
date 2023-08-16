package com.landray.kmss.km.carmng.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.service.IBaseService;



public interface IKmCarmngDispatchersInfoListService  extends IBaseService {

	void saveExportExcel(List kmCarmngDispatchersInfoList, HttpServletResponse response) throws Exception;
}
