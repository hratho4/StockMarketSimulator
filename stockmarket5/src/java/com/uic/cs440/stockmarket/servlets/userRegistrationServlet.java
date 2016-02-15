/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.servlets;

import com.uic.cs440.stockmarket.dao.PlayerDao;
import com.uic.cs440.stockmarket.beans.Player;
import com.uic.cs440.stockmarket.beans.PlayerBalance;
import com.uic.cs440.stockmarket.dao.PlayerbalanceDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Bhavin
 */
public class userRegistrationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
        PrintWriter out = response.getWriter();
        Player user= new Player();
        
            user.setFname(request.getParameter("inputfn"));
            user.setLname(request.getParameter("inputln"));
            user.setBdate(request.getParameter("bdate"));
            user.setCountry(request.getParameter("country"));
            user.setState(request.getParameter("state"));
            user.setCity(request.getParameter("city"));
            user.setContactno(Long.parseLong(request.getParameter("contactno")));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            

            user = PlayerDao.register(user);
            if(user.isValid()){
                out.println("User registered successfully. Please login.");
                String email = request.getParameter("email");
                
                PlayerBalance pb = new PlayerBalance();
                pb.setEmail(email);
                pb.setBalance(10000.00);
                new PlayerbalanceDao().setInitialBalance(pb);
                response.sendRedirect("/stockmarket5/login.jsp");
                HttpSession session = request.getSession(true);
                session.setAttribute("message","User registered successfully. Please login.");
            }
                
            else{
                out.println("User did not register successfully..");
                response.sendRedirect("/stockmarket5/registration.jsp");
            }
        }
        catch(IOException | NumberFormatException e)
        { System.out.println(e);
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
