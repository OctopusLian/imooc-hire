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
                    text: 'IT互联网男女比例统计',  
                    subtext: '',  
                    x:'center',
                    textStyle: {
                        fontWeight: "bolder",
                        height: "1000"
                    } 
                },
                tooltip: {
                    trigger: "item",
                    formatter: "{a} <br/>{b} : {c} ({d}%)",
                },
                legend: {
                    left: "center",
                    bottom: "10",
                    data: [
                        "男",
                        "女",
                    ],
                },
                series: [
                    {
                        name: "男女比例饼状图",
                        type: "pie",
                        roseType: "radius",
                        radius: [15, 95],
                        center: ["50%", "50%"],
                        data: [
                            { value: 12300, name: "男" },
                            { value: 6869, name: "女" },
                        ],
                        animationEasing: "cubicInOut",
                        animationDuration: 2200,
                    },
                ],
            });
        },
    },
};
</script>
