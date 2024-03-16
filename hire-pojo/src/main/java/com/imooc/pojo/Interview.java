
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 面试邀约表
本表为次表，可做冗余，可以用mongo或者es替代
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Interview implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 本面试属于哪个hr的
     */
    private String hrUserId;

    /**
     * 本面试属于哪一个公司的
     */
    private String companyId;

    /**
     * 面试者，候选人id
     */
    private String candUserId;

    /**
     * 面试的岗位id
     */
    private String jobId;

    /**
     * 面试的岗位名称
     */
    private String jobName;

    /**
     * 面试时间
     */
    private LocalDateTime interviewTime;

    /**
     * 面试地点
     */
    private String interviewAddress;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 面试邀约的状态
1：等待候选人接受面试
2：候选人已接受面试
3：候选人已拒绝面试
4：HR已取消面试
5：面试通过
     */
    private Integer status;

    /**
     * 候选人名称（候选人名称）  
简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息
     */
    private String candName;

    /**
     * 候选人头像  
简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息
     */
    private String candFace;

    /**
     * 候选人职位  
简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息
     */
    private String candPosition;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getHrUserId() {
        return hrUserId;
    }

    public void setHrUserId(String hrUserId) {
        this.hrUserId = hrUserId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getCandUserId() {
        return candUserId;
    }

    public void setCandUserId(String candUserId) {
        this.candUserId = candUserId;
    }

    public String getJobId() {
        return jobId;
    }

    public void setJobId(String jobId) {
        this.jobId = jobId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public LocalDateTime getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(LocalDateTime interviewTime) {
        this.interviewTime = interviewTime;
    }

    public String getInterviewAddress() {
        return interviewAddress;
    }

    public void setInterviewAddress(String interviewAddress) {
        this.interviewAddress = interviewAddress;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCandName() {
        return candName;
    }

    public void setCandName(String candName) {
        this.candName = candName;
    }

    public String getCandFace() {
        return candFace;
    }

    public void setCandFace(String candFace) {
        this.candFace = candFace;
    }

    public String getCandPosition() {
        return candPosition;
    }

    public void setCandPosition(String candPosition) {
        this.candPosition = candPosition;
    }

    @Override
    public String toString() {
        return "Interview{" +
        "id=" + id +
        ", hrUserId=" + hrUserId +
        ", companyId=" + companyId +
        ", candUserId=" + candUserId +
        ", jobId=" + jobId +
        ", jobName=" + jobName +
        ", interviewTime=" + interviewTime +
        ", interviewAddress=" + interviewAddress +
        ", remark=" + remark +
        ", status=" + status +
        ", candName=" + candName +
        ", candFace=" + candFace +
        ", candPosition=" + candPosition +
        "}";
    }
}
