
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * <p>
 * 用户表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Users implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 手机号
     */
    private String mobile;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 对外展示名，1：真实姓名，2：昵称
     */
    private Integer showWhichName;

    /**
     * 性别，1:男 0:女 2:保密
     */
    private Integer sex;

    /**
     * 用户头像
     */
    private String face;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 生日
     */
    private LocalDate birthday;

    /**
     * 国家
     */
    private String country;

    /**
     * 省份
     */
    private String province;

    /**
     * 城市
     */
    private String city;

    /**
     * 区县
     */
    private String district;

    /**
     * 介绍
     */
    private String description;

    /**
     * 我参加工作的时间
     */
    private LocalDate startWorkDate;

    /**
     * 我当前职位/职务
     */
    private String position;

    /**
     * 身份角色，1: 求职者，2: 求职者可以切换为HR进行招聘，同时拥有两个身份
     */
    private Integer role;

    /**
     * 成为HR后，认证的（绑定的）公司主键id
     */
    private String hrInWhichCompanyId;

    /**
     * 我的一句话签名
     */
    private String hrSignature;

    /**
     * 我的个性化标签
     */
    private String hrTags;

    /**
     * 创建时间
     */
    private LocalDateTime createdTime;

    /**
     * 更新时间
     */
    private LocalDateTime updatedTime;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Integer getShowWhichName() {
        return showWhichName;
    }

    public void setShowWhichName(Integer showWhichName) {
        this.showWhichName = showWhichName;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getFace() {
        return face;
    }

    public void setFace(String face) {
        this.face = face;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getStartWorkDate() {
        return startWorkDate;
    }

    public void setStartWorkDate(LocalDate startWorkDate) {
        this.startWorkDate = startWorkDate;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public String getHrInWhichCompanyId() {
        return hrInWhichCompanyId;
    }

    public void setHrInWhichCompanyId(String hrInWhichCompanyId) {
        this.hrInWhichCompanyId = hrInWhichCompanyId;
    }

    public String getHrSignature() {
        return hrSignature;
    }

    public void setHrSignature(String hrSignature) {
        this.hrSignature = hrSignature;
    }

    public String getHrTags() {
        return hrTags;
    }

    public void setHrTags(String hrTags) {
        this.hrTags = hrTags;
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
        return "Users{" +
        "id=" + id +
        ", mobile=" + mobile +
        ", nickname=" + nickname +
        ", realName=" + realName +
        ", showWhichName=" + showWhichName +
        ", sex=" + sex +
        ", face=" + face +
        ", email=" + email +
        ", birthday=" + birthday +
        ", country=" + country +
        ", province=" + province +
        ", city=" + city +
        ", district=" + district +
        ", description=" + description +
        ", startWorkDate=" + startWorkDate +
        ", position=" + position +
        ", role=" + role +
        ", hrInWhichCompanyId=" + hrInWhichCompanyId +
        ", hrSignature=" + hrSignature +
        ", hrTags=" + hrTags +
        ", createdTime=" + createdTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
