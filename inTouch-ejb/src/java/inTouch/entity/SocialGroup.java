/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author jfaldanam
 */
@Entity
@Table(name = "SocialGroup")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SocialGroup.findAll", query = "SELECT s FROM SocialGroup s")
    , @NamedQuery(name = "SocialGroup.findById", query = "SELECT s FROM SocialGroup s WHERE s.id = :id")
    , @NamedQuery(name = "SocialGroup.findByName", query = "SELECT s FROM SocialGroup s WHERE s.name like :name")
    , @NamedQuery(name = "SocialGroup.findByCreationDate", query = "SELECT s FROM SocialGroup s WHERE s.creationDate = :creationDate")
    , @NamedQuery(name = "SocialGroup.findByDescription", query = "SELECT s FROM SocialGroup s WHERE s.description = :description")
    , @NamedQuery(name = "SocialGroup.findByType", query = "SELECT s FROM SocialGroup s WHERE s.type = :type")
    , @NamedQuery(name = "SocialGroup.findSocialGroups", query = "SELECT sg FROM SocialGroup sg JOIN Membership m WHERE sg = m.socialGroup AND m.member1 = :user order by sg.name ASC")})
    // findSocialGroups => SELECT SocialGroup.* FROM inTouch.SocialGroup JOIN Membership where Membership.member = "user";
public class SocialGroup implements Serializable, Comparable {

    public enum membershipStatus {
        member, pending, unrelated;
    }
    
    private static final long serialVersionUID = 1L;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Column(name = "creationDate")
    @Temporal(TemporalType.DATE)
    private Date creationDate;
    @Size(max = 500)
    @Column(name = "description")
    private String description;
    @Column(name = "type")
    private Integer type;
    @OneToMany(mappedBy = "socialGroup")
    private Collection<Post> postCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "socialGroup")
    private Collection<Membership> membershipCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "socialGroup")
    private Collection<PendingMembership> pendingMembershipCollection;

    public SocialGroup() {
    }

    public SocialGroup(Integer id) {
        this.id = id;
    }

    public SocialGroup(Integer id, String name, Date creationDate) {
        this.id = id;
        this.name = name;
        this.creationDate = creationDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @XmlTransient
    public Collection<Post> getPostCollection() {
        return postCollection;
    }

    public void setPostCollection(Collection<Post> postCollection) {
        this.postCollection = postCollection;
    }

    @XmlTransient
    public Collection<Membership> getMembershipCollection() {
        return membershipCollection;
    }

    public void setMembershipCollection(Collection<Membership> membershipCollection) {
        this.membershipCollection = membershipCollection;
    }

    @XmlTransient
    public Collection<PendingMembership> getPendingMembershipCollection() {
        return pendingMembershipCollection;
    }

    public void setPendingMembershipCollection(Collection<PendingMembership> pendingMembershipCollection) {
        this.pendingMembershipCollection = pendingMembershipCollection;
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
        if (!(object instanceof SocialGroup)) {
            return false;
        }
        SocialGroup other = (SocialGroup) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "inTouch.entity.SocialGroup[ id=" + id + " ]";
    }
    
    @Override
    public int compareTo(Object o) {
        SocialGroup other = (SocialGroup)o;
        return Integer.compare(other.getId(), this.getId());
    }
    
}
