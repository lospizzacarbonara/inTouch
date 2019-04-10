/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.UserFacade;
import inTouch.entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author avila
 */
@WebServlet(name = "changePasswordServlet", urlPatterns = {"/changePasswordServlet"})
public class changePasswordServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;

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
         response.setCharacterEncoding("UTF-8");
        
        Integer idUser = null;
        User user = new User();
        String str = "";
        
        try{
        str = request.getParameter("idUser").trim();
        }catch(NullPointerException msg){
        String error = " ERROR: idUser es null: " + msg + "(str es: " + str + ")";
        request.setAttribute("exception", error);
        RequestDispatcher rd = request.getRequestDispatcher("/error");
        rd.forward(request,response); 
        }
        
        try{
            idUser = Integer.parseInt(str);
        }
        catch(NumberFormatException msg)
        {
            String error = " ERROR: Formato de id de usuario incorrecto: " + msg + "(str es: " + str + ")";
            request.setAttribute("exception", error);
            RequestDispatcher rd = request.getRequestDispatcher("/error");
            rd.forward(request,response); 
        }
        
        if(idUser == null)
        {
            String error = " ERROR: El usuario es nulo ";
            request.setAttribute("exception", error);
            RequestDispatcher rd = request.getRequestDispatcher("/error");
            rd.forward(request,response); 
        }
        else
        {
            user = this.userFacade.find(idUser);

            request.setAttribute("user",user);
            RequestDispatcher rd = request.getRequestDispatcher("/changePassword.jsp");
            rd.forward(request,response);  
            
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
