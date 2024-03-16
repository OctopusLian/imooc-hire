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
					
					<image v-if="i.id != selectedIndustryId" src="../../static/icons/arrow-close.png" class="arrow" @click="openIndustry(i)"></image>
					<image v-if="i.id == selectedIndustryId" src="../../static/icons/arrow-open.png" class="arrow" @click="closeIndustry(i)"></image>
				</view>
				
				<view class="sub-item-wrapper" v-show="i.id == selectedIndustryId">
					<view :class="selectedSubIndustryId == s.id ? 'sub-item-box-selected' : 'sub-item-box'" v-for="(s, index) in subIndustryArray" :key="s.id" @click="selectItem(s)">
						<text :class="selectedSubIndustryId == s.id ? 'sub-item-words-selected' : 'sub-item-words'">{{s.name}}</text>
					</view>
				</view>
				
				<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			</block>
			
			<view class="btn-next-wrapper" @click="submitChoose()">
				<text class="btn-next-words">确认选择</text>
			</view>
		
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				selectedIndustryId: "",
				selectedIndustryValue: "",
				
				selectedSubIndustryId: "",
				selectedSubIndustryValue: "",
				
				industryArray: [
					{
						id: "1001",
						name: "互联网/IT/电子/通信"
					},
					{
						id: "1002",
						name: "金融行业"
					},
					{
						id: "1003",
						name: "广告/传媒/文化/体育"
					},
				],
				
				subIndustryArray: [
					{
						id: "2001",
						name: "互联网/IT/电子/通信"
					},
					{
						id: "2002",
						name: "金融行业"
					},
					{
						id: "2003",
						name: "广告/传媒/文化/体育"
					},
				]
			}
		},
		onShow() {
		},
		onLoad() {
			this.initTopIndustryList();
		},
		onNavigationBarButtonTap() {
			this.selectedSubIndustryId = "";
			this.selectedIndustryValue = "";
			uni.removeStorageSync("selectedIndustry");
		},
		methods: {
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
			
			closeIndustry(industy) {
				console.log(industy);
				this.selectedIndustryId = 0;
				this.selectedIndustryValue = "";
			},
			
			
			selectItem(subIndusty) {
				this.selectedSubIndustryId = subIndusty.id;
				this.selectedIndustryValue = subIndusty.name;
				
				uni.setStorageSync("selectedIndustry", subIndusty.name);
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
	@import url("chooseIndustry.css");
</style>
