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
@Table(name = "User")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
    , @NamedQuery(name = "User.findById", query = "SELECT u FROM User u WHERE u.id = :id")
    , @NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username like :username")
    , @NamedQuery(name = "User.findByName", query = "SELECT u FROM User u WHERE u.name = :name")
    , @NamedQuery(name = "User.findBySurname", query = "SELECT u FROM User u WHERE u.surname = :surname")
    , @NamedQuery(name = "User.findByBirthdate", query = "SELECT u FROM User u WHERE u.birthdate = :birthdate")
    , @NamedQuery(name = "User.findByPassword", query = "SELECT u FROM User u WHERE u.password = :password")
    , @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email = :email")})
public class User implements Serializable, Comparable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "username")
    private String username;
    @Size(max = 45)
    @Column(name = "name")
    private String name;
    @Size(max = 45)
    @Column(name = "surname")
    private String surname;
    @Column(name = "birthdate")
    @Temporal(TemporalType.DATE)
    private Date birthdate;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "password")
    private String password;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "email")
    private String email;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "friend1")
    private Collection<Friendship> friendshipCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "friend2")
    private Collection<Friendship> friendshipCollection1;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "author")
    private Collection<Post> postCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "member1")
    private Collection<Membership> membershipCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "sender")
    private Collection<PendingFriendship> pendingFriendshipCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "receiver")
    private Collection<PendingFriendship> pendingFriendshipCollection1;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
    private Collection<PendingMembership> pendingMembershipCollection;

    public User() {
    }

    public User(Integer id) {
        this.id = id;
    }

    public User(Integer id, String username, String password, String email) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @XmlTransient
    public Collection<Friendship> getFriendshipCollection() {
        return friendshipCollection;
    }

    public void setFriendshipCollection(Collection<Friendship> friendshipCollection) {
        this.friendshipCollection = friendshipCollection;
    }

    @XmlTransient
    public Collection<Friendship> getFriendshipCollection1() {
        return friendshipCollection1;
    }

    public void setFriendshipCollection1(Collection<Friendship> friendshipCollection1) {
        this.friendshipCollection1 = friendshipCollection1;
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
    public Collection<PendingFriendship> getPendingFriendshipCollection() {
        return pendingFriendshipCollection;
    }

    public void setPendingFriendshipCollection(Collection<PendingFriendship> pendingFriendshipCollection) {
        this.pendingFriendshipCollection = pendingFriendshipCollection;
    }

    @XmlTransient
    public Collection<PendingFriendship> getPendingFriendshipCollection1() {
        return pendingFriendshipCollection1;
    }

    public void setPendingFriendshipCollection1(Collection<PendingFriendship> pendingFriendshipCollection1) {
        this.pendingFriendshipCollection1 = pendingFriendshipCollection1;
    }

    @XmlTransient
    public Collection<PendingMembership> getPendingMembershipCollection() {
        return pendingMembershipCollection;
    }

    public void setPendingMembershipCollection(Collection<PendingMembership> pendingMembershipCollection) {
        this.pendingMembershipCollection = pendingMembershipCollection;
    }
    
    public boolean isFriend(User user) {
        if (this.getFriendshipCollection() != null) {
            for (Friendship f: this.getFriendshipCollection()) {
                if (f.getFriend2() == this) {
                    if (f.getFriend1() == user)
                        return true;
                } else if (f.getFriend2() == user)
                    return true;
            }
        }
        
        if (this.getFriendshipCollection1() != null) {
            for (Friendship f: this.getFriendshipCollection1()) {
                if (f.getFriend2() == this) {
                    if (f.getFriend1() == user)
                        return true;
                } else if (f.getFriend2() == user)
                    return true;
            }
        }
        
        if (this.getPendingFriendshipCollection() != null) {
            for (PendingFriendship f: this.getPendingFriendshipCollection()) {
                if (f.getSender() == this) {
                    if (f.getReceiver() == user)
                        return true;
                } else if (f.getSender() == user)
                    return true;
            }
        }
              
        if (this.getPendingFriendshipCollection1() != null) {
            for (PendingFriendship f: this.getPendingFriendshipCollection1()) {
                if (f.getSender() == this) {
                    if (f.getReceiver() == user)
                        return true;
                } else if (f.getSender() == user)
                    return true;
            }
        }
        
        
        return false;
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
        if (!(object instanceof User)) {
            return false;
        }
        User other = (User) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "inTouch.entity.User[ id=" + id + " ]";
    }

    @Override
    public int compareTo(Object o) {
        User other = (User)o;
        return Integer.compare(other.getId(), this.getId());
    }
    
}
