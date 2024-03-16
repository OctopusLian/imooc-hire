<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input v-model="listQuery.typeName" placeholder="字典类别" style="width: 200px;margin-right: 5px;" class="filter-item" @keyup.enter.native="searchDataDict" />
            <el-input v-model="listQuery.itemValue" placeholder="字典项" style="width: 200px;margin-right: 5px;" class="filter-item" @keyup.enter.native="searchDataDict" />

            <el-button class="filter-item" type="primary" icon="el-icon-search" @click="searchDataDict">
                查询
            </el-button>
            <el-button class="filter-item" style="margin-left: 10px;" type="danger" icon="el-icon-edit" @click="showCreateAdminDialog">
                新增数据字典
            </el-button>
            <!-- <el-button v-waves :loading="downloadLoading" class="filter-item" type="primary" icon="el-icon-download" @click="handleDownload">
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

            <el-table-column width="80px" align="center" label="图标">
                <template slot-scope=" { row } ">
                    <!-- <span>{{ scope.row.icon }}</span> -->
                    <span :class="'tag-icon iconfont' +' '+ row.icon"></span>
                    <!-- <view :class="'tag-icon iconfont' + ' ' + tag.icon"></view> -->
                    <!-- <el-image :src="scope.row.icon" style="width: 80px; height: 80px;">
                    </el-image> -->
                </template>
            </el-table-column>

            <el-table-column min-width="120px" align="center" label="类别名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.typeName }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="120px" align="center" label="类别代码">
                <template slot-scope="{ row }">
                    <span>{{ row.typeCode }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="120px" align="center" label="字典项 - 键">
                <template slot-scope="scope">
                    <span>{{ scope.row.itemKey }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="120px" align="center" label="字典项 - 值">
                <template slot-scope="scope">
                    <span>{{ scope.row.itemValue }}</span>
                </template>
            </el-table-column>

            <el-table-column width="100px" align="center" label="是否启用">
                <template slot-scope="{ row }">
                    <!-- <span>{{ scope.row.enable }}</span> -->
                    <el-tag :type="row.enable | statusFilter">
                        {{ row.enable ? '开启' : '关闭' }}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="80px" align="center" label="排序">
                <template slot-scope="scope">
                    <span>{{ scope.row.sort }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="250">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-edit-outline" @click="showModifyAdminDialog(scope.row.id, 'edit')">
                        修改
                    </el-button>
                    <el-button type="warning" size="small" icon="el-icon-document-delete" @click="deleteDataDict(scope.row.id)">
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

        <el-dialog :visible.sync="dialogDataDictVisible" :title="dialogType==='edit'?'修改数据字典':'新增数据字典'" width="660px" top="5vh">

            <el-form ref="dataDictForm" label-width="80px" :model="dataDict" :rules="rules" label-position="left" style="width: 500px; margin-left:50px;">
                <!-- <el-input v-model="dataDict.id" type="hidden"/> -->

                <el-form-item label="类别代码" prop="typeCode">
                    <el-input v-model="dataDict.typeCode" placeholder="请输入类别代码，例如：CompanyBenefits" maxlength="24"/>
                </el-form-item>

                <el-form-item label="类别名称" prop="typeName">
                    <el-input v-model="dataDict.typeName" placeholder="请输入类别名称，例如：公司福利" maxlength="24"/>
                </el-form-item>
                
                <el-form-item label="字典 - 键" prop="itemKey">
                    <el-input v-model="dataDict.itemKey" placeholder="请输入字典键，例如：Travel" maxlength="24"/>
                </el-form-item>

                <el-form-item label="字典 - 值" prop="itemValue">
                    <el-input v-model="dataDict.itemValue" placeholder="请输入字典值，例如：旅游" maxlength="24"/>
                </el-form-item>

                <el-form-item label="排序" prop="sort">
                    <el-input v-model="dataDict.sort" placeholder="请输入排序，例如：1" maxlength="3"/>
                </el-form-item>

                <el-form-item label="图标" prop="icon">
                    <el-input v-model="dataDict.icon" placeholder="请输入合适的 iconfont" maxlength="64"/>
                </el-form-item>

                <el-form-item label="是否开启" prop="enable">
                    <!-- <el-input v-model="dataDict.enable" placeholder="" maxlength="2"/> -->

                    <el-radio-group v-model="dataDict.enable">
                        <el-radio :label="true" border>
                            启用
                        </el-radio>
                        <el-radio :label="false" border>
                            停用
                        </el-radio>
                    </el-radio-group>

                </el-form-item>
            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogDataDictVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitDataDict">提交</el-button>
            </span>
        </el-dialog>

    </div>
</template>

<script>
import { getDataDictList, createDataDict, deleteDataDict, getDataDictItem, updateDataDict } from '@/api/dataDict';
import { MessageBox, Message } from 'element-ui'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination
import { validURL } from "@/utils/validate";
const { isEmpty,isNumber } = require('@/api/utils.js');

export default {
    name: "adminList",
    components: { Pagination },
    filters: {
        statusFilter(enable) {
            const statusMap = {
                true: "success",
                false: "danger",
                // 已删除: "danger",
                // 隐藏: "gray",
            };
            return statusMap[enable];
        },
    },
    data() {
        const validateRequire = (rule, value, callback) => {
            if (value === "") {
                // this.$message({
                //     message: rule.field + "为必传项",
                //     type: "error",
                // });
                callback(new Error(rule.field + "不能为空"));
            } else {
                callback();
            }
        };
        const validateInteger = (rule, value, callback) => {
            if (value != "" && value != null && value != undefined) {
                if (!isNumber(value)) {
                    callback(new Error(rule.field + "必须为数字"));
                } else {
                    callback();
                }
            } else {
                callback();
            }
        };
        return {
            dialogDataDictVisible: false,
            dialogType: "create",

            dataDict: {
                id: "",
                typeCode: "",
                typeName: "",
                itemKey: "",
                itemValue: "",
                sort: null,
                icon: "",
                enable: false,
            },

            list: null,
            total: 0,
            listLoading: true,
            listQuery: {
                page: 1,
                limit: 10,
                typeName: "",
                itemValue: "",
            },

            rules: {
                typeCode: [{ validator: validateRequire }],
                typeName: [{ validator: validateRequire }],
                itemKey: [{ validator: validateRequire }],
                itemValue: [{ validator: validateRequire }],
                sort: [{ validator: validateInteger }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        deleteDataDict(dictId) {

            MessageBox.confirm('确认删除吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.listLoading = true;
                var bo = {
                    dictId: dictId
                }
                deleteDataDict(bo).then(response => {
                    // console.log(response);
                    this.$notify({
                        title: "成功",
                        message: "删除数据字典成功~",
                        type: "success",
                        duration: 2000,
                    });
                    this.getList();
                });
                this.listLoading = false;
            })
            
        },

        searchDataDict() {
            this.getList();
        },

        getList() {
            this.listLoading = true;
            getDataDictList(this.listQuery).then(response => {
                // console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },

        showCreateAdminDialog() {
            this.dialogDataDictVisible = true;

            this.$nextTick(() => {
                this.$refs['dataDictForm'].resetFields()
            });
            this.dataDict.id = "";
        },

        showModifyAdminDialog(dictId, dialogType) {
            this.dialogDataDictVisible = true;
            this.dialogType = dialogType;

            // 查询数据字典信息
            this.listLoading = true;
            var bo = {
                dictId: dictId
            }
            getDataDictItem(bo).then(response => {
                // console.log(response);
                var ddInfo = response.data;
                this.dataDict = ddInfo;
            });
            this.listLoading = false;
        },

        // 新增数据字典
        submitDataDict() {

            var dataDict = this.dataDict;
                    
                    console.log(dataDict);
                    
            this.$refs.dataDictForm.validate((valid) => {
                if (valid) {

                    this.loading = true;
                    var dataDict = this.dataDict;
                    
                    if ( isEmpty(dataDict.id) ) {
                        createDataDict(dataDict).then(response => {
                            console.log(response);
                            this.$notify({
                                title: "成功",
                                message: "数据字典新增成功~",
                                type: "success",
                                duration: 2000,
                            });

                            this.dialogDataDictVisible = false;
                            this.getList();

                            this.loading = false;

                            this.$nextTick(() => {
                                this.$refs['dataDictForm'].resetFields()
                            });
                        })
                    } else {
                        updateDataDict(dataDict).then(response => {
                            console.log(response);
                            this.$notify({
                                title: "成功",
                                message: "数据字典修改成功~",
                                type: "success",
                                duration: 2000,
                            });

                            this.dialogDataDictVisible = false;
                            this.getList();

                            this.loading = false;

                            this.$nextTick(() => {
                                this.$refs['dataDictForm'].resetFields()
                            });
                        })
                    }

                    
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

<style>
    @import '../../icons/fonts/iconfont.css';
</style>

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

.tag-icon {
    font-size: 22px;
}
</style>
