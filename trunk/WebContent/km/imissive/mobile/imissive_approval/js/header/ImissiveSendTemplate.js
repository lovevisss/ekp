/**
 * 公文政务版头部模板，用于“发文”页签
 */
define(['mui/createUtils', 'mui/i18n/i18n!km-imissive:mobile'], function(createUtils, msg){
	
	var h = createUtils.createTemplate;
	
	// 排序（创建时间）
	var createTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'docCreateTime',
			subject: msg['mobile.kmImissive.createTime'],
			value: ''
		}
	});
	
	// 排序（签发日期）
	var publishTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'docPublishTime',
			subject: msg['mobile.kmImissive.publishTime'],
			value: ''
		}
	});
	
	// 排序（限办日期）
	var deadTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'fdDeadTime',
			subject: msg['mobile.kmImissive.deadline'],
			value: ''
		}
	});
	
	// 分类筛选器
	var categoryFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/catefilter/FilterItem',
		dojoMixins: 'mui/syscategory/SysCategoryMixin',
		dojoProps: {
			modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
			catekey: 'fdTemplate',
			prefix:'q'
		}
	});
	
	return [createTimeFilter, publishTimeFilter, deadTimeFilter, categoryFilter].join('');
	
});