
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
	java.lang.String KeyName;                 //�ļ���
	java.io.File ObjFile;                     //�ļ�����
	java.io.FileReader ObjFileReader;         //���ļ�����
	char[] ChrBuffer;                        //����
	int intLength;                            //ʵ�ʶ������ַ���

	String mSignatureName;			  //ӡ������
	String mSignatureUnit;			  //ǩ�µ�λ
	String mSignatureUser;			  //������
	String mSignatureSN;			  //ǩ��SN
	String mSignatureGUID;			  //ȫ��Ψһ��ʶ��

	String mMACHIP;			  //����IP
	String OPType;			  //������־
	String mKeySn;       //KEY���к�
	mCommand=request.getParameter("COMMAND");
	mExtParam=new String(request.getParameter("EXTPARAM").getBytes("8859_1"));

    System.out.println("");
    System.out.println("ReadPackage");
    System.out.println(mCommand);

	if(mCommand.equalsIgnoreCase("SAVESIGNATURE")){        //����ǩ��������Ϣ
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
					  //ȡ��Ψһֵ(mSignature)
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
       		 		System.out.println("����ǩ�´���:"+e.toString());
        			mResult=false;
      			}
    		}
  		ObjConnBean.CloseConnection();
  		}
		out.clear();
		out.print("SIGNATUREID="+mSignatureID+"\r\n");
		out.print("RESULT=OK");
	}

	if(mCommand.equalsIgnoreCase("GETNOWTIME")){         //��ȡ������ʱ��
		java.sql.Date mDate;
		Calendar cal  = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String mDateTime=formatter.format(cal.getTime());
		out.clear();
		out.print("NOWTIME="+mDateTime+"\r\n");
		out.print("RESULT=OK");
	}
	if(mCommand.equalsIgnoreCase("DELESIGNATURE")){   //ɾ��ǩ��������Ϣ
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

	if(mCommand.equalsIgnoreCase("LOADSIGNATURE")){    //����ǩ��������Ϣ
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


	if(mCommand.equalsIgnoreCase("SHOWSIGNATURE")){   //��ȡ��ǰǩ��SignatureID������SignatureID�����Զ���LOADSIGNATURE����
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
	if(mCommand.equalsIgnoreCase("GETSIGNATUREDATA")){           //����ǩ��ʱ����ȡ��Ҫ����������
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
									"<Field Index='Caption'>���ܼ���</Field>"	+
         							"<Field Index='ID'>BMJH</Field>"+	
          							"<Field Index='VALUE'>"+rs.getString("BMJH")+"</Field>"	+
         							"<Field Index='ProtectItem'>TRUE</Field>"+	
         						  "</Field>";
         		mSignatureData += "<Field>"+
									"<Field Index='Caption'>�׷�</Field>"	+
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
		out.print("SIGNATUREDATA="+mSignatureData+"\r\n");	//ǩ�±�������Ϣ
		out.print("PROPECTTYPE=1\r\n");						//0:������   1:XMLBOAHU  
		out.print("SignatureCount="+SignatureCount+"\r\n"); //ǩ�¸���
		out.print("DIVID=jfdiv\r\n");  						//ǩ��λ��
		out.print("RESULT=OK");
	}

	if(mCommand.equalsIgnoreCase("PUTSIGNATUREDATA")){      //����ǩ��ʱ��д��ǩ������
		mDocumentID=new String(request.getParameter("DOCUMENTID").getBytes("8859_1"));
		mSignature=new String(request.getParameter("SIGNATURE").getBytes("8859_1"));
   		if (ObjConnBean.OpenConnection()){
      			java.sql.PreparedStatement prestmt=null;
      			try{
				//ȡ��Ψһֵ(mSignature)
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
	if(mCommand.equalsIgnoreCase("SAVEHISTORY")){    //����ǩ����ʷ��Ϣ
		mSignatureName=new String(request.getParameter("SIGNATURENAME").getBytes("8859_1"));//ӡ������
		mSignatureUnit=new String(request.getParameter("SIGNATUREUNIT").getBytes("8859_1"));//ӡ�µ�λ
		mSignatureUser=new String(request.getParameter("SIGNATUREUSER").getBytes("8859_1"));//ӡ���û���
		mSignatureSN=new String(request.getParameter("SIGNATURESN").getBytes("8859_1"));//ӡ�����к�
		mSignatureGUID=new String(request.getParameter("SIGNATUREGUID").getBytes("8859_1"));//ȫ��Ψһ��ʶ
		mDocumentID=new String(request.getParameter("DOCUMENTID").getBytes("8859_1"));//ҳ��ID
		mSignatureID=new String(request.getParameter("SIGNATUREID").getBytes("8859_1"));//ǩ�����к�
		mMACHIP=new String(request.getParameter("MACHIP").getBytes("8859_1"));//ǩ�»���IP
		OPType=new String(request.getParameter("LOGTYPE").getBytes("8859_1"));//��־��־
    mKeySn=new String(request.getParameter("KEYSN").getBytes("8859_1"));//KEY���к�
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