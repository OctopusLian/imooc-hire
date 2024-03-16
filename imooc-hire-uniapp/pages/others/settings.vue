<!-- 设置 -->
<template>
	<view>
		
		<view class="options-item">
			<image src="../../static/images/me.png" class="face"></image>
			
			<view class="right-part">
				<text class="item-words" style="font-size: 15px; color: gray;font-weight: 400;">风间影月</text>
				
				<!-- <image src="../../static/icons/right-arrow.png" class="right-arrow" style=""></image> -->
			</view>
		</view>
		
		<view class="options-item" style="margin-top: 12px;" @click="changePerson()">
			<text class="item-words" >我的身份</text>
			
			<view class="right-part">
				<text class="item-words" style="font-size: 14px; color: gray;font-weight: 400;">{{whoami}}</text>
				<!-- <image src="../../static/icons/right-arrow.png" class="right-arrow" style=""></image> -->
			</view>
		</view>
		
		<view style="background-color: #FFFFFF">
			<view class="options-item" style="margin-top: 12px;" @click="goToPrivacy()">
				<text class="item-words" >隐私规则</text>
				
				<view class="right-part">
					<image src="../../static/icons/right-arrow.png" class="right-arrow" style=""></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="options-item" @click="goToAboutUs()">
				<text class="item-words" >关于我们</text>
				
				<view class="right-part">
					<image src="../../static/icons/right-arrow.png" class="right-arrow" style=""></image>
				</view>
			</view>
			
			<view class="line-wrapper"><view class="line"></view></view>
			
			<view class="options-item" @click="goToMyCourses()">
				<text class="item-words" >更多课程</text>
				
				<view class="right-part">
					<image src="../../static/icons/right-arrow.png" class="right-arrow" style=""></image>
				</view>
			</view>
		</view>
		
		<view class="options-item" style="margin-top: 12px;justify-content: center;"  @click="logout()">
			<view class="right-part">
				<text class="logout-words">退出登录</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		components: {
		},
		data() {
			return {
				logoutTouched: false,
				
				whoami: "",
			}
		},
		onShow() {
			var userType = uni.getStorageSync('userType');
			console.log(userType);
			if (userType === this.userType.hr) {
				this.whoami = "招聘者";
			} else {
				this.whoami = "求职者";
			}
		},
		onLoad() {
		},
		methods: {
			logout() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				console.log("logout")
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					url: serverUrl + "/passport/logout?userId=" + userId,
					success(result) {
						var status = result.data.status;
						console.log("logout1222211")
						if (status == 200) {
							console.log("logout111")
							app.clearUserInfo();
							// 退出则关闭ws连接
							app.closeWSConnect();
							uni.reLaunch({
								url: "../loginRegist/loginRegist"
							})
						} else if (status != 200) {
							uni.showToast({
								title: result.data.msg,
								icon: "none"
							});
						}
						
					}
				});
			},
			
			goToAboutUs() {
				uni.navigateTo({
					url: "../others/aboutUs",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToPrivacy() {
				uni.navigateTo({
					url: "../others/privacyRule",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			goToMyCourses() {
				uni.navigateTo({
					url: "../others/moreCourse",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			changePerson() {
				// 判断当前身份，取反获得另外一个身份作为更换角色
				// var userType = uni.getStorageSync('userType');
				// if (userType === this.userType.hr) {
				// 	var hrUserType = this.userType.hr;
				// 	uni.setStorageSync('userType', hrUserType);
				// 	app.changeToCandidate();
				// } else {
				// 	var hrUserType = this.userType.hr;
				// 	uni.setStorageSync('userType', hrUserType);
				// 	app.changeToHR();
				// }
				
				// uni.reLaunch({
				// 	url: "../me/me"
				// })
			}
		}
	}
</script>

<style>
	@import url("settings.css");
</style>