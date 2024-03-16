<template>
    <div v-loading.fullscreen.lock="fullscreenLoading" class="main-article" element-loading-text="PDF下载">
        <div style="padding-top: 50px;" v-if="jobInfo != null">
            <el-form ref="dataForm" label-width="80px" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="职位名称">
                    {{jobInfo.jobName}}
                </el-form-item>
                
                <el-form-item label="职位类型">
                    {{jobInfo.jobType}}
                </el-form-item>

                <el-form-item label="薪资">
                    {{jobInfo.beginSalary}}-{{jobInfo.endSalary}}·{{jobInfo.monthlySalary}}薪
                </el-form-item>

                <el-form-item label="工作经验">
                    {{jobInfo.expYears}}
                </el-form-item>

                <el-form-item label="学历要求">
                    {{jobInfo.edu}}
                </el-form-item>

                <el-form-item label="工作城市">
                    {{jobInfo.city}}
                </el-form-item>

                <el-form-item label="工作地址">
                    {{jobInfo.address}}
                </el-form-item>

                <el-form-item label="职位介绍" style="width: 620px;">
                    <p style="line-height: 23px;margin-top:5px;" v-html="jobInfo.jobDesc">
                        <!-- 职责描述<br>
                        1、理解产品定义，并在整个项目过程中予以持续把握；<br>
                        2、向各职能部门提出人力资源申请，组建项目团队，维持项目团队的在业务进展中的可用性/稳定性；<br>
                        3、在立项初期举行风险评估，在项目进行过程中对风险防范措施予以落实；持续防范项目风险；<br>
                        4、协调公司技术资源，参考研发部门的专业意见，从项目整体角度作出决定；跟踪问题解决状况，并及时汇报管理层；<br>
                        5、协调和评估生产中的具体问题，权衡客户与公司利益，及时给出最优解决方案；<br>
                        6、对项目的进度和质量负责，针对项目中的问题须及时收集并发布，组织相关人员第一时间给出解决方案并监督落实；<br>
                        7、依照公司流程，协同相关部门成员，负责项目按时按质并在项目预算及成本要求范围内，完成量产和订单交付。<br>
                        <br>
                        任职要求：<br>
                        1、本科及以上学历；<br>
                        2、至少2年以上电子消费类产品项目管理或团队领导经验，手机相关行业尤佳；<br>
                        3、具备项目管理理论。 -->
                    </p>
                </el-form-item>

            </el-form>
        </div>
    </div>
</template>

<script>
import { getJobInfo } from '@/api/company';
export default {
    data() {
        return {
            fullscreenLoading: true,
            jobInfo: null
        };
    },
    mounted() {
        console.log("mounted...");
        this.fetchData();
    },
    created() {
        var query = this.$route.query;
        // console.log(query);
        var jobId = query.jobId;
        this.jobId = jobId
    },
    methods: {
        renderJobInfo(jobId) {
            this.dialogJobInfoVisible = true;

            var params = {
                jobId: jobId
            }
            getJobInfo(params).then(response => {
                console.log(response);
                var jobInfo = response.data;

                var jobDesc = jobInfo.jobDesc;
                // jobDesc = jobDesc.replaceAllStr("\n", "<br/>")
                jobDesc = this.replaceAllStr(jobDesc, "\n", "<br/>")

                jobInfo.jobDesc = jobDesc;
                this.jobInfo = jobInfo;


                document.title = "职位信息 - " + jobInfo.jobName;
                setTimeout(() => {
                    this.fullscreenLoading = false;
                    this.$nextTick(() => {
                        window.print();
                    });
                }, 2000);
            })
        },

        replaceAllStr(sourceStr, findStr, repStr) {
            String.prototype.replaceAll = function (FindText, RepText) {
                return this.replace(new RegExp(findStr, "g"), repStr);
            }

            // 把所有imooc替换成lee
            sourceStr = sourceStr.replaceAll(findStr, repStr)
            return sourceStr;
        },

        fetchData() {

            this.renderJobInfo(this.jobId);

            // document.title = "职位信息";
            // setTimeout(() => {
            //     this.fullscreenLoading = false;
            //     this.$nextTick(() => {
            //         window.print();
            //     });
            // }, 3000);
        },
    },
};
</script>