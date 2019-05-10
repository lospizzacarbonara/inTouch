package inTouchServlets;


import inTouch.ejb.FriendshipFacade;
import inTouch.ejb.MembershipFacade;
import inTouch.ejb.UserFacade;
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


@WebServlet(urlPatterns = {"/userProfileLoadServlet"})
public class userProfileLoadServlet extends HttpServlet {

    @EJB
    private MembershipFacade membershipFacade;

    @EJB
    private FriendshipFacade friendshipFacade;

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
        
        Integer idUser = null;
        Integer idUserOther = null;
        User user = null;
        User userOther = null;
        Boolean myProfile = true;
        Boolean myFriend = false;
        List<SocialGroup> myGroup = null;
        
        HttpSession session = request.getSession(false);
        idUser = (Integer)session.getAttribute("userId");
        user = this.userFacade.find(idUser);
               
        
        
        idUserOther = (Integer)request.getAttribute("userId");
         
        if(idUserOther != null)
        {
          
            if(idUserOther != idUser)
            {
                userOther = this.userFacade.find(idUserOther);
                myProfile = false;

                myFriend = this.friendshipFacade.areFriends(user, userOther);

                myGroup = this.membershipFacade.findGroupsBetweenUsers(user, userOther);

            }
        }


        if(myProfile)
        {
           request.setAttribute("user",user);
        }
        else
        {
           request.setAttribute("user",userOther); 
        }
        
        request.setAttribute("myProfile",myProfile);
        request.setAttribute("myFriend",myFriend);
        request.setAttribute("myGroup",myGroup);
        RequestDispatcher rd = request.getRequestDispatcher("/userProfile.jsp");
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
