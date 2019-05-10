/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.MembershipFacade;
import inTouch.ejb.PendingMembershipFacade;
import inTouch.ejb.SocialGroupFacade;
import inTouch.ejb.UserFacade;
import inTouch.entity.Membership;
import inTouch.entity.PendingMembership;
import inTouch.entity.SocialGroup;
import inTouch.entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "acceptPendingInvitation", urlPatterns = {"/acceptPendingInvitation"})
public class acceptPendingInvitation extends HttpServlet {

    @EJB
    private UserFacade userFacade;
    @EJB
    private SocialGroupFacade socialGroupFacade;
    @EJB
    private PendingMembershipFacade pendingMembershipFacade;
    @EJB
    private MembershipFacade membershipFacade;
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
        User u = this.userFacade.find(userId);
        
        String pageURL = request.getParameter("pageURL");
        if (pageURL == null)
            pageURL = "wallServlet";
        
        String acceptGroupStr = request.getParameter("acceptGroupId");
        int acceptGroupId = -1;       
        try {
            acceptGroupId = Integer.parseInt(acceptGroupStr);
        } catch(NumberFormatException e) {
            request.setAttribute("exception", e);
            RequestDispatcher rd = request.getRequestDispatcher("error");
            rd.forward(request, response);
        }
        SocialGroup g = this.socialGroupFacade.find(acceptGroupId);
        
        List<PendingMembership> pendingMemberships = this.pendingMembershipFacade.findPendingFriendship(u, g);
        for (PendingMembership pendingMembership: pendingMemberships)
            this.pendingMembershipFacade.remove(pendingMembership);
        
        Membership mem = new Membership(0, false);
        mem.setMember1(u);
        mem.setSocialGroup(g);
        membershipFacade.create(mem);
        
        response.sendRedirect(pageURL);
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
