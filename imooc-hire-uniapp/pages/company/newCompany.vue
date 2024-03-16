<!-- 创建公司 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">创建公司</text>
				<text class="title-two">新创建的公司将会进行信息审核，请确保填入的信息真实有效</text>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">公司全称</text>
				
				<text class="company-name">{{companyName}}</text>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">公司简称</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="companyShortName" 
						:model="companyShortName" 
						@input="typingContent"
						placeholder="请填写公司简称 (例：慕课网)"
						placeholder-class="placeholder"
						maxlength="36"/>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<view class="field-wrapper" style="justify-content: space-between;">
					<view class="field-wrapper-biz" style="">
						<text class="field-lable-words">LOGO</text>
						<input
							class="company-input"
							type="text" 
							placeholder="请上传企业LOGO"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
					</view>
					
					<view class="business-license-wrapper">
						<image :src="companyLogo" class="company-logo" @click="uploadCompanyLogo()"></image>
						<image src="../../static/icons/right-arrow-gray.png" class="right-arrow" style="" @click="uploadCompanyLogo()"></image>
						<text style="width: 5px;"></text>
					</view>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">公司行业</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="industry" 
						:model="industry" 
						placeholder="请选择公司行业"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"/>
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoIndustry()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">人员规模</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="staffCounts" 
						:model="staffCounts" 
						placeholder="请选择人员规模"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"/>
					<image src="../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoStaffCounts()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			
			<view class="block-name">
				<view class="field-wrapper" style="justify-content: space-between;">
					<view class="field-wrapper-biz" style="">
						<text class="field-lable-words">营业执照</text>
						<input
							class="company-input"
							type="text" 
							placeholder="请上传企业营业执照"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
					</view>
					
					<view class="business-license-wrapper">
						<image :src="businessLicense" class="business-license" @click="uploadBusinessLicense()"></image>
						<image src="../../static/icons/right-arrow-gray.png" class="right-arrow" style="" @click="uploadBusinessLicense()"></image>
						<text style="width: 5px;"></text>
					</view>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			
			<view class="btn-next-wrapper" @click="nextStep()">
				<text class="btn-next-words">完成，下一步</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				companyName: "",
				companyShortName: "",
				industry: "",
				staffCounts: "",
				
				companyLogo: "",
				businessLicense: "",
				companyId: "",
			}
		},
		onNavigationBarButtonTap() {
			
		},
		onShow() {
			// console.log("choosedStaffCounts123");
			var me = this;
			
			var staffCounts = uni.getStorageSync("choosedStaffCounts");
			console.log("staffCounts = " + staffCounts);
			if (staffCounts != undefined && staffCounts != "") {
				me.staffCounts = staffCounts;
			}
			
			var industry = uni.getStorageSync("selectedIndustry");
			console.log("industry = " + industry);
			if (industry != undefined && industry != "") {
				me.industry = industry;
			}
			
		},
		onLoad(params) {
			var companyName	= params.companyName;
			if (companyName == null || companyName == '' || companyName == undefined) {
				// companyName 为空表示，企业审核失败重新发起流程
				var companyJson = params.companyJson;
				var companyInfo = JSON.parse(companyJson);
				this.companyId = companyInfo.id;
				this.companyName = companyInfo.companyName;
				this.industry = companyInfo.industry;
				this.staffCounts = companyInfo.peopleSize;
				this.companyLogo = companyInfo.logo;
				this.companyShortName = companyInfo.shortName;
			} else {
				// companyName 不为空表示，创建新的企业进行入驻
				this.companyName = companyName;
			}
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.companyShortName = e.detail.value;
			},
			
			nextStep() {
				
				if (this.companyName == null || this.companyName == '' || this.companyName == undefined) {
					uni.showToast({
						title: "公司名称不能为空",
						icon: 'error'
					});
					return;
				} else if (this.companyShortName == null || this.companyShortName == '' || this.companyShortName == undefined) {
					uni.showToast({
						title: "公司简称不能为空",
						icon: 'error'
					});
					return;
				} else if (this.companyLogo == null || this.companyLogo == '' || this.companyLogo == undefined) {
					uni.showToast({
						title: "公司LOGO不能为空",
						icon: 'error'
					});
					return;
				} else if (this.industry == null || this.industry == '' || this.industry == undefined) {
					uni.showToast({
						title: "公司行业不能为空",
						icon: 'error'
					});
					return;
				} else if (this.staffCounts == null || this.staffCounts == '' || this.staffCounts == undefined) {
					uni.showToast({
						title: "人员规模不能为空",
						icon: 'error'
					});
					return;
				} else if (this.businessLicense == null || this.businessLicense == '' || this.businessLicense == undefined) {
					uni.showToast({
						title: "营业执照不能为空",
						icon: 'error'
					});
					return;
				}
				
				var companyId = this.companyId;
				if (companyId == null || companyId == '' || companyId == undefined) {
					var tempCompany = {
						companyName: this.companyName,
						shortName: this.companyShortName,
						logo: this.companyLogo,
						industry: this.industry,
						peopleSize: this.staffCounts,
						bizLicense: this.businessLicense,
					};
				} else {
					var tempCompany = {
						companyId: this.companyId,
						companyName: this.companyName,
						shortName: this.companyShortName,
						logo: this.companyLogo,
						industry: this.industry,
						peopleSize: this.staffCounts,
						bizLicense: this.businessLicense,
					};
				}
				
				var userId = app.getUserInfoSession().id;
				
				// 创建公司信息，审核状态为：0，未发起审核。如果用户此处中断，则下次发起审核，就直接进入选择公司页面
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/createNewCompany",
					data: tempCompany,
					success(result) {
						
						if (result.data.status == 200) {
							var newCompanyId = result.data.data;
							
							uni.navigateTo({
								url: "chooseCompany?backPageCounts=3&companyId=" + newCompanyId,
								animationType: "slide-in-bottom",
								success() {
								}
							});
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
			
			gotoIndustry() {
				uni.navigateTo({
					url: "chooseIndustry",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoStaffCounts() {
				uni.navigateTo({
					url: "staffCounts",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			uploadCompanyLogo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					sizeType: ["compressed"],
					success: (e) => {
						var companyLogo = e.tempFilePaths[0];
						
						// 上传
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadLogo",
							name: "file",
							filePath: companyLogo,
							success(result) {
								
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									
									if (res.status == 200) {
										var companyLogoNew = res.data;
										me.companyLogo = companyLogoNew;
										
										uni.showToast({
											title: "LOGO上传成功~",
											duration: 1500
										})
										
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'error'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
								
							}
						})
					}
				})
			},
			
			uploadBusinessLicense() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					sizeType: ["compressed"],
					// crop: {
					// 	quality: 60,
					// 	width: 300,
					// 	height: 300
					// },
					success: (e) => {
						var businessLicense = e.tempFilePaths[0];
						// me.businessLicense = businessLicense;
						
						// return;
						
						// 上传
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadBizLicense",
							name: "file",
							filePath: businessLicense,
							success(result) {
								// console.log(result);
								// console.log(result.data);
								// return;
								
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									
									if (res.status == 200) {
										var faceNewUrl = res.data;
										me.businessLicense = faceNewUrl;
										// 重置本地用户信息
										// app.setUserInfoSession(userInfo);
										// app.setUserSessionToken(userInfo.userToken);
										
										uni.showToast({
											title: "营业执照上传成功~",
											duration: 1500
										})
										
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'error'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
								
							}
						})
					}
				})
			} 
		}
	}
</script>

<style>
	@import url("newCompany.css");
</style>
