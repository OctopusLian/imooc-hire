<template>
    <div class="app-container">
        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="80">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.articleId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column min-width="300px" label="标题">
                <template slot-scope="{ row }">
                    <!-- :to="{path:'/pdf/download' , query :{jobId:jobInfo.id}}" -->
                    <!-- <router-link :to="'/article/edit/'" class="link-type"> -->
                    <router-link :to="{path:'/article/edit' , query :{articleId: row.id}}" class="link-type">
                        <span>{{ row.title }}</span>
                    </router-link>
                </template>
            </el-table-column>

            <el-table-column width="200px" align="center" label="发布日期">
                <template slot-scope="scope">
                    <span>{{ scope.row.publishTime }}</span>
                </template>
            </el-table-column>

            <el-table-column width="120px" align="center" label="作者">
                <template slot-scope="scope">
                    <span>{{ scope.row.publisher }}</span>
                </template>
            </el-table-column>

            <el-table-column width="80px" align="center" label="阅读量">
                <template slot-scope="scope">
                    <span>{{ scope.row.readCounts }}</span>
                </template>``
            </el-table-column>

            <el-table-column class-name="status-col" align="center" label="状态" width="90">
                <template slot-scope="{ row }">
                    <!-- // 0：关闭，待发布，1：正常，可查阅，2：删除，无法查看 -->
                    <el-tag :type="row.status | statusFilter">
                        {{ row.status == 0 ? "待发布" : ""}}
                        {{ row.status == 1 ? "可查阅" : ""}}
                        {{ row.status == 2 ? "已删除" : ""}}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column align="center" label="Actions" width="300">
                <template slot-scope="{ row }">
                    <router-link :to="{path:'/article/edit' , query :{articleId: row.id}}" class="link-type">
                        <el-button type="primary" size="small" icon="el-icon-edit">
                            修改
                        </el-button>
                    </router-link>

                    <el-button type="primary" size="small" style="margin-left: 10px;" icon="el-icon-edit" @click="deleteArticle(row.id)">删除</el-button>

                    <el-button type="primary" size="small" style="margin-left: 10px;" icon="el-icon-edit" @click="openArticle(row.id)">开启</el-button>
                    
                </template>
            </el-table-column>
        </el-table>

        <pagination
            v-show="total > 0"
            :total="total"
            :page.sync="listQuery.page"
            :limit.sync="listQuery.limit"
            @pagination="getList"
        />
    </div>
</template>

<script>
import { getArticleList, deleteArticle, openArticle } from '@/api/article'
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

export default {
    name: "articleList",
    components: { Pagination },
    filters: {
        // 0：关闭，待发布，1：正常，可查阅，2：删除，无法查看
        statusFilter(status) {
            const statusMap = {
                0: "gray",
                1: "success",
                2: "info",
            };
            // const statusMap = {
            //     已发布: "success",
            //     草稿: "info",
            //     已删除: "danger",
            //     隐藏: "gray",
            // };
            return statusMap[status];
        },
    },
    data() {
        return {
            list: null,
            total: 0,
            listLoading: true,
            listQuery: {
                page: 1,
                limit: 10,
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        deleteArticle(id) {
            deleteArticle(id).then(response => {
                console.log(response);
                this.getList();
            })
        },

        openArticle(id) {
            openArticle(id).then(response => {
                console.log(response);
                this.getList();
            })
        },

        getList() {
            this.listLoading = true;
            getArticleList(this.listQuery).then(response => {
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
</style>
