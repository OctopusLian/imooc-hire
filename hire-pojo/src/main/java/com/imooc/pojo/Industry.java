
package com.imooc.pojo;

import java.io.Serializable;

/**
 * <p>
 * 行业表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class Industry implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 行业名称
     */
    private String name;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 为0则当前为第一级分类，否则当前为fatherId所对应行业的子分类
     */
    private String fatherId;

    /**
     * 用于提供给前端tree显示标记是否展示下拉箭头，一级分类与二级分类为true，三级分类也就是最后一级分类是false
     */
    private Boolean isLeaf;

    /**
     * 分类层级，用于标记
     */
    private Integer level;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getFatherId() {
        return fatherId;
    }

    public void setFatherId(String fatherId) {
        this.fatherId = fatherId;
    }

    public Boolean getIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(Boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "Industry{" +
        "id=" + id +
        ", name=" + name +
        ", sort=" + sort +
        ", fatherId=" + fatherId +
        ", isLeaf=" + isLeaf +
        ", level=" + level +
        "}";
    }
}
