<template>
    <div class="pay-container">

        <div class="big-title" style="">
            VIP 权益对比
        </div>
        
        <div id="" class="content-wrapper" style="">

            <ul id="" class="left-wrapper page-words">
                <li id="" class="title-wrapper">
                    <div id="" class="title-item">
                        <span id="" class="">功能特权</span>
                    </div>
                </li>
                <li id="" class="every-item" style="background: #f9fdf9">图表分析</li>
                <li id="" class="every-item" style="background: #fff">查看候选人</li>
                <li id="" class="every-item" style="background: #f9fdf9">职位管理</li>

                <li id="" class="every-item" style="background: ">报表下载</li>
                <li id="" class="every-item" style="background: #f9fdf9">简历下载</li>
                <li id="" class="every-item" style="background: #fff">客服服务</li>

                <li id="" class="every-item" style="background: #f9fdf9">人才推荐</li>
                <li id="" class="every-item" style="background: #fff">大数据分析</li>
            </ul>
            
            <ul id="" class="middle-active enjoy-shadow enjoy" :style="{backgroundImage: 'url(' + vipConnerIcon + ')'}" >
                <li id="" class="title-wrapper" style="height: 106px;">
                    <div id="" class="vip-title">
                        <img :src="vipIcon" width="28px" height="28px" class="svip-icon"/>
                        <span id="" class="vip-title-words">超级会员</span>
                    </div>
                    <div id="" class="buy-btn-wrapper" style="">
                        <!-- <router-link :to="'/orders/wxpay/'"> -->
                        <router-link :to="'/orders/paying'">
                            <p v-if="isSecKill == 0" class="vip-btn" style="">充值VIP会员</p>
                        </router-link>
                        <p v-if="isSecKill == 1" class="vip-btn" style="" @click="showVerifyCode">VIP限时秒杀</p>
                        <span v-if="isSecKill == 1">剩余10件</span>
                    </div>
                </li>
                <li id="" class="every-item" style="background: #fbf4e4"><img :src="yesIcon" width="22px" height="22px" class="svip-icon"/></li>
                <li id="" class="every-item" style="background: #fffaeb">无限制</li>
                <li id="" class="every-item" style="background: #fbf4e4">无限制</li>
                <li id="" class="every-item" style="background: ">无限次</li>
                <li id="" class="every-item" style="background: #fbf4e4">无限次</li>
                <li id="" class="every-item" style="background: #fffaeb">7x24随时服务</li>
                <li id="" class="every-item" style="background: #fbf4e4"><img :src="yesIcon" width="22px" height="22px" class="svip-icon"/></li>
                <li id="" class="every-item last-item" style="background: #fffaeb"><img :src="yesIcon" width="22px" height="22px" class="svip-icon"/></li>
            </ul>
    
            <ul id="" class="left-item-wrapper page-words">
                <li id="" class="title-wrapper" style="height: 102px;">
                    <div id="" class="title-item">
                        <img :src="notVipIcon" width="22px" height="22px" class="svip-icon"/>
                        <span id="" class="vip-title-words">非会员</span>
                    </div>
                </li>
                <li id="" class="every-item" style="background: #f9fdf9"><img :src="noIcon" width="22px" height="22px" class="svip-icon"/></li>
                <li id="" class="every-item" style="background: #fff">仅限3个月</li>
                <li id="" class="every-item" style="background: #f9fdf9">仅限3个月</li>
                <li id="" class="every-item" style="background: ">不提供下载，仅供查看</li>
                <li id="" class="every-item" style="background: #f9fdf9">不提供下载，仅供查看</li>
                <li id="" class="every-item" style="background: #fff"><img :src="noIcon" width="22px" height="22px" class="svip-icon"/></li>
                <li id="" class="every-item" style="background: #f9fdf9"><img :src="noIcon" width="22px" height="22px" class="svip-icon"/></li>
                <li id="" class="every-item" style="background: #fff"><img :src="noIcon" width="22px" height="22px" class="svip-icon"/></li>
            </ul>

        </div>

        <el-dialog :visible.sync="dialogVisible" title="请输入秒杀验证码" width="500px" top="20vh">
            
            <!-- <el-form ref="dataForm" label-width="80px" :model="temp" size="" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item >
                    <el-input placeholder="验证码" style="width: 200px;margin-right: 5px;" class="filter-item" />
                </el-form-item>
                
                <el-form-item >
                    <Identify :identifyCode="identifyCode"></Identify>
                </el-form-item>
            </el-form> -->

            <!-- <el-form ref="dataForm" label-width="80px" :model="temp" label-position="left" style="width: 500px; margin-left:50px;"> -->
                <div style="width: 320px; margin-left:50px;display: flex; flex-direction: row; justify-content: space-between;">
                    <el-input placeholder="验证码" v-model="code" style="width: 200px;margin-right: 5px;"/>
                    <!-- <el-input placeholder="验证码" /> -->
                    <Identify :identifyCode="identifyCode"></Identify>
                </div>
            <!-- </el-form> -->

            <span slot="footer" class="dialog-footer">
                <!-- <router-link :to="'/orders/list/'"> -->
                    <el-button @click="dialogVisible = false">不想要了</el-button>
                <!-- </router-link> -->

                <router-link :to="'/orders/paying/'">
                    <el-button type="primary" @click="dialogVisible = false">参与秒杀</el-button>
                </router-link>
                <!-- <el-button type="warning" @click="dialogVisible = false">审核驳回</el-button> -->
            </span>
        </el-dialog>
    </div>
