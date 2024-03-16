
package com.imooc.pojo;

import java.io.Serializable;

/**
 * <p>
 * 企业相册表，本表只存企业上传的图片
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class CompanyPhoto implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 企业id
     */
    private String companyId;

    private String photos;


    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos;
    }

    @Override
    public String toString() {
        return "CompanyPhoto{" +
        "companyId=" + companyId +
        ", photos=" + photos +
        "}";
    }
}
