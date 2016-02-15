package com.uic.cs440.stockmarket.servlets;

import com.uic.cs440.stockmarket.dao.PlayerDao;
import com.uic.cs440.stockmarket.dao.UserLoginDAO;
import com.uic.cs440.stockmarket.beans.Player;
import com.uic.cs440.stockmarket.beans.PlayerBalance;
import com.uic.cs440.stockmarket.dao.PlayerbalanceDao;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class userLoginServlet
 */
@WebServlet("/userLoginServlet")
public class userLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        UserLoginDAO uld = new UserLoginDAO();
        Player player = uld.login(request.getParameter("username"), request.getParameter("password"));
         if (player.isValid()) {
        session.setAttribute("Player", player);
        
        String email = request.getParameter("username");
        PlayerBalance pb = new PlayerbalanceDao().getBalanceInfo(email);
        session.setAttribute("PlayerBalance", pb);
        
        response.sendRedirect("/stockmarket5/homePortfolio.jsp");
         }
         else
         {
              System.out.println("not valid");
                response.sendRedirect("/stockmarket5/login.jsp");
                session = request.getSession(true);
                session.setAttribute("message","Invalid Username/Password");
         }
//        response.setContentType("text/html;charset=UTF-8");
//        
//        PrintWriter out = response.getWriter();
//        
//          try 
//        {
//            Player player = new PlayerDao().fetchPlayerDetails(request.getParameter("username"), request.getParameter("password"));
//                        
//            if (player.isValid()) {
//                HttpSession session = request.getSession(true);
//                Integer i = (Integer) session.getAttribute("id");
//                System.out.println("--->" + i);
//                if (i == null || i == 0) {
//                    i = new Integer(0);
//                    session.setAttribute("Player", player);
//                    response.sendRedirect("/stockmarket5/homePortfolio.jsp");
//
//                } else {
//                    i = new Integer(i.intValue() + 1);
//                    response.sendRedirect("/stockmarket5/homePortfolio.jsp");
//                }
//               session.setAttribute("id", i);
//
//            } else {
//                System.out.println("not valid");
//                response.sendRedirect("/stockmarket5/login.jsp");
//            }
//            
//        }
//        finally {
//            out.close();
//        }
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
