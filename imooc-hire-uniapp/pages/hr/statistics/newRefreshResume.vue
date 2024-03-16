<!-- HR收藏过的简历  -->
<template>
	<view>
		<view class="resume-wrapper" v-for="(r, index) in resumeList" :key="index">
			
			<view class="resume-item">
				<view class="resume-left">
					<text class="resume-name">风间影月</text>
					<view class="short-words-wrapper">
						<text class="short-words">北京</text>
						<text class="short-words">25岁</text>
						<text class="short-words">本科</text>
						<text class="short-words">10年</text>
						<text class="short-words">15-20k·13薪</text>
					</view>
				</view>
				
				<image src="../../../static/images/me.png" class="small-face"></image>
			</view>
			
			<view class="middle-part">
				<view class="middle-item">
					<image src="../../../static/icons/company2.png" class="small-icon"></image>
					<text class="middle-words">慕课网·研发经理</text>
				</view>
				<view class="middle-item" style="margin-top: 2px;">
					<image src="../../../static/icons/college.png" class="small-icon"></image>
					<text class="middle-words">江南大学·食品学院</text>
				</view>
			</view>
			
			<view class="middle-part" style="margin-top: 5px;">
				<text class="advantage-words">精通网络编程，精通java开发，精通企业级微服务架构，精通大数据。曾担任各大项目技术经理以及架构师角色。</text>
			</view>
			
			<view class="tags-part" style="margin-top: 10px;">
				<text class="my-tag">架构师</text>
				<text class="my-tag">微服务</text>
				<text class="my-tag">网络编程</text>
				<text class="my-tag">Netty</text>
				<text class="my-tag">Spring</text>
				<text class="my-tag">SpringCloud</text>
			</view>
			
			<view class="line-wrapper" style="margin: 16px 0;"><view class="line" style="width: 95%;"></view></view>
			
			<view class="bottom-part" style="margin-top: 0px;">
				<text class="time-words">刷新时间</text>
				<text class="time-words" style="margin-left: 10px;">2022年2月22日 15:00</text>
			</view>
		</view>
		
		<!-- <view class="resume-wrapper">
			
			<view class="resume-item">
				<view class="resume-left">
					<text class="resume-name">风间影月</text>
					<view class="short-words-wrapper">
						<text class="short-words">北京</text>
						<text class="short-words">25岁</text>
						<text class="short-words">本科</text>
						<text class="short-words">10年</text>
						<text class="short-words">15-20k·13薪</text>
					</view>
				</view>
				
				<image src="../../../static/images/me.png" class="small-face"></image>
			</view>
			
			<view class="middle-part">
				<view class="middle-item">
					<image src="../../../static/icons/company2.png" class="small-icon"></image>
					<text class="middle-words">慕课网·研发经理</text>
				</view>
				<view class="middle-item" style="margin-top: 2px;">
					<image src="../../../static/icons/college.png" class="small-icon"></image>
					<text class="middle-words">江南大学·食品学院</text>
				</view>
			</view>
			
			<view class="middle-part" style="margin-top: 5px;">
				<text class="advantage-words">精通网络编程，精通java开发，精通企业级微服务架构，精通大数据。曾担任各大项目技术经理以及架构师角色。</text>
			</view>
			
			<view class="tags-part" style="margin-top: 10px;">
				<text class="my-tag">架构师</text>
				<text class="my-tag">微服务</text>
				<text class="my-tag">网络编程</text>
				<text class="my-tag">Netty</text>
				<text class="my-tag">Spring</text>
				<text class="my-tag">SpringCloud</text>
			</view>
			
			<view class="line-wrapper" style="margin: 16px 0;"><view class="line" style="width: 95%;"></view></view>
			
			<view class="bottom-part" style="margin-top: 0px;">
				<text class="time-words">刷新时间</text>
				<text class="time-words" style="margin-left: 10px;">2022年2月22日 15:00</text>
			</view>
		</view>
		
		<view class="resume-wrapper">
			
			<view class="resume-item">
				<view class="resume-left">
					<text class="resume-name">风间影月</text>
					<view class="short-words-wrapper">
						<text class="short-words">北京</text>
						<text class="short-words">25岁</text>
						<text class="short-words">本科</text>
						<text class="short-words">10年</text>
						<text class="short-words">15-20k·13薪</text>
					</view>
				</view>
				
				<image src="../../../static/images/me.png" class="small-face"></image>
			</view>
			
			<view class="middle-part">
				<view class="middle-item">
					<image src="../../../static/icons/company2.png" class="small-icon"></image>
					<text class="middle-words">慕课网·研发经理</text>
				</view>
				<view class="middle-item" style="margin-top: 2px;">
					<image src="../../../static/icons/college.png" class="small-icon"></image>
					<text class="middle-words">江南大学·食品学院</text>
				</view>
			</view>
			
			<view class="middle-part" style="margin-top: 5px;">
				<text class="advantage-words">精通网络编程，精通java开发，精通企业级微服务架构，精通大数据。曾担任各大项目技术经理以及架构师角色。</text>
			</view>
			
			<view class="tags-part" style="margin-top: 10px;">
				<text class="my-tag">架构师</text>
				<text class="my-tag">微服务</text>
				<text class="my-tag">网络编程</text>
				<text class="my-tag">Netty</text>
				<text class="my-tag">Spring</text>
				<text class="my-tag">SpringCloud</text>
			</view>
			
			<view class="line-wrapper" style="margin: 16px 0;"><view class="line" style="width: 95%;"></view></view>
			
			<view class="bottom-part" style="margin-top: 0px;">
				<text class="time-words">刷新时间</text>
				<text class="time-words" style="margin-left: 10px;">2022年2月22日 15:00</text>
			</view>
		</view>
		
		
		<view class="resume-wrapper">
			
			<view class="resume-item">
				<view class="resume-left">
					<text class="resume-name">风间影月</text>
					<view class="short-words-wrapper">
						<text class="short-words">北京</text>
						<text class="short-words">25岁</text>
						<text class="short-words">本科</text>
						<text class="short-words">10年</text>
						<text class="short-words">15-20k·13薪</text>
					</view>
				</view>
				
				<image src="../../../static/images/me.png" class="small-face"></image>
			</view>
			
			<view class="middle-part">
				<view class="middle-item">
					<image src="../../../static/icons/company2.png" class="small-icon"></image>
					<text class="middle-words">慕课网·研发经理</text>
				</view>
				<view class="middle-item" style="margin-top: 2px;">
					<image src="../../../static/icons/college.png" class="small-icon"></image>
					<text class="middle-words">江南大学·食品学院</text>
				</view>
			</view>
			
			<view class="middle-part" style="margin-top: 5px;">
				<text class="advantage-words">精通网络编程，精通java开发，精通企业级微服务架构，精通大数据。曾担任各大项目技术经理以及架构师角色。</text>
			</view>
			
			<view class="tags-part" style="margin-top: 10px;">
				<text class="my-tag">架构师</text>
				<text class="my-tag">微服务</text>
				<text class="my-tag">网络编程</text>
				<text class="my-tag">Netty</text>
				<text class="my-tag">Spring</text>
				<text class="my-tag">SpringCloud</text>
			</view>
			
			<view class="line-wrapper" style="margin: 16px 0;"><view class="line" style="width: 95%;"></view></view>
			
			<view class="bottom-part" style="margin-top: 0px;">
				<text class="time-words">刷新时间</text>
				<text class="time-words" style="margin-left: 10px;">2022年2月22日 15:00</text>
			</view>
		</view> -->
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				resumeList:[1,2,3,5,6,7,8,9,10],
			}
		},
		onShow() {
		},
		onReachBottom() {
			this.loadMorResume();
		},
		methods: {
			loadMorResume() {
				this.resumeList = this.resumeList.concat(this.resumeList);
			},
			
			goToEditMyFace() {
				uni.navigateTo({
					url: "../userInfo/myFace",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
		}
	}
</script>

<style>
	@import url("newRefreshResume.css");
</style>
