/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.ejb;

import inTouch.entity.SocialGroup;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

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
    
}
