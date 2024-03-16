<template>
    <div class="wscn-http404-container">
        <div class="wscn-http404">
            <div class="pic-404">
                <img
                    class="pic-404__parent"
                    src="@/assets/static/pay/paying.png"
                    alt="404"
                />
                <!-- <img
                    class="pic-404__child left"
                    src="@/assets/404_images/404_cloud.png"
                    alt="404"
                />
                <img
                    class="pic-404__child mid"
                    src="@/assets/404_images/404_cloud.png"
                    alt="404"
                />
                <img
                    class="pic-404__child right"
                    src="@/assets/404_images/404_cloud.png"
                    alt="404"
                /> -->
            </div>
            <div class="bullshit">
                <div class="bullshit__oops">支付页面跳转中...( {{initSeconds}} )</div>
                <!-- <div class="bullshit__headline">{{ message }}</div> -->
                <div class="bullshit__info">
                    由于秒杀人数较多，系统正在准备订单，请耐心等候~
                </div>
                <router-link :to="'/orders/vip/'">
                    <a href="" class="bullshit__return-home">我不想要了</a>
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
import { createTradeOrder } from "@/api/wxpay";
export default {
    name: "PagePaying",
    data() {
        return {
            initSeconds: 3,
        };
    },
    computed: {
        message() {
            return "由于秒杀人数较多，系统正在准备订单，请耐心等候~";
        },
    },
    created() {
        this.display();
    },
    methods: {
        display() {
            var left = this.initSeconds;
            this.timeOut = setInterval(() => {
                left--;

                if (left <= 0) {
                    clearInterval(this.timeOut);
                    // 倒数完毕，跳转到支付页面
                    // this.$router.push(`/login?redirect='/success'`);
                    // this.$router.replace({ path: '/orders/success' });
                    // this.$store.dispatch('name', this.$route);
                    
                    const loading = this.$loading({
                        lock: true,
                        text: '正在准备订单...',
                    });
                    createTradeOrder()
                        .then((response) => {
                            var res = response.data;
                            var orderNum = res;
                            console.log("orderNum = " + orderNum);
                            loading.close();

                            this.$store.dispatch('tagsView/delView', this.$route).then(({ visitedViews }) => {
                                //关闭页面后跳转别的页面
                                this.$router.replace({ path: '/orders/wxpay', query: {orderNum: orderNum} });
                            })
                        })
                        .catch((err) => {
                            console.log(err);
                        });

                    // this.$store.dispatch('tagsView/delView', this.$route).then(({ visitedViews }) => {
                    //     //关闭页面后跳转别的页面
                    //     this.$router.replace({ path: '/orders/wxpay' });
                    // })

                }

                this.initSeconds = left;
            }, 1000)
        }
    }

};
</script>

<style lang="scss" scoped>
.wscn-http404-container {
    transform: translate(-50%, -50%);
    position: absolute;
    top: 40%;
    left: 50%;
}
.wscn-http404 {
    position: relative;
    margin-top: 100px;
    width: 1200px;
    padding: 0 50px;
    overflow: hidden;
    .pic-404 {
        position: relative;
        float: left;
        width: 375px;
        overflow: hidden;
        margin-left: 60px;
        &__parent {
            width: 100%;
        }
        &__child {
            position: absolute;
            &.left {
                width: 80px;
                top: 17px;
                left: 220px;
                opacity: 0;
                animation-name: cloudLeft;
                animation-duration: 2s;
                animation-timing-function: linear;
                animation-fill-mode: forwards;
                animation-delay: 1s;
            }
            &.mid {
                width: 46px;
                top: 10px;
                left: 420px;
                opacity: 0;
                animation-name: cloudMid;
                animation-duration: 2s;
                animation-timing-function: linear;
                animation-fill-mode: forwards;
                animation-delay: 1.2s;
            }
            &.right {
                width: 62px;
                top: 100px;
                left: 500px;
                opacity: 0;
                animation-name: cloudRight;
                animation-duration: 2s;
                animation-timing-function: linear;
                animation-fill-mode: forwards;
                animation-delay: 1s;
            }
            @keyframes cloudLeft {
                0% {
                    top: 17px;
                    left: 220px;
                    opacity: 0;
                }
                20% {
                    top: 33px;
                    left: 188px;
                    opacity: 1;
                }
                80% {
                    top: 81px;
                    left: 92px;
                    opacity: 1;
                }
                100% {
                    top: 97px;
                    left: 60px;
                    opacity: 0;
                }
            }
            @keyframes cloudMid {
                0% {
                    top: 10px;
                    left: 420px;
                    opacity: 0;
                }
                20% {
                    top: 40px;
                    left: 360px;
                    opacity: 1;
                }
                70% {
                    top: 130px;
                    left: 180px;
                    opacity: 1;
                }
                100% {
                    top: 160px;
                    left: 120px;
                    opacity: 0;
                }
            }
            @keyframes cloudRight {
                0% {
                    top: 100px;
                    left: 500px;
                    opacity: 0;
                }
                20% {
                    top: 120px;
                    left: 460px;
                    opacity: 1;
                }
                80% {
                    top: 180px;
                    left: 340px;
                    opacity: 1;
                }
                100% {
                    top: 200px;
                    left: 300px;
                    opacity: 0;
                }
            }
        }
    }
    .bullshit {
        position: relative;
        margin-top: 30px;
        margin-left: 80px;
        float: left;
        width: 380px;
        padding: 30px 0;
        overflow: hidden;
        &__oops {
            font-size: 32px;
            font-weight: bold;
            line-height: 40px;
            color: #c9394a;
            opacity: 0;
            margin-bottom: 20px;
            animation-name: slideUp;
            animation-duration: 0.5s;
            animation-fill-mode: forwards;
        }
        &__headline {
            font-size: 20px;
            line-height: 24px;
            color: #330b0f;
            font-weight: bold;
            opacity: 0;
            margin-bottom: 10px;
            animation-name: slideUp;
            animation-duration: 0.5s;
            animation-delay: 0.1s;
            animation-fill-mode: forwards;
        }
        &__info {
            font-size: 16px;
            line-height: 21px;
            color: grey;
            opacity: 0;
            margin-bottom: 30px;
            animation-name: slideUp;
            animation-duration: 0.5s;
            animation-delay: 0.2s;
            animation-fill-mode: forwards;
        }
        &__return-home {
            display: block;
            float: left;
            width: 110px;
            height: 36px;
            background: #c9394a;
            border-radius: 100px;
            text-align: center;
            color: #ffffff;
            opacity: 0;
            font-size: 14px;
            line-height: 36px;
            cursor: pointer;
            animation-name: slideUp;
            animation-duration: 0.5s;
            animation-delay: 0.3s;
            animation-fill-mode: forwards;
        }
        &__go-orders {
            display: block;
            float: left;
            width: 110px;
            height: 36px;
            background: #0f9408;
            border-radius: 100px;
            text-align: center;
            color: #ffffff;
            opacity: 0;
            font-size: 14px;
            line-height: 36px;
            cursor: pointer;
            animation-name: slideUp;
            animation-duration: 0.5s;
            animation-delay: 0.3s;
            animation-fill-mode: forwards;
        }
        @keyframes slideUp {
            0% {
                transform: translateY(60px);
                opacity: 0;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }
    }
}
</style>
