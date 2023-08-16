Com_RegisterFile("unitDialog.js");
Com_IncludeFile("dialog.js");

function checkIfFutureNodeSelected(){
	if ($("input[name='futureNode']").length == 0)
		return true;
	if ($("input[name='futureNode']:checked").length > 0)
		return true;
	return false;
}


function checkPdf(value,fdMainId,type){
	//if(value == '0'){
	var url= "";
	var existPdf = false;
	var existOfd = false;
	var existWpsOfd = false;
	var existWpsCenterOfd = false;
	if('send' == type){
		url = Com_Parameter.ContextPath+"km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=checkPdf"; 
	}
	if('receive' == type){
		url = Com_Parameter.ContextPath+"km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkPdf"; 
	}
	 $.ajax({     
	     type:"post",   
	     url:url,     
	     data:{fdMainId:fdMainId},    
	     success:function(data){
	    	 var results =  eval("("+data+")");
	    	 if(results['convertStatus'] == '-2'){
	    		 $('#optType').hide();
    			 document.getElementsByName("fdContentType")[0].value = '1';
	    	 }else{
	    		 if(results['isWord']){
		    		 $('#optType').show();
					 //0:Pdf格式、1:Word或WPS格式、2：数科ofd、3:wpsOfd
		    		 if(results['existPdf']){
		    			 existPdf = true;
	    			 }
		    		 if(results['existOfd']){
		    			 existOfd = true;
	    			 }

					 if( (!existPdf && !existOfd) ){
						 $('#optType').hide();
						 document.getElementsByName("fdContentType")[0].value = '1';
					 }else{
						 if(!existPdf){
							 $('input:radio[name="fdContentType"][value="0"]').parent().hide();
						 }
						 if( !existOfd){
							 $('input:radio[name="fdContentType"][value="2"]').parent().hide();
						 }
					 }
		    	 }else{
		    		 $('#optType').hide();
		    		 document.getElementsByName("fdContentType")[0].value = '1';
		    	 }
	    	 }
		}    
  });
}



