<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>

<template:include ref="mobile.edit" compatibleMode="true" newMui="true">

	<template:replace name="title">
		<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.return.title"/>
	</template:replace>
	
	<template:replace name="head">
	</template:replace>
	
	<template:replace name="content">
		<xform:config>
			<html:form action="/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do">
				<div data-dojo-type="mui/view/DocScrollableView" 
						data-dojo-mixins="mui/form/_ValidateMixin,mui/form/_AlignMixin" id="scrollView">
					<html:hidden property="fdId"/>
					<html:hidden property="fdImissiveId"/>
					<html:hidden property="fdDetailId"/>
					<html:hidden property="fdUnitId"/>
					<html:hidden property="fdDeliverType"/>
					<html:hidden property="fdRegType"/>
					
					<p class="txttitle" style="margin-top:2rem;text-align: center;"><bean:message bundle="km-imissive" key="kmImissiveReceiveMain.return.title"/></p>
					<div class="" style="padding: 0rem 1.2rem">
						<table class="muiSimple" cellpadding="0" cellspacing="0" style="margin-top: 2rem;">
							<tr>
								<td>
									<xform:textarea property="docContent" required="true" mobile="true" subject="${lfn:message('km-imissive:kmImissiveReceiveMain.fdReturnOpinion')}"></xform:textarea>
								</td>
							</tr>
						</table>
					</div>
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
                        <li data-dojo-type="mui/tabbar/TabBarButton"
                        	data-dojo-props="colSize:2,onClick:function(){submitFormValidate();}">
                            <bean:message key="button.submit" />
                        </li>
                    </ul>
				</div>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmImissiveReturnOpinionForm"]);
					require(['dijit/registry', 'dojo/query'], 
							function(registry, query){
						window.submitFormValidate = function() {
							var validorObj=registry.byId('scrollView');
							if(validorObj.validate()){
								Com_Submit(document.kmImissiveReturnOpinionForm, 'save');
							}
						};
					});
				</script>
			</html:form>
		</xform:config>
	</template:replace>
	
</template:include>