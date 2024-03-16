<!-- 简历详情 -->
<template>
	<view>
		
		<view class="navigation-bar" style="background-color: #ffffff; z-index: 99999;">
			<view class="nav-left-part">
				<image src="../../static/icons/hr/icon-goback.png" class="back-icon" @click="goback()"></image>
				
				<image :src="face" class="nav-face" :style="{opacity: opacity }"></image>
				<text class="nav-name-words" :style="{opacity: opacity }">{{nickname}}</text>
			</view>
			
			<image v-show="!isLike" src="../../static/icons/hr/icon-unlike.png" class="small-icon" @click="addCollectResume()"></image>
			<image v-show="isLike" src="../../static/icons/hr/icon-like.png" class="small-icon" @click="removeCollectResume()"></image>
		</view>
		
		<view class="name-wrapper">
			<view class="name-box">
				<text class="name-words">{{nickname}}</text>
				<text class="position-words">{{lastWorkExp.position}} · {{lastWorkExp.companyName}}</text>
			</view>
			
			<image :src="face" class="small-face"></image>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="status-box">
			<text class="status-words">{{resume.status}}</text>
			<text class="refresh-words">{{DateUtil.toShowTimeFormat(formatDateTime(resume.refreshTime))}}活跃</text>
		</view>
		
		<view class="info-box">
			<view class="info-item">
				<image src="../../static/icons/hr/icon-work.png" class="info-icon"></image>
				<text class="info-words">{{workYears}}年以上</text>
			</view>
			
			<view class="info-item">
				<image src="../../static/icons/hr/icon-university.png" class="info-icon"></image>
				<text class="info-words">{{edu}}</text>
			</view>
			
			<view class="info-item">
				<image src="../../static/icons/hr/icon-birthday.png" class="birthday-icon"></image>
				<text class="info-words">{{age}}岁</text>
			</view>
		</view>
		
		<!-- <view class="info-box">
			<text class="desc-words">3年开发经验，精通各种技术，非常厉害，架构师大数据啥都精通，来吧，招我把，哈哈哈哈哈哈。三年海王，老厉害了，符合我们公司文化！</text>
		</view> -->
		
		<view class="tags-box">
			<view class="cand-tags-wrapper" v-for="(s, index) in skillsArray" :key="s.id">
				<text class="cand-tag">{{s}}</text>
			</view>
			<!-- <view class="cand-tags-wrapper">
				<text class="cand-tag">大数据</text>
			</view>
			<view class="cand-tags-wrapper">
				<text class="cand-tag">微服务</text>
			</view> -->
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="point-box">
			<!-- <image src="../../static/icons/hr/light-point.png" class="light-point-icon"></image> -->
			<image src="../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="point-words">简历亮点</text>
		</view>
		<view class="info-box">
			<text class="point-content">{{(resume.advantage == null || resume.advantage == '' || resume.advantage == undefined ) ? '暂未填写...' : resume.advantage}}</text>
		</view>
		
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="title-box">
			<image src="../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">求职期望</text>
		</view>
		<view class="expect-wrapper" v-for="(expect, index) in resumeExpectList" :key="index">
			<view class="expect-box">
				<text class="expect-words">{{expect.jobName}}，{{expect.city}}</text>
				<text class="salray-words">{{expect.beginSalary}}-{{expect.endSalary}}K</text>
			</view>
			<text class="industry-words">{{expect.industry}}</text>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="title-box">
			<image src="../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">工作经历</text>
		</view>
		
		<block v-for="(workExp, index) in resume.workExpList" :key="workExp.id">
			<view class="work-wrapper">
				<view class="work-box">
					<text class="company-name-words">{{workExp.companyName}}</text>
					<text class="work-year-words">{{workExp.beginDate}} - {{workExp.endDate}}</text>
				</view>
				<text class="position-words" style="margin-top: 6px;">{{workExp.position}}·{{workExp.department}}</text>
				<text class="work-exp-content">{{workExp.content}}</text>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		</block>
		
		<view class="title-box">
			<image src="../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">项目经验</text>
		</view>
		<block v-for="(projectExp, index) in resume.projectExpList" :key="projectExp.id">
			<view class="work-wrapper">
				<view class="work-box">
					<text class="company-name-words">{{projectExp.projectName}}</text>
					<text class="work-year-words">{{projectExp.beginDate}} - {{projectExp.endDate}}</text>
				</view>
				<text class="position-words" style="margin-top: 6px;">{{projectExp.roleName}}</text>
				<text class="project-exp-content">{{projectExp.content}}</text>
			</view>
			<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		</block>
		
		<view class="title-box">
			<image src="../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">资格证书</text>
		</view>
		<view class="tags-box">
			<view class="cand-tags-wrapper" v-for="(c, index) in credentialsArr" :key="c.id">
				<text class="cand-tag">{{c}}</text>
			</view>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="title-box">
			<image src="../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">教育经历</text>
		</view>
		<block v-for="(edu, index) in resume.educationList" :key="edu.id">
			<view class="work-wrapper">
				<view class="work-box">
					<text class="company-name-words">{{edu.school}}</text>
					<text class="work-year-words">{{edu.beginDate}} - {{edu.endDate}}</text>
				</view>
				<text class="project-exp-content">{{edu.education}} · {{edu.major}}</text>
			</view>
		</block>
		
		<!-- <view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view> -->
		
		
		<view class="chat-wrapper">
			<view class="btn-chat-wrapper" @click="goChatWithCand">
				<text class="btn-chat-words">立即沟通</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				resumeId: "",
				resume: {},
				credentialsArr: [],
				skillsArray: [],
				lastWorkExp: {},
				edu: "",
				
				resumeExpectList: [],
				
				resumeUserId: "",
				nickname: "",
				face: "",
				workYears: 0,
				age: 18,
				sex: "保密",
				
				resumeExpectId: "",
				
				isLike: false,
				
				currentUserInfo: null,
				companyInfo: null,
				
				background:{backgroundColor:'#fd5365'},
				height:0,
				navbarRight:0,
				opacity: 0,
				scrollY: 0,
			}
		},
		onLoad(options) {
			let res =uni.getSystemInfoSync()
			this.height = res.windowHeight;
			this.navbarRight = res.windowWidth;
			
			 // userId + "&resumeId=" + resumeId + "&nickname=" + nickname + "&face=" + face,
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.resumeId = resumeId;
			} else {
			}
			// console.log(resumeId);
			
			var resumeUserId = options.userId;
			if (resumeUserId != null && resumeUserId != "" && resumeUserId != undefined) {
				this.resumeUserId = resumeUserId;
				this.getResume(resumeUserId);
			} else {
			}
			
			this.initMyJobExpectList(resumeId, resumeUserId);
			
			
			var nickname = options.nickname;
			if (nickname != null && nickname != "" && nickname != undefined) {
				this.nickname = nickname;
			} else {
			}
			
			var face = options.face;
			if (face != null && face != "" && face != undefined) {
				this.face = face;
			} else {
			}
			
			var workYears = options.workYears;
			if (workYears != null && workYears != "" && workYears != undefined) {
				this.workYears = workYears;
			} else {
			}
			
			var education = options.education;
			if (education != null && education != "" && education != undefined) {
				this.edu = education;
			} else {
			}
			
			var age = options.age;
			if (age != null && age != "" && age != undefined) {
				this.age = age;
			} else {
			}
			
			var resumeExpectId = options.resumeExpectId;
			if (resumeExpectId != null && resumeExpectId != "" && resumeExpectId != undefined) {
				this.resumeExpectId = resumeExpectId;
			} else {
			}
			this.queryDoHRCollectResume(resumeExpectId);
			
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			this.getCompanyInfo();
			
			setTimeout(() => {
				this.addReadResumeRecord();
				this.addWhoLookMeRecord();
			}, 3000);
		},
		onShow() {
		},
		onPageScroll : function(e) {
		    // console.log("滚动距离为：" + e.scrollTop);
			var that = this,
				scrollY = e.scrollTop;
			var opacity = scrollY / 200;
			opacity = opacity > 1 ? 1 : opacity;
			that.$set(that, 'opacity', opacity);
			that.$set(that, 'scrollY', scrollY);
			if (that.lock) {
				that.$set(that, 'lock', false);
				return;
			}
		},
		methods: {
			// HR看到简历向候选人发起聊天
			goChatWithCand() {
				var resumeUserId = this.resumeUserId;
				
				uni.navigateTo({
					url: "msgList?resumeUserId=" + resumeUserId,
					animationType: "slide-in-right",
					success() {
					}
				});
			},
			
			queryDoHRCollectResume(resumeExpectId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/isHrCollectResume?hrId=" + userId + "&resumeExpectId=" + resumeExpectId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var isLike = result.data.data;
							console.log(isLike);
							me.isLike = isLike;
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
			
			addWhoLookMeRecord() {
			
				var me = this;
				var userId = this.currentUserInfo.id;
				var nickname = this.currentUserInfo.nickname;
				var face = this.currentUserInfo.face;
				var position = this.currentUserInfo.position;
				var companyId = this.companyInfo.id;
				var companyName = this.companyInfo.companyName;
				
				var bo = {
					"hrId": userId,
					"hrCompanyId": companyId,
					"hrFace": face,
					"hrNickname": nickname,
					"hrCompanyName": companyName,
					"hrPosition": position,
					"candUserId": this.resumeUserId
				};
				
				// console.log(bo);
				// return;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					data: bo,
					url: serverUrl + "/counts/hrLookCand",
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
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
			
			addReadResumeRecord() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var resumeExpectId = this.resumeExpectId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/addReadResumeRecord?hrId=" + userId + "&resumeExpectId=" + resumeExpectId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
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
			
			addCollectResume() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var resumeExpectId = this.resumeExpectId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/addCollectResume?hrId=" + userId + "&resumeExpectId=" + resumeExpectId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.isLike = !me.isLike;
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
			
			removeCollectResume() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var resumeExpectId = this.resumeExpectId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/counts/removeCollectResume?hrId=" + userId + "&resumeExpectId=" + resumeExpectId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							me.isLike = !me.isLike;
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
			
			initMyJobExpectList(resumeId, resumeUserId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var resumeId = this.resumeId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/getMyResumeExpectList?resumeId=" + resumeId + "&userId=" + resumeUserId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var resumeExpectList = result.data.data;
							console.log(resumeExpectList);
							me.resumeExpectList = resumeExpectList;
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
			
			getResume(resumeUserId) {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/queryMyResume?userId=" + resumeUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var resume = result.data.data;
							console.log(resume);
							me.resume = resume;
							
							var credentials = resume.credentials;
							var skills = resume.skills;
							var educationList = resume.educationList;
							var workExpList = resume.workExpList;
							me.dealCredentials(credentials);
							me.dealSkills(skills);
							me.dealEdu(educationList);
							me.dealWorkExp(workExpList);
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
			
			dealEdu(educationList) {
				
				if (educationList == null || educationList == undefined || educationList == "") {
					this.edu = "";
				}
				
				var edu = educationList[0].education;
				this.edu = edu;
			},
			
			dealWorkExp(workExpList) {
				if (workExpList == null || workExpList == undefined || workExpList == "") {
					this.lastWorkExp = {};
				}
				
				var lastWorkExp = workExpList[0];
				this.lastWorkExp = lastWorkExp;
				
			},
			
			dealCredentials(credentials) {
				var arr = credentials.split(",");
				// console.log(arr);
				
				var credentialsArr = [];
				for (var i = 0 ; i < arr.length ; i ++) {
					if (arr[i] != null && arr[i] != "" && arr[i] != undefined) {
						credentialsArr.push(arr[i]);
					}
				}
				this.credentialsArr = credentialsArr;
			},
			
			dealSkills(skills) {
				var arr = skills.split(",");
				// console.log(arr);
				
				var tagsArray = [];
				for (var i = 0 ; i < arr.length ; i ++) {
					if (arr[i] != null && arr[i] != "" && arr[i] != undefined) {
						tagsArray.push(arr[i]);
					}
				}
				this.skillsArray = tagsArray;
			},
			
			getCompanyInfo() {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/information?hrUserId=" + userId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var companyInfo = result.data.data;
							me.companyInfo = companyInfo;
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
			
			goback() {
				uni.navigateBack({
					delta: 1
				})
			},
			
			// like() {
			// 	this.isLike = 1;
			// },
			
			// unlike() {
			// 	this.isLike = 0;
			// },
			
			editJob() {
				uni.navigateTo({
					url: "./publishNewJob/publishNewJob",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			formatDateTime(timeStr) {
				if (timeStr == null || timeStr == undefined || timeStr == "") {
					return "";
				}
				var arr = timeStr.split("T");
				return arr[0] + " " + arr[1];
			},
		}
	}
</script>

<style>
	@import url("recommendDetail.css");
</style>
