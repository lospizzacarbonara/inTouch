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
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author jfaldanam
 */
@Stateless
public class MembershipFacade extends AbstractFacade<Membership> {

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MembershipFacade() {
        super(Membership.class);
    }
    
    public void exitGroup(User u, SocialGroup sg){
        Query q;
        //q = this.em.createQuery("select p from Post p where socialGroup = 1");
        q = this.em.createQuery("delete from Membership m where m.socialGroup = :sg and m.member1 = :u" ).setParameter("sg", sg).setParameter("u", u);
        q.executeUpdate();
        
    }
    
    public List<SocialGroup> findGroupsBetweenUsers(User u1, User u2) {
        try {
            List<SocialGroup> list = em.createNamedQuery("Membership.groupsInCommon")
                .setParameter("user1", u1)
                .setParameter("user2", u2)
                .getResultList();

            return list;
        } catch (NoResultException e) {
            return null;
        }
    }
}
