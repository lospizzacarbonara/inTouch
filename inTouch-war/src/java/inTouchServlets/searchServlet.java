/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.SocialGroupFacade;
import inTouch.ejb.UserFacade;
import inTouch.entity.SocialGroup;
import inTouch.entity.Post;
import inTouch.entity.User;
import java.io.IOException;
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
@WebServlet(name = "searchServlet", urlPatterns = {"/search"})
public class searchServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;
    @EJB
    private SocialGroupFacade groupFacade;

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
              
        String searchText = request.getParameter("searchText");
        
        List<User> userList = null;
        Map<User, Object[]> userData = new TreeMap<User, Object[]>();
        List<User> friends = this.userFacade.findFriends(loggedUser);
        List<User> pendingFriends = this.userFacade.findPendingFriends(loggedUser);
        
        if (searchText != null) {
            userList = this.userFacade.findByUsername(searchText);
            for (User u: userList) {
                Object[] data = new Object[2];
                
                //Posts
                Iterator<Post> postIt = u.getPostCollection().iterator(); 
                if (postIt.hasNext())
                    data[0] = postIt.next();
                else
                    data[0] = null;
                
                //Friendship
                if (friends.contains(u))
                    data[1] = User.friendStatus.friends;
                else if (pendingFriends.contains(u))
                    data[1] = User.friendStatus.pending;
                else
                    data[1] = User.friendStatus.unrelated;
                
                
                userData.put(u, data);
            }
            
      
        } else {
            userData = null;
        }
        
        List<SocialGroup> groupList = null;
        Map<SocialGroup, Object[]> groupData = new TreeMap<SocialGroup, Object[]>();
        List<SocialGroup> groups = this.userFacade.findSocialGroups(loggedUser);
        List<SocialGroup> pendingGroups = this.userFacade.findPendingMemberships(loggedUser);
        
        if (searchText != null) {
            groupList = this.groupFacade.findByName(searchText);
            for (SocialGroup g: groupList) {
                Object[] data = new Object[2];
                
                //Posts
                Iterator<Post> postIt = g.getPostCollection().iterator(); 
                if (postIt.hasNext())
                    data[0] = postIt.next();
                else
                    data[0] = null;
                
                //Membership
                if (groups.contains(g))
                    data[1] = SocialGroup.membershipStatus.member;
                else if (pendingGroups.contains(g))
                    data[1] = SocialGroup.membershipStatus.pending;
                else
                    data[1] = SocialGroup.membershipStatus.unrelated;
                
                
                groupData.put(g, data);
            }
            
      
        } else {
            groupData = null;
        }
        
        request.setAttribute("userData", userData);
        request.setAttribute("groupData", groupData);
        
        RequestDispatcher rd = request.getRequestDispatcher("/search.jsp");
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
