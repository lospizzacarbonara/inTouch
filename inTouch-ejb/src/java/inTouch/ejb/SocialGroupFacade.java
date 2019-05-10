/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

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
public class SocialGroupFacade extends AbstractFacade<SocialGroup> {

    @PersistenceContext(unitName = "inTouch-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SocialGroupFacade() {
        super(SocialGroup.class);
    }
        
    public List<SocialGroup> findByName(String name) {
        try {
            return em.createNamedQuery("SocialGroup.findByName")
                .setParameter("name", "%" + name + "%")
                .getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }
    public List<User> getMembers(SocialGroup group){
        List<User> list;
        Query q;
        //q = this.em.createQuery("select p from Post p where socialGroup = 1");
        q = this.em.createQuery("select m.member1 from Membership m where m.socialGroup =:sg")
        .setParameter("sg", group);
        list = q.getResultList();
        return list;   
    }
        public List<User> getPendingMembers(SocialGroup group){
        List<User> list;
        Query q;
        //q = this.em.createQuery("select p from Post p where socialGroup = 1");
        q = this.em.createQuery("select p.user from PendingMembership p where p.socialGroup = :sg")
        .setParameter("sg", group);
        list = q.getResultList();
        return list;   
    }
}
