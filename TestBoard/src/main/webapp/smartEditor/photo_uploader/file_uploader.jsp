<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.util.*,java.text.SimpleDateFormat"%>
<%@ page import = "java.io.FileOutputStream" %>
<%@ page import = "java.io.OutputStream" %>
<%@ page import = "java.io.InputStream" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "org.apache.commons.fileupload.FileItem" %>
<%@ page import = "org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import = "org.apache.commons.fileupload.servlet.ServletFileUpload" %>


<%
System.out.println("============> smartEdiotr File Upload Start!!");
String return1="";
String return2="";
String return3="";
String name = "";
if (ServletFileUpload.isMultipartContent(request)){
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
//1
    uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);    
    for (FileItem item : items) {
        if(item.getFieldName().equals("callback")) {
            return1 = item.getString("UTF-8");
        } else if(item.getFieldName().equals("callback_func")) {
            return2 = "?callback_func="+item.getString("UTF-8");
        } else if(item.getFieldName().equals("Filedata")) {
            if(item.getSize() > 0) {
            	String ext = item.getName().substring(item.getName().lastIndexOf(".")+1);
            	//String defaultPath = request.getServletContext().getRealPath("/");
            	String defaultPath = "D:" + File.separator + "ktr_upload" + File.separator + "smartEditor";
            	
            	Date today = new Date();
				SimpleDateFormat date = new SimpleDateFormat(File.separator + "yyyy" + File.separator + "MM" + File.separator + "dd");
				String dataFolder = date.format(today);
				//2
	            //String path = defaultPath + dataFolder + File.separator;
				String path = defaultPath + File.separator;
				System.out.println("@@smartEditor file Upload Path : " + path);
                File file = new File(path);
                 
                if(!file.exists()) {
                    file.mkdirs();
                }
                String realname = UUID.randomUUID().toString() + "." + ext;
                InputStream is = item.getInputStream();
                OutputStream os=new FileOutputStream(path + realname);
                int numRead;
                byte b[] = new byte[(int)item.getSize()];
                while((numRead = is.read(b,0,b.length)) != -1){
                    os.write(b,0,numRead);
                }
                if(is != null)  is.close();
                os.flush();
                os.close();
                
              	//local
	           	String sFileURL = "http://localhost:8088/test/imageSrc.do?" + 
					          "physical=" + realname; 
					          
				/* String sFileURL = "http://192.168.0.49:8080/imageSrc.do?" + 
							          "physical=" + dataFolder + File.separator + realname; */
					          
		      	//Server    
// 	          	String sFileURL = "http://ktrhrd.hansystem.kr/imageSrc.do?" + 
// 					          "physical=" + realname;
                
	            System.out.println("최종 URL : " + sFileURL);	          
				          
	          	return3 += "&bNewLine=true&sFileName=" + name + "&sFileURL=" + sFileURL; 
            }else {
                return3 += "&errstr=error";
            }
        }
    }
}
response.sendRedirect(return1+return2+return3);
%>