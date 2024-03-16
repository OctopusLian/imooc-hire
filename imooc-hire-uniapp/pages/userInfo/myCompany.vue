<!-- 我认证的公司 -->
<template>
	<view>
		
		<view class="img-box">
			<image src="../../static/images/company.png" class="img-company" style=""></image>
			
			<text class="img-words">北京慕课网网络科技有限公司</text>
			
			<view class="change-company-box" @click="changeCompany()">
				<text class="img-words">更换公司</text>
			</view>
			<view class="leave-company-box" @click="leaveCompany()">
				<text class="img-words" style="color: #31B9B3;">离职公司</text>
			</view>
		</view>
		
		<view class="tips">
			<text class="tips-words">若更换或离职公司：</text>
			<text class="tips-words">1、当前账号取消认证，如需进行招聘服务需要重新进行认证流程</text>
			<text class="tips-words">2、曾经发布过的职位与沟通过的联系人将会全部清空</text>
			<text class="tips-words">3、请务必谨慎更换或离职公司，一旦操作则不可逆转</text>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				sex: 0
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
		},
		methods: {
			leaveCompany() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.showModal({
					title: "确定从该公司离职吗？",
					cancelText: "不了，我再想想",
					confirmText: "确定，我已离职",
					confirmColor: "#31B9B3",
					success(e) {
						if (e.confirm) {
							// console.log('用户点击确定');
							// app.changeToCandidate();
							
							
							
							
							var serverUrl = app.globalData.serverUrl;
							uni.request({
								method: "POST",
								header: {
									headerUserId: userId,
									headerUserToken: app.getUserSessionToken()
								},
								url: serverUrl + "/userinfo/changeUserToCand?hrUserId=" + userId,
								success(result) {
									if (result.data.status == 200) {
										
										uni.setStorageSync('userType', me.userType.candidate);
										
										// 退出重新登录
										uni.showModal({
											title: "您已成功接触与该公司关系",
											cancelText: "好的，重新登录",
											confirmText: "确定，重新登录",
											confirmColor: "#31B9B3",
											success(e) {
												uni.reLaunch({
													url: "../loginRegist/loginRegist"
												})
											}
										})
										
										// let pages = getCurrentPages();			//页面栈
										// let prePage = pages[pages.length - 3];	//上一页
										// uni.navigateBack({
										// 	delta: 2
										// });
										// prePage.$vm.reFresh = Math.random();		//触发上一页监听器
									} else {
										uni.showToast({
											title: result.data.msg,
											icon: "none",
											duration: 3000
										});
									}
								}
							})
							
							
							
							
							
							// uni.setStorageSync('userType', me.userType.candidate);
							
							// // TODO: 发送异步请求，清空当前用户的hr身份
							
							// // uni.reLaunch({
							// // 	url: "../candidate/position"
							// // });
							// // return;
							
							// let pages = getCurrentPages();			//页面栈
							// // console.log(pages);
							// let prePage = pages[pages.length - 3];	//上一页
							// // console.log(prePage);
							// uni.navigateBack({
							// 	delta: 2
							// });
							// prePage.$vm.reFresh = Math.random();		//触发上一页监听器
							
						} else if (e.cancel) {
							// console.log('用户点击取消');
						}
					}
				})
			},
			changeCompany() {
				var me = this;
				uni.showModal({
					title: "确定解绑并更换新公司？",
					cancelText: "不了，我再想想",
					confirmText: "确定，我要更换",
					confirmColor: "#31B9B3",
					success(e) {
						if (e.confirm) {
							
							uni.showToast({
								icon: "none",
								title: "请离职后重新绑定",
								duration: 2000
							})
							
						} else if (e.cancel) {
						}
					}
				})
			}
		}
	}
</script>

<style>
	@import url("myCompany.css");
</style>
