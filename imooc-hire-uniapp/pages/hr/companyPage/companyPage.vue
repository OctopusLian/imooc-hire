<!-- HR 我的页面 -->
<template>
	<view>
		
		<view class="navigation-bar" style="z-index: 99999;">
			<view class="nav-left-part" @click="goback()">
				<image src="../../../static/icons/hr/icon-back-white.png" class="back-icon"></image>
				<!-- <image :src="companyInfo.logo" class="back-icon"></image> -->
			</view>
			
			<!-- <image src="../../../static/icons/hr/ed.png" class="small-icon" @click=""></image> -->
			<view v-show="currentUserType == 1" class="iconfont-edit icon-bianji small-icon" @click="goToCompanyBrand"></view>
		</view>
		
		
		<view class="myInfo">
			<view class="title">
			</view>
			
			<view class="real-me">
				
				<view class="info-box">
					<image v-if="companyInfo != null" :src="companyInfo.logo" class="my-face"></image>
					<!-- <image src="../../../static/images/imooc.png" class="my-face"></image> -->
					
					
					<view class="my-name-wrapper" v-if="companyInfo != null">
						<view class="my-name-box">
							<!-- <text class="my-name">慕课网</text> -->
							<text v-if="companyInfo != null" class="my-name">{{companyInfo.shortName}}</text>
						</view>
						<view class="edit-wrapper">
							<view class="edit-my-resume-wrapper">
								<!-- <text class="edit-my-resume">计算机软件 · 500-999人 · A轮融资</text> -->
								<text class="edit-my-resume">{{companyInfo.industry}} {{companyInfo.peopleSize == null ? '' : '· ' + companyInfo.peopleSize}} {{companyInfo.financStage == null ? '' : '· ' + companyInfo.financStage}}</text>
							</view>
						</view>
					</view>
				</view>
			</view>
			
			<view class="time-box">
				<view class="time-wrapper" style="">
					<image src="../../../static/icons/company/time.png" class="time-icon"></image>
					
					<text style="margin-left: 6px;">{{companyInfo.workTime == null ? "未填写" : companyInfo.workTime}}</text>
					<!-- <text style="margin-left: 6px;">09:00-17:00</text>
					<text style="margin-left: 6px;">周末双休</text> -->
				</view>
			</view>
			
			<view class="tag-box">
				<view class="tag-wrapper">
					<view class="whole-line" style="margin-left: 10px;">
						<scroll-view scroll-x="true" class="tag-scroll">
							<block v-for="(tag, index) in companyBenefits" :key="index" class="">
								<view class="tag-item">
									<view class="tag-inner">
										<!-- <image src="../../../static/icons/edit-1.png" class="tag-icon" style=""></image> -->
										<view :class="'tag-icon iconfont' + ' ' + tag.icon"></view>
										<text class="tag-txt">{{tag.itemValue}}</text>
									</view>
								</view>
							</block>
							<!-- <view class="tag-item"><text class="tag-txt">团队负责人</text></view>
							<view class="tag-item"><text class="tag-txt">绩效管理</text></view>
							<view class="tag-item"><text class="tag-txt">激励机制</text></view>
							<view class="tag-item"><text class="tag-txt">团队建设</text></view>
							<view class="tag-item"><text class="tag-txt">行业大牛</text></view>
							<view class="tag-item"><text class="tag-txt">创业老板</text></view>
							<view class="tag-item"><text class="tag-txt">扁平化管理</text></view> -->
						</scroll-view>
					</view>
				</view>
			</view>
			
		</view>
		
		<view class="block-one">
			<view class="block-box">
				<view class="block-line" style="margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words">公司地址</text>
					</view>
				</view>
				
				<view class="block-line" style="height: 20px;margin-top: 10px;">
					<view class="left-part">
						<image src="../../../static/icons/company/location.png" class="location-icon" style="margin-right: 6px;"></image>
						<!-- <text class="left-part-words" style="font-size: 14px; color: #FFFFFF;">北京市海淀区北三环南路中关村国防科技园99号楼888层</text> -->
						<text class="left-part-words" style="font-size: 14px; color: #FFFFFF;">{{companyInfo.address == null ? '未填写' : ( (companyInfo.province == null ? "" : companyInfo.province) + " " + (companyInfo.city == null ? "" : companyInfo.city) + " " + (companyInfo.district == null ? "" : companyInfo.district) + " " + companyInfo.address)}}</text>
					</view>
				</view>
			</view>
		</view>
		
		<view class="block-one">
			<view class="block-box">
				<view class="block-line" style="margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words">工商信息</text>
					</view>
				</view>
				
				<view class="block-line" style="height: 20px;margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words company-words">公司全称：</text>
						<!-- <text class="left-part-words company-words">北京慕课网科技有限公司</text> -->
						<text class="left-part-words company-words">{{companyInfo.companyName}}</text>
					</view>
				</view>
				<view class="block-line" style="height: 20px;margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words company-words">法人代表：</text>
						<!-- <text class="left-part-words company-words">王大锤</text> -->
						<text class="left-part-words company-words">{{companyInfo.legalRepresentative}}</text>
						<!-- <view class="iconfont">&#xe8ac;</view> -->
						<!-- <view :class="'iconfont' + ' ' + iconName"></view> -->
					</view>
				</view>
				<view class="block-line" style="height: 20px;margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words company-words">成立时间：</text>
						<!-- <text class="left-part-words company-words">2017年05月05日</text> -->
						<text class="left-part-words company-words">{{companyInfo.buildDate}}</text>
					</view>
				</view>
				<view class="block-line" style="height: 20px;margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words company-words">注册资本：</text>
						<!-- <text class="left-part-words company-words">1000万人民币</text> -->
						<text class="left-part-words company-words">{{companyInfo.registCapital}}</text>
					</view>
				</view>
				<view class="block-line" style="height: 20px;margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words company-words">注册地址：</text>
						<!-- <text class="left-part-words company-words">1000万人民币</text> -->
						<text class="left-part-words company-words">{{companyInfo.registPlace}}</text>
					</view>
				</view>
			</view>
		</view>
		
		<view class="block-one">
			<view class="block-box">
				<view class="block-line" style="margin-top: 10px;">
					<view class="left-part">
						<text class="left-part-words">企业相册</text>
					</view>
				</view>
				
				<view class="photo-list-box">
					<scroll-view scroll-x="true" class="tag-scroll">
						<block v-for="(photo, index) in companyPhotoList" :key="index" class="">
							<image :src="photo" class="company-photo" mode="aspectFit" @click="previewImage(photo)"></image>
						</block>
					</scroll-view>
				</view>
				
			</view>
		</view>		
		
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				iconName: "icon-trip",
				companyInfo: {},
				
				currentUserType: null,
				
				signature: "",
				// signature: "我们有很好的团队氛围，归属感很强烈，待遇也十分丰厚~",
				
				// myTags: [],
				myTags: ["职场老司机", "团队负责人", "绩效管理", "激励机制", "团队建设", "行业大牛", "创业老板" , "扁平化管理"],
				
				companyBenefits: [
					{ "icon": "icon-standard", "value": "管理规范", "isSelected": false},
					{ "icon": "icon-training", "value": "技能培训", "isSelected": false},
				],
				
				companyPhotoList: [],
			}
		},
		onShow() {
			// this.initCompanyBenefits();
			this.getCompanyInfo();
			this.getCompanyPhotos();
		},
		onLoad(options) {
			this.currentUserType = options.type;
			this.companyId = options.companyId;
			// console.log("companyId = " + companyId);
		},
		onNavigationBarButtonTap() {
			this.goToCompanyBrand();
		},
		methods:{
			previewImage(url) {
				uni.previewImage({
					urls: [url]
				})
			},
			
			getCompanyPhotos() {
			
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
						console.log(result);
						if (result.data.status == 200) {
							var companyPhotos = result.data.data;
							if (companyPhotos != null) {
								var photosTemp = companyPhotos.photos.split(",");
								// console.log(photosTemp);
								
								var arr = [];
								for (var i = 0 ; i < photosTemp.length ; i ++) {
									arr.push(photosTemp[i])
								}
								// console.log(arr);
								me.companyPhotoList = me.companyPhotoList.concat(arr);
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
			
			showPoints(companyInfo) {
				var advantage = companyInfo.advantage;
				var benefits = companyInfo.benefits;
				var bonus = companyInfo.bonus;
				var subsidy = companyInfo.subsidy;
				
				var advantageArr = advantage.split(",");
				var benefitsArr = benefits.split(",");
				var bonusArr = bonus.split(",");
				var subsidyArr = subsidy.split(",");
				
				var bo = {
					"advantage": advantageArr,
					"benefits": benefitsArr,
					"bonus": bonusArr,
					"subsidy": subsidyArr
				}
				
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getItemsByKeys",
					data: bo,
					success(result) {
						if (result.data.status == 200) {
							var vo = result.data.data;
							console.log(vo)
							var advantageList = vo.advantageList;
							var benefitsList = vo.benefitsList;
							var bonusList = vo.bonusList;
							var subsidyList = vo.subsidyList;
							
							var companyBenefits = [];
							companyBenefits = companyBenefits.concat(advantageList)
															.concat(benefitsList)
															.concat(bonusList)
															.concat(subsidyList);
							me.companyBenefits = companyBenefits;
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
				console.log("companyId = " + companyId);
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
							me.showPoints(companyInfo);
							
							
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
			
			// TODO: 所有图标加载，可以进行优化，高并发优化
			
			// initCompanyBenefits() {
			// 	var companyBenefits = uni.getStorageSync("companyBenefits");
			// 	if (companyBenefits != null && companyBenefits != '' && companyBenefits != undefined && companyBenefits.length > 0) {
			// 		this.companyBenefits = companyBenefits;
			// 	} else {
			// 		this.companyBenefits = [];
			// 	}
				
			// },
			
			goback() {
				// uni.switchTab({
				// 	url: "../me"
				// })
				uni.navigateBack({
					delta: 1
				})
			},
			
			goToCompanyBrand() {
				var companyId = this.companyId;
				console.log("companyId = " + companyId);
				uni.navigateTo({
					url: "companyBrand?companyId=" + companyId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("companyPage.css");
	@import url("../../../static/fonts/iconfont.css");
	
	/* @font-face {
	  font-family: "iconfont"; 
	  src: url('../../../static/fonts/iconfont.woff2?t=1649996261184') format('woff2'),
	       url('../../../static/fonts/iconfont.woff?t=1649996261184') format('woff'),
	       url('../../../static/fonts/iconfont.ttf?t=1649996261184') format('truetype');
	} */
	
	.iconfont {
	  font-family: "iconfont" !important;
	  font-size: 16px;
	  font-style: normal;
	  color: #FFFFFF;
	  -webkit-font-smoothing: antialiased;
	  -moz-osx-font-smoothing: grayscale;
	}
	
	.iconfont-edit {
	  font-family: "iconfont" !important;
	  font-size: 24px;
	  font-weight: 600;
	  font-style: normal;
	  color: #FFFFFF;
	  -webkit-font-smoothing: antialiased;
	  -moz-osx-font-smoothing: grayscale;
	}
</style>
