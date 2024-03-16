<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input v-model="listQuery.title" placeholder="企业名称" style="width: 200px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-input v-model="listQuery.title" placeholder="所在地址" style="width: 200px;margin-right: 5px;" class="filter-item" @keyup.enter.native="handleFilter" />

            <el-select v-model="listQuery.type" placeholder="审核状态" clearable class="filter-item" style="width: 130px;margin-right: 5px;">
                <el-option v-for="item in statusArray" :key="item.key" :label="item.display_name" :value="item.key" />
            </el-select>

            <el-date-picker v-model="dataStart" type="date" placeholder="申请日期(开始)" style="width: 160px;margin-right: 3px;" class="filter-item"/>
            <span class="line" style="margin-right: 3px;color:gray;">-</span>
            <el-date-picker v-model="dataEnd" type="date" placeholder="申请日期(结束)" style="width: 160px;margin-right: 5px;" class="filter-item"/>

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

            <el-table-column width="80" align="center" label="企业图标">
                <template slot-scope="scope">
                    <span><img :src="require('@/assets' + scope.row.logo)" class="sidebar-logo"></span>
                </template>
            </el-table-column>

            <el-table-column width="180px" align="center" label="企业名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.author }}</span>
                </template>
            </el-table-column>

            <el-table-column width="120px" align="center" label="所在行业">
                <template slot-scope="scope">
                    <span>{{ scope.row.industry }}</span>
                </template>
            </el-table-column>

            <el-table-column width="100px" align="center" label="人员规模">
                <template slot-scope="scope">
                    <span>{{ scope.row.staffSize }}</span>
                </template>
            </el-table-column>

            <el-table-column class-name="status-col" align="center" label="状态" width="100">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{ row.status }}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column min-width="280px" align="left" label="地址">
                <template slot-scope="{ row }">
                    <span>{{ row.address }}</span>
                </template>
            </el-table-column>

            <el-table-column width="160px" align="center" label="申请时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.publishTime }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="120">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-view" @click="showCompanyInfo(scope.row.companyId)">
                        详情
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" 
            :total="total" 
            :page.sync="listQuery.page" 
            :limit.sync="listQuery.limit"
            @pagination="getList"/>

        <el-dialog :visible.sync="dialogVisible" title="企业信息审核" width="600px" top="5vh">
            
            <el-form ref="dataForm" label-width="80px" :rules="rules" :model="temp" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="企业名称">
                    <img :src="require('@/assets/static/logo.png')" class="sidebar-logo">
                    北京牛逼轰轰网络科技有限公司
                </el-form-item>
                
                <el-form-item label="所在行业">
                    计算机/互联网
                </el-form-item>

                <el-form-item label="人员规模">
                    2000人
                </el-form-item>

                <el-form-item label="办公地址">
                    北京园区海淀区工业路200号B幢202室
                </el-form-item>

                <el-form-item label="成立时间">
                    2020年12月22日
                </el-form-item>

                <el-form-item label="注册资本">
                    200万
                </el-form-item>

                <el-form-item label="法人代表">
                    喜洋洋
                </el-form-item>

                <el-form-item label="注册地址">
                    北京园区海淀区工业路200号B幢202室
                </el-form-item>

                <el-form-item label="营业执照">
                    <a :href="require('@/assets/static/yyzz.png')" target="_blank">
                        <img :src="require('@/assets/static/yyzz.png')" class="yyzz">
                    </a>
                </el-form-item>

                <el-form-item label="申请人">
                    风间影月 - 13961884846
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="dialogVisible = false">审核通过</el-button>
                <el-button type="warning" @click="dialogVisible = false">审核驳回</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
// import { fetchList } from '@/api/article'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

const statusArray = [
    { key: 'a', display_name: '待审核' },
    { key: 'b', display_name: '审核通过' },
    { key: 'c', display_name: '审核未通过' },
    { key: 'd', display_name: '黑名单' }
]

export default {
    name: "companyList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                待审核: "gray",
                审核通过: "success",
                审核未通过: "danger",
                黑名单: "info",
            };
            return statusMap[status];
        },
    },
    data() {
        return {
            dialogVisible: false,
            destroyOnClose: true,

            dataStart: '',
            dataEnd: '',

            temp: {},
            statusArray,

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
                status: 'published',
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
                status: "审核通过",
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
