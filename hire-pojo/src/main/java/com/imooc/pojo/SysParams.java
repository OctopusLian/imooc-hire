
package com.imooc.pojo;

import java.io.Serializable;

/**
 * <p>
 * 系统参数配置表，本表仅有一条记录
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class SysParams implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    /**
     * 每日最大简历被刷新的次数
     */
    private Integer maxResumeRefreshCounts;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMaxResumeRefreshCounts() {
        return maxResumeRefreshCounts;
    }

    public void setMaxResumeRefreshCounts(Integer maxResumeRefreshCounts) {
        this.maxResumeRefreshCounts = maxResumeRefreshCounts;
    }

    @Override
    public String toString() {
        return "SysParams{" +
        "id=" + id +
        ", maxResumeRefreshCounts=" + maxResumeRefreshCounts +
        "}";
    }
}
