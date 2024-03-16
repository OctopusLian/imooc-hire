<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input v-model="listQuery.reportUserName" placeholder="举报人" style="width: 180px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-input v-model="listQuery.jobName" placeholder="职位名称" style="width: 180px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-input v-model="listQuery.companyName" placeholder="所属企业" style="width: 180px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-select v-model="listQuery.dealStatus" placeholder="审核状态" clearable class="filter-item" style="width: 120px;margin-right: 5px;">
                <el-option v-for="item in reportStatusArray" :key="item.key" :label="item.display_name" :value="item.key" />
            </el-select>

            <el-date-picker 
                v-model="listQuery.beginDate" 
                type="date" 
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd" 
                placeholder="申请日期(开始)" 
                style="width: 160px;margin-right: 3px;" class="filter-item"/>
            <span class="line" style="margin-right: 3px;color:gray;">-</span>
            <el-date-picker 
                v-model="listQuery.endDate" 
                type="date" 
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd" 
                placeholder="举报日期(结束)" 
                style="width: 165px;margin-right: 5px;" 
                class="filter-item"/>

            <el-button class="filter-item" type="primary" icon="el-icon-search" @click="searchList">
                查询
            </el-button>
            <!-- <el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit" @click="handleCreate">
                添加
            </el-button>
            <el-button v-waves :loading="downloadLoading" class="filter-item" type="primary" icon="el-icon-download" @click="handleDownload">
                导出
            </el-button> -->
        </div>

        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="60">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.companyId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column width="160px" align="center" label="职位名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.jobName }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="160px" align="center" label="发布企业">
                <template slot-scope="scope">
                    <span>{{ scope.row.companyName }}</span>
                </template>
            </el-table-column>

            <el-table-column width="125px" align="center" label="举报人">
                <template slot-scope="scope">
                    <span>{{ scope.row.reportUserName }}</span>
                </template>
            </el-table-column>

            <!-- <el-table-column class-name="status-col" align="center" label="职位状态" width="120">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{row.status}}
                    </el-tag>
                </template>
            </el-table-column> -->

            <el-table-column class-name="status-col" align="center" label="处理状态" width="85">
                <template slot-scope="{ row }">

                    <el-tag :type="row.dealStatus | statusFilter">
                        {{ row.dealStatus == 0 ? "待处理" : ""}}
                        {{ row.dealStatus == 1 ? "已处理" : ""}}
                        {{ row.dealStatus == 2 ? "忽略" : ""}}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="185px" align="center" label="举报时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.createdTime }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="120">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-view" @click="renderJobInfo(scope.row.jobId, scope.row.companyName, scope.row.reportReason, scope.row.id)">
                        处理
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" 
            :total="total" 
            :page.sync="listQuery.page" 
            :limit.sync="listQuery.limit"
            @pagination="getList"/>

        <el-dialog :visible.sync="dialogVisible" title="职位信息审核" width="750px" top="5vh">
            <!-- :rules="rules" -->
            <el-form ref="dataForm" label-width="80px" :model="temp" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="职位名称">
                    {{jobInfo.jobName}}
                </el-form-item>

                <el-form-item label="职位类型">
                    {{jobInfo.jobType}}
                </el-form-item>
                
                <el-form-item label="所属企业">
                    {{jobInfo.companyName}}
                </el-form-item>

                <el-form-item label="职位薪资">
                    {{jobInfo.beginSalary}}-{{jobInfo.endSalary}}K · {{jobInfo.monthlySalary}}薪
                </el-form-item>

                <el-form-item label="职位标签">
                    {{jobInfo.tags}}
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

                <!-- <el-form-item label="职位详情">
                    {{jobInfo.jobDesc}}
                </el-form-item> -->
                <el-form-item label="职位详情" style="width: 620px;">
                    <p style="line-height: 23px;margin-top:5px;" v-html="jobInfo.jobDesc">
                        <!-- {{jobInfo.jobDesc}} -->
                    </p>
                </el-form-item>

                <el-form-item label="职位状态">
                    <!-- 1：招聘中，open
                    2：已关闭，close
                    3：违规删除，delete -->
                    {{jobInfo.status == 1 ? "招聘中" : ""}}
                    {{jobInfo.status == 2 ? "已关闭" : ""}}
                    {{jobInfo.status == 3 ? "违规删除" : ""}}
                </el-form-item>

                <!-- <el-form-item label="职位介绍" style="width: 620px;">
                    <p style="line-height: 23px;margin-top:5px;">
                        职责描述<br>
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
                        3、具备项目管理理论。
                    </p>
                </el-form-item> -->

                <el-form-item label="举报缘由" style="color: red;">
                    {{jobInfo.reportReason}}
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">关闭页面</el-button>
                <el-button type="primary" @click="deleteDeal(jobInfo.reportId)">删除职位</el-button>
                <el-button type="warning" @click="ignoreDeal(jobInfo.reportId)">忽略</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { getReportList, getJobInfo, dealJobReportIgnore, dealJobReportDelete } from '@/api/report'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

