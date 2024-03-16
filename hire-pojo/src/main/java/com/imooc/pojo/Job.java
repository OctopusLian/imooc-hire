
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * HR发布的职位表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Job implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 谁的职位，HR角色用户id
     */
    private String hrId;

    /**
     * 职位所属哪家公司的，HR离职后则不能查询到
     */
    private String companyId;

    /**
     * 职位名称
     */
    private String jobName;

    /**
     * 职位类别
     */
    private String jobType;

    /**
     * 工作经验年限
     */
    private String expYears;

    /**
     * 技能标签
     */
    private String edu;

    /**
     * 薪资要求区间-起始
     */
    private Integer beginSalary;

    /**
     * 薪资要求区间-结束
     */
    private Integer endSalary;

    /**
     * 总共几个月工资
     */
    private Integer monthlySalary;

    /**
     * 职位描述
     */
    private String jobDesc;

    /**
     * 职位标签
     */
    private String tags;

    /**
     * 工作城市
     */
    private String city;

    /**
     * 工作地点
     */
    private String address;

    /**
     * 1：招聘中，open
2：已关闭，close
3：违规删除，delete
     */
    private Integer status;

    /**
     * 违规原因
     */
    private String violateReason;

    private LocalDateTime createTime;

    private LocalDateTime updatedTime;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getHrId() {
        return hrId;
    }

    public void setHrId(String hrId) {
        this.hrId = hrId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getExpYears() {
        return expYears;
    }

    public void setExpYears(String expYears) {
        this.expYears = expYears;
    }

    public String getEdu() {
        return edu;
    }

    public void setEdu(String edu) {
        this.edu = edu;
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

    public Integer getMonthlySalary() {
        return monthlySalary;
    }

    public void setMonthlySalary(Integer monthlySalary) {
        this.monthlySalary = monthlySalary;
    }

    public String getJobDesc() {
        return jobDesc;
    }

    public void setJobDesc(String jobDesc) {
        this.jobDesc = jobDesc;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getViolateReason() {
        return violateReason;
    }

    public void setViolateReason(String violateReason) {
        this.violateReason = violateReason;
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
        return "Job{" +
        "id=" + id +
        ", hrId=" + hrId +
        ", companyId=" + companyId +
        ", jobName=" + jobName +
        ", jobType=" + jobType +
        ", expYears=" + expYears +
        ", edu=" + edu +
        ", beginSalary=" + beginSalary +
        ", endSalary=" + endSalary +
        ", monthlySalary=" + monthlySalary +
        ", jobDesc=" + jobDesc +
        ", tags=" + tags +
        ", city=" + city +
        ", address=" + address +
        ", status=" + status +
        ", violateReason=" + violateReason +
        ", createTime=" + createTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
