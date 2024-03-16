
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * <p>
 * 企业表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Company implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 企业名称
     */
    private String companyName;

    /**
     * 企业短名
     */
    private String shortName;

    /**
     * 企业logo
     */
    private String logo;

    /**
     * 营业执照
     */
    private String bizLicense;

    /**
     * 企业所在国家
     */
    private String country;

    /**
     * 所在省份
     */
    private String province;

    /**
     * 所在市
     */
    private String city;

    /**
     * 所在区县
     */
    private String district;

    /**
     * 公司办公地址
     */
    private String address;

    /**
     * 公司性质
     */
    private String nature;

    /**
     * 人员规模/企业规模
     */
    private String peopleSize;

    /**
     * 所在行业
     */
    private String industry;

    /**
     * 融资阶段
     */
    private String financStage;

    /**
     * 工作时间，例：9:00-18:00 周末单休
     */
    private String workTime;

    /**
     * 公司简介
     */
    private String introduction;

    /**
     * 公司优势，例：领导和睦 岗位晋升

     */
    private String advantage;

    /**
     * 福利待遇，例：五险一金 定期体检

     */
    private String benefits;

    /**
     * 薪资福利（奖金），例：年底双薪
     */
    private String bonus;

    /**
     * 补助津贴，例：住房补贴
     */
    private String subsidy;

    /**
     * 成立时间
     */
    private LocalDate buildDate;

    /**
     * 注册资本
     */
    private String registCapital;

    /**
     * 注册地址
     */
    private String registPlace;

    /**
     * 法人代表
     */
    private String legalRepresentative;

    /**
     * 审核状态
0：未发起审核认证(未进入审核流程)
1：审核认证通过
2：审核认证失败
3：审核中（等待审核）
     */
    private Integer reviewStatus;

    /**
     * 审核回复/审核意见
     */
    private String reviewReplay;

    /**
     * 入驻平台授权书
     */
    private String authLetter;

    /**
     * 提交申请人的用户id
     */
    private String commitUserId;

    /**
     * 提交申请人的手机号
     */
    private String commitUserMobile;

    /**
     * 提交审核的日期
     */
    private LocalDate commitDate;

    /**
     * 0: 否  1: 是
     */
    private Integer isVip;

    /**
     * Vip过期日期，判断企业是否vip，需要is_vip=1并且过期日期>=当前日期
     */
    private LocalDate vipExpireDate;

    private LocalDateTime createdTime;

    private LocalDateTime updatedTime;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getBizLicense() {
        return bizLicense;
    }

    public void setBizLicense(String bizLicense) {
        this.bizLicense = bizLicense;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public String getPeopleSize() {
        return peopleSize;
    }

    public void setPeopleSize(String peopleSize) {
        this.peopleSize = peopleSize;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getFinancStage() {
        return financStage;
    }

    public void setFinancStage(String financStage) {
        this.financStage = financStage;
    }

    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getAdvantage() {
        return advantage;
    }

    public void setAdvantage(String advantage) {
        this.advantage = advantage;
    }

    public String getBenefits() {
        return benefits;
    }

    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }

    public String getBonus() {
        return bonus;
    }

    public void setBonus(String bonus) {
        this.bonus = bonus;
    }

    public String getSubsidy() {
        return subsidy;
    }

    public void setSubsidy(String subsidy) {
        this.subsidy = subsidy;
    }

    public LocalDate getBuildDate() {
        return buildDate;
    }

    public void setBuildDate(LocalDate buildDate) {
        this.buildDate = buildDate;
    }

    public String getRegistCapital() {
        return registCapital;
    }

    public void setRegistCapital(String registCapital) {
        this.registCapital = registCapital;
    }

    public String getRegistPlace() {
        return registPlace;
    }

    public void setRegistPlace(String registPlace) {
        this.registPlace = registPlace;
    }

    public String getLegalRepresentative() {
        return legalRepresentative;
    }

    public void setLegalRepresentative(String legalRepresentative) {
        this.legalRepresentative = legalRepresentative;
    }

    public Integer getReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(Integer reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public String getReviewReplay() {
        return reviewReplay;
    }

    public void setReviewReplay(String reviewReplay) {
        this.reviewReplay = reviewReplay;
    }

    public String getAuthLetter() {
        return authLetter;
    }

    public void setAuthLetter(String authLetter) {
        this.authLetter = authLetter;
    }

    public String getCommitUserId() {
        return commitUserId;
    }

    public void setCommitUserId(String commitUserId) {
        this.commitUserId = commitUserId;
    }

    public String getCommitUserMobile() {
        return commitUserMobile;
    }

    public void setCommitUserMobile(String commitUserMobile) {
        this.commitUserMobile = commitUserMobile;
    }

    public LocalDate getCommitDate() {
        return commitDate;
    }

    public void setCommitDate(LocalDate commitDate) {
        this.commitDate = commitDate;
    }

    public Integer getIsVip() {
        return isVip;
    }

    public void setIsVip(Integer isVip) {
        this.isVip = isVip;
    }

    public LocalDate getVipExpireDate() {
        return vipExpireDate;
    }

    public void setVipExpireDate(LocalDate vipExpireDate) {
        this.vipExpireDate = vipExpireDate;
    }

    public LocalDateTime getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(LocalDateTime createdTime) {
        this.createdTime = createdTime;
    }

    public LocalDateTime getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(LocalDateTime updatedTime) {
        this.updatedTime = updatedTime;
    }

    @Override
    public String toString() {
        return "Company{" +
        "id=" + id +
        ", companyName=" + companyName +
        ", shortName=" + shortName +
        ", logo=" + logo +
        ", bizLicense=" + bizLicense +
        ", country=" + country +
        ", province=" + province +
        ", city=" + city +
        ", district=" + district +
        ", address=" + address +
        ", nature=" + nature +
        ", peopleSize=" + peopleSize +
        ", industry=" + industry +
        ", financStage=" + financStage +
        ", workTime=" + workTime +
        ", introduction=" + introduction +
        ", advantage=" + advantage +
        ", benefits=" + benefits +
        ", bonus=" + bonus +
        ", subsidy=" + subsidy +
        ", buildDate=" + buildDate +
        ", registCapital=" + registCapital +
        ", registPlace=" + registPlace +
        ", legalRepresentative=" + legalRepresentative +
        ", reviewStatus=" + reviewStatus +
        ", reviewReplay=" + reviewReplay +
        ", authLetter=" + authLetter +
        ", commitUserId=" + commitUserId +
        ", commitUserMobile=" + commitUserMobile +
        ", commitDate=" + commitDate +
        ", isVip=" + isVip +
        ", vipExpireDate=" + vipExpireDate +
        ", createdTime=" + createdTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
