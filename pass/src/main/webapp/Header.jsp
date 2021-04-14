<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Header</title>
</head>
<body>
<header class="header dark-bg">
<%
int dept_idCheck = Integer.valueOf(session.getAttribute("dept_id").toString()); 
%>  
      <a href="Home.jsp" class="logo"><span class="lite">Mutha Group </span> Portal Accessible SPC System</a> 
      <div class="top-nav notification-row"> 
       <ul class="nav pull-right top-menu" style="text-align: center;"  title="Log Out"> 
          <li id="task_notificatoin_bar" class="dropdown"  title="Log Out"> 
            <a href="Login.jsp" style="font-size: 15px;">
              <img alt="#" src="img/ShutDown.png"  title="Log Out"><b> Sign Out</b>
            </a> 
          </li>  
        </ul> 
        <ul class="nav pull-right top-menu"> 
          <li id="task_notificatoin_bar" class="dropdown">
           <a href="SPC_Report.jsp" style="font-size: 15px;">
               <i class="icon_datareport"></i> <b>SPC Report</b>
            </a> 
          </li>  
        </ul> 
        <ul class="nav pull-right top-menu"> 
          <li id="task_notificatoin_bar" class="dropdown"> 
            <a href="Home.jsp" style="font-size: 15px;">
               <i class="icon_calculator_alt"></i> <b>Summary</b>
            </a> 
          </li>  
        </ul> 
<%--  <%
        if(dept_idCheck==18 || dept_idCheck==6){
        %>
        <ul class="nav pull-right top-menu"> 
          <li id="task_notificatoin_bar" class="dropdown"> 
            <a href="Sample.jsp" style="font-size: 15px;">
               <i class="icon_calculator_alt"></i> <b>Sample</b>
            </a> 
          </li>  
        </ul> 
        <%
        }
%> --%>
      </div>
    </header>
    <!--header end-->
</body>
</html>