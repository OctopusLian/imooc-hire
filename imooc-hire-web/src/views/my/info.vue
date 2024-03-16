<template>
    <div class="components-container">

        <image-cropper
            v-show="imagecropperShow"
            :key="imagecropperKey"
            :width="300"
            :height="300"
            url="file/uploadAdminFace"
            lang-type="zh"
            @close="close"
            @crop-upload-success="cropSuccess"
        />

        <div>
            <!-- :rules="rules" -->
            <el-form ref="adminForm" label-width="80px" :model="adminInfo" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item>
                    <pan-thumb width="150px" height="150px" :image="adminInfo.face">
                        <el-button type="info" size="mini" style="bottom: 10px; margin-top: 40px" @click="imagecropperShow = true">
                            点我修改
                        </el-button>
                    </pan-thumb>
                </el-form-item>
                
                <el-form-item label="账号名" prop="name">
                    <el-input v-model="adminInfo.username" placeholder="请输入账号名..." />
                </el-form-item>

                <el-form-item label="备注信息">
                    <el-input
                        v-model="adminInfo.remark"
                        :autosize="{ minRows: 2, maxRows: 4}"
                        type="textarea"
                        placeholder="管理人员账号信息介绍（选填）"
                    />
                </el-form-item>

                <el-form-item label="创建时间">
                    {{adminInfo.createTime}}
                </el-form-item>

                <el-form-item label="修改时间">
                    {{adminInfo.updatedTime}}
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="submit">保存</el-button>
                    <el-button>取消</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>

    
</template>

<script>
import { myInfo, updateMyInfo } from '@/api/admin';
import ImageCropper from "@/components/ImageCropper";
import PanThumb from "@/components/PanThumb";

export default {
    name: "MyInfo",
    components: { ImageCropper, PanThumb },
    data() {
        return {

            adminInfo: {
                id: "",
                face: "",
                username: "",
                remark: "",
                createTime: "",
                updatedTime: "",
            },

// http://www.itzixi.com/img/arrow.png
            imagecropperShow: false,
            imagecropperKey: 0,
            image: require("@/assets/static/adminFaceTemp.png"),
        };
    },
    created() {
        this.getAdminInfo();
    },
    methods: {
        submit() {
            this.listLoading = true;
            updateMyInfo(this.adminInfo).then(response => {
                // console.log(response);
                this.$notify({
                    title: "成功",
                    message: "修改管理员账号成功~",
                    type: "success",
                    duration: 2000,
                });
            });
            this.listLoading = false;
        },

        getAdminInfo() {
            this.listLoading = true;
            myInfo().then(response => {
                // console.log(response);
                var adminInfo = response.data;
                this.adminInfo = adminInfo;
                if (adminInfo.face == null || adminInfo.face == "" || adminInfo.face == undefined) {
                    this.adminInfo.face = this.image;
                }
            });
            this.listLoading = false;
        },

        cropSuccess(resData) {
            console.log(resData);
            this.imagecropperShow = false;
            this.imagecropperKey = this.imagecropperKey + 1;
            // this.image = resData.files.avatar;
            this.image = resData;
            console.log(resData);
            this.adminInfo.face = resData;
        },
        close() {
            this.imagecropperShow = false;
        },
    },
};
</script>

<style scoped>
.components-container {
    display: flex;
    flex-direction: column;
}

.avatar {
    width: 200px;
    height: 200px;
    border-radius: 50%;
}
</style>

