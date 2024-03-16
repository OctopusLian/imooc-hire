
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 工作经验表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class ResumeWorkExp implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 谁的工作经验，用户id
     */
    private String userId;

    /**
     * 属于哪份简历id
     */
    private String resumeId;

    /**
     * 就职公司名称
     */
    private String companyName;

    /**
     * 行业
     */
    private String industry;

    /**
     * 在职时间-开始
     */
    private String beginDate;

    /**
     * 在职时间-结束
     */
    private String endDate;

    /**
     * 职位名称
     */
    private String position;

    /**
     * 所在部门名称
     */
    private String department;

    /**
     * 工作内容、业绩、职责等
     */
    private String content;

    /**
     * 工作内容、业绩、职责等
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
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

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
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
        return "ResumeWorkExp{" +
        "id=" + id +
        ", userId=" + userId +
        ", resumeId=" + resumeId +
        ", companyName=" + companyName +
        ", industry=" + industry +
        ", beginDate=" + beginDate +
        ", endDate=" + endDate +
        ", position=" + position +
        ", department=" + department +
        ", content=" + content +
        ", contentHtml=" + contentHtml +
        ", createTime=" + createTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
