define(['mui/createUtils',"mui/i18n/i18n!km-imeeting:mobile"], function(createUtils,msg){
	
	var h = createUtils.createTemplate;
	
	var TagFilter = h('div', {
		dojoType: 'mui/property/TagFilterItem',
		dojoProps: {
			name: 'mysummary',
			isTagCount:true,
			options:[{
				name:msg['mobile.approval'],
				value:'myApproval',
				prompt:true
			},{
				name:msg['mobile.approved'],
				value:'myApproved'
			},{
				name:msg['mobile.myDraft'],
				value:'myCreate'
			}],
			values:{'mysummary':'myApproval'}
		}
	});
	
	return [TagFilter].join('');
	
});