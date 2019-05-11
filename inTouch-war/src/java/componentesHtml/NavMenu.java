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
            "                <li><a href=" + ((activo.equals("myProfile")) ? active : "\"/inTouch-war/userProfileLoadServlet\"") + ">Profile</a></li>\n" +
            "                <li><a href=" + ((activo.equals("friends")) ? active : "\"/inTouch-war/friends\"") + ">Friends</a></li>\n" +
            "                <li><a href=" + ((activo.equals("search")) ? active : "\"/inTouch-war/search\"") + ">Search</a></li>\n" +
            "                <li><a href=\"/inTouch-war/lang?lang=spanish\">Spanish</a></li>\n" +
            "                <li><a href=\"/inTouch-war/lang?lang=english\">English</a></li>\n" +
            "                <li><a href=\"/inTouch-war/logout\">Log out</a></li>\n" +
            "            </ul>\n" +
            "        </div>";
        
        return tmp;
    }
    
    public static void main(String[] argv) {
        System.out.println(toHtml(""));
    }
}
