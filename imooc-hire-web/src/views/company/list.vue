<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input v-model="listQuery.companyName" placeholder="企业名称" style="width: 200px;margin-right: 5px;" class="filter-item" />

            <el-input v-model="listQuery.commitUser" placeholder="申请人" style="width: 200px;margin-right: 5px;" class="filter-item" />

            <el-select v-model="listQuery.reviewStatus" placeholder="审核状态" clearable class="filter-item" style="width: 130px;margin-right: 5px;">
                <el-option v-for="item in statusArray" :key="item.key" :label="item.display_name" :value="item.key" />
            </el-select>

            <el-date-picker 
                v-model="listQuery.commitDateStart" 
                type="date" 
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd" 
                placeholder="申请日期(开始)" 
                style="width: 160px;margin-right: 3px;" class="filter-item"/>
            <span class="line" style="margin-right: 3px;color:gray;">-</span>
            <el-date-picker 
                v-model="listQuery.commitDateEnd" 
                type="date" 
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd" 
                placeholder="申请日期(结束)" 
                style="width: 160px;margin-right: 5px;" class="filter-item"/>

            <el-button class="filter-item" type="primary" icon="el-icon-search"  @click="searchCompany">
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
                    <span><img :src="scope.row.logo" class="sidebar-logo"></span>
                </template>
            </el-table-column>

            <el-table-column min-width="180px" align="center" label="企业名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.companyName }}</span>
                </template>
            </el-table-column>

            <el-table-column width="120px" align="center" label="所在行业">
                <template slot-scope="scope">
                    <span>{{ scope.row.industry }}</span>
                </template>
            </el-table-column>

            <el-table-column width="100px" align="center" label="人员规模">
                <template slot-scope="scope">
                    <span>{{ scope.row.peopleSize }}</span>
                </template>
            </el-table-column>

            <el-table-column class-name="status-col" align="center" label="状态" width="120">
                <template slot-scope="{ row }">
                    <el-tag :type="row.reviewStatus | statusFilter">
                        {{ row.reviewStatus == 0 ? "未发起审核" : ""}}
                        {{ row.reviewStatus == 1 ? "认证通过" : ""}}
                        {{ row.reviewStatus == 2 ? "认证失败" : ""}}
                        {{ row.reviewStatus == 3 ? "审核中" : ""}}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="120px" align="center" label="申请人">
                <template slot-scope="scope">
                    <span>{{ scope.row.commitUser }}</span>
                </template>
            </el-table-column>

            <el-table-column width="160px" align="center" label="申请时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.commitDate }}</span>
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

        <el-dialog v-if="companyInfo != null" :visible.sync="dialogVisible" title="企业信息审核" width="600px" top="5vh">
            
            <el-form ref="dataForm" label-width="80px"  :model="temp" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="企业名称">
                    <img :src="companyInfo.logo" class="sidebar-logo">
                    {{companyInfo.companyName}}
                </el-form-item>

                <el-form-item label="企业简称">
                    {{companyInfo.shortName}}
                </el-form-item>
                
                <el-form-item label="所在行业">
                    {{companyInfo.industry}}
                </el-form-item>

                <el-form-item label="人员规模">
                    {{companyInfo.peopleSize}}
                </el-form-item>

                <el-form-item label="企业性质">
                    {{companyInfo.nature}}
                </el-form-item>

                <el-form-item label="融资阶段">
                    {{companyInfo.financStage}}
                </el-form-item>

                <el-form-item label="办公地址">
                    {{companyInfo.province}}{{companyInfo.city}}{{companyInfo.district}}{{companyInfo.address}}
                </el-form-item>

                <el-form-item label="工作时间">
                    {{companyInfo.workTime}}
                </el-form-item>

                <el-form-item label="公司优势">
                    <span v-for="a in advantageList" :key="a.id" style="margin-right: 6px;">
                        {{a.itemValue}}
                    </span>
                </el-form-item>

                <el-form-item label="福利待遇">
                    <span v-for="b in benefitsList" :key="b.id" style="margin-right: 6px;">
                        {{b.itemValue}}
                    </span>
                </el-form-item>

                <el-form-item label="薪资福利（奖金）">
                    <span v-for="b in bonusList" :key="b.id" style="margin-right: 6px;">
                        {{b.itemValue}}
                    </span>
                </el-form-item>

                <el-form-item label="补助津贴">
                    <span v-for="s in subsidyList" :key="s.id" style="margin-right: 6px;">
                        {{s.itemValue}}
                    </span>
                </el-form-item>

                <el-form-item label="公司简介">
                    {{companyInfo.introduction}}
                </el-form-item>

                <el-form-item label="法人代表">
                    {{companyInfo.legalRepresentative}}
                </el-form-item>
                <el-form-item label="注册资本">
                    {{companyInfo.registCapital}}
                </el-form-item>
                <el-form-item label="注册地址">
                    {{companyInfo.registPlace}}
                </el-form-item>
                <el-form-item label="成立日期">
                    {{companyInfo.buildDate}}
                </el-form-item>

                <el-form-item label="营业执照">
                    <a :href="companyInfo.bizLicense" target="_blank">
                        <img :src="companyInfo.bizLicense" class="yyzz">
                    </a>
                </el-form-item>

                <el-form-item label="认证授权书">
                    <a :href="companyInfo.authLetter" target="_blank">
                        <img :src="companyInfo.authLetter" class="yyzz">
                    </a>
                </el-form-item>

                <el-form-item v-if="companyInfo.commitUser != null && companyInfo.commitUser != ''" label="申请人">
                    {{companyInfo.commitUser}} - {{companyInfo.commitMobile}}
                </el-form-item>

                <el-form-item v-if="companyInfo.reviewStatus != 3" label="审核意见">
                    <!-- 只有审核中状态 显示文本框，其他状态只显示文字 -->
                    {{reviewReplay}}
                </el-form-item>
                <el-form-item v-if="companyInfo.reviewStatus == 3" label="审核意见">
                    <!-- 只有审核中状态 显示文本框，其他状态只显示文字 -->
                    <el-input v-model="reviewReplay" style="width: 320px;margin-right: 5px;" class="filter-item" />
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <!-- 只有审核中状态 显示 -->
                <el-button v-if="companyInfo.reviewStatus == 3" type="primary" @click="doReview(1)">审核通过</el-button>
                <el-button v-if="companyInfo.reviewStatus == 3" type="warning" @click="doReview(2)">审核驳回</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { getCompanyList, getCompanyInfo, doReview, getItemsByKeys } from '@/api/company';
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

