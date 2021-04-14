package com.muthagroup.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 
import com.muthagroup.dao.PassLogin_DAO;
import com.muthagroup.vo.Pass_VO;
 
@WebServlet("/Login_Control")
public class Login_Control extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name = request.getParameter("uname");
			String pass = request.getParameter("password"); 
			HttpSession session = request.getSession();
			Pass_VO vo = new Pass_VO();
			PassLogin_DAO dao = new PassLogin_DAO();
			
			vo.setName(name);
			vo.setPass(pass);			
			
			dao.login_User(session,vo,response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
}
