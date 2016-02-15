/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.servlets;

import com.uic.cs440.stockmarket.beans.Player;
import com.uic.cs440.stockmarket.beans.PlayerBalance;
import com.uic.cs440.stockmarket.beans.StockInfo;
import com.uic.cs440.stockmarket.dao.PlayerbalanceDao;
import com.uic.cs440.stockmarket.dao.SellStockDao;
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
public class buyStockServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
    
           HttpSession session = request.getSession(true);
           Player player = (Player) session.getAttribute("Player");
           StockInfo stock = new StockInfo();
           System.out.println(player.getEmail()+"   "+request.getParameter("price")+" "+request.getParameter("stck"));
           float price = Float.parseFloat(request.getParameter("price"));
           int buy_quantity = Integer.parseInt(request.getParameter("buy_quantity"));
            System.out.println(buy_quantity+request.getParameter("stck"));
          //  stock.setStockQuantity(quantity);
            stock.setStockSymbol(request.getParameter("stck"));
            stock.setEmail(player.getEmail());
            stock= buyStockDao.buyStock(stock,buy_quantity,price);
            
            /*---------------------------------------------------------------------------------*/
            float spentAmt = (float)buy_quantity * price * -1.0f;
            String sa = String.valueOf(spentAmt);
            Double spentAmount = Double.parseDouble(sa);
            
            new PlayerbalanceDao().setBalance(spentAmount, player.getEmail());
            PlayerBalance pv = (PlayerBalance)session.getAttribute("PlayerBalance");
            pv.setBalance(pv.getBalance() + spentAmount);
            
            response.sendRedirect("/stockmarket5/stockDetail.jsp?symbol="+request.getParameter("stck"));
          
        
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
