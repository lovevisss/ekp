package com.landray.kmss.km.carmng.transfer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.hibernate.cfg.Environment;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.km.carmng.model.KmCarmngInfomation;
import com.landray.kmss.km.carmng.service.IKmCarmngInfomationService;
import com.landray.kmss.sys.admin.dbchecker.metadata.util.MetadataUtil;
import com.landray.kmss.sys.admin.transfer.constant.ISysAdminTransferConstant;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;

public class KmCarmngNewTask extends KmCarmngNewChecker implements
		ISysAdminTransferTask {
	
	@Override
    public SysAdminTransferResult run(
			SysAdminTransferContext sysAdminTransferContext) {
		String uuid=sysAdminTransferContext.getUUID();	
		ISysAdminTransferTaskService sysAdminTransferTaskService=(ISysAdminTransferTaskService)SpringBeanUtil.getBean("sysAdminTransferTaskService");
		try {
			List sysAdminTransferList=new ArrayList();
			sysAdminTransferList=sysAdminTransferTaskService.getBaseDao().findValue(null, "sysAdminTransferTask.fdUuid='"+uuid+"'", null);		
			SysAdminTransferTask sysAdminTransferTask=(SysAdminTransferTask)sysAdminTransferList.get(0);
			if (sysAdminTransferTask.getFdStatus() != 1) {
				doTransfer();
			}
		} catch (Exception e) {
			logger.error("执行旧数据迁移为空异常", e);
			return new SysAdminTransferResult(ISysAdminTransferConstant.TASK_STATUS_NOT_RUNED, e.getLocalizedMessage(),
					e);
		}
		
		return SysAdminTransferResult.OK;
	}

	public void doTransfer() throws SQLException {
		IKmCarmngInfomationService kmCarmngInfomationService = (IKmCarmngInfomationService) SpringBeanUtil
				.getBean("kmCarmngInfomationService");
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection conn = dataSource.getConnection();
		ResultSet dispatch_rs = null;
		ResultSet register_rs = null;
		PreparedStatement ps_dispatch_select = null;
		PreparedStatement ps_dispatch_update = null;
		PreparedStatement ps_register_select = null;
		PreparedStatement ps_register_update = null;
		PreparedStatement ps_dispatchlist_insert = null;
		PreparedStatement ps_dispatchuser_drop = null;

		try {
			if (!MetadataUtil.isSQLServer(ResourceUtil.getKmssConfigString(Environment.DIALECT))) {
				ps_dispatchuser_drop = conn.prepareStatement("drop table if exists km_carmng_dispatcher_user");
			} else {
				ps_dispatchuser_drop = conn.prepareStatement("drop table km_carmng_dispatcher_user");

			}
			ps_dispatch_select = conn.prepareStatement(
					"select fd_id,fd_car_info_id,fd_driver_id,fd_drivers_name,fd_sys_driver_id,fd_relation_phone,fd_flag from km_carmng_dispatchers_info where fd_car_info_id is not null");
			ps_dispatch_update = conn
					.prepareStatement("update km_carmng_dispatchers_info set fd_carinfo_names = ? where fd_id = ?");

			ps_register_select = conn
					.prepareStatement("select fd_id from km_carmng_register_info where fd_dispatchers_id = ?");
			ps_dispatchlist_insert = conn.prepareStatement(
					"insert into km_carmng_dispatchers_infolist (fd_id ,fd_carinfo_id,fd_carinfo_name,fd_carinfo_no,fd_motorcade_id,"
							+ "fd_motorcade_name,fd_vehichestype_id,fd_vehichestype_name,fd_carinfo_seatnum,fd_driver_id,"
							+ "fd_driver_name,fd_sys_driver_id,fd_relation_phone,fd_flag,fd_register_id,fd_dispatchers_id) "
							+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");

			ps_register_update = conn
					.prepareStatement(
							"update km_carmng_register_info set fd_dispatchinfolist_id = ? where fd_dispatchers_id = ?");
			// ps_dispatchlist_select = conn
			// .prepareStatement(
			// "select fd_id from km_carmng_dispatchers_infolist where
			// fd_register_id is not null");

			/*
			 * fd_car_info_id,fd_driver_id,fd_drivers_name,fd_relation_phone
			 * ,fd_destination,fd_travel_path,fd_flag,fd_sys_driver_id
			 */

			/*
			 * `fd_id` `fd_carinfo_name` `fd_vehichestype_id`
			 * `fd_vehichestype_name` `fd_carinfo_no` `fd_driver_id`
			 * `fd_driver_name` `fd_relation_phone` `fd_carinfo_seatnum`
			 * `fd_motorcade_id` `fd_motorcade_name` `fd_flag`
			 * `fd_sys_driver_id` `fd_register_id` `fd_dispatchers_id`
			 * `fd_carinfo_id`
			 */

			try {
				ps_dispatchuser_drop.execute();
			} catch (Exception e) {
				logger.info("表km_carmng_dispatcher_user不存在!");

			}
			dispatch_rs = ps_dispatch_select.executeQuery();
			while (dispatch_rs.next()) {
				ps_register_select.setString(1, dispatch_rs.getString(1));
				register_rs = ps_register_select.executeQuery();
				String registerId = "";
				String fdId = IDGenerator.generateID();
				while (register_rs.next()) {
					registerId = register_rs.getString(1);
				}
				KmCarmngInfomation kmCarmngInfomation = (KmCarmngInfomation) kmCarmngInfomationService
						.findByPrimaryKey(dispatch_rs.getString(2));
				ps_dispatchlist_insert.setString(1, fdId);
				ps_dispatchlist_insert.setString(2, dispatch_rs.getString(2));
				ps_dispatchlist_insert.setString(3, kmCarmngInfomation.getDocSubject());
				ps_dispatchlist_insert.setString(4, kmCarmngInfomation.getFdNo());
				ps_dispatchlist_insert.setString(5, kmCarmngInfomation.getFdMotorcade().getFdId());
				ps_dispatchlist_insert.setString(6, kmCarmngInfomation.getFdMotorcade().getFdName());
				ps_dispatchlist_insert.setString(7, kmCarmngInfomation.getFdVehichesType().getFdId());
				ps_dispatchlist_insert.setString(8, kmCarmngInfomation.getFdVehichesType().getFdName());
				ps_dispatchlist_insert.setString(9, kmCarmngInfomation.getFdSeatNumber().toString());
				ps_dispatchlist_insert.setString(10, dispatch_rs.getString(3));
				ps_dispatchlist_insert.setString(11, dispatch_rs.getString(4));
				ps_dispatchlist_insert.setString(12, dispatch_rs.getString(5));
				ps_dispatchlist_insert.setString(13, dispatch_rs.getString(6));
				ps_dispatchlist_insert.setString(14, dispatch_rs.getString(7));
				ps_dispatchlist_insert.setString(15, registerId);
				ps_dispatchlist_insert.setString(16, dispatch_rs.getString(1));
				ps_dispatchlist_insert.addBatch();
				ps_dispatch_update.setString(1, kmCarmngInfomation.getFdNo());
				ps_dispatch_update.setString(2, dispatch_rs.getString(1));
				ps_dispatch_update.addBatch();

				ps_register_update.setString(1, fdId);
				ps_register_update.setString(2, dispatch_rs.getString(1));
				ps_register_update.addBatch();
			}
			ps_dispatchlist_insert.executeBatch();
			ps_dispatch_update.executeBatch();
			ps_register_update.executeBatch();


		} catch (SQLException e) {
			logger.error("执行旧数据迁移为空异常", e);
			conn.rollback();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭流
			JdbcUtils.closeStatement(ps_register_select);
			JdbcUtils.closeStatement(ps_dispatch_select);
			JdbcUtils.closeStatement(ps_dispatch_update);
			JdbcUtils.closeStatement(ps_dispatchlist_insert);
			JdbcUtils.closeStatement(ps_register_update);
			JdbcUtils.closeStatement(ps_dispatchuser_drop);
			JdbcUtils.closeConnection(conn);
		}
	}

}
