<template>
    <div class="app-container">
        <div class="form-container">
                <el-form ref="dataForm" v-model="industry" label-width="80px" size="mini" label-position="left" style="width: 360px; margin-left:50px;">
                    <el-form-item label="行业名称">
                        <el-input v-model="industry.name" placeholder="行业名称" style="width: 200px;margin-right: 5px;" class="filter-item"/>
                    </el-form-item>
                    
                    <el-form-item label="排序">
                        <el-input type="" v-model="industry.sort" placeholder="排序" style="width: 200px;margin-right: 5px;" class="filter-item"/>
                    </el-form-item>

                    <span class="dialog-footer">
                        <el-button icon="el-icon-delete" size="mini" type="info" @click="clear">清空</el-button>
                        <el-button icon="el-icon-s-promotion" size="mini" type="primary" @click="createIndustry">创建</el-button>
                        <el-button icon="el-icon-edit" size="mini" type="primary" @click="updateIndustry">更新</el-button>
                        <el-button icon="el-icon-delete" size="mini" type="danger" @click="deleteIndustry">删除</el-button>
                    </span>
                </el-form>

            <aside class="hint">
                <span style="font-size: 12px; color: gray;">
                    <p style="line-height: 20px;margin-top:5px;">
                        <i class="el-icon-info"> 提示：</i><br>
                        <span style="font-size: 13px; color:red; font-weight: bold;" v-if="currentSelectedIndustryName != null && currentSelectedIndustryName != ''">当前选中的节点为：{{currentSelectedIndustryName}}<br></span>
                        1、【创建】为新增行业，未选中行业则创建顶级分类，选中则创建该节点下子分类，最后一级分类不可创建；<br>
                        2、【更新】前需要点击任何一项行业，在表单中修改后点击【更新】即可提交修改；<br>
                        3、【删除】前需要选中任何一项行业后，方可点击删除；<br>
                        4、【清空】清除表单中的待提交信息。<br>
                    </p>

                    <!-- <span style="font-size: 14px; color: red;font-weight: bold;">
                        点击行业后，需要查询后端，每次从缓存中获得<br>
                        缓存穿透、雪崩、击穿问题可以在这里出现，还有双写一致，还有分布式锁。
                    </span> -->
                </span>
            </aside>
        </div>

        <el-tree
            ref="tree"
            node-key="id"
            :data="data"
            :props="defaultProps"
            :load="loadNode"
            lazy 
            :highlight-current="highlightCurrent"
            @node-click="currentNodeClick"
            style="margin-top: 20px;"
        ></el-tree>
        <!-- 
        :load="loadNode"
        lazy 
        -->
    </div>
</template>

<script>
import { getTopList,getChildrenIndustryList,createNode,updateNode,deleteNode } from '@/api/industry';
const { isEmpty,isNumber } = require('@/api/utils.js');

