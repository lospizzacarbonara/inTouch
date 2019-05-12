/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.MembershipFacade;
import inTouch.ejb.SocialGroupFacade;
import inTouch.ejb.UserFacade;
import inTouch.entity.Membership;
import inTouch.entity.SocialGroup;
import inTouch.entity.User;
import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nellogy
 */
@WebServlet(name = "createGroupServlet", urlPatterns = {"/createGroupServlet"})
public class createGroupServlet extends HttpServlet {

    @EJB
    SocialGroupFacade sgFacade;
    
    @EJB
    MembershipFacade memFacade;
    
    @EJB
    UserFacade userFacade;
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
        
        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        User user = this.userFacade.find(userId);
        
        
        String groupName = request.getParameter("groupName");
        String groupDescription = request.getParameter("body");
        
        SocialGroup group = new SocialGroup(0, groupName, new Date());
        group.setDescription(groupDescription);
        this.sgFacade.create(group);
        
        Membership mem = new Membership(0, true);
        mem.setSocialGroup(group);
        mem.setMember1(user);
        this.memFacade.create(mem);
        
        response.sendRedirect("groupWallServlet?groupId="+group.getId());
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
