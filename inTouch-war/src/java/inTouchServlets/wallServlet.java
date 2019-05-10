/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.PostFacade;
import inTouch.ejb.UserFacade;
import inTouch.entity.Post;
import inTouch.entity.SocialGroup;
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
 * @author Nellogy
 */
@WebServlet(name = "wallServlet", urlPatterns = {"/wallServlet"})
public class wallServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;
    @EJB 
    private PostFacade postFacade;

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
        int loggedUserId = (Integer) session.getAttribute("userId");
        
        User user = userFacade.find(loggedUserId);
        List<Post> globalPostList, privatePostList;
        List<SocialGroup> groupList;
        List<User> friendInvites;
        List<SocialGroup> groupInvites;
        
        response.setContentType("text/html;charset=UTF-8");
        privatePostList = postFacade.getPrivatePost(user); //sólo los de los amigos y grupos
        globalPostList = postFacade.getPublicPost(); //sólo los mensajes globales (públicos)
        groupList = userFacade.findSocialGroups(user); //grupos del usuario
        friendInvites = userFacade.findPendingToAcceptFriends(user);
        groupInvites = userFacade.findPendingInvitationMemberships(user);
        
        request.setAttribute("user", user);
        request.setAttribute("groupList", groupList);
        request.setAttribute("globalPostList", globalPostList);
        request.setAttribute("privatePostList", privatePostList);
        request.setAttribute("friendInviteList", friendInvites);
        request.setAttribute("groupInviteList", groupInvites);
        RequestDispatcher rd = request.getRequestDispatcher("/wall.jsp");
        rd.forward(request,response);
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
