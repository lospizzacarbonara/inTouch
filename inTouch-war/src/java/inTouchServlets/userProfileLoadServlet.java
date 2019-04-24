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
import javax.servlet.http.HttpSession;


@WebServlet(urlPatterns = {"/userProfileLoadServlet"})
public class userProfileLoadServlet extends HttpServlet {

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
        User user = new User();
        Boolean myProfile = true;
        Boolean myFriend = false;
        Boolean myGroup = false;
        String str = null;
        
        Object obj =  request.getAttribute("userId");
         
        
        if(obj != null)
        {
            str = obj.toString();
            myProfile = false;
            
            
            obj = request.getAttribute("myFriend");
            
            if(obj != null)
            {
                myFriend = (Boolean)obj;
            }
            else
            {
                myFriend = false;
            }
            
            obj = request.getAttribute("myGroup");
            
            if(obj != null)
            {
                myGroup = (Boolean)obj;
            }
            else
            {
                myGroup = false;
            }
            
        }
        else
        {
            HttpSession session = request.getSession(false);
            obj = session.getAttribute("userId");
            
            if(obj != null)
            {
                str = obj.toString();
            }
        }

        if(obj != null)
        {
            try
            {
                idUser = Integer.parseInt(str);
                user = this.userFacade.find(idUser);
            }
            catch(NumberFormatException msg)
            {
                System.out.println("Formato de id de usuario incorrecto: " + msg);
            }
        }
        
        
        
        

        request.setAttribute("user",user);
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
