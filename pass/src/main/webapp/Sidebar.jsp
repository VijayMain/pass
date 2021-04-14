<%@page import="com.muthagroup.conUtil.Connection_Util"%>
<%@page import="java.sql.ResultSet"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sidebar</title>
</head>
<body>
<%
try{
%>
<!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu">
          <!-- <li class="active">
            <a class="" href="Home.jsp">
                    <i class="icon_house_alt"></i>
                    <span>Dashboard</span>
             </a>
          </li> -->
          <li class="sub-menu">
            <a href="javascript:;" class="">
               <i class="icon_building_alt"></i>
               <span>SPC Details</span>
               <span class="menu-arrow arrow_carrot-right"></span>
               </a>
            <ul class="sub">
            <!-- <li><a class="" href="#"><i class="icon_datareport"></i>Summary</a></li> -->
              <li><a class="" href="Home.jsp"><i class="icon_like"></i>Home</a></li>
              <li><a class="" href="SixSigma_Define.jsp"><i class="icon_pencil"></i>Define</a></li>  
            </ul>
          </li>
        </ul>
      </div> 
    </aside>
    <%
}catch(Exception e){
	e.printStackTrace();
}
    %>
</body>
</html>