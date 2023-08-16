/**
 * 公文政务版（交换库）头部模板，用于“我会签的”页签
 */
define(['mui/createUtils', 'mui/i18n/i18n!km-imissive:mobile'], function(createUtils, msg){
	
	var h = createUtils.createTemplate;
	
	// 排序（创建时间）
	var createTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'docCreateTime',
			subject: msg['mobile.kmImissive.createTime'],
			value: 'down'
		}
	});
	
	// 属性筛选器
	var propertyFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/property/FilterItem',
		dojoMixins: 'km/imissive/mobile/exchange_library/js/header/MySignPropertyMixin'
	});
	

	return [createTimeFilter, propertyFilter].join('');
	
});