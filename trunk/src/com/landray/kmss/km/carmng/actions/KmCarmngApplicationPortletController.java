package com.landray.kmss.km.carmng.actions;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.km.carmng.model.KmCarmngApplication;
import com.landray.kmss.km.carmng.service.IKmCarmngApplicationService;
import com.landray.kmss.sys.portal.cloud.dto.CellDataVO;
import com.landray.kmss.sys.portal.cloud.dto.ColumnDataVO;
import com.landray.kmss.sys.portal.cloud.dto.RowDataVO;
import com.landray.kmss.sys.portal.cloud.dto.TableDataVO;
import com.landray.kmss.sys.portal.cloud.util.ListDataUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.KmssMediaTypes;
import com.landray.kmss.web.RestResponse;
import com.sunbor.web.tag.Page;

import net.sf.json.JSONArray;

/**
 * 门户数据源数据接口
 * 
 * @author cwj
 *
 */
@Controller
@RequestMapping(value = "/data/km-carmng/kmCarmngApplicationPortlet")
public class KmCarmngApplicationPortletController {

	private IKmCarmngApplicationService kmCarmngApplicationService;

	public void setKmCarmngApplicationService(
			IKmCarmngApplicationService kmCarmngApplicationService) {
		this.kmCarmngApplicationService = kmCarmngApplicationService;
	}

	@RequestMapping(value = "/listPortlet", produces = {
			KmssMediaTypes.APPLICATION_JSON_UTF8 })
	@ResponseBody
	public RestResponse<?> listPortlet(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		RequestContext requestCtx = new RequestContext(request, true);
		Map<String, ?> rtnMap = null;
		try {
			rtnMap = kmCarmngApplicationService.listPortlet(requestCtx);
		} catch (Exception e) {
			e.printStackTrace();
			// 错误处理
			return RestResponse.error(RestResponse.ERROR_CODE_500,
					e.getMessage());
		}
		JSONArray datas = (JSONArray) rtnMap.get("datas"); // 列表形式使用
		Page page = (Page) rtnMap.get("page"); // 简单列表使用
		String dataview = requestCtx.getParameter("dataview");
		if ("classic".equals(dataview)) {// 视图展现方式:classic(简单列表)
			return RestResponse.ok(datas);
		} else {// 视图展现方式:listtable(列表)
			return RestResponse.ok(getListData(page, requestCtx));
		}
	}

