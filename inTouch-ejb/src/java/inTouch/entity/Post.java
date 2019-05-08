/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inTouch.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jfaldanam
 */
@Entity
@Table(name = "Post")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Post.findAll", query = "SELECT p FROM Post p")
    , @NamedQuery(name = "Post.findById", query = "SELECT p FROM Post p WHERE p.id = :id")
    , @NamedQuery(name = "Post.findByBody", query = "SELECT p FROM Post p WHERE p.body = :body")
    , @NamedQuery(name = "Post.findByPublishedDate", query = "SELECT p FROM Post p WHERE p.publishedDate = :publishedDate")
    , @NamedQuery(name = "Post.findByPrivate1", query = "SELECT p FROM Post p WHERE p.private1 = :private1")
    , @NamedQuery(name = "Post.findByAttachment", query = "SELECT p FROM Post p WHERE p.attachment = :attachment")
    , @NamedQuery(name = "Post.findPrivatePosts", query = "SELECT p FROM Post p WHERE (((p.author in (SELECT f.friend2 FROM Friendship f where f.friend1 = :user)) or (p.socialGroup in (SELECT m.socialGroup FROM Membership m WHERE m.member1 = :user)) or (p.author = :user)) and p.private1 = TRUE) ORDER BY p.publishedDate DESC")})
public class Post implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Integer id;
    @Size(max = 500)
    @Column(name = "body")
    private String body;
    @Basic(optional = false)
    @NotNull
    @Column(name = "publishedDate")
    @Temporal(TemporalType.DATE)
    private Date publishedDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "private")
    private boolean private1;
    @Size(max = 100)
    @Column(name = "attachment")
    private String attachment;
    @JoinColumn(name = "socialGroup", referencedColumnName = "id")
    @ManyToOne
    private SocialGroup socialGroup;
    @JoinColumn(name = "author", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User author;

    public Post() {
    }

    public Post(Integer id) {
        this.id = id;
    }

    public Post(Integer id, Date publishedDate, boolean private1) {
        this.id = id;
        this.publishedDate = publishedDate;
        this.private1 = private1;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Date getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Date publishedDate) {
        this.publishedDate = publishedDate;
    }

    public boolean getPrivate1() {
        return private1;
    }

    public void setPrivate1(boolean private1) {
        this.private1 = private1;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public SocialGroup getSocialGroup() {
        return socialGroup;
    }

    public void setSocialGroup(SocialGroup socialGroup) {
        this.socialGroup = socialGroup;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
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
        if (!(object instanceof Post)) {
            return false;
        }
        Post other = (Post) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "inTouch.entity.Post[ id=" + id + " ]";
    }
    
}
