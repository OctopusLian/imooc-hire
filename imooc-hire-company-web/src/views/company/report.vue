<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input v-model="listQuery.title" placeholder="举报人" style="width: 180px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-input v-model="listQuery.title" placeholder="职位名称" style="width: 180px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-input v-model="listQuery.title" placeholder="所属企业" style="width: 180px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-select v-model="listQuery.type" placeholder="审核状态" clearable class="filter-item" style="width: 120px;margin-right: 5px;">
                <el-option v-for="item in reportStatusArray" :key="item.key" :label="item.display_name" :value="item.key" />
            </el-select>

            <el-date-picker v-model="dataStart" type="date" placeholder="举报日期(开始)" style="width: 160px;margin-right: 3px;" class="filter-item"/>
            <span class="line" style="margin-right: 3px;color:gray;">-</span>
            <el-date-picker v-model="dataEnd" type="date" placeholder="举报日期(结束)" style="width: 160px;margin-right: 5px;" class="filter-item"/>

            <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
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

            <el-table-column width="150px" align="center" label="职位名称">
                <template slot-scope="scope">
                    <span>Java 架构师</span>
                </template>
            </el-table-column>

            <el-table-column min-width="160px" align="center" label="发布企业">
                <template slot-scope="scope">
                    <span>{{ scope.row.author }}</span>
                </template>
            </el-table-column>

            <el-table-column width="120px" align="center" label="举报人">
                <template slot-scope="scope">
                    <span>风间影月</span>
                </template>
            </el-table-column>

            <!-- <el-table-column class-name="status-col" align="center" label="职位状态" width="120">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{row.status}}
                    </el-tag>
                </template>
            </el-table-column> -->

            <el-table-column class-name="status-col" align="center" label="处理状态" width="120">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{row.status}}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="180px" align="center" label="举报时间">
                <template slot-scope="scope">
                    <span>2022-02-14 14:14:14</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="120">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-view" @click="showCompanyInfo(scope.row.companyId)">
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
            
            <el-form ref="dataForm" label-width="80px" :rules="rules" :model="temp" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="职位名称">
                    Java高级工程师
                </el-form-item>
                
                <el-form-item label="所属企业">
                    江苏南京牛逼有限公司
                </el-form-item>

                <el-form-item label="发布人">
                    风间影月
                </el-form-item>

                <el-form-item label="职位行业">
                    互联网/计算机
                </el-form-item>

                <el-form-item label="职位介绍" style="width: 620px;">
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
                </el-form-item>

                <el-form-item label="举报缘由" style="color: red;">
                    虚假发布
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="dialogVisible = false">关闭职位</el-button>
                <el-button type="warning" @click="dialogVisible = false">忽略</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
// import { fetchList } from '@/api/article'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

const reportStatusArray = [
    { key: 'b', display_name: '待处理' },
    { key: 'c', display_name: '已处理 - 忽略' },
    { key: 'a', display_name: '已处理 - 职位关闭' },
]

const jobStatusArray = [
    { key: 'b', display_name: '开启' },
    { key: 'c', display_name: '隐藏' },
    { key: 'c', display_name: '关闭' },
]

export default {
    name: "reportList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                未处理: "gray",
                忽略: "info",
                职位关闭: "success",
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

            dataStart: '',
            dataEnd: '',

            temp: {},
            reportStatusArray,
            jobStatusArray,

            list: null,
            total: 0,
            listLoading: true,
            listQuery: {
                page: 1,
                limit: 20,
                type: undefined,
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        // 打开前重置信息
        resetCompanyInfo() {
            this.temp = {
                id: undefined,
                importance: 1,
                remark: '',
                timestamp: new Date(),
                title: '',
                status: '未处理',
                type: ''
            }
        },
        showCompanyInfo(companyId) {
            this.resetCompanyInfo();
            this.dialogVisible = true;
            this.temp.id = companyId;
            // this.$nextTick(() => {
            //     this.$refs['dataForm'].clearValidate()
            // })
        },


        getList() {
            this.listLoading = false;
            // this.list = response.data.items
            this.total = 50;

            var articleList = {
                companyId: "1810107M6XAAG2FW",
                logo: "/static/logo.png",
                publishTime: new Date(),
                author: "北京慕课网网络科技有限公司",
                industry: "计算机/互联网",
                staffSize: "5000人",
                status: "忽略",
                readCounts: 11930,
                address: "北京市海淀区北三环路中关村园区B幢2单元505室",
            };
            var arr = []; 
            arr.length = 20;
            arr.fill(articleList)
            // arr.push(articleList);
            this.list = arr;
            console.log(this.list);

            // this.listLoading = true
            // fetchList(this.listQuery).then(response => {
            //   this.list = response.data.items
            //   this.total = response.data.total
            //   this.listLoading = false
            // })
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
