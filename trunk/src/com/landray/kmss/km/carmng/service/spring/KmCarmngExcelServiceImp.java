package com.landray.kmss.km.carmng.service.spring;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.km.carmng.service.IKmCarmngExcelService;
import com.landray.kmss.util.excel.Column;
import com.landray.kmss.util.excel.ExcelOutput;
import com.landray.kmss.util.excel.ExcelOutputImp;
import com.landray.kmss.util.excel.Sheet;
import com.landray.kmss.util.excel.WorkBook;
/**
 * 创建日期 2010-二月-26
 * @author 
 * 
 */
public class KmCarmngExcelServiceImp extends BaseServiceImp implements IKmCarmngExcelService {
	
	/*
	 * 导出
	 */
	@Override
	public void export(String title, Column[] cols, List rows, HttpServletResponse response ) throws Exception{
		WorkBook workbook = new WorkBook();
		Locale chinaLocale = new Locale("zh", "ZH");
		workbook.setLocale(chinaLocale);
		workbook.setBundle("km-carmng");
		workbook.setFilename(title);
		Sheet sheet = new Sheet();
		sheet.setTitle(title);
		for (int i = 0; i < cols.length; i++) {
            sheet.addColumn(cols[i]);
        }
		for (int i = 0; i < rows.size(); i++){
			Object[] obj = (Object[])rows.get(i);
			sheet.addContent(obj);
		}
		workbook.setFilename(title);
		workbook.addSheet(sheet);
		ExcelOutput output = new ExcelOutputImp();
		output.output(workbook, response);
	}

}
