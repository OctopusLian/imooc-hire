<template>
    <div class="app-container">
        <el-button :loading="downloadLoading" style="margin:0 0 20px 20px;" type="primary" icon="el-icon-document" @click="handleDownload">
            Export Excel
        </el-button>
        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="80">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.companyId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column min-width="220px" align="center" label="职位名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.title }}</span>
                </template>
            </el-table-column>

            <el-table-column width="120px" align="center" label="发布人">
                <template slot-scope="scope">
                    <span>{{ scope.row.publisher }}</span>
                </template>
            </el-table-column>

            <el-table-column width="110px" align="center" label="状态">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{ row.status }}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="220px" align="center" label="发布时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.publishTime }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" min-width="450">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-view" @click="showCreateAdminDialog()">
                        查看
                    </el-button>
                    <el-button type="warning" size="small" icon="el-icon-s-promotion" @click="showCreateAdminDialog()">
                        发布
                    </el-button>
                    <el-button type="info" size="small" icon="el-icon-close" @click="showCreateAdminDialog()">
                        关闭
                    </el-button>
                    <el-button type="danger" size="small" icon="el-icon-refresh" @click="showCreateAdminDialog()">
                        刷新
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" 
            :total="total" 
            :page.sync="listQuery.page" 
            :limit.sync="listQuery.limit"
            @pagination="getList"/>

        <el-dialog :visible.sync="dialogJobInfoVisible" title="职位信息" width="750px" top="5vh">
            
            <el-form ref="dataForm" label-width="80px" :model="temp" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
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

            </el-form>

            <span slot="footer" class="dialog-footer">
                <!-- <el-button @click="dialogJobInfoVisible = false">取 消</el-button> -->
                <el-button type="primary" @click="dialogJobInfoVisible = false">关 闭 页 面</el-button>
            </span>
        </el-dialog>

    </div>
</template>

<script>
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

export default {
    name: "jobsList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                招聘中: "success",
                待发布: "danger",
                已关闭: "warning",
                已删除: "info",
            };
            return statusMap[status];
        },
    },
    data() {
        
        return {
            downloadLoading: false,
            filename: 'aaa',
            autoWidth: true,
            bookType: 'xlsx',

            dialogVisible: false,
            dialogJobInfoVisible: false,
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

        handleDownload() {
            this.downloadLoading = true
            import('@/utils/Export2Excel').then(excel => {
            // import('@/components/vendor/Export2Excel2').then(excel => {
                const tHeader = ['Id', 'Title', 'Author', 'Readings', 'Date']
                const filterVal = ['jobId', 'title', 'publisher', 'status', 'publishTime']
                const list = this.list
                console.log(list);
                const data = this.formatJson(filterVal, list)
                console.log(data);
                console.log(excel);
                debugger;
                excel.export_json_to_excel({
                    header: tHeader,
                    data,
                    filename: this.filename,
                    autoWidth: this.autoWidth,
                    bookType: this.bookType
                })
                // excel.export_json_to_excel({
                //     header: tHeader,
                //     data,
                //     filename: "职位列表",
                //     autoWidth: true,
                //     bookType: "xlsx"
                // })
                this.downloadLoading = false
            })
        },
        formatJson(filterVal, jsonData) {
            return jsonData.map(v => filterVal.map(j => {
                // return parseTime(v[j])
                // } else {
                return v[j]
                // }
            }))
        },

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
            this.dialogJobInfoVisible = true;
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


                // this.dialogJobInfoVisible = false;
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

        getList() {
            this.listLoading = false;
            // this.list = response.data.items
            this.total = 50;

            var jobsList = {
                jobId: "1810107M6XAAG2FW",
                title: "Java高级工程",
                publishTime: "2022-02-22 16:15:55",
                publisher: "风间影月",
                status: "已关闭",     // 招聘中，待发布，已关闭
            };
            var arr = []; 
            arr.length = 10;
            arr.fill(jobsList)
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
