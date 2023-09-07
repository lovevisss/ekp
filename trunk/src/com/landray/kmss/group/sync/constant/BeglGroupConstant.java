package com.landray.kmss.group.sync.constant;

import com.landray.kmss.group.sync.model.WorkChange;
import com.landray.kmss.group.sync.model.WorkStatus;

import java.util.HashMap;
import java.util.Map;

//常量
public interface BeglGroupConstant {

    public static final String CORP_NAME = "浙江嘉兴国有资本投资运营有限公司(本部)";


    public static final String THIRDDB = "mmall";

    public static final Integer CORP_CODE = 101;

    public static final HashMap<Object, WorkStatus> WORK_STATUS_MAP = new HashMap<Object, WorkStatus>() {
        {
            put("temporary", new WorkStatus("试用", "001", 0));
            put("trial", new WorkStatus("试用", "001", 0));
            put("practice", new WorkStatus("实习", "000", 0));
            put("official", new WorkStatus("在岗", "002", 0));
            put("trialDelay", new WorkStatus("试用", "001", 0));
            put("leave", new WorkStatus("离职", "102", 1));
            put("retire", new WorkStatus("退休", "501", 5));
            put("dismissal", new WorkStatus("辞退", "103", 1));

        }
    };
//    OA系统内存的是数字，注意转换
//            1 表示正常     对应中间库 1
//            2 表示已到期   对应中间库 2
//            3 表示已解除   对应中间库 5
    public static final Map<String, Integer>  AGREEMENTTYPE = new HashMap<String, Integer>(){
        {
            put("1",1);
            put("2",2);
            put("3",5);
        }
    };
//"OA系统内存的是数字，注意转换
//        1 表示正常     对应中间库 1
//            2 表示已到期   对应中间库 0
//            3 表示已解除   对应中间库 0"

    public static final Map<String, Integer>  AGREEMENTMEMO = new HashMap<String, Integer>() {
        {
            put("1", 1);
            put("2", 0);
            put("3", 0);
        }
    };

    public static final HashMap<Object, WorkChange> WORK_CHANGE_MAP = new HashMap<Object, WorkChange>() {
        {
            put("员工增加", new WorkChange("员工增加", "101", 1));
            put("重新入职", new WorkChange("重新入职", "102", 1));
            put("员工离职", new WorkChange("员工离职", "301", 3));
            put("员工退休", new WorkChange("员工退休", "305", 3));
            put("员工死亡", new WorkChange("员工死亡", "307", 3));
            put("员工岗位调动", new WorkChange("员工岗位调动", "501", 5));
            put("员工转正", new WorkChange("员工转正", "502", 5));
            put("员工其他变更", new WorkChange("员工其他变更", "590", 5));

        }
    };



}
