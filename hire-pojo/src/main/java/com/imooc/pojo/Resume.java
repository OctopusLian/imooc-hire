
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 简历表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Resume implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 谁的简历，用户id
     */
    private String userId;

    /**
     * 个人优势
     */
    private String advantage;

    /**
     * 个人优势的html内容，用于展示
     */
    private String advantageHtml;

    /**
     * 资格证书
     */
    private String credentials;

    /**
     * 技能标签
     */
    private String skills;

    /**
     * 求职状态
     */
    private String status;

    /**
     * 刷新简历时间
     */
    private LocalDateTime refreshTime;

    private LocalDateTime createTime;

    private LocalDateTime updatedTime;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAdvantage() {
        return advantage;
    }

    public void setAdvantage(String advantage) {
        this.advantage = advantage;
    }

    public String getAdvantageHtml() {
        return advantageHtml;
    }

    public void setAdvantageHtml(String advantageHtml) {
        this.advantageHtml = advantageHtml;
    }

    public String getCredentials() {
        return credentials;
    }

    public void setCredentials(String credentials) {
        this.credentials = credentials;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getRefreshTime() {
        return refreshTime;
    }

    public void setRefreshTime(LocalDateTime refreshTime) {
        this.refreshTime = refreshTime;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(LocalDateTime updatedTime) {
        this.updatedTime = updatedTime;
    }

    @Override
    public String toString() {
        return "Resume{" +
        "id=" + id +
        ", userId=" + userId +
        ", advantage=" + advantage +
        ", advantageHtml=" + advantageHtml +
        ", credentials=" + credentials +
        ", skills=" + skills +
        ", status=" + status +
        ", refreshTime=" + refreshTime +
        ", createTime=" + createTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
