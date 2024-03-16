<!-- HR收藏过的简历  -->
<template>
	<view>
		
		<view class="resume-wrapper" v-for="(r, index) in allResumeList" :key="index" @click="gotoDetail(r.userId, r.resumeId, r.nickname, r.face, r.workYears, r.education, r.age, r.resumeExpectId)">
			
			<view class="resume-item">
				<view class="resume-left">
					<text class="resume-name">{{r.jobType}} · {{r.nickname}}</text>
					<view class="short-words-wrapper">
						<!-- {{r.age}}岁 | {{r.education}} | {{r.workYears}}年 | {{r.beginSalary}}-{{r.endSalary}}K -->
						<text class="short-words">{{r.city}}</text>
						<text class="short-words">{{r.age}}岁</text>
						<text class="short-words">{{r.education}}</text>
						<text class="short-words"> {{r.workYears}}年</text>
						<text class="short-words">{{r.beginSalary}}-{{r.endSalary}}K</text>
					</view>
				</view>
				
				<image :src="r.face" class="small-face"></image>
			</view>
			
			<view class="middle-part">
				<view class="middle-item">
					<image src="../../../static/icons/company2.png" class="small-icon"></image>
					<text class="middle-words">{{r.companyName}}·{{r.position}}</text>
				</view>
				<view class="middle-item" style="margin-top: 2px;">
					<image src="../../../static/icons/college.png" class="small-icon"></image>
					<text class="middle-words">{{r.school}}·{{r.major}}</text>
				</view>
			</view>
			
			<view class="middle-part" style="margin-top: 5px;">
				<text class="advantage-words">{{r.advantage}}</text>
			</view>
			
			<view class="tags-part" style="margin-top: 10px;">
				<text class="my-tag" v-for="(t, index) in getTagsArray(r.skills)" :key="index">{{t}}</text>
				<!-- <text class="my-tag">架构师</text>
				<text class="my-tag">微服务</text>
				<text class="my-tag">网络编程</text>
				<text class="my-tag">Netty</text>
				<text class="my-tag">Spring</text>
				<text class="my-tag">SpringCloud</text> -->
			</view>
			
			<view class="line-wrapper" style="margin: 16px 0;"><view class="line" style="width: 95%;"></view></view>
			
			<view class="bottom-part" style="margin-top: 0px;">
				<text class="time-words">收藏时间</text>
				<text class="time-words" style="margin-left: 10px;">{{r.hrCollectResumeTime}}</text>
			</view>
		</view>
		
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				resumeList:[1,2,3,5,6,7,8,9,10],
				
				page: 0,	// 默认第1页
				limit: 10,	// 每页显示10条
				allResumeList: [],
			}
		},
		onShow() {
		},
		onReachBottom() {
			this.loadMorResume();
		},
		onLoad() {
			this.getPagedList(0);
		},
		methods: {
			gotoDetail(userId, resumeId, nickname, face, workYears, education, age, resumeExpectId) {
				uni.navigateTo({
					// url: "../recommendDetail"
					url: "../recommendDetail?userId=" + userId + 
											"&resumeId=" + resumeId + 
											"&nickname=" + nickname + 
											"&face=" + face +
											"&workYears=" + workYears + 
											"&education=" + education + 
											"&age=" + age + 
											"&resumeExpectId=" + resumeExpectId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			getTagsArray(tags) {
				var tagsArray = [];
				
				if (tags != null && tags != "" && tags != undefined) {
					var tempArr = tags.split(",");
					for (var i = 0 ; i < tempArr.length ; i ++) {
						if (tempArr[i] != null && tempArr[i] != "" && tempArr[i] != undefined) {
							tagsArray.push(tempArr[i]);
						}
					}
				}	
				
				return tagsArray;
			},
			
			getPagedList(page) {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/pagedCollectResumeList?hrId=" + userId + "&page=" + page + "&pageSize=10",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data;
							// console.log(me.total);
							// me.page = me.page + 1;
							console.log(list);
							
							if (page == 0) {
								me.allResumeList = [];
							}
							me.allResumeList = me.allResumeList.concat(list);
							
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
			
			loadMorResume() {
				// this.resumeList = this.resumeList.concat(this.resumeList);
				var page = this.page + 1;
				this.page = page;
				this.getPagedList(page);
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
	@import url("collectResume.css");
</style>
