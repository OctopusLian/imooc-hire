<!-- 所在行业页面 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 50px;">
				<text class="title-one">所在行业</text>
				<text class="title-two">请选择公司的行业，最多1项</text>
			</view>
			
		
			<block v-for="(i, index) in industryArray" :key="i.id">
				<view class="main-item-box">
					<text v-if="i.id != selectedIndustryId" class="main-item-words" @click="openIndustry(i)">{{i.name}}</text>
					<text v-if="i.id == selectedIndustryId" class="main-item-words" @click="closeIndustry(i)">{{i.name}}</text>
					
					<image v-if="i.id != selectedIndustryId" src="../../../static/icons/arrow-close.png" class="arrow" @click="openIndustry(i)"></image>
					<image v-if="i.id == selectedIndustryId" src="../../../static/icons/arrow-open.png" class="arrow" @click="closeIndustry(i)"></image>
					<!-- <text class="main-item-words">{{i.value}}</text>
					
					<image v-if="i.id != selectedIndustryId" src="../../../static/icons/arrow-close.png" class="arrow" @click="openIndustry(i)"></image>
					<image v-if="i.id == selectedIndustryId" src="../../../static/icons/arrow-open.png" class="arrow" @click="closeIndustry(i)"></image> -->
				</view>
				
				<!-- <view class="sub-item-wrapper" v-show="i.id == selectedIndustryId">
					<view :class="selectedSubIndustryId == s.id ? 'sub-item-box-selected' : 'sub-item-box'" v-for="(s, index) in subIndustryArray" :key="s.id" @click="selectItem(s)">
						<text :class="selectedSubIndustryId == s.id ? 'sub-item-words-selected' : 'sub-item-words'">{{s.value}}</text>
					</view>
				</view> -->
				<view class="sub-item-wrapper" v-show="i.id == selectedIndustryId">
					<view :class="selectedSubIndustryId == s.id ? 'sub-item-box-selected' : 'sub-item-box'" v-for="(s, index) in subIndustryArray" :key="s.id" @click="selectItem(s)">
						<text :class="selectedSubIndustryId == s.id ? 'sub-item-words-selected' : 'sub-item-words'">{{s.name}}</text>
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
			return {
				selectedIndustryId: 0,
				selectedIndustryValue: "",
				
				selectedSubIndustryId: "",
				selectedSubIndustryValue: "",
				
				industryArray: [],
				subIndustryArray: []
			}
		},
		onShow() {
		},
		onLoad(options) {
			this.companyId = options.companyId;
			this.industry = options.industry;
			
			this.initTopIndustryList();
		},
		onNavigationBarButtonTap() {
			this.modifyIndustry();
		},
		methods: {
			modifyIndustry() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var companyId = this.companyId;
				var industry = this.selectedIndustryValue;
				
				if (industry == null || industry == "" || industry == undefined) {
					uni.showToast({
						title: "请选择企业性质",
						icon: "none",
						duration: 3000
					});
					return;
				}
				
				var pendingInfo = {
					"currentUserId": userId,
					"companyId": companyId,
					"industry": industry
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
							
							uni.navigateBack({
								delta: 1,
								animationType: "fade-out"
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
			
			initTopIndustryList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "GET",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/industry/app/initTopList",
					success(result) {
						
						if (result.data.status == 200) {
							var topList = result.data.data;
							console.log(topList);
							me.industryArray = topList;
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
				// console.log(industy);
				this.selectedIndustryId = industy.id;
				this.selectedIndustryValue = industy.value;
				
				var topId = industy.id;
				console.log("topId = " + topId);
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "GET",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/industry/app/getThirdListByTop/" + topId,
					success(result) {
						
						if (result.data.status == 200) {
							var thirdList = result.data.data;
							console.log(thirdList);
							me.subIndustryArray = thirdList;
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
			
			// openIndustry(industy) {
			// 	console.log(industy);
			// 	this.selectedIndustryId = industy.id;
			// 	this.selectedIndustryValue = industy.value;
			// },
			
			closeIndustry(industy) {
				console.log(industy);
				this.selectedIndustryId = 0;
				this.selectedIndustryValue = "";
			},
			
			selectItem(subIndusty) {
				console.log(subIndusty);
				this.selectedSubIndustryId = subIndusty.id;
				this.selectedIndustryValue = subIndusty.name;
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
	@import url("companyIndustry.css");
</style>