export default {
    name: "industrySettings",
    data() {
        return {
            highlightCurrent: true,

            currentSelectedIndustryName: "",    // 当前选中的节点，为了在提示中给用户看到
            industry: {
                id: "",
                name: "",
                sort: null,
                fatherId: 0,    // 为0则当前为第一级分类，否则当前为fatherId所对应行业的子分类
                isLeaf: false,
                level: 0,       // 为1则当前为第一级分类，以此类推，默认未选中则为0
            },

            data: [
                {
                    id: "1",
                    name: "互联网·游戏·软件",
                    isLeaf: false,
                    children: [
                        {
                            id: "1001",
                            name: "互联网/电商",
                            children: [
                                {
                                    id: "1002",
                                    name: "电子商务",
                                    isLeaf: true,
                                },
                                {
                                    id: "1003",
                                    name: "人工智能",
                                },
                                {
                                    id: "1004",
                                    name: "文娱平台",
                                },
                                {
                                    id: "1005",
                                    name: "大数据",
                                },
                                {
                                    id: "1006",
                                    name: "区块链",
                                },
                                {
                                    id: "1007",
                                    name: "物联网",
                                },
                            ],
                        },
                        {
                            id: "2001",
                            name: "游戏产业",
                            children: [
                                {
                                    id: "2002",
                                    name: "游戏媒体",
                                },
                                {
                                    id: "2003",
                                    name: "游戏机",
                                },
                                {
                                    id: "2004",
                                    name: "游戏平台",
                                },
                                {
                                    id: "2005",
                                    name: "游戏开发",
                                },
                                {
                                    id: "2006",
                                    name: "电子竞技",
                                },
                            ],
                        },
                        {
                            id: "3001",
                            name: "计算机软件",
                            children: [
                                {
                                    id: "3002",
                                    name: "软件开发",
                                },
                                {
                                    id: "3003",
                                    name: "SAAS服务",
                                },
                                {
                                    id: "3004",
                                    name: "软件服务",
                                },
                            ],
                        },
                    ],
                },
                {
                    name: "AAA",
                    children: [
                        {
                            name: "BBB",
                            children: [
                                {
                                    name: "ddd",
                                },
                            ],
                        },
                        {
                            name: "CCC",
                            children: [
                                {
                                    name: "eee",
                                },
                            ],
                        },
                    ],
                },
            ],
            defaultProps: {
                children: "children",
                label: "name",
                isLeaf: "isLeaf"
            },

            isFirst: true,
            resolve: null,
            node: null,
        };
    },
    created() {
        // this.getTopListForInit();
        
    },
    methods: {
        // 异步懒加载子节点
        loadNode(node, resolve) {

            // var industryId = node.id;
            var industryId = node.data.id;
            if (industryId == undefined) {
                // 初始化的时候都是0
                industryId = 0;
            }
            // console.log(node.data.id);
            // console.log(industryId);
            getChildrenIndustryList(industryId).then(response => {
                var data = response.data;
                if (data == null) {
                    return;
                }
                resolve(data);
                // this.data = childrenData;
                // console.log(data);
            })
        },

        // 初始化的时候查询所有顶级节点数据
        getTopListForInit() {
            getTopList().then(response => {
                var data = response.data;
                this.data = data;
                // console.log(data);
            })
        },
        // 清空数据，恢复tree未选择
        clear() {
            var industry = {
                id: "",
                name: "",
                sort: null,
                fatherId: 0,
                isLeaf: false,
                level: 0,
            }
            this.industry = industry;
            
            var tree = this.$refs.tree; 
            tree.setCurrentKey(null);

            this.currentSelectedIndustryName = "";
        },

        currentNodeClick(data) {
            console.log(data);
            this.industry.id = data.id;
            this.industry.name = data.name;
            this.industry.sort = data.sort;
            this.industry.fatherId = data.fatherId;
            this.industry.isLeaf = data.isLeaf;
            this.industry.level = data.level;

            this.currentSelectedIndustryName = data.name;
        },

        createIndustry () {
            var industry = this.industry;

            if (isEmpty(industry.name)) {
                this.$message({
                    message: "行业名称不能为空",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            } else if (isEmpty(industry.sort)) {
                this.$message({
                    message: "排序不能为空",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            } else if (isEmpty(industry.fatherId) || isEmpty(industry.isLeaf) || isEmpty(industry.level)) {
                this.$message({
                    message: "信息不完整或页面代码破损",
                    type: "error",
                    showClose: true,
                    duration: 1500,
                });
                return;
            } else if (!isNumber(industry.sort)) {
                this.$message({
                    message: "排序只能是正整数",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }

            if (industry.level == 3) {
                // 3级分类不可以添加
                this.$message({
                    message: "当前行业类目下不可创建子行业",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
            } else if (industry.level === 1 || industry.level === 2) {
                // 1级和2级分类可以添加子分类
                
                var industryTemp = {
                    id: null,     // 创建需要清空id的值
                    name: industry.name,
                    sort: industry.sort,
                    fatherId: industry.id,      // // 父id为当前选择的节点id
                    isLeaf: false,
                    level: 0,
                }
                
                // 向下一级创建分类
                if (industry.level === 1) {
                    industryTemp.level = 2;
                } else if (industry.level === 2) {
                    industryTemp.level = 3;
                    // 三级节点作为叶子节点进行标记
                    industryTemp.isLeaf = true;
                } 
                createNode(industryTemp).then(response => {
                    var data = response.data;
                    this.refreshNode(industry.id);
                    // console.log(data);
                    this.$notify({
                        title: "创建成功",
                        message: "新创建的子行业节点已成功入库！",
                        type: "success",
                        duration: 2000,
                    });
                })
            } else if (industry.level == 0) {
                // 创建一级分类

                var industryTemp = {
                    id: null,     // 创建需要清空id的值
                    name: industry.name,
                    sort: industry.sort,
                    fatherId: 0,      // // 父id为当前选择的节点id
                    isLeaf: false,
                    level: 1,
                }

                createNode(industryTemp).then(response => {
                    var data = response.data;
                    // this.refreshNode(industry.id);
                    this.getTopListForInit();
                    // console.log(data);
                    this.$notify({
                        title: "创建成功",
                        message: "新创建的一级行业节点已成功入库！",
                        type: "success",
                        duration: 2000,
                    });
                })
            } else {
                // 如果没有则提示错误
                this.$message({
                    message: "参数错误，请联系管理员~",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
            }
        },

        refreshNode(id){
            let node = this.$refs.tree.getNode(id);
            node.loaded = false;
            node.expand();
        },

        updateIndustry() {
            var tree = this.$refs.tree; 
            var node = tree.getCurrentNode();
            // console.log(node);
            if (node == null || node == undefined) {
                this.$message({
                    message: "请选中一个行业分类",
                    type: "warning",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }

            var industry = this.industry;
            this.validate(industry);
            
            if (isEmpty(industry.id)) {
                this.$message({
                    message: "信息不完整或页面代码破损",
                    type: "error",
                    showClose: true,
                    duration: 1500,
                });
                return;
            }

            var industryTemp = {
                id: industry.id,     // 创建需要清空id的值
                name: industry.name,
                sort: industry.sort,
                fatherId: industry.fatherId,      // // 父id为当前选择的节点id
                isLeaf: industry.isLeaf,
                level: industry.level,
            }

            updateNode(industryTemp).then(response => {
                var data = response.data;
                if (industry.level === 2 || industry.level === 3) {
                    this.refreshNode(industry.fatherId);
                } else {
                    this.getTopListForInit();
                }
                
                // console.log(data);
                this.$notify({
                    title: "更新成功",
                    message: "行业节点已成功更新入库！",
                    type: "success",
                    duration: 2000,
                });
            })
            
        },

        validate(industry) {
            if (isEmpty(industry.name)) {
                this.$message({
                    message: "行业名称不能为空",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            } else if (isEmpty(industry.sort)) {
                this.$message({
                    message: "排序不能为空",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            } else if (isEmpty(industry.fatherId) || isEmpty(industry.isLeaf) || isEmpty(industry.level)) {
                this.$message({
                    message: "信息不完整或页面代码破损",
                    type: "error",
                    showClose: true,
                    duration: 1500,
                });
                return;
            } else if (!isNumber(industry.sort)) {
                this.$message({
                    message: "排序只能是正整数",
                    type: "error",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }
        },

        deleteIndustry () {
            var tree = this.$refs.tree; 
            var node = tree.getCurrentNode();
            // console.log(node);
            if (node == null || node == undefined) {
                this.$message({
                    message: "请选中一个行业分类",
                    type: "warning",
                    showClose: true,
                    duration: 2000,
                });
                return;
            }

            this.$confirm('确认删除该节点吗？', '警告', {
                confirmButtonText: '确认',
                cancelButtonText: '取消',
                type: 'warning'
            })
            .then(async() => {
                var industryId = node.id;
                deleteNode(industryId).then(response => {
                    var data = response.data;
                    if (node.level === 2 || node.level === 3) {
                        this.refreshNode(node.fatherId);
                    } else {
                        this.getTopListForInit();
                    }
                    
                    // console.log(data);
                    this.$notify({
                        title: "删除成功",
                        message: "该行业节点已成功删除！",
                        type: "success",
                        duration: 2000,
                    });
                })
            })
            .catch(err => { console.error(err) })
        }
    },
};
</script>

<style scoped>
.row-container {
    display: flex;
    flex-direction: row;
} 

.hint {
    margin-top: 35px;
    background: #eef1f6;
    padding: 10px 10px 20px 10px;
    margin-bottom: 10px;
    border-radius: 2px;
    display: block;
    line-height: 22px;
    font-size: 16px;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;
    color: #2c3e50;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    /* a {
        color: #337ab7;
        cursor: pointer;

        &:hover {
            color: rgb(32, 160, 255);
        }
    } */
}
.form-container {
    background-color: rgb(252, 250, 250);
    padding: 20px 0 0 0 ;
}
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
.line {
    text-align: center;
}
</style>
