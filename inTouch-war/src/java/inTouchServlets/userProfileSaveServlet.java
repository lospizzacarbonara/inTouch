/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.UserFacade;
import inTouch.entity.User;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
@WebServlet(name = "perfilUsuarioGuardarServlet", urlPatterns = {"/perfilUsuarioGuardarServlet"})
public class userProfileSaveServlet extends HttpServlet {

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
        User user;
        
        String str = request.getParameter("idUsuario");
        
        try{
            idUser = Integer.parseInt(str);
        }
        catch(NumberFormatException msg)
        {
            System.out.println("Formato de id de usuario incorrecto: " + msg);
        }
        
        if(idUser == null)
        {
            System.out.println("El usuario es nulo");
        }
        else
        {
            boolean cambio = false;
            user = new User(idUser);
            
            str = request.getParameter("nombre");
            String strO = request.getParameter("nombreOriginal");
            user.setName(str);
            cambio = cambio || str == strO;
            
            str = request.getParameter("apellido");
            strO = request.getParameter("apellidoOriginal");
            user.setSurname(str);
            cambio = cambio || str == strO;

            str = request.getParameter("birthday");
            strO = request.getParameter("birthdayOriginal");
            Date fecha = null;
            try
            {
                SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy");
                fecha = date_format.parse(str);
            }
            catch(ParseException e)
            {
                System.out.println("Formato de fecha incorrecto");
            }
            user.setBirthdate(fecha);
            cambio = cambio || str == strO;
            
            str = request.getParameter("user");
            strO = request.getParameter("userOriginal");
            user.setUsername(str);
            cambio = cambio || str == strO;

            str = request.getParameter("password");
            strO = request.getParameter("passwordOriginal");
            user.setPassword(str);
            cambio = cambio || str == strO;

            str = request.getParameter("email");
            strO = request.getParameter("emailOriginal");
            user.setEmail(str);
            cambio = cambio || str == strO;
            
            if(cambio)
            {
                request.setAttribute("user",user);
                RequestDispatcher rd = request.getRequestDispatcher("/perfilUsuario.jsp");
                rd.forward(request,response);
            }                       
        }    
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
