<template>
    <div class="createPost-container">
        <el-form ref="postForm" :model="postForm" label-position="left" :rules="rules" class="form-container">
            <el-row type="flex" justify="end" style="margin-top: 20px;">
                <el-button v-loading="loading" style="margin-left: 10px" type="success" @click="submitForm">
                    发布文章
                </el-button>
                <!-- <el-button v-loading="loading" type="warning" @click="draftForm">
                    存为草稿
                </el-button> -->
            </el-row>

            <div class="createPost-main-container">
                <el-row>

                    <el-col :span="24">
                        <el-form-item style="margin-bottom: 40px;" prop="title">
                            <MDinput v-model="postForm.title" :maxlength="100" name="name" required>
                                请输入文章标题
                            </MDinput>
                        </el-form-item>

                        <div class="postInfo-container">
                            <el-row>

                                <el-col>
                                    <el-form-item label-width="80px" label="发布时间:" class="postInfo-container-item">
                                        <el-date-picker
                                            v-model="postForm.publishTime"
                                            type="datetime"
                                            format="yyyy-MM-dd HH:mm:ss"
                                            value-format="yyyy-MM-dd HH:mm:ss" 
                                            placeholder="选择发布时间"
                                            :picker-options="forbiddenTime"
                                        />
                                    </el-form-item>
                                </el-col>

                            </el-row>
                        </div>
                    </el-col>
                </el-row>

                <el-form-item prop="content" style="margin-bottom: 30px">
                    <Tinymce
                        id="editor"
                        name="editor"
                        ref="editor"
                        v-model="postForm.content"
                        :height="400"
                    />
                </el-form-item>

                <el-form-item prop="articleCover" style="margin-bottom: 30px">
                    <Upload v-model="postForm.articleCover" />
                </el-form-item>
            </div>
        </el-form>
    </div>
</template>

<script>
import Tinymce from "@/components/Tinymce";
import Upload from "@/components/Upload/SingleImage3";
import MDinput from "@/components/MDinput";
import Sticky from "@/components/Sticky"; // 粘性header组件
import { validURL } from "@/utils/validate";
import { fetchArticle, saveArticle, getArticleDetail } from "@/api/article";
import { searchUser } from "@/api/remote-search";
import Warning from "./components/Warning";
import {
    CommentDropdown,
    PlatformDropdown,
    SourceUrlDropdown,
} from "./components/Dropdown";

const defaultForm = {
    // status: "draft",
    title: "", // 文章题目
    content: "", // 文章内容
    // content_short: "", // 文章摘要
    // source_uri: "", // 文章外链
    articleCover: "",
    // image_uri: "", // 文章图片
    // display_time: undefined, // 前台展示时间
    articleId: undefined,
    publishTime: null,
    // platforms: ["a-platform"],
    // comment_disabled: false,
    // importance: 0,
};

export default {
    name: "articleCreate",
    components: {
        Tinymce,
        MDinput,
        Upload,
        Sticky,
        Warning,
        CommentDropdown,
        PlatformDropdown,
        SourceUrlDropdown,
    },
    props: {
        isEdit: {
            type: Boolean,
            default: false,
        },
    },
    data() {
        const validateRequire = (rule, value, callback) => {
            if (value === "") {
                this.$message({
                    message: rule.field + "为必传项",
                    type: "error",
                });
                callback(new Error(rule.field + "为必传项"));
            } else {
                callback();
            }
        };
        return {
            articleId: "",
            postForm: Object.assign({}, defaultForm),
            loading: false,
            userListOptions: [],
            rules: {
                // articleCover: [{ validator: validateRequire }],
                title: [{ validator: validateRequire }],
                content: [{ validator: validateRequire }]
            },
            tempRoute: {},

            forbiddenTime:{                    //禁用当前日期之前的日期
                disabledDate(time) {
                //Date.now()是javascript中的内置函数，它返回自1970年1月1日00:00:00 UTC以来经过的毫秒数。
                    return time.getTime() < Date.now() - 8.64e7;
                },
            },
        };
    },
    created() {
        var query = this.$route.query;
        // console.log(query);
        var articleId = query.articleId;
        this.articleId = articleId;
        // console.log("articleId = " + articleId);
        this.fetchData(articleId);
    },
    methods: {
        fetchData(id) {
            getArticleDetail(id).then((response) => {
                this.postForm = response.data;
                var publishTime = response.data.publishTime;

                var timeArr = publishTime.split("T");
                publishTime = timeArr[0] + " " + timeArr[1];
                this.postForm.publishTime = publishTime;
                this.postForm.articleId = response.data.id;
            })
            .catch((err) => {
                console.log(err);
            });
        },

        resetForm() {
            this.postForm = {
                title: "", // 文章题目
                content: "", // 文章内容
                articleCover: "",
                publishTime: null,
            };
        },

        submitForm() {
            console.log(this.postForm);
            this.$refs.postForm.validate((valid) => {
                if (valid) {
                    this.loading = true;

                    saveArticle(this.postForm).then((response) => {
                        console.log(response);
                        this.postForm.content = "";
                        this.$notify({
                            title: "成功",
                            message: "修改文章成功",
                            type: "success",
                            duration: 2000,
                        });
                        this.loading = false;
                        this.resetForm();
                    });

                    
                } else {
                    console.log("error submit!!");
                    return false;
                }
            });
        },
    },
};
</script>

<style lang="scss" scoped>
@import "~@/styles/mixin.scss";

.createPost-container {
    position: relative;

    .createPost-main-container {
        padding: 10px 45px 20px 50px;

        .postInfo-container {
            position: relative;
            @include clearfix;
            margin-bottom: 10px;

            .postInfo-container-item {
                float: left;
            }
        }
    }

    .word-counter {
        width: 40px;
        position: absolute;
        right: 10px;
        top: 0px;
    }
}

.article-textarea ::v-deep {
    textarea {
        padding-right: 40px;
        resize: none;
        border: none;
        border-radius: 0px;
        border-bottom: 1px solid #bfcbd9;
    }
}
</style>
