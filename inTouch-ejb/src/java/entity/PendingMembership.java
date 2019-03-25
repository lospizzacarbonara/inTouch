/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

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
@Table(name = "PendingMembership")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PendingMembership.findAll", query = "SELECT p FROM PendingMembership p")
    , @NamedQuery(name = "PendingMembership.findById", query = "SELECT p FROM PendingMembership p WHERE p.id = :id")
    , @NamedQuery(name = "PendingMembership.findByInvitation", query = "SELECT p FROM PendingMembership p WHERE p.invitation = :invitation")})
public class PendingMembership implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "invitation")
    private boolean invitation;
    @JoinColumn(name = "group", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Group group1;
    @JoinColumn(name = "user", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User user;

    public PendingMembership() {
    }

    public PendingMembership(Integer id) {
        this.id = id;
    }

    public PendingMembership(Integer id, boolean invitation) {
        this.id = id;
        this.invitation = invitation;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public boolean getInvitation() {
        return invitation;
    }

    public void setInvitation(boolean invitation) {
        this.invitation = invitation;
    }

    public Group getGroup1() {
        return group1;
    }

    public void setGroup1(Group group1) {
        this.group1 = group1;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
        if (!(object instanceof PendingMembership)) {
            return false;
        }
        PendingMembership other = (PendingMembership) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "db.PendingMembership[ id=" + id + " ]";
    }
    
}
