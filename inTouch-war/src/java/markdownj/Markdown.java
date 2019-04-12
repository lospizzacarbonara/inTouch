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
        //Converting any number of new lines(\n) into 2
        str = str.replaceAll("[\n]+", "\n\n");
        
        if (mk == null)
            mk = new MarkdownProcessor();
        return  mk.markdown(str);
    }
}
