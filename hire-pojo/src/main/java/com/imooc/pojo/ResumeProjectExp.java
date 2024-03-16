
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 项目经验表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class ResumeProjectExp implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 谁的项目经验，用户id
     */
    private String userId;

    /**
     * 属于哪份简历id
     */
    private String resumeId;

    /**
     * 项目名称
     */
    private String projectName;

    /**
     * 担任角色
     */
    private String roleName;

    /**
     * 项目开始日期
     */
    private String beginDate;

    /**
     * 项目结束日期
     */
    private String endDate;

    /**
     * 项目描述
     */
    private String content;

    /**
     * 项目描述
     */
    private String contentHtml;

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

    public String getResumeId() {
        return resumeId;
    }

    public void setResumeId(String resumeId) {
        this.resumeId = resumeId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContentHtml() {
        return contentHtml;
    }

    public void setContentHtml(String contentHtml) {
        this.contentHtml = contentHtml;
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
        return "ResumeProjectExp{" +
        "id=" + id +
        ", userId=" + userId +
        ", resumeId=" + resumeId +
        ", projectName=" + projectName +
        ", roleName=" + roleName +
        ", beginDate=" + beginDate +
        ", endDate=" + endDate +
        ", content=" + content +
        ", contentHtml=" + contentHtml +
        ", createTime=" + createTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
