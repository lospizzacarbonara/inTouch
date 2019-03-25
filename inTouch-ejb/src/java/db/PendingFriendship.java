/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
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
@Table(name = "PendingFriendship")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PendingFriendship.findAll", query = "SELECT p FROM PendingFriendship p")
    , @NamedQuery(name = "PendingFriendship.findById", query = "SELECT p FROM PendingFriendship p WHERE p.id = :id")})
public class PendingFriendship implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Integer id;
    @JoinColumn(name = "sender", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User sender;
    @JoinColumn(name = "receiver", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User receiver;

    public PendingFriendship() {
    }

    public PendingFriendship(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public User getReceiver() {
        return receiver;
    }

    public void setReceiver(User receiver) {
        this.receiver = receiver;
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
        if (!(object instanceof PendingFriendship)) {
            return false;
        }
        PendingFriendship other = (PendingFriendship) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "db.PendingFriendship[ id=" + id + " ]";
    }
    
}
