package com.muthagroup.control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.conUtil.Connection_Util;
import com.muthagroup.dao.SPC_DataDAO;
import com.muthagroup.vo.Pass_VO; 
 
@WebServlet("/SPCData_Control")
public class SPCData_Control extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection con = Connection_Util.getLocalUserConnection(); 
			Connection conMaster = Connection_Util.getConnectionMaster();
			
			Pass_VO vo = new Pass_VO();
			SPC_DataDAO dao = new SPC_DataDAO();
			HttpSession session = request.getSession();
			
			String fromDate = request.getParameter("fromdate");
		 	String toDate = request.getParameter("todate");
		 	String datafor = request.getParameter("datafor"); 
		 	int parameter = Integer.valueOf(request.getParameter("parameter"));
		 	
		 	vo.setFromDate(fromDate);
		 	vo.setToDate(toDate);
		 	vo.setParameter(parameter);
		 	vo.setDatafor(datafor);
		 	
		 	
		 	
		 	
		 	/*String disp_query = "";
		 	if (datafor.equalsIgnoreCase("all")) {
		 		disp_query = "SELECT TOP 50 [id]  as id FROM baker_summary where datetime_sheet between '"
		 				+ fromDate
		 				+ "' and '"
		 				+ toDate
		 				+ "' and enable=1 order by id desc";
		 	} else {
		 		disp_query = "SELECT TOP 50 [id]  as id FROM baker_summary where datetime_sheet between '"
		 				+ fromDate
		 				+ "' and '"
		 				+ toDate
		 				+ "' and enable=1 and vendor_code= '"
		 				+ datafor
		 				+ "' order by id desc";
		 	}
		 	ArrayList idList=new ArrayList();
		 	
		 	PreparedStatement ps_summary = conMaster.prepareStatement(disp_query);
			ResultSet rs_summary = ps_summary.executeQuery();
			while (rs_summary.next()) {
				idList.add(rs_summary.getInt("id"));
			}*/
		 	
			dao.generateGraph(vo,session,response,request);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
