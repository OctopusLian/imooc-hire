<template>
    <div class="upload-container">
        <!-- <el-button :style="{background:color,borderColor:color}" icon="el-icon-upload" size="mini" type="primary" @click="dialogVisible=true">
            上传图片
        </el-button> -->
        <el-dialog :visible.sync="dialogVisible">
            <el-upload
                name="files"
                :multiple="true"
                :file-list="fileList"
                :show-file-list="true"
                :on-remove="handleRemove"
                :on-success="handleSuccess"
                :before-upload="beforeUpload"
                class="editor-slide-upload"
                action="http://192.168.1.10:8000/file/uploadArticleImages"
                list-type="picture-card"
                :on-change="handleChange"
                :http-request="myUploader"
            >
            <!-- action="https://httpbin.org/post" -->
                <el-button size="small" type="primary">
                点击上传
                </el-button>
            </el-upload>
            <el-button @click="dialogVisible = false">
                取消
            </el-button>
            <el-button type="primary" @click="handleSubmit">
                确认
            </el-button>
        </el-dialog>
    </div>
</template>

<script>
// import { getToken } from 'api/qiniu'
import { uploadFiles } from "@/api/article";

export default {
    name: 'EditorSlideUpload',
    props: {
        color: {
        type: String,
        default: '#1890ff'
        }
    },
    data() {
        return {
            dialogVisible: false,
            listObj: {},
            fileList: [],
            
            file: {},
            myFileList: []
        }
    },
    methods: {
        handleChange(file, fileList) {
            this.myFileList = fileList;
            console.log(fileList);
        },
        // handleChange(file) {
        //     this.file = file.raw
        // },
        myUploader() {
            console.log();
            let formData = new FormData();
            // formData.append("files", this.file);
		    // form.append(" "," ");
            this.myFileList.forEach(item => {
                formData.append('files', item.raw, item.raw.name);
            });
            // debugger;
            uploadFiles(formData).then(response => {
                console.log(response);
                this.myFileList = [];
            })
        },

        checkAllSuccess() {
            // debugger;
            return Object.keys(this.listObj).every(item => this.listObj[item].hasSuccess)
        },
        handleSubmit() {
            // debugger;
            const arr = Object.keys(this.listObj).map(v => this.listObj[v])
            if (!this.checkAllSuccess()) {
                this.$message('Please wait for all images to be uploaded successfully. If there is a network problem, please refresh the page and upload again!')
                return
            }
            this.$emit('successCBK', arr)
            this.listObj = {}
            this.fileList = []
            this.dialogVisible = false
        },
        handleSuccess(response, file) {
            // debugger;
            const uid = file.uid
            const objKeyArr = Object.keys(this.listObj)
            for (let i = 0, len = objKeyArr.length; i < len; i++) {
                if (this.listObj[objKeyArr[i]].uid === uid) {
                this.listObj[objKeyArr[i]].url = response.files.file
                this.listObj[objKeyArr[i]].hasSuccess = true
                return
                }
            }
        },
        handleRemove(file) {
            // debugger;
            const uid = file.uid
            const objKeyArr = Object.keys(this.listObj)
            for (let i = 0, len = objKeyArr.length; i < len; i++) {
                if (this.listObj[objKeyArr[i]].uid === uid) {
                delete this.listObj[objKeyArr[i]]
                return
                }
            }
        },
        beforeUpload(file) {
            // debugger;
            const _self = this
            const _URL = window.URL || window.webkitURL
            const fileName = file.uid
            this.listObj[fileName] = {}
            return new Promise((resolve, reject) => {
                // debugger;
                const img = new Image()
                img.src = _URL.createObjectURL(file)
                img.onload = function() {
                _self.listObj[fileName] = { hasSuccess: false, uid: file.uid, width: this.width, height: this.height }
                }
                resolve(true)
            })
        }
    }
}
</script>

<style lang="scss" scoped>
.editor-slide-upload {
    margin-bottom: 20px;
    ::v-deep .el-upload--picture-card {
        width: 100%;
    }
}
</style>
