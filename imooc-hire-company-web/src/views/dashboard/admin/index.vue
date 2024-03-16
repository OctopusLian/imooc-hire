<template>
    <div class="dashboard-editor-container">
        <div v-if="isVip" style="padding: 20px">
            <el-row style="background: #fff; padding: 10px; margin-bottom: 32px">
                <map-chart :chart-data="mapData" />
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
        </div>

        <div v-if="!isVip" style="padding-bottom: 20px;">
            <div class="vip bg-vip" :style="{backgroundImage: 'url(' + bigBG + ')'}">
                <p class="main-title">
                    超级会员专享服务，招聘快人一步
                </p>
                <div class="go-buy-btn">
                    <div class="go-buy-btn-box">
                        <router-link :to="'/orders/vip/'">
                            <p class="center-button-base center-button-light-golden center-button-golden">开通VIP特权</p>
                        </router-link>
                        <!-- <img :src="require('@/assets' + logo)"/> -->
                        <!-- <img :src="require('@/assets' + chartIcon)"/> -->
                        <!-- <img :src="img"/> -->
                    </div>
                </div>
                <div class="main-box-items-area">
                    <div>
                        <div class="five-items-wrapper" style="">
                            
                            <div class="item-box">
                                <div class="box-card-wrapper" style="">
                                    <div class="single-item my-box-card">
                                        <div class="item-body-background"></div>
                                        <div class="item-every-body">
                                            <div class="item-title" style="font-weight: bold;">
                                                图表分析
                                            </div>
                                            <div class="item-sub-title" style="">
                                                行业分析，图表展示
                                            </div>
                                            
                                            <div class="single-icon-show icon-charts" :style="{backgroundImage: 'url(' + chartIcon + ')'}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item-box">
                                <div class="box-card-wrapper" style="">
                                    <div class="single-item my-box-card">
                                        <div class="item-body-background"></div>
                                        <div class="item-every-body">
                                            <div class="item-title" style="font-weight: bold;">
                                                候选人管理
                                            </div>
                                            <div class="item-sub-title" style="">
                                                无限制查看候选人
                                            </div>
                                            <div class="single-icon-show icon-charts" :style="{backgroundImage: 'url(' + candidateIcon + ')'}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item-box">
                                <div class="box-card-wrapper" style="">
                                    <div class="single-item my-box-card">
                                        <div class="item-body-background"></div>
                                        <div class="item-every-body">
                                            <div class="item-title" style="font-weight: bold;">
                                                职位管理
                                            </div>
                                            <div class="item-sub-title" style="">
                                                无限制查看职位
                                            </div>
                                            <div class="single-icon-show icon-charts" :style="{backgroundImage: 'url(' + positionIcon + ')'}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item-box">
                                <div class="box-card-wrapper" style="">
                                    <div class="single-item my-box-card">
                                        <div class="item-body-background"></div>
                                        <div class="item-every-body">
                                            <div class="item-title" style="font-weight: bold;">
                                                报表下载
                                            </div>
                                            <div class="item-sub-title" style="">
                                                候选人、职位Excel下载
                                            </div>
                                            <div class="single-icon-show icon-charts" :style="{backgroundImage: 'url(' + excelIcon + ')'}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item-box">
                                <div class="box-card-wrapper" style="">
                                    <div class="single-item my-box-card">
                                        <div class="item-body-background"></div>
                                        <div class="item-every-body">
                                            <div class="item-title" style="font-weight: bold;">
                                                简历下载
                                            </div>
                                            <div class="item-sub-title" style="">
                                                无限制任意下载简历
                                            </div>
                                            <div class="single-icon-show icon-charts" :style="{backgroundImage: 'url(' + downloadIcon + ')'}"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="more-vip" style="">
                更多会员特色权益
            </div>

            <div class="more-wrapper bottom-items" style="width: 100%;">
                <div class="five-bottom-items" style="width: 1130px;">

                    <div class="single-bottom-item" style="width: 192px;">
                        <div class="more-item">
                            <img class="" :src="customServiceIcon"/>
                        </div>
                        <div class="more-item more-item-main-title">全天候客服</div>
                        <div class="more-item more-item-sub-title">7x24随时为您服务</div>
                    </div>
                    
                    <div class="single-bottom-item" style="width: 192px;">
                        <div class="more-item">
                            <img class="" :src="personnelServiceIcon"/>
                        </div>
                        <div class="more-item more-item-main-title">人才推荐</div>
                        <div class="more-item more-item-sub-title">为您推选更优质的候选人</div>
                    </div>

                    <div class="single-bottom-item" style="width: 192px;">
                        <div class="more-item">
                            <img class="" :src="customMakeIcon"/>
                        </div>
                        <div class="more-item more-item-main-title">企业定制</div>
                        <div class="more-item more-item-sub-title">专属贵公司的特权服务</div>
                    </div>

                    <div class="single-bottom-item" style="width: 192px;">
                        <div class="more-item">
                            <img class="" :src="bigDataIcon"/>
                        </div>
                        <div class="more-item more-item-main-title">大数据分析</div>
                        <div class="more-item more-item-sub-title">招聘趋势图表分析</div>
                    </div>

                    <div class="single-bottom-item" style="width: 192px;">
                        <div class="more-item">
                            <img class="" :src="teach1v1Icon"/>
                        </div>
                        <div class="more-item more-item-main-title">一对一指导</div>
                        <div class="more-item more-item-sub-title">帮助企业解决招聘难题</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { isVip } from '@/api/company';
