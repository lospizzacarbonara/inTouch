/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouchServlets;

import static hash.SHA2.getSHA512;
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

/**
 *
 * @author avila
 */
@WebServlet(name = "changePasswordSaveServlet", urlPatterns = {"/changePasswordSaveServlet"})
public class changePasswordSaveServlet extends HttpServlet {
    
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
        response.setCharacterEncoding("UTF-8");
        
        Integer idUser = null;
        User user = new User();
        String str = "";
        Integer statusCode = 0; //valor inicial del codigo de estado, que indica que no se han producido novedades
        // Valores de statusCode:
        // 0 - sin novedades
        // 1 - no se introdujo la contraseña actual
        // 2 - la contraseña introducida no es la correcta
        // 3 - no se introdujo la contraseña nueva
        // 4 - no se repitio la contraseña nueva
        // 5 - la repeticion de la contraseña nueva no coincide con la contraseña nueva
        // 9 - se realizo el cambio correctamente
        
        //leo el id de usuario del request
        try
        {
            str = request.getParameter("idUser").trim();
        }
        catch(NullPointerException msg)
        {
            String error = " ERROR: idUser es null: " + msg + "(str es: " + str + ")";
            request.setAttribute("exception", error);
            RequestDispatcher rd = request.getRequestDispatcher("/error");
            rd.forward(request,response); 
        }
        
        //convierto el id en interger
        try
        {
            idUser = Integer.parseInt(str);
        }
        catch(NumberFormatException msg)
        {
            String error = " ERROR: Formato de id de usuario incorrecto: " + msg + "(str es: " + str + ")";
            request.setAttribute("exception", error);
            RequestDispatcher rd = request.getRequestDispatcher("/error");
            rd.forward(request,response); 
        }
        
        //controlo que el id de usuario no sea nulo
        if(idUser == null)
        {
            String error = " ERROR: El usuario es nulo ";
            request.setAttribute("exception", error);
            RequestDispatcher rd = request.getRequestDispatcher("/error");
            rd.forward(request,response); 
        }
        else
        {
            //busco el usuario mediante la id recibida en la request
            user = this.userFacade.find(idUser);
            String password = "";
            
            //leo el parametro "oldPassword", y si es nulo coloco el valor 1 en la variable statusCode
            try
            {
                password = (new String (request.getParameter("oldPassword").getBytes("ISO-8859-1"),"UTF-8")).trim();
            }
            catch(NullPointerException e)
            {
                statusCode = 1;
            }
            if(password.equals(""))
            {
                statusCode = 1;
            }
            
            //si la clave vieja se ha introducido se comprueba que sea correcta
            if(statusCode == 0)
            {
                String sha512 = getSHA512(password);
                Boolean correct = true;
                correct = user.getPassword().equals(sha512);
                //si la contraseña no es la correcta se coloca en statusCode el valor 2
                if(!correct)
                {
                    statusCode = 2;
                }
            }
            String newPassword1 = "";
            String newPassword2 = "";
            //verifico si se introdujo la contraseña nueva, sino se introdujo coloco el valor 3 en statusCode
            if(statusCode == 0)
            {
                try
                {
                    newPassword1 = (new String (request.getParameter("newPassword").getBytes("ISO-8859-1"),"UTF-8")).trim();
                }
                catch(NullPointerException e)
                {
                    statusCode = 3;
                }
                if(newPassword1.equals(""))
                {
                    statusCode = 3;
                }
            }
            //verifico si se introdujo la repetición de la contraseña nueva, sino se introdujo coloco el valor 4 en statusCode
            if(statusCode == 0)
            {
                try
                {
                    newPassword2 = (new String (request.getParameter("newPasswordAgain").getBytes("ISO-8859-1"),"UTF-8")).trim();
                }
                catch(NullPointerException e)
                {
                    statusCode = 4;
                }
                if(newPassword2.equals(""))
                {
                    statusCode = 4;
                }
            }
            
            //verifico si la contraseña nueva y la repetición son iguales, sino lo son coloco el valor 5 en statusCode
            //y si son iguales se coloca el valor 9 en statusCode
            if(statusCode == 0)
            {
                if(!(newPassword1.equals(newPassword2)))
                {
                    statusCode = 5;
                }
                else
                {
                    statusCode = 9;
                }
            }
            
            //si todo ha sido correcto se guarda la nueva contraeña en la base de datos
            if(statusCode == 9)
            {
                String claveNueva = getSHA512(newPassword1);
                user.setPassword(claveNueva);
                this.userFacade.edit(user);
            }
            
            
            //si se introdujo una contraseña y se produjo un error se vuelve a la pagina de cambio de contraseña con los valores introducidos
            //si todo ha ido correctamente no se devuelve ningun valor y se muestra la pagina con los campos en blanco y con un mensaje de exito
            if(statusCode > 1 && statusCode < 9)
            {
                request.setAttribute("oldPassword",password);
            }
            if(statusCode > 3 && statusCode < 9)
            {
                request.setAttribute("newPassword1",newPassword1);
            }
            if(statusCode > 4 && statusCode < 9)
            {
                request.setAttribute("newPassword2",newPassword2);
            }
            request.setAttribute("statusCode",statusCode);
            request.setAttribute("user",user);
            RequestDispatcher rd = request.getRequestDispatcher("/changePassword.jsp");
            rd.forward(request,response);  
            
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
