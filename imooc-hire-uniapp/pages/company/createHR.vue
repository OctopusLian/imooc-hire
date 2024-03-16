<!-- 创建HR名片 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">创建你的HR名片</text>
				<text class="title-two">向候选人介绍一下自己吧~</text>
			</view>
			
			<view class="block-face">
				<text class="field-lable">头像</text>
				
				<image src="../../static/images/me.png" v-if="currentUserInfo == null" class="small-face"></image>
				<image :src="currentUserInfo.face" v-if="currentUserInfo != null" class="small-face"></image>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">姓名</text>
				
				<input
					class="nickname-input"
					type="text" 
					:value="realname" 
					:model="realname" 
					placeholder="请填入真实姓名"
					placeholder-class="placeholder"
					@input="typingRealname"
					maxlength="12"/>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">我的公司</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="companyName" 
						:model="companyName" 
						placeholder="您当前就职的公司"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="36"/>
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoMyCompany()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">我的职务</text>
				
				<input
					class="position-input"
					type="text" 
					:value="position" 
					:model="position" 
					placeholder="真实的职务可以获得更多信赖"
					placeholder-class="placeholder"
					maxlength="12"/>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			
			<view class="btn-next-wrapper" @click="gotoVerify()">
				<text class="btn-next-words">提交审核</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				realname: "",
				companyName: "",
				position: "",
				
				reviewCompanyBO: null,
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
			// 获得用户信息
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			
			this.position = currentUserInfo.position
			
			
			
			// 如果存在bo，则赋值页面
			var reviewCompanyBO = uni.getStorageSync("reviewCompanyBO");
			console.log(reviewCompanyBO);
			if (reviewCompanyBO != null && reviewCompanyBO != undefined) {
				this.reviewCompanyBO = reviewCompanyBO;
				this.companyName = reviewCompanyBO.companyName;
				console.log(this.companyName);
			}
		},
		methods: {
			typingRealname(e) {
				this.realname = e.detail.value;
				this.reviewCompanyBO.realname = this.realname;
			},
			
			gotoMyCompany() {
				uni.navigateTo({
					url: "enterCompany",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			freshUserInfo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				// 修改昵称
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/freshUserInfo?userId=" + userId,
					success(result) {
						if (result.data.status == 200) {
							var userInfo = result.data.data;
							// 重置本地用户信息
							app.setUserInfoSession(userInfo);
							app.setUserSessionToken(userInfo.userToken);
						}
					}
				})
			},
			
			gotoVerify() {
				var me = this;
				uni.showModal({
					title: "提交后不可变更，您奖进入信息审核流程",
					cancelText: "稍等，我再想想",
					confirmText: "确定，我要提交",
					confirmColor: "#31B9B3",
					success(e) {
						if (e.confirm) {
							
							var userId = app.getUserInfoSession().id;
							var reviewCompanyBO = me.reviewCompanyBO;
							// console.log(reviewCompanyBO);
							var serverUrl = app.globalData.serverUrl;
							uni.request({
								method: "POST",
								header: {
									headerUserId: userId,
									headerUserToken: app.getUserSessionToken()
								},
								url: serverUrl + "/company/goReviewCompany",
								data: reviewCompanyBO,
								success(result) {
									
									if (result.data.status == 200) {
										
										me.freshUserInfo();
										
										uni.removeStorageSync("reviewCompanyBO");
										uni.removeStorageSync("choosedStaffCounts");
										uni.removeStorageSync("selectedIndustry");
										
										uni.showToast({
											title: "企业信息已提交，请耐心等待审核~",
											duration: 2500,
											success() {
												uni.navigateTo({
													url: "verify/verifying",
													animationType: "slide-in-bottom",
													success() {
													}
												});
											}
										})
										
									} else {
										uni.showToast({
											title: result.data.msg,
											icon: "none",
											duration: 3000
										});
									}
									
								}
							})
							
							
							// uni.navigateTo({
							// 	url: "verify/verifying",
							// 	animationType: "slide-in-bottom",
							// 	success() {
							// 	}
							// });
							
						}
					}
				})
			}
		}
	}
</script>

<style>
	@import url("createHR.css");
</style>