	private TableDataVO getListData(Page pageData,
			RequestContext request) {
		String myFlow = request.getParameter("myFlow");
		String owner = request.getParameter("owner");
		TableDataVO table = new TableDataVO();
		List<RowDataVO> datas = new ArrayList<>();
		List<ColumnDataVO> columns = new ArrayList<>();
		// 开始处理columns =========
		ColumnDataVO col = new ColumnDataVO(); // fdId
		col.setProperty("fdId");
		col.setRenderType("hidden");
		columns.add(col);
		col = new ColumnDataVO();
		col.setProperty("docSubject"); // docSubject
		col.setTitle(
				ResourceUtil
						.getString("km-carmng:kmCarmngApplication.docSubject"));
		// col.setWidth("60px");
		columns.add(col);
		col = new ColumnDataVO(); // fdApplicationPath
		col.setProperty("fdApplicationPath");
		col.setTitle(
				ResourceUtil.getString(
						"km-carmng:kmCarmngApplication.fdApplicationPath"));
		// col.setWidth("80px");
		columns.add(col);
		col = new ColumnDataVO();
		col.setProperty("docCreateTime"); // docCreateTime
		col.setTitle(ResourceUtil
				.getString("km-carmng:kmCarmngApplication.fdApplicationTime"));
		// col.setWidth("60px");
		columns.add(col);
		if (!"unExecuted".equals(myFlow)) {
			col = new ColumnDataVO();
			col.setProperty("docStatus"); // docStatus
			col.setTitle(ResourceUtil
					.getString("km-carmng:kmCarmngApplication.docStatus"));
			// col.setWidth("60px");
			columns.add(col);
		}
		if (StringUtil.isNull(owner)) {
			col = new ColumnDataVO(); // docCreator.fdName
			col.setProperty("docCreator.fdName");
			col.setTitle(ResourceUtil.getString(
					"km-carmng:kmCarmngApplication.fdApplicationPerson"));
			// col.setWidth("60px");
			columns.add(col);
		}
		col = new ColumnDataVO(); // handlerName
		col.setProperty("handlerName");
		col.setTitle(ResourceUtil.getString(
				"km-carmng:sysWfNode.processingNode.currentProcessor"));
		// col.setWidth("60px");
		columns.add(col);
		// 结束处理columns ===========
		// 开始处理datas ==============
		List<KmCarmngApplication> topics = pageData.getList();
		if (topics != null && !topics.isEmpty()) {
			RowDataVO rowData = null;
			List<CellDataVO> cells = null;
			CellDataVO cell = null;
			for (KmCarmngApplication topic : topics) {
				rowData = new RowDataVO();
				cells = new ArrayList<>();

				cell = new CellDataVO(); // fdId
				cell.setCol("fdId");
				cell.setValue(topic.getFdId());
				cells.add(cell);

				cell = new CellDataVO();
				cell.setCol("docSubject"); // docSubject
				cell.setValue(topic.getDocSubject());
				cell.setHref(
						"/km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId="
								+ topic.getFdId());
				cells.add(cell);

				cell = new CellDataVO();
				cell.setCol("fdApplicationPath"); // fdApplicationPath
				StringBuffer sb = new StringBuffer();
				if (StringUtil.isNotNull(topic.getFdDeparture())) {
					sb.append(topic.getFdDeparture());
					sb.append(" - ");
				}
				if (StringUtil.isNotNull(topic.getFdDestination())) {
					sb.append(topic.getFdDestination());
				}
				if (StringUtil.isNotNull(topic.getFdApplicationPath())) {
					sb.append(" - ");
					sb.append(topic.getFdApplicationPath());
				}
				cell.setValue(sb.toString());
				cells.add(cell);

				cell = new CellDataVO();
				cell.setCol("docCreateTime"); // docCreateTime
				cell.setValue(
						DateUtil.convertDateToString(topic.getDocCreateTime(),
								"date", request.getLocale()));
				cells.add(cell);

				if (!"unExecuted".equals(myFlow)) {
					cell = new CellDataVO();
					cell.setCol("docStatus"); // docStatus
					String docStatus = null;
					int status = Integer.parseInt(topic.getDocStatus());
					if (status < 30) {
						docStatus = ListDataUtil
								.getDocStatusString(topic.getDocStatus());
					} else if (status == 30 && topic.getFdIsDispatcher() == 1) {
						docStatus = ResourceUtil
								.getString("km-carmng:kmCarmng.tree.publish");
					} else {
						if (topic.getFdIsDispatcher() == 2) {
                            docStatus = ResourceUtil.getString(
                                    "km-carmng:kmCarmng.tree.publish2");
                        }
						if (topic.getFdIsDispatcher() == 3
								|| topic.getFdIsDispatcher() == 4) {
                            docStatus = ResourceUtil.getString(
                                    "km-carmng:kmCarmng.tree.publish3");
                        }
					}
					cell.setValue(docStatus);
					cells.add(cell);
				}

				if (StringUtil.isNull(owner)) {
					cell = new CellDataVO();
					cell.setCol("docCreator.fdName"); // docCreator.fdName
					cell.setValue(topic.getDocCreator().getFdName());
					cells.add(cell);
				}
				cell = new CellDataVO();
				cell.setCol("handlerName"); // handlerName
				cell.setValue(ListDataUtil.getLbpmName(topic.getFdId(),
						"handlerName", false, null));
				cells.add(cell);
				rowData.setCells(cells);
				datas.add(rowData);
			}
		}
		// 结束处理datas ==============
		table.setColumns(columns);
		table.setData(datas);
		return table;
	}
}
