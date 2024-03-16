
package com.imooc.pojo;

import java.io.Serializable;

/**
 * <p>
 * 数据字典表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class DataDictionary implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 数据字典的类别代码code，根据本code可以找到对应的所有下属的value列表，例如：benefits（同一类型item所对应的code都是一致的）
     */
    private String typeCode;

    /**
     * 数据字典的类别名称，例如：福利待遇（同一类型item所对应的name都是一致的）
     */
    private String typeName;

    /**
     * 字典项，数据字典类别下的所有key，每个key对应一个value，可以根据类型key和字典key同时找到具体某一项字典value，例如：travel-旅游
     */
    private String itemKey;

    /**
     * 每个单个的数据字典的值，唯一key所对应的值value，例如：旅游
     */
    private String itemValue;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 对应的字体图标，可以为空
     */
    private String icon;

    /**
     * 是否开启，1：启用，0：停用
     */
    private Boolean enable;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getItemKey() {
        return itemKey;
    }

    public void setItemKey(String itemKey) {
        this.itemKey = itemKey;
    }

    public String getItemValue() {
        return itemValue;
    }

    public void setItemValue(String itemValue) {
        this.itemValue = itemValue;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "DataDictionary{" +
        "id=" + id +
        ", typeCode=" + typeCode +
        ", typeName=" + typeName +
        ", itemKey=" + itemKey +
        ", itemValue=" + itemValue +
        ", sort=" + sort +
        ", icon=" + icon +
        ", enable=" + enable +
        "}";
    }
}
