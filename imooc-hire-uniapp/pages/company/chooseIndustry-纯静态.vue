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
					<text v-if="i.id != selectedIndustryId" class="main-item-words" @click="openIndustry(i)">{{i.value}}</text>
					<text v-if="i.id == selectedIndustryId" class="main-item-words" @click="closeIndustry(i)">{{i.value}}</text>
					
					<image v-if="i.id != selectedIndustryId" src="../../static/icons/arrow-close.png" class="arrow" @click="openIndustry(i)"></image>
					<image v-if="i.id == selectedIndustryId" src="../../static/icons/arrow-open.png" class="arrow" @click="closeIndustry(i)"></image>
				</view>
				
				<view class="sub-item-wrapper" v-show="i.id == selectedIndustryId">
					<view :class="selectedSubIndustryId == s.id ? 'sub-item-box-selected' : 'sub-item-box'" v-for="(s, index) in subIndustryArray" :key="s.id" @click="selectItem(s)">
						<text :class="selectedSubIndustryId == s.id ? 'sub-item-words-selected' : 'sub-item-words'">{{s.value}}</text>
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
				selectedIndustryId: 0,
				selectedIndustryValue: "",
				
				selectedSubIndustryId: "",
				selectedSubIndustryValue: "",
				
				industryArray: [
					{
						id: "1001",
						value: "互联网/IT/电子/通信"
					},
					{
						id: "1002",
						value: "金融行业"
					},
					{
						id: "1003",
						value: "广告/传媒/文化/体育"
					},
					{
						id: "1004",
						value: "教育培训"
					},
					{
						id: "1005",
						value: "医疗/制药"
					},
					{
						id: "1006",
						value: "交通/物流/贸易"
					},
					{
						id: "1007",
						value: "服务行业"
					},
					{
						id: "1008",
						value: "房地产"
					},
					{
						id: "1009",
						value: "汽车"
					},
					{
						id: "1010",
						value: "机械/制造"
					},
				],
				
				subIndustryArray: [
					{
						id: "2001",
						value: "互联网/IT/电子/通信"
					},
					{
						id: "2002",
						value: "金融行业"
					},
					{
						id: "2003",
						value: "广告/传媒/文化/体育"
					},
					{
						id: "3004",
						value: "教育培训"
					},
					{
						id: "3005",
						value: "医疗/制药"
					},
					{
						id: "3006",
						value: "交通/物流/贸易"
					},
					{
						id: "3007",
						value: "服务行业"
					},
					{
						id: "3008",
						value: "房地产"
					},
					{
						id: "4009",
						value: "汽车"
					},
					{
						id: "4010",
						value: "机械/制造"
					},
				]
			}
		},
		onShow() {
		},
		onLoad() {
			
		},
		onNavigationBarButtonTap() {
			this.selectedSubIndustryId = "";
			this.selectedIndustryValue = "";
			uni.removeStorageSync("selectedIndustry");
		},
		methods: {
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
	@import url("chooseIndustry.css");
</style>
