/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package markdownj;

/**
 *
 * @author jfaldanam
 */
public class Markdown {
    private static MarkdownProcessor mk = null;
    public static String toHtml(String str) {
        if (mk == null)
            mk = new MarkdownProcessor();
        return  mk.markdown(str);
    }    
}
