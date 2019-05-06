/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jfaldanam
 */
@Entity
@Table(name = "Membership")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Membership.findAll", query = "SELECT m FROM Membership m")
    , @NamedQuery(name = "Membership.findById", query = "SELECT m FROM Membership m WHERE m.id = :id")
    , @NamedQuery(name = "Membership.findByAdmin", query = "SELECT m FROM Membership m WHERE m.admin = :admin")
    , @NamedQuery(name = "Membership.groupsInCommon", query = "SELECT DISTINCT m1.socialGroup FROM Membership m1, Membership m2 WHERE m1.member1 = :user1 and m2.member1 = :user2")
    })
public class Membership implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "admin")
    private boolean admin;
    @JoinColumn(name = "socialGroup", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private SocialGroup socialGroup;
    @JoinColumn(name = "member", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User member1;

    public Membership() {
    }

    public Membership(Integer id) {
        this.id = id;
    }

    public Membership(Integer id, boolean admin) {
        this.id = id;
        this.admin = admin;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public boolean getAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public SocialGroup getSocialGroup() {
        return socialGroup;
    }

    public void setSocialGroup(SocialGroup socialGroup) {
        this.socialGroup = socialGroup;
    }

    public User getMember1() {
        return member1;
    }

    public void setMember1(User member1) {
        this.member1 = member1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Membership)) {
            return false;
        }
        Membership other = (Membership) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "inTouch.entity.Membership[ id=" + id + " ]";
    }
    
}
