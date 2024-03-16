package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 文章表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Article implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 文章标题
     */
    private String title;

    /**
     * 文章内容，长度不超过9999，自行在前后端判断
     */
    private String content;

    /**
     * 文章封面图，article_type=1 的时候展示
     */
    private String articleCover;

    /**
     * 发布者amin_id
     */
    private String publishAdminId;

    /**
     * 文章发布时间（也是预约发布的时间）
     */
    private LocalDateTime publishTime;

    /**
     * 发布者，字段冗余，避免多表关联
     */
    private String publisher;

    /**
     * 发布者头像，字段冗余
     */
    private String publisherFace;

    /**
     * 文章状态：0：关闭，待发布，1：正常，可查阅，2：删除，无法查看
     */
    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getArticleCover() {
        return articleCover;
    }

    public void setArticleCover(String articleCover) {
        this.articleCover = articleCover;
    }

    public String getPublishAdminId() {
        return publishAdminId;
    }

    public void setPublishAdminId(String publishAdminId) {
        this.publishAdminId = publishAdminId;
    }

    public LocalDateTime getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(LocalDateTime publishTime) {
        this.publishTime = publishTime;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublisherFace() {
        return publisherFace;
    }

    public void setPublisherFace(String publisherFace) {
        this.publisherFace = publisherFace;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "Article{" +
        "id=" + id +
        ", title=" + title +
        ", content=" + content +
        ", articleCover=" + articleCover +
        ", publishAdminId=" + publishAdminId +
        ", publishTime=" + publishTime +
        ", publisher=" + publisher +
        ", publisherFace=" + publisherFace +
        ", status=" + status +
        ", createTime=" + createTime +
        ", updateTime=" + updateTime +
        "}";
    }
}