import PanelGroup from "./components/PanelGroup";
import LineChart from "./components/LineChart";
import MapChart from "./components/MapChart";
import RaddarChart from "./components/RaddarChart";
import PieChart from "./components/PieChart";
import BarChart from "./components/BarChart";

const countsData = {
    newUsers: [100, 120, 161, 134, 105, 160, 165],
    newHRs: [120, 82, 91, 154, 162, 140, 145],
    newCompanies: [33, 122, 291, 254, 182, 140, 145],
    successCandidates: [44, 182, 191, 54, 62, 60, 185],
};

const mapData = [
    { name: "北京", value: 1000 },
    { name: "天津", value: 596 },
    { name: "上海", value: 102 },
    { name: "重庆", value: 6320 },
    { name: "河北", value: 2000 },
    { name: "河南", value: 11057 },
    { name: "云南", value: 23987 },
    { name: "辽宁", value: 1111 },
    { name: "黑龙江", value: 15687 },
    { name: "湖南", value: 8693 },
    { name: "安徽", value: 9631 },
    { name: "山东", value: 12143 },
    { name: "新疆", value: 6354 },
    { name: "江苏", value: 1111 },
    { name: "浙江", value: 5987 },
    { name: "江西", value: 4214 },
    { name: "湖北", value: 2222 },
    { name: "广西", value: 3621 },
    { name: "甘肃", value: 1047 },
    { name: "山西", value: 300 },
    { name: "内蒙古", value: 1111 },
    { name: "陕西", value: 489 },
    { name: "吉林", value: 600 },
    { name: "福建", value: 607895 },
    { name: "贵州", value: 708 },
    { name: "广东", value: 63214 },
    { name: "青海", value: 96874 },
    { name: "西藏", value: 120147 },
    { name: "四川", value: 1010102 },
    { name: "宁夏", value: 32104 },
    { name: "海南", value: 15978 },
    { name: "台湾", value: 1111 },
    { name: "香港", value: 26874 },
    { name: "澳门", value: 879631 },
];

export default {
    name: "DashboardAdmin",
    components: {
        PanelGroup,
        LineChart,
        MapChart,
        RaddarChart,
        PieChart,
        BarChart,
    },
    data() {
        return {
            // isVip: 1, // 1: 是VIP，企业付费。0: 不是VIP
            isVip: false,

            countsData: countsData,
            mapData: mapData,

            bigBG: require('@/assets/static/vip/bigBG.png'),
            chartIcon: require('@/assets/static/vip/chart.png'),
            candidateIcon: require('@/assets/static/vip/candidate.png'),
            positionIcon: require('@/assets/static/vip/position.png'),
            excelIcon: require('@/assets/static/vip/excel.png'),
            downloadIcon: require('@/assets/static/vip/download.png'),
            
            customServiceIcon: require('@/assets/static/vip/custom-service.png'),
            personnelServiceIcon: require('@/assets/static/vip/personnel-service.png'),
            customMakeIcon: require('@/assets/static/vip/custom-make.png'),
            bigDataIcon: require('@/assets/static/vip/big-data.png'),
            teach1v1Icon: require('@/assets/static/vip/1v1teach.png'),

            leftArrowIcon: require('@/assets/static/vip/left-arrow.png'),
            rightArrowIcon: require('@/assets/static/vip/right-arrow.png'),
        };
    },
    created() {
        this.queryMyCompanyIsVip();
    },
    methods: {
        queryMyCompanyIsVip() {
            isVip().then(response => {
                console.log(response);
                var isVip = response.data;
                this.isVip = isVip;
            })
        },

        handleSetLineChartData(type) {
            // this.lineChartData = lineChartData[type];
            this.countsData = countsData;
        },
    },
};
</script>

