<!-- 公司品牌信息页面 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">公司品牌信息</text>
				<text class="title-two">完善公司信息，可以获得更多候选人的信赖与兴趣~</text>
			</view>
			
			<view class="title-wrapper" style="margin-top: 10px; margin-bottom: 50px;">
				<text class="title-two">信息完善程度 {{percent}}%</text>
				<progress :percent="percent" border-radius="20" stroke-width="10" activeColor="#19B0AB" backgroundColor="#f3f6f6" class="progress"/>
			</view>
			
			<view class="main-item-box">
				<text class="main-item-words">基本信息</text>
				
				<image v-if="!isOpend" src="../../../static/icons/arrow-close.png" class="arrow" @click="openBasicInfo()"></image>
				<image v-if="isOpend" src="../../../static/icons/arrow-open.png" class="arrow" @click="closeBasicInfo()"></image>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<block v-if="isOpend">
				<view class="block-name">
					<text class="field-lable-words">公司全称（不可更改）</text>
					
					<input
						class="field-input"
						type="text" 
						:value="companyInfo.companyName" 
						:model="companyInfo.companyName" 
						placeholder=""
						placeholder-class="placeholder"
						disabled="true"
						style="margin-top: 10px;"
						maxlength="12"/>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">对外展示名称（简称）</text>
					
					<view class="field-wrapper" style="">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.shortName" 
							:model="companyInfo.shortName" 
							placeholder="请填写公司简称"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"
							@click="gotoCompanyShortName()"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoCompanyShortName()"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<!-- <view class="block-name">
					<text class="field-lable-words">对外展示名称（简称）</text>
					
					<input
						class="field-input"
						type="text" 
						:value="companyInfo.shortName" 
						:model="companyInfo.shortName" 
						placeholder="请填写公司简称"
						placeholder-class="placeholder"
						style="margin-top: 10px;"
						maxlength="12"/>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view> -->
				
				<view class="block-name">
					<text class="field-lable-words">企业LOGO</text>
					
					<view v-if="companyInfo.logo == null || companyInfo.logo == ''" class="field-wrapper" style="">
						<input
							class="field-input"
							type="text" 
							placeholder="请上传企业LOGO"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoCompanyLogo()"></image>
					</view>
					<view v-if="companyInfo.logo != null || companyInfo.logo != ''" class="field-wrapper" style="">
						<image :src="companyInfo.logo" class="company-logo" @click="gotoCompanyLogo()"></image>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoCompanyLogo()"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">公司规模</text>
					
					<view class="field-wrapper"  @click="gotoCompanyStaffCounts()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.peopleSize" 
							:model="companyInfo.peopleSize" 
							placeholder="请选择公司人员规模"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"
							/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">公司性质</text>
					
					<view class="field-wrapper" @click="gotoCompanyNature()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.nature" 
							:model="companyInfo.nature" 
							placeholder="请选择公司性质"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">公司行业</text>
					
					<view class="field-wrapper" @click="gotoCompanyIndustry()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.industry" 
							:model="companyInfo.industry" 
							placeholder="请选择公司行业"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">融资阶段</text>
					
					<view class="field-wrapper" @click="gotoCompanyFinancing()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.financStage" 
							:model="companyInfo.financStage" 
							placeholder="请选择融资阶段"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">公司地址</text>
					
					<view class="field-wrapper" @click="gotoCompanyAddress()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.address" 
							:model="companyInfo.address" 
							placeholder="请填写公司地址"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="32"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">工作时间</text>
					
					<view class="field-wrapper" @click="gotoWorkTime()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.workTime" 
							:model="companyInfo.workTime" 
							placeholder="请选择工作时间"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			</block>
			
		
			<view class="main-item-box" style="margin-top: 10px;">
				<text class="main-item-words">公司介绍</text>
				
				<image src="../../../static/icons/right-arrow-gray.png" class="arrow" @click="gotoCompanyIntroduce()"></image>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			
			<view class="main-item-box">
				<text class="main-item-words">公司亮点</text>
				
				<image src="../../../static/icons/right-arrow-gray.png" class="arrow" @click="gotoCompanyBenefits()"></image>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="main-item-box">
				<text class="main-item-words">公司相册</text>
				
				<image src="../../../static/icons/right-arrow-gray.png" class="arrow" @click="gotoCompanyPhoto()"></image>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="main-item-box">
				<text class="main-item-words">工商信息</text>
				
				<image v-if="!isBizOpend" src="../../../static/icons/arrow-close.png" class="arrow" @click="openBizInfo()"></image>
				<image v-if="isBizOpend" src="../../../static/icons/arrow-open.png" class="arrow" @click="closeBizInfo()"></image>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<block v-if="isBizOpend">
				<view class="block-name">
					<text class="field-lable-words">法人代表</text>
					
					<view class="field-wrapper" @click="gotoLegalRepresentative()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.legalRepresentative" 
							:model="companyInfo.legalRepresentative" 
							placeholder="请填写法人代表"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="32"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">成立时间</text>
					
					<view class="field-wrapper">
						<picker mode="multiSelector" :range="dateRange" :value="companyInfo.buildDate" @change="bindDateChange"
							:class="companyInfo.buildDate == null ? 'placeholder' : 'field-input'">
							<view class="field-words">{{companyInfo.buildDate == null ? '请选择成立日期' : companyInfo.buildDate}}</view>
						</picker>
						<!-- <input
							class="field-input"
							type="text" 
							:value="companyInfo.buildDate" 
							:model="companyInfo.buildDate" 
							placeholder="请选择公司成立时间"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/> -->
						<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">注册资本</text>
					
					<view class="field-wrapper" @click="gotoRegistCapital()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.registCapital" 
							:model="companyInfo.registCapital" 
							placeholder="请填写公司注册资本"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="12"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="block-name">
					<text class="field-lable-words">注册地址</text>
					
					<view class="field-wrapper" @click="gotoRegistPlace()">
						<input
							class="field-input"
							type="text" 
							:value="companyInfo.registPlace" 
							:model="companyInfo.registPlace" 
							placeholder="请填写公司注册地址"
							placeholder-class="placeholder"
							disabled="true"
							maxlength="32"/>
						<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
					</view>
				</view>
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
				
				
			</block>
		
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			const date = new Date()
			const years = []
			const year = date.getFullYear()
			const months = []
			const month = date.getMonth() + 1
			const days = []
			const day = date.getDate()
			for (let i = 1990; i <= date.getFullYear(); i++) {
				years.push(i)
			}
			for (let i = 1; i <= 12; i++) {
				months.push(i)
			}
			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			return {
				birthday: "请选择",
				years,
				year,
				months,
				month,
				days,
				day,
				dateRange: [
					years, 
					months,
					days
				],
				
				isOpend: false,
				isBizOpend: false,
				
				basicInfo: {
					companyName: "北京慕课网网络科技有限公司"
				},
				
				companyInfo: {},
				companyPhotoList: [],
				percent: 0,
			}
		},
		onShow() {
			this.getCompanyInfo();
			// this.getCompanyPhotos();
		},
		onLoad(options) {
			this.companyId = options.companyId;
		},
		methods:{
			showPercent(companyInfo) {
				var total = 18;
				var counts = 0;
				if (companyInfo == null) {
					this.percent = 0;
					return;
				}
				
				if (companyInfo.shortName != null && companyInfo.shortName != undefined && companyInfo.shortName != '') {
					counts ++;
				}
				if (companyInfo.logo != null && companyInfo.logo != undefined && companyInfo.logo != '') {
					counts ++;
				}
				if (companyInfo.peopleSize != null && companyInfo.peopleSize != undefined && companyInfo.peopleSize != '') {
					counts ++;
				}
				if (companyInfo.nature != null && companyInfo.nature != undefined && companyInfo.nature != '') {
					counts ++;
				}
				if (companyInfo.industry != null && companyInfo.industry != undefined && companyInfo.industry != '') {
					counts ++;
				}
				if (companyInfo.financStage != null && companyInfo.financStage != undefined && companyInfo.financStage != '') {
					counts ++;
				}
				if (companyInfo.address != null && companyInfo.address != undefined && companyInfo.address != '') {
					counts ++;
				}
				if (companyInfo.workTime != null && companyInfo.workTime != undefined && companyInfo.workTime != '') {
					counts ++;
				}
				if (companyInfo.introduction != null && companyInfo.introduction != undefined && companyInfo.introduction != '') {
					counts ++;
				}
				if (companyInfo.advantage != null && companyInfo.advantage != undefined && companyInfo.advantage != '') {
					counts ++;
				}
				if (companyInfo.benefits != null && companyInfo.benefits != undefined && companyInfo.benefits != '') {
					counts ++;
				}
				if (companyInfo.bonus != null && companyInfo.bonus != undefined && companyInfo.bonus != '') {
					counts ++;
				}
				if (companyInfo.subsidy != null && companyInfo.subsidy != undefined && companyInfo.subsidy != '') {
					counts ++;
				}
				// if (this.companyPhotoList != null && this.companyPhotoList.length > 0) {
				// 	console.log(companyPhotoList);
				// 	counts ++;
				// }
				if (companyInfo.buildDate != null && companyInfo.buildDate != undefined && companyInfo.buildDate != '') {
					counts ++;
				}
				if (companyInfo.registCapital != null && companyInfo.registCapital != undefined && companyInfo.registCapital != '') {
					counts ++;
				}
				if (companyInfo.registPlace != null && companyInfo.registPlace != undefined && companyInfo.registPlace != '') {
					counts ++;
				}
				if (companyInfo.legalRepresentative != null && companyInfo.legalRepresentative != undefined && companyInfo.legalRepresentative != '') {
					counts ++;
				}
				
				this.percent = parseInt(counts / total * 100);
				console.log(this.percent);
				this.getCompanyPhotos(counts, total);
			},
			
			getCompanyPhotos(counts, total) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/getPhotos?companyId=" + companyId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyPhotos = result.data.data;
							var photosTemp = companyPhotos.photos.split(",");
							// console.log(photosTemp);
							
							var arr = [];
							for (var i = 0 ; i < photosTemp.length ; i ++) {
								arr.push(photosTemp[i])
							}
							// console.log(arr);
							me.companyPhotoList = me.companyPhotoList.concat(arr);
							if (me.companyPhotoList != null && me.companyPhotoList.length > 0) {
								counts ++;
								me.percent = parseInt(counts / total * 100);
							}
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
			
			getCompanyInfo() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/moreInfo?companyId=" + companyId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
							console.log(companyInfo);
							me.showPercent(companyInfo);
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
			
			
			
			openBizInfo() {
				this.isBizOpend = true;
			},
			closeBizInfo() {
				this.isBizOpend = false;
			},
			
			openBasicInfo() {
				this.isOpend = true;
			},
			closeBasicInfo() {
				this.isOpend = false;
			},
			
			bindDateChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				var dayIndex = selectedArray[2];
				
				var year = this.dateRange[0][yearIndex];
				var month = this.dateRange[1][monthIndex];
				var day = this.dateRange[2][dayIndex];
				
				var buildDate = year + "-" + (month < 10 ? '0' + month : month) + "-" + (day < 10 ? '0' + day : day);
				// this.companyInfo.buildDate = this.buildDate;
				
				this.modifyBuildDate(buildDate);
			},
			
			modifyBuildDate(buildDate) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				
				if (buildDate == null || buildDate == "" || buildDate == undefined) {
					uni.showToast({
						title: "请选择合适的成立日期",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"buildDate": buildDate
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
							me.companyInfo.buildDate = buildDate;
							uni.showToast({
								title: "修改成功~",
								duration: 2000,
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
			
			gotoLegalRepresentative() {
				var companyId = this.companyId;
				var legalRepresentative = this.companyInfo.legalRepresentative;
				if (legalRepresentative == null) {
					legalRepresentative = "";
				}
				uni.navigateTo({
					url: "./companyLegalRepresentative?companyId=" + companyId + "&legalRepresentative=" + legalRepresentative,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoRegistPlace() {
				var companyId = this.companyId;
				var registPlace = this.companyInfo.registPlace;
				if (registPlace == null) {
					registPlace = "";
				}
				uni.navigateTo({
					url: "./companyRegistPlace?companyId=" + companyId + "&registPlace=" + registPlace,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoRegistCapital() {
				var companyId = this.companyId;
				var registCapital = this.companyInfo.registCapital;
				if (registCapital == null) {
					registCapital = "";
				}
				uni.navigateTo({
					url: "./companyRegistCapital?companyId=" + companyId + "&registCapital=" + registCapital,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyAddress() {
				var companyId = this.companyId;
				var address = this.companyInfo.address;
				if (address == null) {
					address = "";
				}
				uni.navigateTo({
					url: "./companyAddress?companyId=" + companyId + "&address=" + address,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyShortName() {
				var companyId = this.companyId;
				var shortName = this.companyInfo.shortName;
				if (shortName == null) {
					shortName = "";
				}
				uni.navigateTo({
					url: "./companyShortName?companyId=" + companyId + "&shortName=" + shortName,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyPhoto() {
				var companyId = this.companyId;
				uni.navigateTo({
					url: "./companyPhoto?companyId=" + companyId,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyBenefits() {
				// var advantage = ",";
				// var benefits = ",";
				// var bonus = ",";
				// var subsidy = ",";
				var companyId = this.companyId;
				var advantage = this.companyInfo.advantage;
				var benefits = this.companyInfo.benefits;
				var bonus = this.companyInfo.bonus;
				var subsidy = this.companyInfo.subsidy;
				uni.navigateTo({
					url: "./companyBenefits?companyId=" + companyId
											+ "&advantage=" + advantage
											+ "&benefits=" + benefits
											+ "&bonus=" + bonus
											+ "&subsidy=" + subsidy,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyIntroduce() {
				var companyId = this.companyId;
				var introduction = this.companyInfo.introduction;
				if (introduction == null || introduction == "" || introduction == undefined) {
					introduction = "";
				}
				uni.navigateTo({
					url: "./companyIntroduce?companyId=" + companyId + "&introduction=" + introduction,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoWorkTime() {
				var companyId = this.companyId;
				var workTime = this.companyInfo.workTime;
				uni.navigateTo({
					url: "./companyWorkTime?companyId=" + companyId + "&workTime=" + workTime,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyLogo() {
				var companyId = this.companyId;
				uni.navigateTo({
					url: "./companyLogo?companyId=" + companyId,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyStaffCounts() {
				var companyId = this.companyId;
				var peopleSize = this.companyInfo.peopleSize;
				// console.log(companyId);
				// console.log(peopleSize);
				// return;
				uni.navigateTo({
					url: "./companyStaffCounts?companyId=" + companyId + "&peopleSize=" + peopleSize,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyIndustry() {
				var companyId = this.companyId;
				var industry = this.companyInfo.industry;
				uni.navigateTo({
					url: "./companyIndustry?companyId=" + companyId + "&industry=" + industry,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyFinancing() {
				var companyId = this.companyId;
				var financStage = this.companyInfo.financStage;
				
				uni.navigateTo({
					url: "./companyFinancing?companyId=" + companyId + "&financStage=" + financStage,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoCompanyNature() {
				var companyId = this.companyId;
				var nature = this.companyInfo.nature;
				
				uni.navigateTo({
					url: "./companyNature?companyId=" + companyId + "&nature=" + nature,
					animationType: "slide-in-bottom"
				});
			},
			
			gotoTags() {
				uni.navigateTo({
					url: "./hrTags",
					animationType: "slide-in-bottom"
				});
			}
		}
	}
</script>

<style>
	@import url("companyBrand.css");
</style>
