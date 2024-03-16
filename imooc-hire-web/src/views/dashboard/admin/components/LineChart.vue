<template>
    <div :class="className" :style="{ height: height, width: width }" />
</template>

<script>
import echarts from "echarts";
require("echarts/theme/macarons"); // echarts theme

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
            default: "400px",
        },
        autoResize: {
            type: Boolean,
            default: true,
        },
        chartData: {
            type: Object,
            required: true,
        },
    },
    data() {
        return {
            chart: null,
        };
    },
    watch: {
        chartData: {
            deep: true,
            handler(val) {
                this.setOptions(val);
            },
        },
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
            this.setOptions(this.chartData);
        },
        setOptions({ newUsers, newHRs, newCompanies, successCandidates } = {}) {
            this.chart.setOption({
                // title: {
                //     text: "一周人数统计",
                //     textStyle: {
                //         color: "#08cd6a",
                //         fontWeight: "bolder",
                //         lineHeight: "8"
                //     } 
                // },
                title: {  
                    text: '一周数据统计',  
                    subtext: '',  
                    x:'center',
                    textStyle: {
                        fontWeight: "bolder",
                        height: "1000"
                    } 
                }, 
                xAxis: {
                    data: ["2-22", "2-23", "2-24", "2-25", "2-26", "2-27", "2-28"],
                    boundaryGap: false,     // 坐标轴两边是否留白
                    axisTick: {
                        show: false,
                    },
                },
                grid: {         // 图片的位置
                    left: 10,
                    right: 10,
                    bottom: 20,
                    top: 65,
                    containLabel: true,
                },
                tooltip: {      // 鼠标移动提示框
                    trigger: "axis",
                    axisPointer: {
                        type: "cross",
                    },
                    padding: [5, 10],
                },
                yAxis: {        // y轴设置
                    axisTick: {
                        show: false,
                    },
                },
                legend: {
                    data: ["用户数", "HR人数", "企业数", "成功入职数"],
                    top: "35"
                },
                series: [
                    {
                        name: "用户数",
                        smooth: true,
                        type: "line",
                        itemStyle: {
                            normal: {
                                color: "#40c9c6",
                                lineStyle: {
                                    color: "#40c9c6",
                                    width: 2,
                                },
                                areaStyle: {
                                    color: "#e5f8f8",
                                },
                            },
                        },
                        data: newUsers,
                        animationDuration: 2000,
                        animationEasing: "cubicInOut",
                        // https://echarts.apache.org/examples/zh/editor.html?c=line-easing 动画效果
                    },
                    {
                        name: "HR人数",
                        smooth: true,
                        type: "line",
                        itemStyle: {
                            normal: {
                                color: "#36a3f7",
                                lineStyle: {
                                    color: "#36a3f7",
                                    width: 2,
                                },
                                areaStyle: {
                                    color: "#cbe0f0",
                                },
                            },
                        },
                        data: newHRs,
                        animationDuration: 2000,
                        animationEasing: "quadraticOut",
                    },
                    {
                        name: "企业数",
                        smooth: true,
                        type: "line",
                        itemStyle: {
                            normal: {
                                color: "#f4516c",
                                lineStyle: {
                                    color: "#f4516c",
                                    width: 2,
                                },
                                areaStyle: {
                                    color: "#f1d5da",
                                },
                            },
                        },
                        data: newCompanies,
                        animationDuration: 2000,
                        animationEasing: "sinusoidalIn",
                    },
                    {
                        name: "成功入职数",
                        smooth: true,
                        type: "line",
                        itemStyle: {
                            normal: {
                                color: "#eea70d",
                                lineStyle: {
                                    color: "#eea70d",
                                    width: 2,
                                },
                                areaStyle: {
                                    color: "#f1e8d4",
                                },
                            },
                        },
                        data: successCandidates,
                        animationDuration: 2000,
                        animationEasing: "quadraticInOut",
                    },
                ],
            });
        },
    },
};
</script>
