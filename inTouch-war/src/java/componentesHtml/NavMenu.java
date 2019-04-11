/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package componentesHtml;

/**
 *
 * @author jfaldanam
 */
public class NavMenu {
    private final static String active = "\"#\" class=\"active\"";
    
    public static String toHtml(String activo) {
        String tmp =
            "<!-- Menú de navegación horizontal superior, utiliza la hoja de estilo menucss.css -->\n" +
            "        <div id=\"menu\">\n" +
            "            <ul>\n" +
            "                <li><a href=" + ((activo.equals("home")) ? active : "\"/inTouch-war/wallServlet\"")+ ">Home</a></li>\n" +
            "                <li><a href=" + ((activo.equals("options")) ? active : "\"/inTouch-war/options\"") + ">Options</a></li>\n" +
            "                <li><a href=" + ((activo.equals("friends")) ? active : "\"/inTouch-war/friend\"") + ">Friends</a></li>\n" +
            "                <li><a href=" + ((activo.equals("search")) ? active : "\"/inTouch-war/search\"") + ">Search</a></li>\n" +
            "                <li><a href=" + ((activo.equals("myProfile")) ? active : "\"/inTouch-war/userProfileLoadServlet\"") + ">Profile</a></li>\n" +
            "            </ul>\n" +
            "        </div>";
        
        return tmp;
    }
    
    public static void main(String[] argv) {
        System.out.println(toHtml(""));
    }
}
