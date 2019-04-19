/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

import inTouch.entity.PendingFriendship;
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
public class PendingFriendshipFacade extends AbstractFacade<PendingFriendship> {

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PendingFriendshipFacade() {
        super(PendingFriendship.class);
    }
    
    public List<PendingFriendship> findPendingFriendship(User u1, User u2) {
        try {
            List<PendingFriendship> list = em.createNamedQuery("PendingFriendship.findPendingFriendship")
                .setParameter("user1", u1)
                .setParameter("user2", u2)
                .getResultList();

            return list;
        } catch (NoResultException e) {
            return null;
        }
    }
    
}
