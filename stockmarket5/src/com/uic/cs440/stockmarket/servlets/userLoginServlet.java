package com.uic.cs440.stockmarket.servlets;

import com.uic.cs440.stockmarket.dao.PlayerDao;
import com.uic.cs440.stockmarket.beans.Player;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class userLoginServlet
 */
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
        
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        
        try 
        {
            Player player = new PlayerDao().fetchPlayerDetails(request.getParameter("username"), request.getParameter("password"));
                        
            if (player.isValid()) {
                Integer i = (Integer) session.getAttribute("id");
                System.out.println("--->" + i);
                if (i == null || i == 0) {
                    i = new Integer(0);
                    session.setAttribute("Player", player);
                    response.sendRedirect("/stockmarket5/homePortfolio.jsp");

                } else {
                    i = new Integer(i.intValue() + 1);
                    response.sendRedirect("/stockmarket5/homePortfolio.jsp");
                }
               session.setAttribute("id", i);

            } else {
                System.out.println("not valid");
                response.sendRedirect("/stockmarket5/login.jsp");
            }
        }
        finally {
            out.close();
        }
        
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
