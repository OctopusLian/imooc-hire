<template>
    <div class="login-container wrapper">
        <el-form
            ref="loginForm"
            :model="loginForm"
            :rules="loginRules"
            class="login-form left"
            auto-complete="on"
            label-position="left"
        >
            <div class="title-container">
                <h3 class="title">企业招聘后台系统</h3>
            </div>

            <el-form-item style="padding: 55px 0 45px; margin-top: 30px; text-align: center; ">
                <vue-qr v-show="showQRCode" :logoSrc="require('@/assets/static/logo.png')" :text="loginQRToken" :size="200" style=""></vue-qr>

                <el-image v-show="!showQRCode" style="width: 200px; height: 200px;" :fit="fit" :src="require('@/assets/static/login/scan-success.png')">
                    <div slot="placeholder"></div>
                </el-image>
            </el-form-item>

            <div class="tips"  style="text-align: center;">
                <span style="">{{showQRCode ? tipWords1 : tipWords2}}</span>
            </div>

            <!-- <el-form-item prop="username">
                <span class="svg-container">
                    <svg-icon icon-class="user" />
                </span>
                <el-input
                    ref="username"
                    v-model="loginForm.username"
                    placeholder="Username"
                    name="username"
                    type="text"
                    tabindex="1"
                    auto-complete="on"
                />
            </el-form-item> -->

            <!-- <el-form-item prop="password">
                <span class="svg-container">
                    <svg-icon icon-class="password" />
                </span>
                <el-input
                    :key="passwordType"
                    ref="password"
                    v-model="loginForm.password"
                    :type="passwordType"
                    placeholder="Password"
                    name="password"
                    tabindex="2"
                    auto-complete="on"
                    @keyup.enter.native="handleLogin"
                />
                <span class="show-pwd" @click="showPwd">
                    <svg-icon :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'"/>
                </span>
            </el-form-item> -->

            <!-- <el-button
                :loading="loading"
                type="primary"
                style="width: 100%; margin-bottom: 30px"
                @click.native.prevent="handleLogin">登 录</el-button> -->

            <!-- <vue-qr :logoSrc="logo" :text="loginQRToken" :size="200"></vue-qr> -->

            <!-- <div class="tips">
                <span style="margin-right: 20px">username: admin</span>
                <span> password: any</span>
            </div> -->
        </el-form>

        <div class="right">
            <el-carousel trigger="click" indicator-position="none" :interval="interval" style="height: 100%;">
                <el-carousel-item style="height: 100%;">
                    <el-image style="width: 100%; height: 100%" :fit="fit" :src="require('@/assets/static/login/company1.jpg')">
                        <div slot="placeholder"></div>
                    </el-image>
                </el-carousel-item>
                <el-carousel-item style="height: 100%;">
                    <el-image style="width: 100%; height: 100%" :fit="fit" :src="require('@/assets/static/login/company2.jpg')">
                        <div slot="placeholder"></div>
                    </el-image>
                </el-carousel-item>
                <el-carousel-item style="height: 100%;">
                    <el-image style="width: 100%; height: 100%" :fit="fit" :src="require('@/assets/static/login/company3.jpg')">
                        <div slot="placeholder"></div>
                    </el-image>
                </el-carousel-item>
            </el-carousel>
        </div>
    </div>
</template>

<script>
import { validUsername } from "@/utils/validate";
import vueQr from 'vue-qr';
import { MessageBox, Message } from 'element-ui'

