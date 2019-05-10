/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.FriendshipFacade;
import inTouch.ejb.PendingFriendshipFacade;
import inTouch.ejb.UserFacade;
import inTouch.entity.Friendship;
import inTouch.entity.PendingFriendship;
import inTouch.entity.User;
import java.io.IOException;
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
@WebServlet(name = "acceptFriend", urlPatterns = {"/acceptFriend"})
public class acceptFriendServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;
    @EJB
    private FriendshipFacade friendshipFacade;
    @EJB
    private PendingFriendshipFacade pendingFriendshipFacade;
    
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
        User receiver = this.userFacade.find(userId);
        
        String pageURL = request.getParameter("pageURL");
        if (pageURL == null)
            pageURL = "friends";
        
        String acceptFriendStr = request.getParameter("acceptUserId");
        int acceptFriendId = -1;       
        try {
            acceptFriendId = Integer.parseInt(acceptFriendStr);
        } catch(NumberFormatException e) {
            request.setAttribute("exception", e);
            RequestDispatcher rd = request.getRequestDispatcher("error");
            rd.forward(request, response);
        }
        User sender = this.userFacade.find(acceptFriendId);
        
        List<PendingFriendship> pendingFriendships = this.pendingFriendshipFacade.findPendingFriendship(sender, receiver);
        for (PendingFriendship pendingFriendship: pendingFriendships)
            this.pendingFriendshipFacade.remove(pendingFriendship);
        
        Friendship friendship = new Friendship(0);
        friendship.setFriend1(sender);
        friendship.setFriend2(receiver);
        this.friendshipFacade.create(friendship);
        
        Friendship friendship2 = new Friendship(0);
        friendship2.setFriend1(receiver);
        friendship2.setFriend2(sender);
        this.friendshipFacade.create(friendship2);
        
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
