
var formOption = {
    formName: 'kmImeetingMainForm',
    modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingMain',
    templateName: 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
    subjectField: 'fdName',
    mode: 'main_category',
    
    dialogs: {
    	km_imeeting_findScheme: {
    		modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingScheme',
    		sourceUrl: '/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=findScheme'
    	}
    },
    
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    detailTables: [],
    dataType: {},
    detailNotNullProp: {}
};