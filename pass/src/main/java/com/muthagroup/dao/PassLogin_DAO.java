package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

import com.muthagroup.conUtil.Connection_Util;
import com.muthagroup.vo.Pass_VO;

public class PassLogin_DAO {

	public void login_User(HttpSession session, Pass_VO vo, HttpServletResponse response) { 
		try {
			int uid = 0, comp_id=0;
			int dept_id=0; 
			String deptName="";
			boolean flag=false;
			Connection con = Connection_Util.getLocalUserConnection(); 
			PreparedStatement ps_user=null, ps_dept=null;
			ResultSet rs_user=null, rs_dept=null; 
			
			ps_user = con.prepareStatement("select * from user_tbl where Enable_id=1 and Login_Name='" +vo.getName()+"' and Login_Password='" + vo.getPass() + "'");
			rs_user = ps_user.executeQuery(); 
			while (rs_user.next())
			{
					uid = rs_user.getInt("U_Id"); 
					dept_id=rs_user.getInt("dept_id");  
					comp_id=rs_user.getInt("Company_Id");
					ps_dept = con.prepareStatement("select * from user_tbl_dept where dept_id="+dept_id);
					rs_dept = ps_dept.executeQuery();
				while (rs_dept.next()) {
					deptName=rs_dept.getString("Department");
				}
				flag=true;
			}
				
				if(flag==true)
				{
					session.setAttribute("uid", uid); 
					session.setAttribute("dept_id", dept_id);
					session.setMaxInactiveInterval(-1); 
					response.sendRedirect("Home.jsp");
				}else
				{
					response.sendRedirect("Login.jsp?error='Login Fail...Please check User Name and Password...!!!'");  
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
