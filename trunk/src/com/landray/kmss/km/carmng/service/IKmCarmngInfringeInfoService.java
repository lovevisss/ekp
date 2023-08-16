package com.landray.kmss.km.carmng.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.service.IBaseService;

/**
 * 创建日期 2010-三月-24
 * 
 * @author 叶中奇 违章信息业务对象接口
 */
public interface IKmCarmngInfringeInfoService extends IBaseService {

	List count(HttpServletRequest request) throws Exception;

	void saveExportExcel(List valueList, HttpServletResponse response,
			HttpServletRequest request) throws Exception;

}
