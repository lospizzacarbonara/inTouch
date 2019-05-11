/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package componentesHtml;

import json.simple.*;
import json.simple.parser.*;
import lang.English;
import lang.Spanish;

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
        
        String content = "";
        
        switch(language) {
            case "english":
                content = English.text;
                break;
            case "spanish":
                content = Spanish.text;
                break;
        }
        
        JSONParser parser = new JSONParser();
        try {
            JSONObject full = (JSONObject) parser.parse(content);
            pageJson = (JSONObject)  full.get(page);
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
        System.out.println(ml.get("welcome"));
        System.out.println(ml.get("introduceData"));
        System.out.println(ml.get("title"));

    }
    
}
