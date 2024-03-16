<!-- HR 我的页面 -->
<template>
	<view>
		<view class="myInfo">
			<view class="title">
				<!-- <text class="title-text">慕聘网</text> -->
			</view>
			
			<!-- < view class="navigation-bar" style="z-index: 99999;" :style="{opacity: opacity }">
				<image src="../../static/images/me.png" class="small-face"></image>
				
				<view class="small-nickname">
					<text class="title-text">风间影月</text>
				</view>
			</view> -->
			
			<view class="real-me">
				
				<view class="info-box">
					<image src="../../static/images/me.png" v-if="currentHRInfo == null" class="my-face"></image>
					<image :src="currentHRInfo.face" v-if="currentHRInfo != null" class="my-face"></image>
					
					<view class="my-name-wrapper">
						<view class="my-name-box">
							<text class="my-name" v-if="currentHRInfo == null">风间影月</text>
							<text class="my-name" v-if="currentHRInfo != null">{{currentHRInfo.showWhichName == 1 ? currentHRInfo.realName : currentHRInfo.nickname}}</text>
						</view>
						<view class="edit-wrapper">
							<view class="edit-my-resume-wrapper">
								<text class="edit-my-resume">{{companyInfo == null ? '慕课网' : companyInfo.shortName }} · {{currentHRInfo == null ? '架构师' : currentHRInfo.position}}</text>
							</view>
						</view>
					</view>
				</view>
				
				<view class="edit-box" v-show="currentUserType == 2">
					<image src="../../static/icons/candidate/icon-follow.png" v-show="doIFollow" class="icon-follow" @click="unfollow(hrUserId)"></image>
					<image src="../../static/icons/candidate/icon-unfollow.png" v-show="!doIFollow" class="icon-follow" @click="follow(hrUserId)"></image>
				</view>
				
				<view class="edit-box" v-show="currentUserType == 1" @click="goToHRInfo()">
					<text class="edit-my-info">修改个人信息</text>
					<image src="../../static/icons/right-arrow-lightgray.png" style="width: 12px;height: 12px;align-self: center;"></image>
				</view>
			</view>
			
			<view class="vip-box"  v-if="myTags.length <= 0">
				<view class="vip-wrapper">
					<view class="upgrade-vip" style="margin-left: 10px;">
						<view class="vip-left-part">
							<text class="about-words">完善个人标签，获得更多关注</text>
						</view>
						
						<image src="../../static/icons/edit-1.png" v-show="currentUserType == 1" @click="gotoTags()" style="width: 20px;height: 20px;align-self: center;margin-right: 12px;"></image>
					</view>
				</view>
			</view>
			
			<view class="tag-box"  v-if="myTags.length > 0">
				<view class="tag-wrapper">
					<view class="whole-line" style="margin-left: 10px;">
						<scroll-view scroll-x="true" :class="{'tag-scroll': currentUserType == 1, 'tag-scroll-more-width': currentUserType == 2}">
							<block v-for="(tag, index) in myTags" :key="index" >
								<view class="tag-item"><text class="tag-txt">{{tag}}</text></view>
							</block>
							<!-- <view class="tag-item"><text class="tag-txt">团队负责人</text></view>
							<view class="tag-item"><text class="tag-txt">绩效管理</text></view>
							<view class="tag-item"><text class="tag-txt">激励机制</text></view>
							<view class="tag-item"><text class="tag-txt">团队建设</text></view>
							<view class="tag-item"><text class="tag-txt">行业大牛</text></view>
							<view class="tag-item"><text class="tag-txt">创业老板</text></view>
							<view class="tag-item"><text class="tag-txt">扁平化管理</text></view> -->
						</scroll-view>
						
						<image src="../../static/icons/edit-1.png" v-show="currentUserType == 1" @click="gotoTags()" style="width: 20px;height: 20px;align-self: center;margin-right: 12px;"></image>
					</view>
				</view>
			</view>
			
			
		</view>
		
		<view class="block-one">
			<view class="block-box">
				<view class="block-line" style="margin-top: 6px;">
					<view class="left-part">
						<text class="left-part-words">个人签名</text>
					</view>
					
					<view v-show="currentUserType == 1" class="right-part" @click="gotoSignature()">
						<image src="../../static/icons/edit-2.png" style="width: 20px;height: 20px;align-self: center;"></image>
					</view>
				</view>
				
				<view class="block-line" style="height: 20px;" v-if="signature == null || signature == ''">
					<view class="left-part">
						<text class="left-part-words" style="font-size: 14px; color: #a7b1bf;">您还没有个人签名噢~</text>
					</view>
				</view>
				
				<view class="block-line" style="height: 20px;" v-if="signature == null || signature == ''">
					<view class="left-part">
						<text class="left-part-words" style="font-size: 14px; color: #a7b1bf;">一句诚意的话，可以吸引更多懂你的人才</text>
					</view>
				</view>
				
				<view class="block-signature" style="" v-if="signature != null && signature != ''">
					<view class="left-part">
						<text class="left-part-words" style="font-size: 14px; color: #a7b1bf;">{{signature}}</text>
					</view>
				</view>
			</view>
		</view>
		
		<view class="block-two">
			<view class="my-position-box" style="height: 40px; align-self: center;">
				<view class="block-line" style="margin-top: 6px;">
					<view class="left-part" style="border-bottom: solid 3px #31B9B3; padding-bottom: 4px;">
						<text class="left-part-words">我的职位</text>
					</view>
				</view>
			</view>
			
			<view class="position-box" style="">
				<view class="position-item" v-for="(j, index) in jobList" :key="index">
					<view class="block-line" style="margin-top: 6px;">
						<view class="left-part" style="">
							<text class="left-part-words">{{j.jobName}}</text>
						</view>
						
						<view class="right-part" style="">
							<text class="left-part-words" style="color: #ff6400; margin-right: 8px;">{{j.beginSalary}}-{{j.endSalary}}K</text>
						</view>
					</view>
					
					<view class="block-desc">
						<text class="position-desc">{{j.city}}</text>
						<text class="separator">|</text>
						<text class="position-desc">{{j.expYears}}</text>
						<text class="separator">|</text>
						<text class="position-desc">{{j.edu}}</text>
					</view>
				</view>
				
				<!-- <view class="position-item" style="">
					<view class="block-line" style="margin-top: 6px;">
						<view class="left-part" style="">
							<text class="left-part-words">高级Java工程师</text>
						</view>
						
						<view class="right-part" style="">
							<text class="left-part-words" style="color: #ff6400; margin-right: 4px;">20-30k</text>
						</view>
					</view>
					
					<view class="block-desc">
						<text class="position-desc">北京</text>
						<text class="separator">|</text>
						<text class="position-desc">3-5年</text>
						<text class="separator">|</text>
						<text class="position-desc">本科及以上</text>
					</view>
				</view> -->
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				hrUserId: "",
				
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				
				jobList:[],
				
				doIFollow: false,
				currentUserType: null,
				
				signature: "",
				// signature: "我们有很好的团队氛围，归属感很强烈，待遇也十分丰厚~",
				currentHRInfo: null,
				companyInfo: null,
				
				myTags: [],
				// myTags: ["职场老司机", "团队负责人", "绩效管理", "激励机制", "团队建设", "行业大牛", "创业老板" , "扁平化管理"]
			}
		},
		onShow() {
			// 是HR的话，表示为 hr主页，刷新一下
			if (this.currentUserType == 1) {
				this.ifHRRefreshPage();
			}
			// 获得用户信息
			// var currentUserInfo = getApp().getUserInfoSession();
			// this.currentUserInfo = currentUserInfo;
			// this.signature = currentUserInfo.hrSignature;
			
			// var hrTags = currentUserInfo.hrTags;
			// var tagsArr = hrTags.split(",");
			// var myTags = [];
			// for (var i = 0 ; i < tagsArr.length ; i ++) {
			// 	var temp = tagsArr[i];
			// 	if (temp != null && temp != "" && temp != undefined) {
			// 		myTags.push(temp);
			// 	}
			// }
			// this.myTags = myTags;
			// console.log(myTags);
			
			// this.getCompanyInfo(this.currentUserInfo.id);
		},
		onLoad(options) {
			// console.log(options);
			var currentUserType = options.type;
			this.currentUserType = currentUserType;
			
			
			var hrUserId = options.hrUserId;
			if (hrUserId != null && hrUserId != "" && hrUserId != undefined && currentUserType == 2) {
				// 求职者
				this.hrUserId = hrUserId;
				this.getHrInfo(hrUserId);
				this.getCompanyInfo(hrUserId);
			} else {
				// HR
				this.ifHRRefreshPage();
			}
			
			this.queryDoCandFollowHr();
			
		},
		methods:{
			getHRJobList(page, status) {
				// 本接口仅仅只查询5条记录
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				var hrUserId = this.hrUserId;
				var companyId = this.companyInfo.id;
				
				var status = 1;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/job/hr/jobList?hrId=" + hrUserId + "&companyId=" + companyId + "&page=1&limit=5&status=" + status,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							me.page = result.data.data.page;
							console.log(list);
							// console.log(me.jobList);
							me.jobList = me.jobList.concat(list);
							
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
			
			queryDoCandFollowHr() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var hrId = this.hrUserId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/doseCandFollowHr?hrId=" + hrId + "&candUserId=" + userId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var doIFollow = result.data.data;
							console.log(doIFollow);
							me.doIFollow = doIFollow;
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
			
			ifHRRefreshPage() {
				var currentUserInfo = getApp().getUserInfoSession();
				this.hrUserId = currentUserInfo.id;
				this.currentHRInfo = currentUserInfo;
				this.signature = currentUserInfo.hrSignature;
				
				var myTags = [];
				var hrTags = currentUserInfo.hrTags;
				if (hrTags != null && hrTags != "" && hrTags != undefined) {
					var tagsArr = hrTags.split(",");
					for (var i = 0 ; i < tagsArr.length ; i ++) {
						var temp = tagsArr[i];
						if (temp != null && temp != "" && temp != undefined) {
							myTags.push(temp);
						}
					}
				}
				this.myTags = myTags;
				
				this.getCompanyInfo(currentUserInfo.id);
			},
			
			getHrInfo(hrUserId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + hrUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentHRInfo = result.data.data;
							me.currentHRInfo = currentHRInfo;
							console.log(currentHRInfo);
							
							me.signature = currentHRInfo.hrSignature;
							
							var hrTags = currentHRInfo.hrTags;
							var myTags = [];
							if (hrTags != null && hrTags != "" && hrTags != undefined) {
								var tagsArr = hrTags.split(",");
								for (var i = 0 ; i < tagsArr.length ; i ++) {
									var temp = tagsArr[i];
									if (temp != null && temp != "" && temp != undefined) {
										myTags.push(temp);
									}
								}
							}
							me.myTags = myTags;
							
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
			
			getCompanyInfo(hrUserId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/information?hrUserId=" + hrUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
							console.log(companyInfo);
							
							me.getHRJobList(1, 1);
							
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
			
			unfollow(hrUserId) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/unfollowHr?hrId=" + hrUserId + "&candUserId=" + userId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.doIFollow = false;
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
			
			follow(hrUserId) {
				
					var me = this;
					var userId = getApp().getUserInfoSession().id;
					
					var bo = {
					    "candUserId": userId,
					    "hrId": hrUserId,
					    "hrFace": this.currentHRInfo.face,
					    "hrNickname": this.currentHRInfo.nickname,
					    "hrCompanyName": this.companyInfo.companyName,
					    "hrPosition": this.currentHRInfo.position
					}
					
					var serverUrl = app.globalData.serverUrl;
					uni.request({
						method: "POST",
						header: {
							headerUserId: userId,
							headerUserToken: app.getUserSessionToken()
						},
						data: bo,
						url: serverUrl + "/counts/followHr",
						success(result) {
							console.log(result);
							if (result.data.status == 200) {
								me.doIFollow = true;
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
			
			goToHRInfo() {
				uni.navigateTo({
					url: "./hrInfo?type=" + this.userType.hr,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			gotoSignature() {
				uni.navigateTo({
					url: "./hrSignature",
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
	@import url("hrPage.css");
</style>
