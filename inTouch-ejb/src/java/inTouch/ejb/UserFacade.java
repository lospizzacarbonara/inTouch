/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

import inTouch.entity.User;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 *
 * @author jfaldanam
 */
@Stateless
public class UserFacade extends AbstractFacade<User> {

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserFacade() {
        super(User.class);
    }
    
    public List<User> findByusername(String username) {
        try {
            return em.createNamedQuery("User.findByUsername")
                .setParameter("username", "%" + username + "%")
                .getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }
    
    public List<User> findFriends(User u) {
        try {
            List<User> list = em.createNamedQuery("Friendship.findFriends")
                .setParameter("user", u)
                .getResultList();
                        
            return list;
        } catch (NoResultException e) {
            return null;
        }
    }
    
    public List<User> findPendingFriends(User u) {
        try {
            List<User> list = em.createNamedQuery("PendingFriendship.findFriends")
                .setParameter("user", u)
                .getResultList();
            
            return list;
        } catch (NoResultException e) {
            return null;
        }
    }
}
