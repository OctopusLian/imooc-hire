<template>
    <div :class="className" :style="{ height: height, width: width }" />
</template>

<script>
import echarts from "echarts";
require("echarts/theme/macarons"); // echarts theme
require("echarts/map/js/china");

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
            default: "600px",
        },
        autoResize: {
            type: Boolean,
            default: true,
        },
        chartData: {
            type: Array,
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
            // this.setOptions();
            this.setOptions(this.chartData);
        },

        // 根据不同地域程序员的数量，在地图上展示
        setOptions(chartData) {
            
            this.chart.setOption({
                backgroundColor: '#FFFFFF',  
                title: {  
                    text: '全国城市程序员数据统计',  
                    subtext: '',  
                    x:'center',
                    textStyle: {
                        fontWeight: "bolder",
                    } 
                }, 
                tooltip : {  
                    trigger: 'item'  
                },  
                visualMap: {
                    min: 1,
                    max: 100000,	// 粉丝数范围，可以自定义
                    text: ['High', 'Low'],
                    realtime: false,
                    calculable: true,
                    inRange: {
                        color: ['lightskyblue', 'yellow', 'orangered']
                    }
                    // inRange: {
                    //     color: ['#5475f5', '#9feaa5', '#85daef','#74e2ca', '#e6ac53', '#9fb5ea'] 
                    // }
                },
                //配置属性
                series: [{  
                    name: '数据',  
                    type: 'map',  
                    mapType: 'china',   
                    roam: true,  
                    label: {  
                        normal: {  
                            show: true  //省份名称  
                        },  
                        emphasis: {  
                            show: false  
                        }  
                    },  
                    data: chartData  //数据
                }]
            });
        },
    },
};
</script>
