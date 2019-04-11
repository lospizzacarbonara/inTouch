/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

import inTouch.entity.Membership;
import inTouch.entity.Post;
import inTouch.entity.SocialGroup;
import inTouch.entity.User;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author jfaldanam
 */
@Stateless
public class PostFacade extends AbstractFacade<Post> {

    @EJB
    private UserFacade userFacade;

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PostFacade() {
        super(Post.class);
    }
    
    //Return a list of all the public posts
    public List<Post> getPublicPost(){
        List<Post> list;
        Query q;
        q = this.em.createQuery("select p from Post p where p.private1 = false");
        
        list = q.getResultList();
        return list;
    }
    
    //Return a list of all the private posts for a user
    public List<Post> getPrivatePost(User user){
        List<SocialGroup> groupList;
        List<User> friendList;
        List<Post> postList, resultList = new ArrayList<>();
        Query q;
        
        groupList = userFacade.findSocialGroups(user);
        friendList = userFacade.findFriends(user);
        q = this.em.createQuery("select p from Post p where p.private1 = true");
        
        postList = q.getResultList();
        int i = 0;
        if (postList != null){
            postList.forEach((p) -> {
                User u = friendList.get(i);
                SocialGroup sg = groupList.get(i);
                
                if(p.getAuthor() == u){
                    resultList.add(p);
                } else if(p.getSocialGroup() == sg){
                    resultList.add(p);
                }
            });
        }
        //post de mis grupos
        //post de mis amigos
        return resultList;
    }
    
}
