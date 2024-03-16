<!-- 公司介绍页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">编辑公司简称</text>
				<text class="title-two">企业简称有助于品牌提升，也便于更好记忆~</text>
			</view>
			
			<input 
				:value="companyShortName"
				:model="companyShortName" 
				maxlength="12" 
				class="textarea"
				placeholder="请填写公司简称(最少12个字)" 
				placeholder-class="placeholder"
				@input="typingContent"/>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				companyShortName: "",
				
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.companyShortName = options.shortName;
		},
		onNavigationBarButtonTap() {
			// console.log(123);
			this.modifyShortName();
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.companyShortName = e.detail.value;
			},
			
			modifyShortName() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var companyShortName = this.companyShortName;
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"shortName": companyShortName
				};
				
				// 修改昵称
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/modify",
					data: pendingInfo,
					success(result) {
						
						if (result.data.status == 200) {
							
							uni.showToast({
								title: "修改成功~",
								duration: 2000,
								success() {
									uni.navigateBack({
										delta: 1,
										animationType: "fade-out"
									})
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
			},
			
			openIndustry(industy) {
				console.log(industy);
				this.selectedIndustryId = industy.id;
				this.selectedIndustryValue = industy.value;
			},
			
			closeIndustry(industy) {
				console.log(industy);
				this.selectedIndustryId = 0;
				this.selectedIndustryValue = "";
			},
			
			
			selectItem(subIndusty) {
				this.selectedSubIndustryId = subIndusty.id;
				this.selectedIndustryValue = subIndusty.value;
				
				uni.setStorageSync("selectedIndustry", subIndusty.value);
			},
			
			
			submitChoose() {
				uni.navigateBack({
					delta: 1
				})
			}
			
		}
	}
</script>

<style>
	@import url("companyShortName.css");
</style>
