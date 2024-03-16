
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 求职期望表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class ResumeExpect implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 谁的求职期望，用户id
     */
    private String userId;

    /**
     * 属于哪份简历id
     */
    private String resumeId;

    /**
     * 期望职位
     */
    private String jobName;

    /**
     * 工作所在城市
     */
    private String city;

    /**
     * 工作对应所处行业
     */
    private String industry;

    /**
     * 薪资要求区间-起始
     */
    private Integer beginSalary;

    /**
     * 薪资要求区间-结束
     */
    private Integer endSalary;

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

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public Integer getBeginSalary() {
        return beginSalary;
    }

    public void setBeginSalary(Integer beginSalary) {
        this.beginSalary = beginSalary;
    }

    public Integer getEndSalary() {
        return endSalary;
    }

    public void setEndSalary(Integer endSalary) {
        this.endSalary = endSalary;
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
        return "ResumeExpect{" +
        "id=" + id +
        ", userId=" + userId +
        ", resumeId=" + resumeId +
        ", jobName=" + jobName +
        ", city=" + city +
        ", industry=" + industry +
        ", beginSalary=" + beginSalary +
        ", endSalary=" + endSalary +
        ", createTime=" + createTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
