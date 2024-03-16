<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input v-model="listQuery.accountName" placeholder="账号名称" style="width: 200px;margin-right: 5px;" class="filter-item" @keyup.enter.native="searchAdmin" />

            <el-button class="filter-item" type="primary" icon="el-icon-search" @click="searchAdmin">
                查询
            </el-button>
            <el-button class="filter-item" style="margin-left: 10px;" type="danger" icon="el-icon-edit" @click="showCreateAdminDialog">
                创建账号
            </el-button>
            <!-- <el-button v-waves :loading="downloadLoading" class="filter-item" type="primary" icon="el-icon-download" @click="handleDownload">
                导出
            </el-button> -->
        </div>

        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="80">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.companyId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column width="100px" align="center" label="头像">
                <template slot-scope="scope">
                    <!-- <span>{{ scope.row.face }}</span> -->
                    <el-image :src="scope.row.face" style="width: 80px; height: 80px;">
                    </el-image>
                </template>
            </el-table-column>

            <el-table-column min-width="160px" align="center" label="账号名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.username }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="180px" align="left" label="备注信息">
                <template slot-scope="{ row }">
                    <span>{{ row.remark }}</span>
                </template>
            </el-table-column>

            <el-table-column width="200px" align="center" label="创建时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.createTime }}</span>
                </template>
            </el-table-column>

            <el-table-column width="200px" align="center" label="修改时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.updatedTime }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="250">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-edit-outline" @click="showResetPwdDialog(scope.row.id)">
                        重置密码
                    </el-button>
                    <el-button v-if="scope.row.username != 'admin'" type="warning" size="small" icon="el-icon-document-delete" @click="deleteAdmin(scope.row.username)">
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

        <el-dialog :visible.sync="dialogCreateAdminVisible" :title="dialogType==='edit'?'修改账号':'创建账号'" width="660px" top="5vh">
            
            <el-form ref="adminForm" label-width="80px" :model="adminInfo" :rules="rules" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="账号名" prop="username">
                    <el-input v-model="adminInfo.username" placeholder="请输入账号名..." />
                </el-form-item>

                <el-form-item label="密码" prop="password">
                    <el-input type="password" v-model="adminInfo.password" placeholder="请输入密码..." />
                </el-form-item>
                
                <el-form-item label="备注信息" prop="remark">
                    <el-input
                        v-model="adminInfo.remark"
                        :autosize="{ minRows: 2, maxRows: 4}"
                        type="textarea"
                        placeholder="管理人员账号信息介绍（选填）"
                    />
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogCreateAdminVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitCreateAdminInfo">提交</el-button>
            </span>
        </el-dialog>

        <el-dialog :visible.sync="dialogResetPwdVisible" title="重置密码" width="660px" top="5vh">
            
            <el-form ref="resetPwdForm" label-width="80px" :model="resetPwdBO" label-position="left" style="width: 500px; margin-left:50px;">

                <el-input type="hidden" v-model="resetPwdBO.adminId" />

                <el-form-item label="密码" prop="password">
                    <el-input type="password" v-model="resetPwdBO.password" placeholder="请输入密码..." />
                </el-form-item>
                
                <el-form-item label="重复密码" prop="rePassword">
                    <el-input type="password" v-model="resetPwdBO.rePassword" placeholder="请重复密码..." />
                </el-form-item>
            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogResetPwdVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitResetPwd">确认重置</el-button>
            </span>
        </el-dialog>

    </div>
</template>

<script>
import { getAdminList, createAdmin, deleteAdmin, resetPwd } from '@/api/admin';
import { MessageBox, Message } from 'element-ui'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination
import { validURL } from "@/utils/validate";

const statusArray = [
    { key: 'a', display_name: '待审核' },
    { key: 'b', display_name: '审核通过' },
    { key: 'c', display_name: '审核未通过' },
    { key: 'd', display_name: '黑名单' }
]

export default {
    name: "adminList",
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
            console.log(rule);
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
            dialogResetPwdVisible: false,
            dialogType: "create",

            destroyOnClose: true,

            adminInfo: {
                username: "",
                password: "",
                remark: "",
            },

            resetPwdBO: {
                adminId: "",
                password: "",
                rePassword: "",
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
                accountName: "",
            },

            rules: {
                username: [{ validator: validateRequire }],
                password: [{ validator: validateRequire }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        deleteAdmin(username) {

            MessageBox.confirm('确认删除吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.listLoading = true;
                var bo = {
                    username: username
                }
                deleteAdmin(bo).then(response => {
                    // console.log(response);
                    this.$notify({
                        title: "成功",
                        message: "删除管理员账号成功~",
                        type: "success",
                        duration: 2000,
                    });
                    this.getList();
                });
                this.listLoading = false;
            })
            
        },

        searchAdmin() {
            this.getList();
        },

        getList() {
            this.listLoading = true;
            getAdminList(this.listQuery).then(response => {
                console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },

        showResetPwdDialog(adminId) {

            this.dialogResetPwdVisible = true;
            this.resetPwdBO.adminId = adminId;

            this.$nextTick(() => {
                this.$refs['resetPwdForm'].resetFields()
            })
        },

        // 打开前重置信息
        resetAdminInfo() {
            this.adminInfo = {
                username: "",
                password: "",
                remark: "",
            }
        },
        showCreateAdminDialog() {
            // this.resetAdminInfo();
            this.dialogCreateAdminVisible = true;
            // this.$nextTick(() => {
            //     this.$refs['adminForm'].clearValidate()
            // })
        },

        // 修改密码
        submitResetPwd() {

            if (this.resetPwdBO.password == null || this.resetPwdBO.password == "" || this.resetPwdBO.password == undefined) {
                this.$message({
                    message: "请输入密码...",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }

            if (this.resetPwdBO.rePassword == null || this.resetPwdBO.rePassword == "" || this.resetPwdBO.rePassword == undefined) {
                this.$message({
                    message: "请输入重复密码...",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }
            if (this.resetPwdBO.password != this.resetPwdBO.rePassword) {
                this.$message({
                    message: "两次密码不一致...",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }

            this.loading = true;

            resetPwd(this.resetPwdBO).then(response => {
                console.log(response);
                this.$notify({
                    title: "成功",
                    message: "密码创建成功~",
                    type: "success",
                    duration: 2000,
                });

                this.$nextTick(() => {
                    this.$refs['resetPwdForm'].resetFields()
                });
                this.dialogResetPwdVisible = false;
            })

            this.loading = false;
        },

        // 创建admin账号
        submitCreateAdminInfo() {
            this.$refs.adminForm.validate((valid) => {
                if (valid) {
                    this.loading = true;

                    createAdmin(this.adminInfo).then(response => {
                        console.log(response);
                        this.$notify({
                            title: "成功",
                            message: "管理员创建成功~",
                            type: "success",
                            duration: 2000,
                        });

                        // this.resetAdminInfo();
                        
                        this.$nextTick(() => {
                            this.$refs['adminForm'].resetFields()
                        });
                        this.dialogCreateAdminVisible = false;
                        this.getList();
                    })

                    this.loading = false;
                } else {
                    console.log("error submit!!");
                    return false;
                }

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
