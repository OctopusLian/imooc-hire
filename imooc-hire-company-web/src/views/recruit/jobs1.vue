<template>
    <div class="app-container">
        <el-button :loading="downloadLoading" type="primary" @click="exportHandler">导出</el-button>
    </div>
</template>

<script>
import { outExportExcel } from '@/utils/excel';
export default {
    name: "jobsLista222",
    components: { outExportExcel },
    data() {
        return {
            downloadLoading:false,
            filename: 'aaa', // xlsx文件名称
            autoWidth: true, //宽度自适应
            bookType: 'xlsx', // 要导出的文件
            list:[{zone_name:'吊袜带哇',type_name:'带娃',cate_name:'的味道',name:'的无法',status:'得我',price:'111.00'}] // 到导出的列表数据
        };
    },
    created() {
    },
    methods: {

        exportHandler() {
            // const { tableData } = this;
            // const tableHeader = ['学号', '姓名', '语文成绩'];
            // const tableKey = ['number', 'name', 'grade'];

            const tHeader = ['分为', '分为0']
            const filterVal = ['zone_name', 'type_name']
            const list = this.list

            // 这里是业务逻辑
            outExportExcel(tHeader, filterVal, list);
        },

        exportHandler2() {
                this.downloadLoading = true
                import('@/components/vendor/Export2Excel').then(excel => {
                // import('../../utils/Export2Excel').then(excel => {
                    const tHeader = ['分为', '分为', 'GRE', 'GRE', 'GRE', 'GRE']
                    const filterVal = ['zone_name', 'type_name', 'cate_name', 'name', 'status', 'price']

                    const data = this.formatJson(filterVal, this.list)
                    // var data = this.list;
                    console.log(data)
                    // excel.export_json_to_excel({
                    //     header: tHeader,
                    //     data,
                    //     filename: this.filename,
                    //     autoWidth: this.autoWidth,
                    //     bookType: this.bookType
                    // })
                    excel.export_json_to_excel(tHeader,data,"归集明细")
                    this.downloadLoading = false
                })
            },
            /*
            * 将对象数组格式化为二维数据，例如：[{id:1,number:111},{id:2,number:222}] 转换为 [[1,111],[2,222]]
            * */
            formatJson(filterVal, tableData) {
                return tableData.map(v => {
                    return filterVal.map(j => {
                        return v[j]
                    })
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
