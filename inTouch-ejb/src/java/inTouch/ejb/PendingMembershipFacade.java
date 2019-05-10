/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

import inTouch.entity.PendingMembership;
import inTouch.entity.SocialGroup;
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
public class PendingMembershipFacade extends AbstractFacade<PendingMembership> {

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PendingMembershipFacade() {
        super(PendingMembership.class);
    }
    
        public List<PendingMembership> findPendingFriendship(User u, SocialGroup g) {
        try {
            List<PendingMembership> list = em.createNamedQuery("PendingMembership.findPendingMembership")
                .setParameter("user", u)
                .setParameter("group", g)
                .getResultList();

            return list;
        } catch (NoResultException e) {
            return null;
        }
    }
    
}
