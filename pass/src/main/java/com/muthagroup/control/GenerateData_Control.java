package com.muthagroup.control;

import java.io.IOException; 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

@WebServlet("/GenerateData_Control")
public class GenerateData_Control extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {	
			String fromDate = request.getParameter("fromdate");
		 	String toDate = request.getParameter("todate");
		 	String datafor = request.getParameter("datafor");  
		 	response.sendRedirect("Home.jsp?fromDate="+fromDate+"&toDate="+toDate+"&datafor="+datafor);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
