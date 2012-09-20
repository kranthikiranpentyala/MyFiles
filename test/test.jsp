<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd"> 

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html> 
<head> 
</head> 
<body>
<% 
try {
String connectionURL = "jdbc:mysql://10.32.27.16:3306/publishers"; 
String type1=request.getParameter("domain");
String createddate=request.getParameter("createddate");
%>
<%
//String type1="30";
Connection connection = null; 

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

connection = DriverManager.getConnection(connectionURL, "root", "");
if(!connection.isClosed())
%>

 <!-- <font size="+3" color="green"></b> -->
<% 
           Statement st=connection.createStatement();
           ResultSet res = st.executeQuery("select domain from top"+type1+" where date_format(createddate,'%e-%c-%Y')='"+createddate+"'");
           //ResultSet res = st.executeQuery("select distinct publisherkey from publisher_trending where domain='"+domain+"'");
           //out.println("publisherkey: " +res);
int rowCount = 0;  
while ( res.next() )  
{  
    // Process the row.  
   rowCount++;  
}
//res.last();

    // Get the row number of the last row which is also the row count
//    int rowCount = res.getRow();  
   //out.println("rows: " +rowCount);
//res.beforefirst();
if( rowCount != 0) 
{
   res = st.executeQuery("select domain from top"+type1+" where date_format(createddate,'%e-%c-%Y')='"+createddate+"'");
%> 
 <select name='domain'> 
<% 
   while (res.next()) 
   {
      String s = res.getString("domain");
%> 
         <option value="<%=s%>"><%=s%></option>
<% 
   }
%>
      </select> 
      <br/>
  <!--    <input type="button" name="go" class="portlet-form-button" value="Show Chart" onClick="doForm()"/> -->
<%}else{ 
%>
<font color="red">
<%
out.println("No domains for this combination." );
%>
</font>
</br>
<%
}connection.close();
}
catch(Exception ex){
%>
</font>
<font size="+3" color="red"></b>
<%
out.println("Unable to connect to database.");
}
%>

<!--
//out.println(s +"\n"); %> createddate >= '"+from_date+"'  and createddate <= '"+end_date+"' and
-->
</font>
</body> 
</html> 

