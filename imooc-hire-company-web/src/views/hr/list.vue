<template>
    <div class="app-container">
        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="编号" width="60">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.hrId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column width="140" align="center" label="HR姓名">
                <template slot-scope="scope">
                    <span>{{ scope.row.realName }}</span>
                </template>
            </el-table-column>

            <el-table-column width="140" align="center" label="昵称">
                <template slot-scope="scope">
                    <span>{{ scope.row.nickname }}</span>
                </template>
            </el-table-column>

            <el-table-column width="100" align="center" label="头像">
                <template slot-scope="scope">
                    <el-image style="width: 60px; height: 60px; border-radius: 40px;" :src="scope.row.face">
                        <div slot="placeholder"></div>
                    </el-image>
                </template>
            </el-table-column>

            <el-table-column width="120" align="center" label="职位">
                <template slot-scope="scope">
                    <span>{{ scope.row.position }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="150" class-name="status-col" align="left" label="个人标签">
                <!-- <template slot-scope="{ row }"> -->
                <template slot-scope="scope">
                    <span v-for="tag in showTags(scope.row.hrTags)" :key="tag" >
                        <el-tag :type="gray" style="margin-left: 3px; margin-top: 3px;">
                            {{ tag }} 
                        </el-tag>
                    </span>
                </template>
            </el-table-column>

            <el-table-column width="220" align="left" label="个性签名">
                <template slot-scope="scope">
                    <span>{{ scope.row.hrSignature }}</span>
                </template>
            </el-table-column>

            <el-table-column width="170" align="center" label="加入日期">
                <template slot-scope="scope">
                    <span>{{ scope.row.createdTime }}</span>
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
import { getHrList } from '@/api/company';
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

export default {
    name: "HRList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                交易成功: "success",
                支付失败: "danger",
                已删除: "info",
                隐藏: "gray",
            };
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

            gray: "gray",
            blank: " "
        };
    },
    created() {
        this.getList();
    },
    methods: {
        showTags(hrTagsStr) {
            // debugger;
            if (hrTagsStr == null || hrTagsStr == undefined || hrTagsStr == "") {
                return "";
            }
            var arr = hrTagsStr.split(",");
            var hrTagsArr = [];
            for (var i = 0 ; i < arr.length ; i ++) {
                if (arr[i] != null && arr[i] != "" && arr[i] != undefined) {
                    hrTagsArr.push(arr[i]);
                }
            }
            return hrTagsArr;
        },

        getList() {
            this.listLoading = true;
            getHrList(this.listQuery).then(response => {
                console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },
        
        getList2() {
            this.listLoading = false;
            // this.list = response.data.items
            this.total = 50;

            var hrList = {
                hrId: "190718DYXWAND8H0",
                hrName: "风间影月",        
                face: "http://www.itzixi.com/img/arrow.png",        
                jobTitle: "人力资源总监",
                tags: ["行业大牛", "老板本人", "团队建设", "完美主义", "激情澎湃", "游戏宅", "亲和力", "团队负责人", "资深HR", "绩效管理"],
                signature: "深耕互联网技术岗位招聘，快到碗里来吧~",     // 对话人才（个人签名）
                joinTime: "2021-12-14",      // 加入公司成为HR的时间
            };

            var arr = []; 
            arr.length = 20;
            arr.fill(hrList)
            // arr.push(articleList);
            this.list = arr;
            console.log(this.list);
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