const reportStatusArray = [
    { key: null, display_name: '全部' },
    { key: '0', display_name: '待处理' },
    { key: '1', display_name: '已处理' },
    { key: '2', display_name: '忽略、无需处理' },
]

export default {
    name: "reportList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                0: "info",
                1: "danger",
                2: "gray",
                // 关闭: "danger",
            };
            return statusMap[status];
        },
        // statusFilter(status) {
        //     const statusMap = {
        //         开启: "gray",
        //         隐藏: "success",
        //         关闭: "danger",
        //         黑名单: "info",
        //     };
        //     return statusMap[status];
        // },
    },
    data() {
        return {
            dialogVisible: false,
            destroyOnClose: true,

            jobInfo: {},

            temp: {},
            reportStatusArray,

            list: null,
            total: 0,
            listLoading: true,
            listQuery: {
                reportUserName: "",
                jobName: "",
                companyName: "",
                dealStatus: null,
                beginDate: null,
                endDate: null,

                page: 1,
                limit: 10,
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        ignoreDeal(reportId) {
            var params = {
                reportId: reportId
            };
            dealJobReportIgnore(params).then(response => {
                console.log(response);
                this.$notify({
                    title: "通知",
                    message: "该职位无须处理，已忽略",
                    type: "success",
                    duration: 2000,
                });
                this.dialogVisible = false;
                this.getList();
            });
        },

        deleteDeal(reportId) {
            var params = {
                reportId: reportId
            };
            dealJobReportDelete(params).then(response => {
                console.log(response);
                this.$notify({
                    title: "通知",
                    message: "该职位已被处理，处理结果：已删除",
                    type: "success",
                    duration: 2000,
                });
                this.dialogVisible = false;
                this.getList();
            });
        },

        renderJobInfo(jobId, companyName, reportReason, reportId) {
            // this.resetCompanyInfo();
            this.dialogVisible = true;
            // this.temp.id = companyId;
            // this.$nextTick(() => {
            //     this.$refs['dataForm'].clearValidate()
            // })

            var params = {
                jobId: jobId
            }
            getJobInfo(params).then(response => {
                console.log(response);
                var jobInfo = response.data;

                var jobDesc = jobInfo.jobDesc;
                // jobDesc = jobDesc.replaceAllStr("\n", "<br/>")
                jobDesc = this.replaceAllStr(jobDesc, "\n", "<br/>")

                jobInfo.reportId = reportId;
                jobInfo.reportReason = reportReason;
                jobInfo.jobDesc = jobDesc;
                jobInfo.companyName = companyName;
                this.jobInfo = jobInfo;
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

        searchList() {
            this.getList();
        },

        getList() {
            this.listLoading = true;
            getReportList(this.listQuery).then(response => {
                console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },

    },
};
</script>

<style scoped>
.edit-input {
    padding-right: 100px;
}
.cancel-btn {
    position: absolute;
    right: 15px;
    top: 10px;
}
.sidebar-logo {
    width: 30px;
    height: 30px;
    vertical-align: middle;
}
.yyzz {
    width: 160px;
    height: 200px;
}
.line{
    text-align: center;
}
</style>
