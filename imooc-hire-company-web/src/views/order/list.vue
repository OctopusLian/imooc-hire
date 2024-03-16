<template>
    <div class="app-container">
        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="订单编号" min-width="220">
                <template slot-scope="scope">
                    <span>{{ scope.row.id }}</span>
                </template>
            </el-table-column>

            <el-table-column width="120" align="center" label="商品价格">
                <template slot-scope="scope">
                    <span>{{ changeToYuan(scope.row.totalAmount) }}元</span>
                </template>
            </el-table-column>

            <el-table-column width="120" align="center" label="实付金额">
                <template slot-scope="scope">
                    <span>{{ changeToYuan(scope.row.realPayAmount) }}元</span>
                </template>
            </el-table-column>

            <el-table-column min-width="260" align="center" label="商品名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.itemName }}</span>
                </template>
            </el-table-column>

            <el-table-column class-name="status-col" align="center" label="订单状态" width="120">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{ row.status == 10 ? "待付款" : "" }}
                        {{ row.status == 40 ? "交易成功" : "" }}
                        {{ row.status == 50 ? "交易关闭" : "" }}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="220" align="center" label="交易时间">
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
import { getOrderList } from "@/api/wxpay";
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination

export default {
    name: "orderList",
    components: { Pagination },
    filters: {
        statusFilter(status) {
            const statusMap = {
                10: "warning",
                20: "danger",
                30: "gray",
                40: "success",
                50: "info",
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
        };
    },
    created() {
        this.getList();
    },
    methods: {
        changeToYuan(amount) {
            return (amount/100).toFixed(2);
        },

        getList() {
            this.listLoading = true;
            getOrderList(this.listQuery).then(response => {
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

            var orderList = {
                orderId: "190718DYXWAND8H0",
                itemPrice: "99",        // 商品标价
                dealPrice: "99",        // 实付金额
                itemName: "VIP充值超级会员(默认时效-1个月)",
                orderStatus: "交易成功",
                createTime: "2021-12-14 18:00:29",      // 消费时间（生效时间）
                expireTime: "2021-12-14 18:00:29",      // VIP失效时间
            };

            // var articleList = {
            //     articleId: "1001",
            //     publishTime: new Date(),
            //     author: "风间影月",
            //     status: "已删除",
            //     readCounts: 11930,
            //     title: "这是文章标题",
            // };
            var arr = []; 
            arr.length = 20;
            arr.fill(orderList)
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
</style>
