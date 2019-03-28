/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import inTouch.ejb.UserFacade;
import inTouch.entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author darioarrebola
 */
@WebServlet(name = "signUpServlet", urlPatterns = {"/signUpServlet"})
public class signUpServlet extends HttpServlet {
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
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String nombre = new String (request.getParameter("nombre").getBytes("ISO-8859-1"),"UTF-8");
        String apellido = new String (request.getParameter("apellido").getBytes("ISO-8859-1"),"UTF-8");
        String email = new String (request.getParameter("email").getBytes("ISO-8859-1"),"UTF-8");
        String fecha = new String (request.getParameter("fecha").getBytes("ISO-8859-1"),"UTF-8");
        String usuario = new String (request.getParameter("usuario").getBytes("ISO-8859-1"),"UTF-8");
        String clave = new String (request.getParameter("clave").getBytes("ISO-8859-1"),"UTF-8");
        
        User user = new User(new Random().nextInt(),usuario,clave,email);
        this.userFacade.create(user);
        
       PrintWriter out = response.getWriter();
        try {
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet que procesa un formulario b&aacute;sico</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" + "Nombre: " + nombre + "  Apellido: " + apellido+  ":</h1>");
            out.println("<h1>" + "email: " + email + "  fecha de nacimiento: " + fecha+  ":</h1>");
            out.println("<h1>" + "Nombre de Usuario: " + usuario + "  Clave: " + clave+  ":</h1>");

            out.println("</body>");
            out.println("</html>");
            
        } finally { 
            out.close();
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
