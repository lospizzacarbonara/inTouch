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
        q = this.em.createQuery("select p from Post p where p.private1 = false order by p.publishedDate DESC");
        
        list = q.getResultList();
        return list;
    }
    
    //Return a list of all the private posts for a user
    public List<Post> getPrivatePost(User user){
        List<Post> list;
        int userId = user.getId();
        Query q = em.createNamedQuery("Post.findPrivatePosts")
                .setParameter("user", user);
        list = q.getResultList();
        return list;
    }
    
    public int getLastID(){
        return (Integer)this.em.createQuery("SELECT max(p.id) from Post p").getSingleResult();
    }
    
}
