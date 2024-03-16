
// 导出的方法  tHeader => 设置Excel的表格第一行的标题  filterVal => 对象的属性key值 被导出listData => 导出数据  => 导出(文件)名称

export function outExportExcel(tHeader = [], filterVal = [], listData = [], exportName = new Date().getTime()) {
    require.ensure([], () => {
        // 注意这个Export2Excel路径
        const { export_json_to_excel } = require('@/components/vendor/Export2Excel');
        const data = formatJson(filterVal, listData);
        console.log(data);
        // export_json_to_excel(tHeader, data, exportName);

        export_json_to_excel({
            multiHeader: [],
            header: tHeader,
            data: data,
            filename: "aaa",
            merges: [],
            autoWidth: true,
            bookType: 'xlsx'
        });

    });
}

function formatJson(filterVal, jsonData) {
    return jsonData.map(v => filterVal.map(j => v[j]))
}
