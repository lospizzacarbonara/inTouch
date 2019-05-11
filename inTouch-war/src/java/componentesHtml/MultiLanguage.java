/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package componentesHtml;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import json.simple.*;
import json.simple.parser.*;

/**
 *
 * @author jfaldanam
 */
public class MultiLanguage {
    
    private String language;
    private String page;
    private JSONObject pageJson;
    
    public MultiLanguage(String language, String page) {
        this.language = language;
        this.page = page;
        
        JSONParser parser = new JSONParser();
        try {
            JSONObject full = (JSONObject) parser.parse(new FileReader("../lang/" + language + ".json"));
            pageJson = (JSONObject)  full.get(page);
        } catch (FileNotFoundException ex) {
            System.out.println("File not found" + ex.getMessage());
        } catch (IOException ex) {
            System.out.println("IO exception" + ex.getMessage());
        } catch (ParseException ex) {
            System.out.println("Parse Error" + ex.getMessage());
        }
    }
    
    public String get(String field) {
        return (String) pageJson.get(field);
    }
    
    public static void main(String[] args) {
        MultiLanguage ml = new MultiLanguage("english", "login");
        
        System.out.println(ml.get("title"));
        
        MultiLanguage ml2 = new MultiLanguage("spanish", "login");
        
        System.out.println(ml2.get("title"));
    }
    
}
