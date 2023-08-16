
<%@page import="com.landray.kmss.km.imissive.iSignatureHTML.iDBManager2000"%><%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
    iDBManager2000 ObjConnBean = new iDBManager2000();
	String mCommand;
	String mDocumentID = "";
	String mSignatureID = "";
	String mSignature = "";	
	String mSignatures;
	String strSql;
  	String mExtParam;

	boolean mResult;
	java.lang.String KeyName;                 //文件名
	java.io.File ObjFile;                     //文件对象
	java.io.FileReader ObjFileReader;         //读文件对象
	char[] ChrBuffer;                        //缓冲
	int intLength;                            //实际读出的字符数

	String mSignatureName;			  //印章名称
	String mSignatureUnit;			  //签章单位
	String mSignatureUser;			  //持章人
	String mSignatureSN;			  //签章SN
	String mSignatureGUID;			  //全球唯一标识符

	String mMACHIP;			  //机器IP
	String OPType;			  //操作标志
	String mKeySn;       //KEY序列号
	mCommand=request.getParameter("COMMAND");
	mExtParam=new String(request.getParameter("EXTPARAM").getBytes("8859_1"));

    System.out.println("");
    System.out.println("ReadPackage");
    System.out.println(mCommand);

	if(mCommand.equalsIgnoreCase("SAVESIGNATURE")){        //保存签章数据信息
		mDocumentID=new String(request.getParameter("DOCUMENTID").getBytes("8859_1"));
		mSignatureID=new String(request.getParameter("SIGNATUREID").getBytes("8859_1"));
		mSignature=new String(request.getParameter("SIGNATURE").getBytes("8859_1"));
		System.out.println("DocuemntID:"+mDocumentID);
		System.out.println("SignatureID:"+mSignatureID);
		//System.out.println("Signature:"+mSignature);
   		if (ObjConnBean.OpenConnection()){
			//strSql="SELECT * from km_imissive_signature Where SignatureID='"+mSignatureID+"' and DocumentID='"+mDocumentID+"'";
    		strSql="SELECT * from km_imissive_signature Where SignatureID=? and DocumentID=?";
			java.sql.PreparedStatement prestmt=null;
			prestmt = ObjConnBean.Conn.prepareStatement(strSql);
			prestmt.setString(1, mSignatureID);
			prestmt.setString(2, mDocumentID);
			ResultSet rs = null;
    		rs = ObjConnBean.ExecuteQuery(strSql,prestmt);
    		if (rs.next()) {
       			//strSql = "update km_imissive_signature set DocumentID='"+mDocumentID+"',SIGNATUREID='"+mSignatureID+"',Signature='"+mSignature+"'";
       			//strSql = strSql + "  Where SignatureID='"+mSignatureID+"' and DocumentID='"+mDocumentID+"'";
		    	strSql = "update km_imissive_signature set DocumentID=?,SIGNATUREID=?,Signature=? Where SignatureID=? and DocumentID=?";
       			java.sql.PreparedStatement pstmt=null;
       			pstmt=ObjConnBean.Conn.prepareStatement(strSql);
       			pstmt.setString(1, mDocumentID);
       			pstmt.setString(2, mSignatureID);
       			pstmt.setString(3, mSignature);
       			pstmt.setString(4, mSignatureID);
       			pstmt.setString(5, mDocumentID);
       			ObjConnBean.ExecuteUpdate(strSql,pstmt);
    		}else{
      			java.sql.PreparedStatement prestmt=null;
      			try{
					  //取得唯一值(mSignature)
    				java.util.Date dt=new java.util.Date();
    				long lg=dt.getTime();
    				Long ld=new Long(lg);
    				mSignatureID=ld.toString();
        			String Sql="insert into km_imissive_signature (DocumentID,SignatureID,Signature) values (?,?,?) ";					
		    	    prestmt=ObjConnBean.Conn.prepareStatement(Sql);
        			prestmt.setString(1, mDocumentID);
			        prestmt.setString(2, mSignatureID);
    	    		prestmt.setString(3, mSignature);

			        ObjConnBean.Conn.setAutoCommit(true);
        			prestmt.execute();
		    	    //ObjConnBean.Conn.commit();
        			prestmt.close();
			        mResult=true;
    	  		}
      			catch(SQLException e){
       		 		System.out.println("保存签章错误:"+e.toString());
        			mResult=false;
      			}
    		}
  		ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print("SIGNATUREID="+mSignatureID+"\r\n");
		out.print("RESULT=OK");
	}

	if(mCommand.equalsIgnoreCase("GETNOWTIME")){         //获取服务器时间
		java.sql.Date mDate;
		Calendar cal  = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String mDateTime=formatter.format(cal.getTime());
		out.clear();
		out.print("NOWTIME="+mDateTime+"\r\n");
		out.print("RESULT=OK");
	}
	if(mCommand.equalsIgnoreCase("DELESIGNATURE")){   //删除签章数据信息
		mDocumentID=request.getParameter("DOCUMENTID");
		mSignatureID=request.getParameter("SIGNATUREID");
		System.out.println("DocuemntID:"+mDocumentID);
		System.out.println("SignatureID:"+mSignatureID);
   		if (ObjConnBean.OpenConnection()){
  			//strSql="SELECT * from km_imissive_signature Where SignatureID='"+mSignatureID+"' and DocumentID='"+mDocumentID+"'";
			strSql="SELECT * from km_imissive_signature Where SignatureID=? and DocumentID=?";
			java.sql.PreparedStatement prestmt=null;
			prestmt = ObjConnBean.Conn.prepareStatement(strSql);
			prestmt.setString(1, mSignatureID);
			prestmt.setString(2, mDocumentID);
  			ResultSet rs=null;
			rs = ObjConnBean.ExecuteQuery(strSql,prestmt);
			if(rs.next()){
				try{
					//strSql="DELETE from km_imissive_signature Where SignatureID='"+mSignatureID+"' and DocumentID='"+mDocumentID+"'";
					strSql="DELETE from km_imissive_signature Where SignatureID=? and DocumentID=?";
					java.sql.PreparedStatement pstmt=null;
	       			pstmt=ObjConnBean.Conn.prepareStatement(strSql);
	       			pstmt.setString(1, mSignatureID);
	       			pstmt.setString(2, mDocumentID);
					ObjConnBean.ExecuteUpdate(strSql,pstmt);
				}
				catch(Exception ex){
					out.println(ex.toString());
				}
			}
			ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print("RESULT=OK");
	}

	if(mCommand.equalsIgnoreCase("LOADSIGNATURE")){    //调入签章数据信息
		mDocumentID=request.getParameter("DOCUMENTID");
		mSignatureID=request.getParameter("SIGNATUREID");
		System.out.println("DocuemntID:"+mDocumentID);
		System.out.println("SignatureID:"+mSignatureID);
   		if (ObjConnBean.OpenConnection()){
  			//strSql="SELECT * from km_imissive_signature Where SignatureID='"+mSignatureID+"' and DocumentID='"+mDocumentID+"'";
			strSql="SELECT * from km_imissive_signature Where SignatureID=? and DocumentID=?";
  			java.sql.PreparedStatement prestmt=null;
			prestmt = ObjConnBean.Conn.prepareStatement(strSql);
			prestmt.setString(1, mSignatureID);
			prestmt.setString(2, mDocumentID);
  			ResultSet rs=null;
			rs = ObjConnBean.ExecuteQuery(strSql,prestmt);
			if(rs.next()){
				mSignature=rs.getString("Signature");
			}
			ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print(mSignature+"\r\n");
		out.print("RESULT=OK");
	}


	if(mCommand.equalsIgnoreCase("SHOWSIGNATURE")){   //获取当前签章SignatureID，调出SignatureID，再自动调LOADSIGNATURE数据
		  mDocumentID=request.getParameter("DOCUMENTID");
		  System.out.println("DocuemntID:"+mDocumentID);
    	mSignatures="";
   		if (ObjConnBean.OpenConnection()){
  			//strSql="SELECT * from km_imissive_signature Where DocumentID='"+mDocumentID + "'";
			strSql="SELECT * from km_imissive_signature Where DocumentID=?";
  			java.sql.PreparedStatement prestmt=null;
			prestmt = ObjConnBean.Conn.prepareStatement(strSql);
			prestmt.setString(1, mDocumentID);
  			ResultSet rs=null;
			rs = ObjConnBean.ExecuteQuery(strSql,prestmt);
			while(rs.next()){
				mSignatures=mSignatures+rs.getString("SignatureID")+";";
			}
			ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print("SIGNATURES="+mSignatures+"\r\n");
		out.print("RESULT=OK");
	}


	//---------------------------------------------------------------------------------------
	if(mCommand.equalsIgnoreCase("GETSIGNATUREDATA")){           //批量签章时，获取所要保护的数据
	    	String mSignatureData="";
		mDocumentID=request.getParameter("DOCUMENTID");
        System.out.println(new String(request.getParameter("FIELDSLIST").getBytes("8859_1")) );
        System.out.println(request.getParameter("FIELDSNAME"));
        int SignatureCount = 0;
   		if (ObjConnBean.OpenConnection()){
  			//strSql="SELECT XYBH,BMJH,JF,YF,HZNR,QLZR,CPMC,DGSL,DGRQ  from HTMLDocument Where DocumentID='"+mDocumentID + "'";
			strSql="SELECT XYBH,BMJH,JF,YF,HZNR,QLZR,CPMC,DGSL,DGRQ  from HTMLDocument Where DocumentID=?";
  			java.sql.PreparedStatement prestmt=null;
			prestmt = ObjConnBean.Conn.prepareStatement(strSql);
			prestmt.setString(1, mDocumentID);
  			ResultSet rs=null;
			rs = ObjConnBean.ExecuteQuery(strSql,prestmt);
			mSignatureData = "<?xml version='1.0' encoding='GB2312' standalone='yes'?>";
			if (rs.next()){
				//mSignatureData=mSignatureData+"XYBH="+(rs.getString("XYBH"))+"\r\n";
				//mSignatureData=mSignatureData+"BMJH="+(rs.getString("BMJH"))+"\r\n";
				//mSignatureData=mSignatureData+"JF="+(rs.getString("JF"))+"\r\n";
				//mSignatureData=mSignatureData+"YF="+(rs.getString("YF"))+"\r\n";
				//mSignatureData=mSignatureData+"HZNR="+(rs.getString("HZNR"))+"\r\n";
				//mSignatureData=mSignatureData+"QLZR="+(rs.getString("QLZR"))+"\r\n";
				//mSignatureData=mSignatureData+"CPMC="+(rs.getString("CPMC"))+"\r\n";
				//mSignatureData=mSignatureData+"DGSL="+(rs.getString("DGSL"))+"\r\n";
				//mSignatureData=mSignatureData+"DGRQ="+(rs.getString("DGRQ"))+"\r\n";
				SignatureCount++;
				mSignatureData += "<Signature>";
         		mSignatureData += "<Field>"+
									"<Field Index='Caption'>保密级别</Field>"	+
         							"<Field Index='ID'>BMJH</Field>"+	
          							"<Field Index='VALUE'>"+rs.getString("BMJH")+"</Field>"	+
         							"<Field Index='ProtectItem'>TRUE</Field>"+	
         						  "</Field>";
         		mSignatureData += "<Field>"+
									"<Field Index='Caption'>甲方</Field>"	+
         							"<Field Index='ID'>JF</Field>"+	
          							"<Field Index='VALUE'>"+rs.getString("JF")+"</Field>"	+
         							"<Field Index='ProtectItem'>TRUE</Field>"+	
         						  "</Field>";	  				    
				mSignatureData +="</Signature>";
			}
			mSignatureData=java.net.URLEncoder.encode(mSignatureData);
			ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print("SIGNATUREDATA="+mSignatureData+"\r\n");	//签章保护的信息
		out.print("PROPECTTYPE=1\r\n");						//0:表单保护   1:XMLBOAHU  
		out.print("SignatureCount="+SignatureCount+"\r\n"); //签章个数
		out.print("DIVID=jfdiv\r\n");  						//签章位置
		out.print("RESULT=OK");
	}

	if(mCommand.equalsIgnoreCase("PUTSIGNATUREDATA")){      //批量签章时，写入签章数据
		mDocumentID=new String(request.getParameter("DOCUMENTID").getBytes("8859_1"));
		mSignature=new String(request.getParameter("SIGNATURE").getBytes("8859_1"));
   		if (ObjConnBean.OpenConnection()){
      			java.sql.PreparedStatement prestmt=null;
      			try{
				//取得唯一值(mSignature)
    				java.util.Date dt=new java.util.Date();
    				long lg=dt.getTime();
    				Long ld=new Long(lg);
    				mSignatureID=ld.toString();
        			String Sql="insert into km_imissive_signature (DocumentID,SignatureID,Signature) values (?,?,?) ";
		    	    prestmt =ObjConnBean.Conn.prepareStatement(Sql);
        			prestmt.setString(1, mDocumentID);
			        prestmt.setString(2, mSignatureID);
    	    		prestmt.setString(3, mSignature);
			        ObjConnBean.Conn.setAutoCommit(true);
        			prestmt.execute();
		    	    ObjConnBean.Conn.commit();
        			prestmt.close();
			        mResult=true;
    	  		}
      			catch(SQLException e){
       		 		System.out.println(e.toString());
        			mResult=false;
      			}
  		ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print("SIGNATUREID="+mSignatureID+"\r\n");
		out.print("RESULT=OK");
	}

	//---------------------------------------------------------------------------------------
	if(mCommand.equalsIgnoreCase("SAVEHISTORY")){    //保存签章历史信息
		mSignatureName=new String(request.getParameter("SIGNATURENAME").getBytes("8859_1"));//印章名称
		mSignatureUnit=new String(request.getParameter("SIGNATUREUNIT").getBytes("8859_1"));//印章单位
		mSignatureUser=new String(request.getParameter("SIGNATUREUSER").getBytes("8859_1"));//印章用户名
		mSignatureSN=new String(request.getParameter("SIGNATURESN").getBytes("8859_1"));//印章序列号
		mSignatureGUID=new String(request.getParameter("SIGNATUREGUID").getBytes("8859_1"));//全球唯一标识
		mDocumentID=new String(request.getParameter("DOCUMENTID").getBytes("8859_1"));//页面ID
		mSignatureID=new String(request.getParameter("SIGNATUREID").getBytes("8859_1"));//签章序列号
		mMACHIP=new String(request.getParameter("MACHIP").getBytes("8859_1"));//签章机器IP
		OPType=new String(request.getParameter("LOGTYPE").getBytes("8859_1"));//日志标志
    mKeySn=new String(request.getParameter("KEYSN").getBytes("8859_1"));//KEY序列号
    if (ObjConnBean.OpenConnection()){
      java.sql.PreparedStatement prestmt=null;
      try{
				java.sql.Date mDate;
				Calendar cal  = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				String mDateTime=formatter.format(cal.getTime());

        strSql="insert into HTMLHistory(SignatureName,SignatureUnit,SignatureUser,SignatureSN,";
        strSql=strSql+"SignatureGUID,DocumentID,SignatureID,IP,LogTime,LogType,KeySN)";
        strSql=strSql+" values(?,?,?,?,?,?,?,?,?,?,?)";
        prestmt =ObjConnBean.Conn.prepareStatement(strSql);

        prestmt.setString(1, mSignatureName);
        prestmt.setString(2, mSignatureUnit);
        prestmt.setString(3, mSignatureUser);
        prestmt.setString(4, mSignatureSN);
        prestmt.setString(5, mSignatureGUID);
        prestmt.setString(6, mDocumentID);
        prestmt.setString(7, mSignatureID);
        prestmt.setString(8, mMACHIP);
        prestmt.setString(9,mDateTime);
        prestmt.setString(10,OPType);
        prestmt.setString(11,mKeySn);
        ObjConnBean.Conn.setAutoCommit(true);
        prestmt.execute();
        ObjConnBean.Conn.commit();
        prestmt.close();
        mResult=true;
      }
      catch(SQLException e){
        System.out.println(e.toString());
        mResult=false;
      }
  		ObjConnBean.CloseConnection();
    }
		out.clear();
		out.print("SIGNATUREID="+mSignatureID+"\r\n");
		out.print("RESULT=OK");
	}
%>