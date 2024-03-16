<!-- 面试邀约记录 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper" v-for="(r, index) in recordList" :key="index">
				<view class="interview-date-box">
					<text class="interview-date-words">面试日期：</text>
					<text class="interview-date-words">2022-02-14</text>
				</view>
				
				<view class="line-wrapper" style="margin: 10px 0px;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="cand-wrapper">
					<image src="../../../static/images/me.png" class="face"></image>
					
					<view class="cand-info">
						<view class="name-info">
							<text class="cand-name">风间影月</text>
							<text class="interview-status">已取消</text>
						</view>
						<text class="cand-company">北京慕课网软件公司 · 架构师</text>
					</view>
				</view>
				
				<view class="interview-job-box">
					<text class="interview-date-words">面试：</text>
					<text class="interview-date-words">Java高级工程师 · 20-30K</text>
				</view>
			</view>
			
			<!-- <view class="title-wrapper">
				<view class="interview-date-box">
					<text class="interview-date-words">面试日期：</text>
					<text class="interview-date-words">2022-02-14</text>
				</view>
				
				<view class="line-wrapper" style="margin: 10px 0px;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="cand-wrapper">
					<image src="../../../static/images/me.png" class="face"></image>
					
					<view class="cand-info">
						<view class="name-info">
							<text class="cand-name">风间影月</text>
							<text class="interview-status">已取消</text>
						</view>
						<text class="cand-company">北京慕课网软件公司 · 架构师</text>
					</view>
				</view>
				
				<view class="interview-job-box">
					<text class="interview-date-words">面试：</text>
					<text class="interview-date-words">Java高级工程师 · 20-30K</text>
				</view>
			</view>
			
			<view class="title-wrapper">
				<view class="interview-date-box">
					<text class="interview-date-words">面试日期：</text>
					<text class="interview-date-words">2022-02-14</text>
				</view>
				
				<view class="line-wrapper" style="margin: 10px 0px;"><view class="line" style="width: 100%;"></view></view>
				
				<view class="cand-wrapper">
					<image src="../../../static/images/me.png" class="face"></image>
					
					<view class="cand-info">
						<view class="name-info">
							<text class="cand-name">风间影月</text>
							<text class="interview-status">已取消</text>
						</view>
						<text class="cand-company">北京慕课网软件公司 · 架构师</text>
					</view>
				</view>
				
				<view class="interview-job-box">
					<text class="interview-date-words">面试：</text>
					<text class="interview-date-words">Java高级工程师 · 20-30K</text>
				</view>
			</view> -->
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				recordList:[1,2,3,5,6,7,8,9,10],
			}
		},
		onShow() {
		},
		onReachBottom() {
			this.loadMorRecord();
		},
		methods: {
			loadMorRecord() {
				this.recordList = this.recordList.concat(this.recordList);
			},
			
			editJob() {
				
			},
		}
	}
</script>

<style>
	@import url("interviewRecord.css");
</style>
