<!-- 公司介绍页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">编辑法人代表</text>
				<text class="title-two">完善企业信息有助于候选人查看~</text>
			</view>
			
			<input 
				:value="legalRepresentative"
				:model="legalRepresentative" 
				maxlength="8" 
				class="textarea"
				placeholder="请填写公司法人代表" 
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
				legalRepresentative: "",
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.legalRepresentative = options.legalRepresentative;
		},
		onNavigationBarButtonTap() {
			// console.log(123);
			this.modify();
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.legalRepresentative = e.detail.value;
			},
			
			modify() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var legalRepresentative = this.legalRepresentative;
				
				if (legalRepresentative == null || legalRepresentative == "" || legalRepresentative == undefined) {
					uni.showToast({
						title: "请填写法人代表",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"legalRepresentative": legalRepresentative
				};
				
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
