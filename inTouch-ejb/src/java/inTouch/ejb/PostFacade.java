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
        List<Post> postList;
        List<Post> resultList = new ArrayList<>();
        Query q;
        
        groupList = userFacade.findSocialGroups(user);
        friendList = userFacade.findFriends(user);
        q = this.em.createQuery("select p from Post p where p.private1 = true");
        
        postList = q.getResultList();
        if (postList != null){
            postList.forEach((p) -> {
                friendList.forEach((u) -> {
                    if (p.getAuthor().equals(u) || p.getAuthor().equals(user)) {
                        resultList.add(p);
                    } else {
                        groupList.stream().filter((sg) -> (p.getSocialGroup().equals(sg))).forEachOrdered((_item) -> {
                            postList.add(p);
                        });
                    }
                });               
            });
        }
        return resultList;
    }
    
    public int getLastID(){
        return (Integer)this.em.createQuery("SELECT max(p.id) from Post p").getSingleResult();
    }
    
}
