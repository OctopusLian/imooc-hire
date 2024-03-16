<!-- 登录注册页 -->
<template>
	<view class="page">
		<!-- 这里是状态栏, 每个页面都需要有，目的不让页面覆盖状态栏 -->
		<!-- <view :style="{height: statusBarHeight + 'px'}"></view> -->
		
		<!-- <image src="../../static/images/icon-close-black.png" style="width: 50rpx;height: 50rpx;" @click="close()"></image> -->
		
		<view class="login-box">
			<text class="code-text">验证码登录</text>
			<text class="code-tips">注：未注册的手机号验证通过后将自动注册~</text>
			
			<view class="mobile-box">
				<text class="mobile-prefix" style="align-self: center;">+86</text>
				
				<view class="middle" style="align-self: center;"></view>
				
				<input type="number" 
					class="mobile" 
					:value="mobile" 
					:model="mobile" 
					@input="typingMobile"
					placeholder="请输入手机号" 
					placeholder-style="color: #b1aeb0;"
					maxlength="11"
					style="align-self: center;"/>
			</view>
			<view class="line" style="height: 1rpx;background-color: #afafb3;"></view>
			
			<view class="mobile-box" style="margin-top: 20rpx;">
				<input type="number" 
					class="mobile" 
					:value="verifyCode"
					:model="verifyCode"
					@input="typingVerifyCode"
					placeholder="请输入验证码" 
					placeholder-style="color: #b1aeb0;"
					maxlength="6" 
					style="width: 360rpx;align-self: center;"/>
				
				<view class="middle" style="align-self: center;"></view>
				
				<view
					:class="{'btn-code':!codeTouched, 'btn-code-touched': codeTouched}"
					@touchstart="touchstartCode"
					@touchend="touchendCode"
					@click="getCode()"
					style="border-width: 1px;border-color: #FFFFFF;width: 220rpx;height: 80rpx;border-radius: 30rpx;display: flex;flex-direction: row;justify-content: center;align-self: center;">
					<text class="code-btn-text" style="align-self: center;">{{codeBtnText}}</text>
				</view>
			</view>
			<view class="line"></view>
			
			<view 
				:class="{'btn-login':!loginTouched, 'btn-login-touched': loginTouched}"
				@touchstart="touchstartLogin"
				@touchend="touchendLogin"
				@click="loginOrRegist()"
				style="margin-top: 50rpx;border-width: 1px;border-color: #FFFFFF;width: 650rpx;height: 120rpx;opacity: 0.8;border-radius: 100rpx;display: flex;flex-direction: row;justify-content: center;align-self: center;">
					<text class="login-btn-text" style="align-self: center;">登录 / 注册</text>
			</view>
			
		</view>
	</view>
</template>

<script>
	var system = uni.getSystemInfoSync();
	var app = getApp();
	export default {
		data() {
			return {
				statusBarHeight: 0,
				
				mobile: "13812345678",
				verifyCode: "",
				codeBtnText: "获得验证码",
				codeTimes: 0,
				
				loginTouched: false,
				codeTouched: false,
			}
		},
		onLoad() {
			this.statusBarHeight = system.statusBarHeight;
		},
		methods: {
			touchstartLogin() {
				this.loginTouched = true;
			},
			touchendLogin() {
				this.loginTouched = false;
			},
			touchstartCode() {
				// timer在运行期间，禁止触摸
				if(this.codeTimes > 0) {
					return;
				} else {
					this.codeTouched = true;
				}
			},
			touchendCode() {
				// timer在运行期间，禁止触摸
				if(this.codeTimes > 0) {
					return;
				} else {
					this.codeTouched = false;
				}
			},
			close() {
				uni.navigateBack({
					delta: 1,
					animationType: "slide-out-bottom"
				})
			},
			typingMobile(e) {
				var event = e;
				this.mobile = e.detail.value;
			},
			typingVerifyCode(e) {
				var event = e;
				this.verifyCode = e.detail.value;
			},
			getCode() {
				var me = this;
				
				if(me.codeTimes > 0) {
					return;
				}
				
				me.codeTouched = true;
				
				var mobile = me.mobile;
				
				if (app.isStrEmpty(mobile) || mobile.length != 11) {
					uni.showToast({
						title: "手机号不正确",
						icon: "none"
					});
					return;
				}
				
				var serverUrl = app.globalData.serverUrl;
				// 调用后端发送验证码
				uni.request({
					method: "POST",
					url: serverUrl + "/passport/getSMSCode?mobile=" + mobile,
					success(result) {
						var status = result.data.status;
						if (status != 200) {
							uni.showToast({
								title: result.data.msg,
								icon: "none"
							});
						}
						
						// 开始倒数60秒限制
						if(me.codeTimes == 0) {
							me.doTimer(59);
						}
					}
				});
					
			},
			// 发送验证码的倒计时方法
			doTimer(times) {
				var me = this;
				// 倒计时定时器
				var sendCodeBtnFunction = function(){
					var left = times--;
	
					if (left <= 0) {
						me.codeTouched = false;
						me.codeBtnText = "发送验证码";
						clearInterval(smsTimer);
					} else {
						me.codeBtnText = left + "s";
					}
					me.codeTimes = left;
				};
				var smsTimer = setInterval(sendCodeBtnFunction, 1000);
			},
			
			loginOrRegist() {
				var me = this;
				var verifyCode = me.verifyCode;
				var mobile = me.mobile;
				
				if (app.isStrEmpty(verifyCode)) {
					uni.showToast({
						title: "请填写验证码",
						icon: "none"
					});
					return;
				}
				
				if (app.isStrEmpty(mobile) || mobile.length != 11) {
					uni.showToast({
						title: "手机号不正确",
						icon: "none"
					});
					return;
				}
				
				var serverUrl = app.globalData.serverUrl;
				// 调用后端登录注册
				uni.request({
					method: "POST",
					url: serverUrl + "/passport/login",
					data: {
						"mobile": mobile,
						"smsCode": verifyCode
					},
					success(result) {
						var status = result.data.status;
						if (status == 200) {
							var userInfo = result.data.data;
							app.setUserInfoSession(userInfo);
							app.setUserSessionToken(userInfo.userToken);
							// 登录成功，关闭当前页
							me.goto();
						} else if (status != 200) {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
					}
				});
			},
			
			goto() {
				var me = this;
				var userType = uni.getStorageSync('userType');
				// 如果没有，默认设置为候选人
				if (userType == undefined || userType == "" || userType == null) {
					uni.setStorageSync('userType', me.userType.candidate);
				}
				
				console.log(userType)
				if (userType == this.userType.hr) {
					app.changeToHR();
				} else {
					app.changeToCandidate();
				}
				
				// 判断，只有H5这么做，因为HR不兼容、不支持
				// #ifdef H5
				console.log("H5进入")
				uni.setStorageSync('userType', 2);
				uni.switchTab({
					url: "../candidate/position"
				});
				// #endif
			}
		}
	}
</script>

<style>
	@import url("loginRegist.css");
</style>
