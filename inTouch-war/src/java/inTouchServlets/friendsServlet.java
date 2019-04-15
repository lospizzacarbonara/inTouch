/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.UserFacade;
import inTouch.entity.Post;
import inTouch.entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
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
@WebServlet(name = "friendsServlet", urlPatterns = {"/friends"})
public class friendsServlet extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        int loggedUserId = (Integer) session.getAttribute("userId");
        User loggedUser = new User(loggedUserId);
        
        Map<User, Object[]> friendsData = new TreeMap<User, Object[]>();        
        List<User> friends = this.userFacade.findFriends(loggedUser);
        
        for (User u: friends) {
            Object[] data = new Object[1];
            
            //Posts
            Iterator<Post> postIt = u.getPostCollection().iterator(); 
            if (postIt.hasNext())
                data[0] = postIt.next();
            else
                data[0] = null;
            
            friendsData.put(u, data);
        }
        
        Map<User, Object[]> pendingFriendsData = new TreeMap<User, Object[]>();
        List<User> pendingFriends = this.userFacade.findPendingFriends(loggedUser);
        
        for (User u: pendingFriends) {
            Object[] data = new Object[1];
            
            //Posts
            Iterator<Post> postIt = u.getPostCollection().iterator(); 
            if (postIt.hasNext())
                data[0] = postIt.next();
            else
                data[0] = null;
            
            pendingFriendsData.put(u, data);
        }
        
        request.setAttribute("friendsData", friendsData);
        request.setAttribute("pendingFriendsData", pendingFriendsData);
        
        RequestDispatcher rd = request.getRequestDispatcher("/friends.jsp");
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
