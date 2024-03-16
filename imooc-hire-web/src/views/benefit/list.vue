<template>
    <div class="app-container">
        <div class="filter-container">
            <el-button class="filter-item" style="" type="danger" icon="el-icon-edit" @click="showCreateAdminDialog">
                新增福利
            </el-button>
            <!-- <el-button v-waves :loading="downloadLoading" class="filter-item" type="primary" icon="el-icon-download" @click="handleDownload">
                导出
            </el-button> -->
        </div>

        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="200">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.companyId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column min-width="320px" align="center" label="福利待遇">
                <template slot-scope="scope">
                    <span>{{ scope.row.author }}</span>
                </template>
            </el-table-column>

            <el-table-column width="280px" align="center" label="创建时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.publishTime }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="250">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-edit-outline" @click="showCreateAdminDialog()">
                        修改
                    </el-button>
                    <el-button type="warning" size="small" icon="el-icon-document-delete" @click="deleteAdmin()">
                        删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" 
            :total="total" 
            :page.sync="listQuery.page" 
            :limit.sync="listQuery.limit"
            @pagination="getList"/>

        <el-dialog :visible.sync="dialogCreateAdminVisible" :title="dialogType==='edit'?'修改福利':'新增福利'" width="660px" top="5vh">
            
            <el-form ref="adminForm" label-width="80px" :model="adminInfo" :rules="rules" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="福利名称" prop="name">
                    <el-input v-model="adminInfo.name" placeholder="请输入内容..." />
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogCreateAdminVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitCreateAdminInfo">提交</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
// import { fetchList } from '@/api/article'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination
import { validURL } from "@/utils/validate";

const statusArray = [
    { key: 'a', display_name: '待审核' },
    { key: 'b', display_name: '审核通过' },
    { key: 'c', display_name: '审核未通过' },
    { key: 'd', display_name: '黑名单' }
]

export default {
    name: "benefitList",
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
            dialogVisible: false,
            dialogCreateAdminVisible: false,
            dialogType: "create",

            destroyOnClose: true,

            adminInfo: {
                name: "",
                password: "",
                desc: "",
            },

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

            rules: {
                name: [{ validator: validateRequire }],
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
                timestamp: "",
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

        // 打开前重置信息
        resetAdminInfo() {
            this.temp = {
                id: undefined,
                importance: 1,
                remark: '',
                timestamp: "",
                title: '',
                status: 'published',
                type: ''
            }
        },
        showCreateAdminDialog() {
            this.resetAdminInfo();
            this.dialogCreateAdminVisible = true;
            this.$nextTick(() => {
                this.$refs['adminForm'].clearValidate()
            })
        },

        // 创建admin账号
        submitCreateAdminInfo() {
            this.$refs.adminForm.validate((valid) => {
                if (valid) {
                    this.loading = true;
                    this.$notify({
                        title: "成功",
                        message: "发布文章成功",
                        type: "success",
                        duration: 2000,
                    });
                    this.loading = false;
                } else {
                    console.log("error submit!!");
                    return false;
                }


                // this.dialogCreateAdminVisible = false;
            });


            // this.$message({
            //     message: "保存成功",
            //     type: "success",
            //     showClose: true,
            //     duration: 2000,
            // });
            // this.$message({
            //     message: "请填写必要的标题和内容",
            //     type: "warning",
            //     showClose: true,
            //     duration: 2000,
            // });
        },

        deleteAdmin() {

        },

        searchAdmin() {

        },

        

        getList() {
            this.listLoading = false;
            // this.list = response.data.items
            this.total = 50;

            var articleList = {
                companyId: "1810107M6XAAG2FW",
                logo: "/static/logo.png",
                publishTime: "2022-02-22 16:15:55",
                author: "风间影月",
                industry: "计算机/互联网",
                staffSize: "5000人",
                status: "审核通过",
                readCounts: 11930,
                address: "北京市海淀区北三环路中关村园区B幢2单元505室",
            };
            var arr = []; 
            arr.length = 10;
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
