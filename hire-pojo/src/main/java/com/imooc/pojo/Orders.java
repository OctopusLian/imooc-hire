
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 订单表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Orders implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 用户主键id
     */
    private String userId;

    /**
     * 购买用户所在的企业主键id
     */
    private String companyId;

    /**
     * 商品名称
     */
    private String itemName;

    /**
     * 订单总价
     */
    private Integer totalAmount;

    /**
     * 实际支付总价格
     */
    private Integer realPayAmount;

    /**
     * 邮费;默认可以为零，代表包邮
     */
    private Integer postAmount;

    /**
     * 支付方式
     */
    private Integer payMethod;

    /**
     * 订单状态
     */
    private Integer status;

    /**
     * 扩展字段
     */
    private String extend;

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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Integer getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Integer totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getRealPayAmount() {
        return realPayAmount;
    }

    public void setRealPayAmount(Integer realPayAmount) {
        this.realPayAmount = realPayAmount;
    }

    public Integer getPostAmount() {
        return postAmount;
    }

    public void setPostAmount(Integer postAmount) {
        this.postAmount = postAmount;
    }

    public Integer getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(Integer payMethod) {
        this.payMethod = payMethod;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getExtend() {
        return extend;
    }

    public void setExtend(String extend) {
        this.extend = extend;
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
        return "Orders{" +
        "id=" + id +
        ", userId=" + userId +
        ", companyId=" + companyId +
        ", itemName=" + itemName +
        ", totalAmount=" + totalAmount +
        ", realPayAmount=" + realPayAmount +
        ", postAmount=" + postAmount +
        ", payMethod=" + payMethod +
        ", status=" + status +
        ", extend=" + extend +
        ", createdTime=" + createdTime +
        ", updatedTime=" + updatedTime +
        "}";
    }
}
