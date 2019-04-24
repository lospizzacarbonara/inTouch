/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.PendingMembershipFacade;
import inTouch.ejb.SocialGroupFacade;
import inTouch.ejb.UserFacade;
import inTouch.entity.PendingMembership;
import inTouch.entity.SocialGroup;
import inTouch.entity.User;
import java.io.IOException;
import java.util.Random;
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
 * @author jfaldanam
 */
@WebServlet(name = "joinGroup", urlPatterns = {"/joinGroup"})
public class joinGroupServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;
    @EJB
    private SocialGroupFacade groupFacade;
    @EJB
    private PendingMembershipFacade pendingMembershipFacade;
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
        int userId = (Integer)session.getAttribute("userId");
        User loggedUser = this.userFacade.find(userId);
        
        String groupStr = request.getParameter("groupId");
        int groupId = -1;       
        try {
            groupId = Integer.parseInt(groupStr);
        } catch(NumberFormatException e) {
            request.setAttribute("exception", e);
            RequestDispatcher rd = request.getRequestDispatcher("error");
            rd.forward(request, response);
        }
        
        SocialGroup group = this.groupFacade.find(groupId);
        
        PendingMembership pending = new PendingMembership(new Random().nextInt());
        pending.setInvitation(false);
        pending.setUser(loggedUser);
        pending.setSocialGroup(group);
                
        this.pendingMembershipFacade.create(pending);
        
        RequestDispatcher rd = request.getRequestDispatcher("search");
        rd.forward(request, response);
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
