package com.landray.kmss.code.springmvc.trans;

/**
 * 文件转换器
 */
public abstract class FileTranser {
	public static enum Result {
		Break, Continue, Delay
	}

	public abstract Result execute(TransContext context) throws Exception;
}
