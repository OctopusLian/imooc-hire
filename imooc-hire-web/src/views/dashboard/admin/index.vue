<template>
    <div class="dashboard-editor-container">
        <!-- <github-corner class="github-corner" /> -->

        <panel-group @handleSetLineChartData="handleSetLineChartData" />

        <el-row style="background: #fff; padding: 16px 16px 0; margin-bottom: 32px">
            <line-chart :chart-data="countsData"/>
        </el-row>

        <el-row style="background: #fff; padding: 16px 16px 0; margin-bottom: 32px">
            <map-chart :chart-data="mapData"/>
        </el-row>
        

        <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="8">
                <div class="chart-wrapper">
                    <raddar-chart />
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
                <div class="chart-wrapper">
                    <pie-chart />
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
                <div class="chart-wrapper">
                    <bar-chart />
                </div>
            </el-col>
        </el-row>

        <!-- <el-row :gutter="8">
            <el-col
                :xs="{ span: 24 }"
                :sm="{ span: 24 }"
                :md="{ span: 24 }"
                :lg="{ span: 12 }"
                :xl="{ span: 12 }"
                style="padding-right: 8px; margin-bottom: 30px"
            >
                <transaction-table />
            </el-col>
            <el-col
                :xs="{ span: 24 }"
                :sm="{ span: 12 }"
                :md="{ span: 12 }"
                :lg="{ span: 6 }"
                :xl="{ span: 6 }"
                style="margin-bottom: 30px"
            >
                <todo-list />
            </el-col>
            <el-col
                :xs="{ span: 24 }"
                :sm="{ span: 12 }"
                :md="{ span: 12 }"
                :lg="{ span: 6 }"
                :xl="{ span: 6 }"
                style="margin-bottom: 30px"
            >
                <box-card />
            </el-col>
        </el-row> -->
    </div>
</template>

<script>
// import GithubCorner from '@/components/GithubCorner'
import PanelGroup from "./components/PanelGroup";
import LineChart from "./components/LineChart";
import MapChart from "./components/MapChart";
import RaddarChart from "./components/RaddarChart";
import PieChart from "./components/PieChart";
import BarChart from "./components/BarChart";
// import TransactionTable from './components/TransactionTable'
// import TodoList from './components/TodoList'
// import BoxCard from './components/BoxCard'

const lineChartData = {
    newUsers: {
        expectedData: [100, 120, 161, 134, 105, 160, 165],
        actualData: [120, 82, 91, 154, 162, 140, 145],
    },
    newHRs: {
        expectedData: [200, 192, 120, 144, 160, 130, 140],
        actualData: [180, 160, 151, 106, 145, 150, 130],
    },
    newCompanies: {
        expectedData: [80, 100, 121, 104, 105, 90, 100],
        actualData: [120, 90, 100, 138, 142, 130, 130],
    },
    successCandidates: {
        expectedData: [130, 140, 141, 142, 145, 150, 160],
        actualData: [120, 82, 91, 154, 162, 140, 130],
    },
};

const countsData = {
    newUsers: [100, 120, 161, 134, 105, 160, 165],
    newHRs: [120, 82, 91, 154, 162, 140, 145],
    newCompanies: [33, 122, 291, 254, 182, 140, 145],
    successCandidates: [44, 182, 191, 54, 62, 60, 185],
};

const mapData = [ 
    {name: '北京',value: 1000 },{name: '天津',value: 596 },  
    {name: '上海',value: 102 },{name: '重庆',value: 6320 },  
    {name: '河北',value: 2000 },{name: '河南',value: 11057 },  
    {name: '云南',value: 23987 },{name: '辽宁',value: 1111 },  
    {name: '黑龙江',value: 15687 },{name: '湖南',value: 8693 },  
    {name: '安徽',value: 9631 },{name: '山东',value: 12143 },  
    {name: '新疆',value: 6354 },{name: '江苏',value: 1111 },  
    {name: '浙江',value: 5987 },{name: '江西',value: 4214 },  
    {name: '湖北',value: 2222 },{name: '广西',value: 3621 },  
    {name: '甘肃',value: 1047 },{name: '山西',value: 300 },  
    {name: '内蒙古',value: 1111 },{name: '陕西',value: 489 },  
    {name: '吉林',value: 600 },{name: '福建',value: 607895 },  
    {name: '贵州',value: 708 },{name: '广东',value: 63214 },  
    {name: '青海',value: 96874 },{name: '西藏',value: 120147 },  
    {name: '四川',value: 1010102 },{name: '宁夏',value: 32104 },  
    {name: '海南',value: 15978 },{name: '台湾',value: 1111 },  
    {name: '香港',value: 26874 },{name: '澳门',value: 879631 }
];

export default {
    name: "DashboardAdmin",
    components: {
        // GithubCorner,
        PanelGroup,
        LineChart,
        MapChart,
        RaddarChart,
        PieChart,
        BarChart,
        // TransactionTable,
        // TodoList,
        // BoxCard
    },
    data() {
        return {
            // lineChartData: lineChartData.newUsers,
            countsData: countsData,
            mapData: mapData,
        };
    },
    methods: {
        handleSetLineChartData(type) {
            // this.lineChartData = lineChartData[type];
            this.countsData = countsData;
        },

        
    },
};
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
    padding: 32px;
    background-color: rgb(240, 242, 245);
    position: relative;

    .github-corner {
        position: absolute;
        top: 0px;
        border: 0;
        right: 0;
    }

    .chart-wrapper {
        background: #fff;
        padding: 16px 16px 0;
        margin-bottom: 32px;
    }
}

@media (max-width: 1024px) {
    .chart-wrapper {
        padding: 8px;
    }
}
</style>
