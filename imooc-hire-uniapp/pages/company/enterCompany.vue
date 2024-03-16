<!-- 输入公司页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">公司全称</text>
				<text class="title-two">您当前就职的公司</text>
			</view>
			
			<view class="company-wrapper">
				<input
					class="company-input"
					type="text" 
					:value="companyName" 
					:model="companyName" 
					placeholder="请填入营业执照上的公司名称"
					placeholder-class="placeholder"
					maxlength="30"
					@input="typingContent"/>
				
				<text class="length-text" style="margin-top: 2px;"><text style="color: #31B9B3;">{{wordsLength}}</text>/30</text> 
			</view>
			
			<view class="line-wrapper" style="margin: 10px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="tips-box">
				<view class="tips">
					<text class="tip-zero">注意事项</text>
					<text class="tip-item">1. 请务必输入营业执照上的公司全称</text>
					<text class="tip-item">2. 请注意区分总公司和分公司</text>
					<text class="tip-item">3. 公司名称将会用于后续的企业认证，请确保准确</text>
				</view>
			</view>
			
			<image src="../../static/images/BusinessLicence.png" class="business-licence"></image>
		
		
			<view class="btn-next-wrapper" @click="getCompanyByFullName()">
				<text class="btn-next-words">确认加入公司</text>
			</view>
			<!-- <button type="default" class="btn-next" :disabled="disabled" @click="next()">下一步</button>	 -->
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				companyName: "",
				wordsLength: 0,
				disabled: true,
				
				companyExist: true,
				companyCheck: false,
				
				companyInfo: null,
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
			this.wordsLength = this.companyName.length;

		},
		methods: {
			getCompanyByFullName() {
				var companyName = this.companyName;
				
				if (companyName == null || companyName == '' || companyName == undefined) {
					uni.showToast({
						title: "请输入公司全称",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/getByFullName?fullName=" + companyName,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
							
							if (companyInfo == null || companyInfo == '' || companyInfo == undefined) {
								me.companyExist = false;
							} else {
								me.companyExist = true;
								
							}
							
							me.next();
							
							// console.log(companyInfo);
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
						
					}
				})
			},
			
			typingContent(e) {
				var event = e;
				this.companyName = e.detail.value;
				this.wordsLength = this.companyName.length;
				
				if (this.wordsLength > 0) {
					this.disabled = false;
				}
			},
			
			next() {
				var me = this;
				var companyInfo = me.companyInfo;
				
				if (this.companyExist) {
					
					if (companyInfo.reviewStatus == 3) {
						uni.showModal({
							title: "该公司正在审核中，请稍后再试~",
							cancelText: "取消",
							confirmText: "返回上一页",
							confirmColor: "#31B9B3",
							success(e) {
								if (e.confirm) {
									
									// 跳转入驻认证流程
									uni.navigateBack({
										delta: 1
									})
									
								}
							}
						});
					} else if (companyInfo.reviewStatus == 2) {
						uni.showModal({
							title: "审核失败的企业将重新进入审核流程",
							cancelText: "返回",
							confirmText: "下一步",
							confirmColor: "#31B9B3",
							success(e) {
								if (e.confirm) {
									
									var companyJson = JSON.stringify(companyInfo);
									// 跳转入驻认证流程
									uni.navigateTo({
										// url: "newCompany?companyName=" + me.companyName,
										url: "newCompany?companyJson=" + companyJson + "&companyName=",
										animationType: "slide-in-bottom"
									});
									
								}
							}
						});
					} else {
						uni.showModal({
							title: "该公司已经存在，跳转后请直接选择即可入驻",
							cancelText: "返回",
							confirmText: "下一步",
							confirmColor: "#31B9B3",
							success(e) {
								if (e.confirm) {
									
									// 跳转入驻认证流程
									uni.navigateTo({
										url: "chooseCompany?backPageCounts=2&companyId=" + companyInfo.id,
										animationType: "slide-in-bottom"
									});
									
								}
							}
						});
					}
					
				} else {
					uni.showModal({
						title: "该公司不存在，跳转后创建公司即可入驻",
						cancelText: "返回",
						confirmText: "下一步",
						confirmColor: "#31B9B3",
						success(e) {
							if (e.confirm) {
								
								// 跳转入驻认证流程
								uni.navigateTo({
									url: "newCompany?companyName=" + me.companyName,
									animationType: "slide-in-bottom"
								});
								
							}
						}
					});
				}
				
			}
		}
	}
</script>

<style>
	@import url("enterCompany.css");
</style>
