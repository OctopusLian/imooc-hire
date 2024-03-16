<template>
    <div :class="className" :style="{ height: height, width: width }" />
</template>

<script>
import echarts from "echarts";
require("echarts/theme/macarons"); // echarts theme

const animationDuration = 3000;

export default {
    props: {
        className: {
            type: String,
            default: "chart",
        },
        width: {
            type: String,
            default: "100%",
        },
        height: {
            type: String,
            default: "300px",
        },
    },
    data() {
        return {
            chart: null,
        };
    },
    mounted() {
        this.$nextTick(() => {
            this.initChart();
        });
    },
    beforeDestroy() {
        if (!this.chart) {
            return;
        }
        this.chart.dispose();
        this.chart = null;
    },
    methods: {
        initChart() {
            this.chart = echarts.init(this.$el, "macarons");

            this.chart.setOption({
                title: {
                    text: '头部行业年度从业人数统计',  
                    subtext: '',  
                    x:'center',
                    textStyle: {
                        fontWeight: "bolder",
                        height: "1000"
                    } 
                },
                tooltip: {
                    trigger: 'item',
                },
                radar: {
                    center: ['50%', '50%'],
                    radius: 90,
                    indicator: [    // 拿到最大的数据，和最小的数据，做一个区间，这样雷达图可以显示的比较完整
                        { text: 'IT互联网', min:50, max: 400 },
                        { text: '金融证券', min:50, max: 400 },
                        { text: '医疗制药', min:50, max: 400 },
                        { text: '教育培训', min:50, max: 400 },
                        { text: '电子通信', min:50, max: 400 },
                        { text: '影视媒体', min:50, max: 400 },
                    ]
                },
                legend: {
                    type: 'scroll',
                    bottom: 10,
                    data: (function () {
                        var list = [];
                        for (var i = 1; i <= 28; i++) {
                            list.push(i + 2000 + '');
                        }
                    return list;
                    })()
                    // left: "center",
                    // bottom: "10",
                    // data: [
                    //     "Allocated Budget",
                    //     "Expected Spending",
                    //     "Actual Spending",
                    // ],
                },
                visualMap: {
                    min: 30,
                    max: 500,	    // 拿到最大的数据，和最小的数据，做一个区间，这样雷达图可以显示的比较完整
                    text: ['High', 'Low'],
                    top: 'middle',
                    right: -5,
                    // color: ['#009ad6', '#fcaf17'],
                    // color: ['#f58220', 'yellow', 'lightskyblue'],
                    color: ['#b6a2de', '#2dc7c9'],
                    // color: ['red', 'yellow'],
                    // color: ['lightblue', 'blue'],
                    calculable: true
                },
                // animationDuration: animationDuration,
                series: (function () {
                    var series = [];
                    for (var i = 1; i <= 28; i++) {
                    series.push({
                        type: 'radar',
                        symbol: 'none',
                        lineStyle: {
                            width: 1
                        },
                        emphasis: {
                            areaStyle: {
                                color: 'rgba(0,250,0,0.3)'
                            }
                        },
                        data: [
                            {
                                value: [
                                    (40 - i) * 10,
                                    (38 - i) * 4 + 60,
                                    i * 5 + 10,
                                    i * 9,
                                    (i * i) / 2,
                                    i * (i-1)/2,
                                ],
                                name: i + 2000 + ''
                            }
                        ],
                        animationEasing: "cubicInOut",
                        animationDuration: 1500,
                    });
                    }
                    return series;
                })()
            });
        },

        initChart2() {
            this.chart = echarts.init(this.$el, "macarons");

            this.chart.setOption({
                tooltip: {
                    trigger: "axis",
                    axisPointer: {
                        // 坐标轴指示器，坐标轴触发有效
                        type: "shadow", // 默认为直线，可选为：'line' | 'shadow'
                    },
                },
                radar: {
                    radius: "66%",
                    center: ["50%", "42%"],
                    splitNumber: 8,
                    splitArea: {
                        areaStyle: {
                            color: "rgba(127,95,132,.3)",
                            opacity: 1,
                            shadowBlur: 45,
                            shadowColor: "rgba(0,0,0,.5)",
                            shadowOffsetX: 0,
                            shadowOffsetY: 15,
                        },
                    },
                    indicator: [
                        { name: "Sales", max: 10000 },
                        { name: "Administration", max: 20000 },
                        { name: "Information Technology", max: 20000 },
                        { name: "Customer Support", max: 20000 },
                        { name: "Development", max: 20000 },
                        { name: "Marketing", max: 20000 },
                    ],
                },
                legend: {
                    left: "center",
                    bottom: "10",
                    data: [
                        "Allocated Budget",
                        "Expected Spending",
                        "Actual Spending",
                    ],
                },
                series: [
                    {
                        type: "radar",
                        symbolSize: 0,
                        areaStyle: {
                            normal: {
                                shadowBlur: 13,
                                shadowColor: "rgba(0,0,0,.2)",
                                shadowOffsetX: 0,
                                shadowOffsetY: 10,
                                opacity: 1,
                            },
                        },
                        data: [
                            {
                                value: [5000, 7000, 12000, 11000, 15000, 14000],
                                name: "Allocated Budget",
                            },
                            {
                                value: [4000, 9000, 15000, 15000, 13000, 11000],
                                name: "Expected Spending",
                            },
                            {
                                value: [
                                    5500, 11000, 12000, 15000, 12000, 12000,
                                ],
                                name: "Actual Spending",
                            },
                        ],
                        animationDuration: animationDuration,
                    },
                ],
            });
        },
    },
};
</script>
