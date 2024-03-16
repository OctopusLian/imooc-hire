<!-- 公司介绍页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">编辑公司地址</text>
				<text class="title-two">完善企业信息有助于候选人查看~</text>
			</view>
			
			<input 
				:value="companyAddress"
				:model="companyAddress" 
				maxlength="12" 
				class="textarea"
				placeholder="请填写公司地址" 
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
				companyAddress: "",
				
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.companyAddress = options.address;
		},
		onNavigationBarButtonTap() {
			// console.log(123);
			this.modifyAddress();
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.companyAddress = e.detail.value;
			},
			
			modifyAddress() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var companyAddress = this.companyAddress;
				
				if (companyAddress == null || companyAddress == "" || companyAddress == undefined) {
					uni.showToast({
						title: "请填写企业地址",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"address": companyAddress
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
	@import url("companyAddress.css");
</style>