</template>

<script>
import Identify from "@/components/Identify";

export default {
    name: "vipPayment",
    components: { Identify },
    props: {
    },
    data() {
        return {
            // isSecKill: 1,
            isSecKill: 0,
            dialogVisible: false,

            temp: {}, 

            code: "",
            identifyCode: "6188",

            vipIcon: require('@/assets/static/vip/vip.png'),
            notVipIcon: require('@/assets/static/vip/not-vip.png'),
            vipConnerIcon: require('@/assets/static/vip/vip-conner.png'),

            yesIcon: require('@/assets/static/vip/yes.png'),
            noIcon: require('@/assets/static/vip/no.png'),
        };
    },
    computed: {
    },
    created() {
    },
    methods: {
        showVerifyCode() {
            this.dialogVisible = true;
        },

        // submitSecKill() {
        //     this.dialogVisible = false;

        //     this.$router.resolve({ path: '/views/order/error' });
        // },
    },
};
</script>

<style lang="scss" scoped>
@import "~@/styles/mixin.scss";

.page-words {
    color: #464545;
    font: "Microsoft YaHei", arial, SimSun, 宋体;
}

.pay-container {
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.big-title {
    font-size: 28px;
    margin-top: 50px;
    margin-bottom: 10px;
    align-self: center;
}

ul, li, ol {
    list-style: none;
    padding: 0;
    margin: 0;
}

ul {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    // padding-inline-start: 40px;
}

.content-wrapper {
    width: 825px;
    // height: 1550px;
    margin: 10px auto 40px;
    position: relative;
}

.left-wrapper {
    float: left;
    border: 1px solid #d0d3d0;
    background: #fff;
    width: 273px;
    position: absolute;

    left: 0;
}

.title-wrapper {
    height: 102px;
    padding-top: 20px;
    text-align: center;
    line-height: 45px;
    font-size: 14px;
}

.title-item {
    font-size: 20px;

    text-align: center;
    height: 45px;
    line-height: 45px;

    display: flex;
    flex-direction: row;
    justify-content: center;
}

p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}

.every-item {
    text-align: center;
    height: 45px;
    line-height: 45px;
    font-size: 14px;

    display: flex;
    flex-direction: column;
    justify-content: center;
}

.every-item-words {
    color: #666;
    display: block;
    width: 100%;
    height: 100%;

    text-decoration: none;
}


.middle-active {
    border-color: #f2ddaf;
    background-color: #fffaeb;
    margin-top: 12px;
    width: 285px;
    left: 269px;
    z-index: 10;
}

.middle-title-bg {
    border-color: #f2ddaf;
    background-color: #fffaeb;
}

.content-wrapper .middle-active.enjoy {
    border-color: #f2ddaf; 
    background-color: #fffaeb;
    background-position: 220px 0px;
    background-repeat: no-repeat;
}

.enjoy-shadow {
    // left: 275px;
    color: #ca963b;
    -moz-box-shadow: 0 0 10px 2px rgba(0,0,0,.08);
    box-shadow: 0 0 10px 2px rgb(0 0 0 / 8%);

    float: left;
    border: 1px solid #d3d1d0;
    background: #fff;
    position: absolute;
}

.vip-title {
    font-size: 20px;
    font-weight: bold;

    display: flex;
    flex-direction: row;
    justify-content: center;
}

.svip-title .vip-type-icon {
    display: inline-block;
    *display: inline;
    *zoom: 1;
    vertical-align: middle;
    height: 30px;
}

.svip-icon {
    align-self: center;
}

.vip-title-words {
    margin-left: 3px;
    height: 30px;
    line-height: 30px;
    display: inline-block;
    vertical-align: middle;

    align-self: center;
}

.buy-btn-wrapper {
    display: inline-block;
    *display: inline;
    *zoom: 1;
}

.vip-btn {
    width: 115px;
    height: 32px;
    font-size: 14px;
    line-height: 30px;
    text-align: center;
    border-radius: 15px;
    border: 1px solid #f9d681;
    background-color: #f9d681;
    color: #351d06;
    cursor: pointer;
    display: inline-block;
    *display: inline;
    margin: 0 5px;
    *zoom: 1;
}

.last-item {
    height: 50px;
    padding-top: 3px;
}

.left-item-wrapper {
    left: 550px;
    float: left;
    border: 1px solid #d3d1d0;
    background: #fff;
    width: 273px;
    position: absolute;
}

.left-item-title-wrapper {
    height: 102px;
    padding-top: 20px;
}

</style>
