<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.util.UUID" %>
<%@ page import = "java.io.FileOutputStream" %>
<%@ page import = "java.io.OutputStream" %>
<%@ page import = "java.io.InputStream" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.util.List" %>
<%@ page import = "org.apache.commons.fileupload.FileItem" %>
<%@ page import = "org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import = "org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<%
String sFileInfo = "";
String name = request.getHeader("file-name");
String ext = name.substring(name.lastIndexOf(".")+1);
String defaultPath = request.getServletContext().getRealPath("/");

String path = defaultPath + "upload" + File.separator;
File file = new File(path);
if(!file.exists()) {
    file.mkdirs();
}
String realname = UUID.randomUUID().toString() + "." + ext;
InputStream is = request.getInputStream();
OutputStream os=new FileOutputStream(path + realname);
int numRead;
byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
while((numRead = is.read(b,0,b.length)) != -1){
    os.write(b,0,numRead);
}
if(is != null) {
    is.close();
}
os.flush();
os.close();
sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/upload/"+realname;
out.println(sFileInfo);

%>