<style lang="scss" scoped>
.five-bottom-items {
    display: flex; 
    flex-direction: row;
    justify-content: space-between;
}

.single-bottom-item {
    padding: 20px 8px;
}

.single-bottom-item:hover {
    // box-shadow: 1px 1px 1px 2px #e8e8e8;
    border-radius: 3px;
    -webkit-box-shadow: #999898 0px 0px 4px; 
    -moz-box-shadow: #999898 0px 0px 4px; 
    box-shadow: #999898 0px 0px 4px;
}

.more-item {
    display: flex; 
    flex-direction: row;
    justify-content: center;
}

.more-item-main-title {
    height: 18px;
    font-size: 18px;
    margin-top: 23px;
    margin-bottom: 9px;
    text-align: center;
    line-height: 18px;
    color: #0e0517;
}

.more-item-sub-title {
    height: 20px;
    font-size: 14px;
    text-align: center;
    color: #b2b2b2;
    line-height: 20px;
    color: #999;
}

.more-wrapper {
    display: flex; 
    flex-direction: row;
    justify-content: center;
    margin-top: 30px;
}

.more-vip {
    margin-top: 50px; 
    font-size: 25px; 
    display: flex; 
    flex-direction: row;
    justify-content: center;
}

.vip {
    position: relative;
    height: 455px;
    width: 100%;
    overflow: hidden;
}

.bg-vip {
    background-color: #160b03;
    background-position: center center;
    background-repeat: no-repeat;
}

.box-card-wrapper {
    position: relative;
    height: 220px;
    .my-box-card {
        // width: 100%;
        height: 100%;
        transition: all 0.2s linear;
        &:hover {
            transform: translateY(-10px);
            filter: contrast(130%);
            .item-title {
                color: #b99141; 
            }
            .item-sub-title {
                color: #b99141; 
            }
            .item-body-background {
                box-shadow:2px 2px 18px #d7b808;
            }
        }
    }
}

.item-body-background {
    width: 200px;
    height: 100%;
    overflow: hidden;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    position: absolute;
    top: 0;
    background-color: #fff;
    opacity: .95;
    filter: alpha(Opacity=95);
}

.item-title {
    height: 20px;
    font-size: 20px;
    margin-top: 40px;
    margin-bottom: 15px;
    text-align: center;
}

.item-sub-title {
    height: 14px;
    font-size: 14px;
    text-align: center;
}

.main-title {
    position: absolute;
    width: 100%;
    font-size: 30px;
    top: 35px;
    text-align: center;
    color: #f9d681;
}

.go-buy-btn {
    position: absolute;
    width: 100%;
    top: 150px;
    text-align: center;
}

.go-buy-btn-box {
    display: inline-block;
    *display: inline;
    *zoom: 1;
}

.center-button-golden {
    width: 185px;
    height: 50px;
    font-size: 20px;
    line-height: 50px;
    text-align: center;
    border-radius: 25px;
}

.center-button-light-golden {
    border: 1px solid #f9d681;
    background-color: #f9d681;
    color: #351d06;
}

.center-button-light-golden:hover {
    border: 1px solid #f9d681;
    background-color: #e6c579;
    color: #351d06;
}

.center-button-base {
    cursor: pointer;
    display: inline-block;
    *display: inline;
    margin: 0 5px;
    *zoom: 1;
}

.main-box-items-area {
    position: absolute;
    left: 50%;
    margin-left: -565px;
    top: 249px;    
}

.five-items-wrapper {
    width: 1130px;
    height: 226px;

    display: flex;
    flex-direction: row;
    justify-content: flex-start;
}

.item-box {
    margin-top: 10px;
    float: left;
}

.single-item {
    width: 200px;
    height: 226px;
    margin: 0 13px;
    position: relative;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    cursor: pointer;
}



.item-every-body {
    width: 200px;
    height: 100%;
    position: absolute;
}



.single-icon-show {
    position: absolute;
    left: 50%;
    bottom: 50px;
    margin-left: -30px;
    width: 80px;
    height: 70px;
}

.icon-charts {
    background-repeat: no-repeat;
}

.item-title {
    height: 18px;
    font-size: 18px;
    margin-top: 23px;
    margin-bottom: 9px;
    text-align: center;
    line-height: 18px;
    color: #0e0517;
}

.item-sub-title {
    height: 20px;
    font-size: 14px;
    text-align: center;
    color: #b2b2b2;
    line-height: 20px;
    color: #999;
}


.dashboard-editor-container {
    // padding: 32px;
    // background-color: rgb(240, 242, 245);
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
