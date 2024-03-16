<template>
    <div :class="className" :style="{ height: height, width: width }" />
</template>

<script>
import echarts from "echarts";
require("echarts/theme/macarons"); // echarts theme

const animationDuration = 2200;

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
                    text: '每日简历投递数统计',  
                    subtext: '',  
                    x:'center',
                    textStyle: {
                        fontWeight: "bolder",
                        height: "1000"
                    } 
                },
                tooltip: {
                    trigger: "axis",
                    axisPointer: {
                        // 坐标轴指示器，坐标轴触发有效
                        type: "shadow", // 默认为直线，可选为：'line' | 'shadow'
                    },
                },
                grid: {
                    top: 32,
                    left: "2%",
                    right: "2%",
                    bottom: "10",
                    containLabel: true,
                },
                xAxis: [
                    {
                        type: "category",
                        data: ["2-22", "2-23", "2-24", "2-25", "2-26", "2-27", "2-28"],
                        axisTick: {
                            alignWithLabel: true,
                        },
                    },
                ],
                yAxis: [
                    {
                        type: "value",
                        axisTick: {
                            show: false,
                        },
                    },
                ],
                series: [
                    {
                        name: "男性",
                        type: "bar",
                        stack: "vistors",
                        barWidth: "60%",
                        data: [100, 80, 60, 120, 110, 50, 75],
                        animationDuration,
                    },
                    {
                        name: "女性",
                        type: "bar",
                        stack: "vistors",
                        barWidth: "60%",
                        data: [80, 30, 50, 100, 69, 80, 60],
                        animationDuration,
                    },
                ],
            });
        },
    },
};
</script>
