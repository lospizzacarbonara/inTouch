/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.PostFacade;
import inTouch.ejb.SocialGroupFacade;
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

/**
 *
 * @author darioarrebola
 */
@WebServlet(name = "groupWallServlet", urlPatterns = {"/groupWallServlet"})
public class groupWallServlet extends HttpServlet {
    
    @EJB
    private UserFacade userFacade;
    @EJB 
    private PostFacade postFacade;
    @EJB
    private SocialGroupFacade socialGroupFacade;

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
        
        
        //HttpSession session = request.getSession();
        //int currentGroupId = (Integer) session.getAttribute("groupId");
        //int loggedUserId = (Integer) session.getAttribute("userId");
        //User user = new User(loggedUserId);
        //int currentGroupId = Integer.parseInt(request.getParameter("groupId"));
        int currentGroupId = Integer.parseInt(request.getParameter("groupId"));
        SocialGroup group = socialGroupFacade.find(currentGroupId);
        
        List<Post> groupPostList;
        List<User> userList;
        String groupDescription;
        
        response.setContentType("text/html;charset=UTF-8");
        //groupPostList = new ArrayList<Post>();
        //userList = new ArrayList<User>();
        groupPostList = postFacade.getGroupPost(group); //grupos del usuario
        userList = userFacade.getUserList(group);
        groupDescription=group.getDescription();
        request.setAttribute("groupPostList", groupPostList);
        request.setAttribute("userList", userList);
        request.setAttribute("group", group);
        request.setAttribute("groupDescription",groupDescription);
        RequestDispatcher rd = request.getRequestDispatcher("/groupWall.jsp");
        rd.forward(request,response);
        }
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
    

    