const statusArray = [
    { key: '', display_name: '全部' },
    { key: '0', display_name: '未发起审核' },
    { key: '3', display_name: '审核中' },
    { key: '1', display_name: '审核认证通过' },
    { key: '2', display_name: '审核认证失败' },
]

export default {
    name: "companyList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                0: "gray",
                1: "success",
                2: "danger",
                3: "info",
            };
            return statusMap[status];
            // const statusMap = {
            //     待审核: "gray",
            //     审核通过: "success",
            //     审核未通过: "danger",
            //     黑名单: "info",
            // };
            // return statusMap[status];
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
                companyName: "",
                commitUser: "",
                reviewStatus: null,
                commitDateStart: null,
                commitDateEnd: null,

                page: 1,
                limit: 10,
            },

            companyInfo: null,
            reviewReplay: "",

            advantageList: [],
            benefitsList: [],
            bonusList: [],
            subsidyList: [],
        };
    },
    created() {
        this.getList();
    },
    methods: {
        doReview(status) {
            var bo = {
                hrUserId: this.companyInfo.commitUserId,
                companyId: this.companyInfo.companyId,
                reviewReplay: this.reviewReplay,
                reviewStatus: status,
            }
            // console.log(bo);
            this.listLoading = true;
            doReview(bo).then(response => {
                console.log(response);
                // var companyInfo = response.data;
                // this.companyInfo = companyInfo;
                // this.reviewReplay = companyInfo.reviewReplay;

                this.companyInfo = null;
                this.reviewReplay = "";
                this.getList();

                this.dialogVisible = false;
                this.listLoading = false;
            });

        },

        searchCompany() {
            this.getList();
        },

        getList() {
            this.listLoading = true;
            getCompanyList(this.listQuery).then(response => {
                console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },

        showCompanyInfo(companyId) {
            this.listLoading = true;
            var params = {
                companyId: companyId
            }
            getCompanyInfo(params).then(response => {
                console.log(response);
                var companyInfo = response.data;
                this.companyInfo = companyInfo;
                this.reviewReplay = companyInfo.reviewReplay;

                var advantage = companyInfo.advantage == null ? "" : companyInfo.advantage;
				var benefits = companyInfo.benefits == null ? "" : companyInfo.benefits; 
				var bonus = companyInfo.bonus == null ? "" : companyInfo.bonus;
				var subsidy = companyInfo.subsidy == null ? "" : companyInfo.subsidy;

                var advantageArr = advantage.split(",");
				var benefitsArr = benefits.split(",");
				var bonusArr = bonus.split(",");
				var subsidyArr = subsidy.split(",");

                var bo = {
					"advantage": advantageArr,
					"benefits": benefitsArr,
					"bonus": bonusArr,
					"subsidy": subsidyArr
				}

                getItemsByKeys(bo).then(response => {
                    var vo = response.data;
                    console.log(vo);
                    this.advantageList = vo.advantageList;
                    this.benefitsList = vo.benefitsList;
                    this.bonusList = vo.bonusList;
                    this.subsidyList = vo.subsidyList;
                });


                this.dialogVisible = true;
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