export default {
    name: "Login",
    components: {
        vueQr
    },
    data() {
        const validateUsername = (rule, value, callback) => {
            if (!validUsername(value)) {
                callback(new Error("请输入用户名..."));
            } else {
                callback();
            }
        };
        const validatePassword = (rule, value, callback) => {
            if (value.length < 6) {
                callback(
                    new Error("请输入长度大于6的密码...")
                );
            } else {
                callback();
            }
        };
        return {
            maxReadCounts: 0,

            loginQRToken: "正在加载，请稍后重试...",
            loginPreToken: "",
            showQRCode: true,
            tipWords1: "打开慕聘网App，使用HR角色扫一扫即可登录",
            tipWords2: "请在慕聘网App上根据提示进行登录确认",

            fit: "cover",
            interval: 2500,
            // ['fill', 'contain', 'cover', 'none', 'scale-down'],
            loginForm: {
                username: "admin",
                password: "123456",
            },
            loginRules: {
                username: [
                    {
                        required: true,
                        trigger: "blur",
                        validator: validateUsername,
                    },
                ],
                password: [
                    {
                        required: true,
                        trigger: "blur",
                        validator: validatePassword,
                    },
                ],
            },
            loading: false,
            passwordType: "password",
            redirect: undefined,
        };
    },
    watch: {
        $route: {
            handler: function (route) {
                this.redirect = route.query && route.query.redirect;
            },
            immediate: true,
        },
        showQRCode(oldValue, newValue) {
            // console.log("oldValue = " + oldValue);
            // console.log("newValue = " + newValue);

            var me = this;
            if (newValue) {
                clearInterval(me.intervalCodeHasBeenRead);
                
                var intervalCheckLogin = setInterval(function() {
                    me.checkLogin();
                }, "3000");
                me.intervalCheckLogin = intervalCheckLogin;
            }
            
        }
    },
    created() {
        // console.log(123);
        this.getQRToken();

        var me = this;
        var intervalCodeHasBeenRead = setInterval(function() {
            me.codeHasBeenRead();
        }, "3000");
        this.intervalCodeHasBeenRead = intervalCodeHasBeenRead;
    }, 
    methods: {
        checkLogin() {
            var me = this;
            var params = {
                preToken: me.loginPreToken
            }
            this.loading = true;
            this.$store
                .dispatch("user/checkLogin", params)
                .then((response) => {
                    console.log(response);
                    var saasToken = response;
                    if (saasToken != null && saasToken != "" && saasToken != undefined) {
                        clearInterval(me.intervalCheckLogin);    
                        this.$router.push({ path: this.redirect || "/" });
                        this.loading = false;
                    }
                })
                .catch(() => {
                    this.loading = false;
                });
        },

        codeHasBeenRead() {
            if (this.maxReadCounts > 30) {
                MessageBox.confirm('页面失效，请刷新后再执行扫描登录！', '友情提示', {
                    confirmButtonText: '刷新页面',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    location. reload()
                })
                clearInterval(this.intervalCodeHasBeenRead);
                return;
            }

            var me = this;
            var params = {
                qrToken: me.loginQRToken
            }
            // console.log("index.vue - codeHasBeenRead() = " + me.loginQRToken);
            this.$store
                .dispatch("user/codeHasBeenRead", params)
                .then((response) => {
                    
                    // console.log(response);
                    var readArray = response;
                    // console.log("readArray.length = " + readArray.length);

                    if (readArray.length == 1) {
                        // do nothing
                    } else if (readArray.length == 2) {
                        var isRead = readArray[0];
                        var preToken = readArray[1];

                        me.showQRCode = false;
                        me.loginPreToken = preToken;
clearInterval(me.intervalCodeHasBeenRead);
                        // console.log("me.loginPreToken = " + me.loginPreToken);
                    }

                })
                .catch(() => {
                    // this.loading = false;
                });

            this.maxReadCounts = this.maxReadCounts + 1;
        },


        getQRToken() {
            var me = this;
            this.$store
                .dispatch("user/getQRToken")
                .then((response) => {
                    var qrToken = response;
                    // console.log("index.vue - getQRToken() = " + qrToken);
                    me.loginQRToken = qrToken;
                })
                .catch(() => {
                    // this.loading = false;
                });
        },
        showPwd() {
            if (this.passwordType === "password") {
                this.passwordType = "";
            } else {
                this.passwordType = "password";
            }
            this.$nextTick(() => {
                this.$refs.password.focus();
            });
        },
        handleLogin() {
            this.$refs.loginForm.validate((valid) => {
                if (valid) {
                    this.loading = true;

                    this.$store
                        .dispatch("user/login", this.loginForm)
                        .then(() => {
                            this.$router.push({ path: this.redirect || "/" });
                            this.loading = false;
                        })
                        .catch(() => {
                            this.loading = false;
                        });
                } else {
                    console.log("error submit!!");
                    return false;
                }
            });
        },
    },
};
</script>

<style lang="scss">
/* 修复input 背景不协调 和光标变色 */
/* Detail see https://github.com/PanJiaChen/vue-element-admin/pull/927 */

$bg: #283443;
$light_gray: #fff;
$cursor: #fff;

@supports (-webkit-mask: none) and (not (cater-color: $cursor)) {
    .login-container .el-input input {
        color: $cursor;
    }
}

.el-carousel__container {
    height: 100%;
}

.wrapper {
    display: flex;
    flex-direction: row;
}

.left {
    width: 50%;
}

.right {
    width: 50%;
}

/* reset element-ui css */
.login-container {
    .el-input {
        display: inline-block;
        height: 47px;
        width: 85%;

        input {
            background: transparent;
            border: 0px;
            -webkit-appearance: none;
            border-radius: 0px;
            padding: 12px 5px 12px 15px;
            color: $light_gray;
            height: 47px;
            caret-color: $cursor;

            &:-webkit-autofill {
                box-shadow: 0 0 0px 1000px $bg inset !important;
                -webkit-text-fill-color: $cursor !important;
            }
        }
    }

    .el-form-item {
        border: 1px solid rgba(255, 255, 255, 0.1);
        background: rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        color: #454545;
    }
}
</style>

<style lang="scss" scoped>
$bg: #31522f;
$dark_gray: #889aa4;
$light_gray: #eee;

.login-container {
    min-height: 100%;
    width: 100%;
    background-color: $bg;
    overflow: hidden;

    .login-form {
        position: relative;
        width: 520px;
        max-width: 100%;
        /* padding: 160px 35px 0; */
        padding: 160px 0px 0;
        margin: 0 auto;
        overflow: hidden;
    }

    .tips {
        font-size: 18px;
        color: #fff;
        margin-bottom: 10px;
        font-weight: 500;

        span {
            /* &:first-of-type {
                margin-right: 16px;
            } */
        }
    }

    .svg-container {
        padding: 6px 5px 6px 15px;
        color: $dark_gray;
        vertical-align: middle;
        width: 30px;
        display: inline-block;
    }

    .title-container {
        position: relative;

        .title {
            font-size: 26px;
            color: $light_gray;
            margin: 0px auto 40px auto;
            text-align: center;
            font-weight: bold;
        }
    }

    .show-pwd {
        position: absolute;
        right: 10px;
        top: 7px;
        font-size: 16px;
        color: $dark_gray;
        cursor: pointer;
        user-select: none;
    }
}
</style>
