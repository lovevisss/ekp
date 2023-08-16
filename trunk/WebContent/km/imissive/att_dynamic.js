

/**
 * 盖章
 */
function WebOpenSignature(fdKey,userId){
	try{
		var obj = document.getElementById("JGWebOffice_"+fdKey);
		if(obj&&Attachment_ObjectInfo[fdKey]){
			Attachment_ObjectInfo[fdKey].ocxObj.WebSetMsgByName("jgUserId", userId);			
			if (null != userOsTypeParam && userOsTypeParam == "windows") {
				if (null != jgBigVersionParam && jgBigVersionParam == "2015") {
					if (navigator.userAgent.indexOf("Firefox") >= 0){
						obj.ExecuteScript("OpenSign","ActiveObject.FuncExtModule.WebOpenSignature(5)");
					} else {
						Attachment_ObjectInfo[fdKey].ocxObj.WebOpenSignature();					
					}
				} else {
					Attachment_ObjectInfo[fdKey].ocxObj.WebOpenSignature(5);
				}
			} else {
				if (null != isEnabledParam && isEnabledParam == "true") {
					Attachment_ObjectInfo[fdKey].ocxObj.WebOpenSignature();
				}
			}
			sigzqFlag = true;
			StatusMsg(Attachment_ObjectInfo[fdKey].ocxObj.Status);
		}
	}catch(e)
	{
		e.description;
	}
}
