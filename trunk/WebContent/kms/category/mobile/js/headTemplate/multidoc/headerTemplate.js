define(['mui/createUtils', 'mui/i18n/i18n!kms-knowledge:kmsKnowledgeBaseDoc.docPublishTime', 
        'mui/i18n/i18n!kms-knowledge:kmsKnowledge.readCount'], 
    
    function(createUtils, msg, msg2){

	var h = createUtils.createTemplate;

	var sortItem1 = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps : {
			name : 'docPublishTime',
			subject : msg['kmsKnowledgeBaseDoc.docPublishTime'],
			value : 'down'
		}
	});
	
	var sortItem2 = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps : {
			name : 'docReadCount',
			subject : msg2['kmsKnowledge.readCount']
		}
	});
	
	var properties = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/property/FilterItem',
		dojoMixins: 'kms/category/mobile/js/headTemplate/multidoc/propertyMixin'
	});
	
	var cateFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/catefilter/FilterItem',
		dojoMixins: 'mui/catefilter/simplecategory/FilterItem',
		dojoProps: {
			modelName: 'com.landray.kmss.kms.category.model.KmsCategoryMain',
			parentId: '${param.categoryId}'
		}
	});
	
	return [sortItem1, sortItem2, properties, cateFilter].join('') ;
	
});