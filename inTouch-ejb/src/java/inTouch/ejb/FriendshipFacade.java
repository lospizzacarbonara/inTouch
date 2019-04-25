/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

import inTouch.entity.Friendship;
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
public class FriendshipFacade extends AbstractFacade<Friendship> {

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FriendshipFacade() {
        super(Friendship.class);
    }
    
    
    public List<Friendship> findFriendshipBetweenFriends(User u1, User u2) {
        try {
            List<Friendship> list = em.createNamedQuery("Friendship.findFriendshipBetweenFriends")
                .setParameter("user1", u1)
                .setParameter("user2", u2)
                .getResultList();

            return list;
        } catch (NoResultException e) {
            return null;
        }
    }
    
    public boolean areFriends(User u1, User u2) {
        return findFriendshipBetweenFriends(u1, u2).size() == 2;
    }
}
