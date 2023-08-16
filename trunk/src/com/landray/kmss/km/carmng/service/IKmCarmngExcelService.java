package com.landray.kmss.km.carmng.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.util.excel.Column;

public interface IKmCarmngExcelService extends IBaseService {
	public void export(String title,Column[] cols,List rows, HttpServletResponse response ) throws Exception;
}
