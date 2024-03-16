<!-- 候选人详情 -->
<template>
	<view>
		
		<view class="navigation-bar" style="background-color: #ffffff; z-index: 99999;">
			<view class="nav-left-part" v-if="resumeUserInfo != null">
				<image src="../../../static/icons/hr/icon-goback.png" class="back-icon" @click="goback()"></image>
				
				<image :src="resumeUserInfo.face" class="nav-face" :style="{opacity: opacity }"></image>
				<text class="nav-name-words" :style="{opacity: opacity }">{{resumeUserInfo.nickname}}</text>
			</view>
		</view> 
		
		<view class="name-wrapper" v-if="resumeUserInfo != null">
			<view class="name-box">
				<text class="name-words">{{resumeUserInfo.nickname}}</text>
				<text class="position-words">{{lastWorkExp.position}} · {{lastWorkExp.companyName}}</text>
			</view>
			
			<image :src="resumeUserInfo.face" class="small-face"></image>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="status-box">
			<text class="status-words">{{resume.status}}</text>
			<!-- <text class="refresh-words">3天前活跃</text> -->
			<text class="refresh-words">{{DateUtil.toShowTimeFormat(formatDateTime(resume.refreshTime))}}活跃</text>
		</view>
		
		<view class="info-box">
			<view class="info-item">
				<image src="../../../static/icons/hr/icon-work.png" class="info-icon"></image>
				<text class="info-words">{{workYears}}年以上</text>
			</view>
			
			<view class="info-item" v-if="edu != null && edu != '' && edu != undefined">
				<image src="../../../static/icons/hr/icon-university.png" class="info-icon"></image>
				<text class="info-words">{{edu}}</text>
			</view>
			
			<view class="info-item">
				<image src="../../../static/icons/hr/icon-birthday.png" class="birthday-icon"></image>
				<text class="info-words">{{age}}岁</text>
			</view>
		</view>
		
		<!-- <view class="info-box">
			<text class="desc-words">{{(resume.advantage == null || resume.advantage == '' || resume.advantage == undefined ) ? '暂未填写...' : resume.advantage}}</text>
		</view> -->
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="title-box">
			<image src="../../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">求职期望</text>
		</view>
		<view class="expect-wrapper" v-for="(expect, index) in resumeExpectList" :key="index">
			<view class="expect-box">
				<text class="expect-words">{{expect.jobName}}，{{expect.city}}</text>
				<text class="salray-words">{{expect.beginSalary}}-{{expect.endSalary}}K</text>
			</view>
			<text class="industry-words">{{expect.industry}}</text>
		</view>
		<!-- <view class="expect-wrapper">
			<view class="expect-box">
				<text class="expect-words">Java高级，广州</text>
				<text class="salray-words">15-26K</text>
			</view>
			<text class="industry-words">计算机·游戏·互联网·电子商务</text>
		</view>
		<view class="expect-wrapper">
			<view class="expect-box">
				<text class="expect-words">Java架构师，北京</text>
				<text class="salray-words">22-26K</text>
			</view>
			<text class="industry-words">计算机·游戏·互联网·电子商务</text>
		</view> -->
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="point-box">
			<!-- <image src="../../static/icons/hr/light-point.png" class="light-point-icon"></image> -->
			<image src="../../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="point-words">优势亮点</text>
		</view>
		<view class="info-box">
			<text class="point-content">{{(resume.advantage == null || resume.advantage == '' || resume.advantage == undefined ) ? '暂未填写...' : resume.advantage}}</text>
		</view>
		
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
		
		<view class="title-box">
			<image src="../../../static/icons/hr/point.png" class="point-icon"></image>
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
		<!-- <view class="work-wrapper">
			<view class="work-box">
				<text class="company-name-words">北京慕课网科技有限公司</text>
				<text class="work-year-words">2019.09-至今</text>
			</view>
			<text class="position-words" style="margin-top: 6px;">Java高级开发·技术部</text>
			<text class="work-exp-content">3年开发经验，精通各种技术，非常厉害，架构师大数据啥都精通，来吧，招我把，哈哈哈哈哈哈。三年海王，老厉害了，符合我们公司文化！</text>
		</view>
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view> -->
		
		<view class="title-box">
			<image src="../../../static/icons/hr/point.png" class="point-icon"></image>
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
		
		<!-- <view class="work-wrapper">
			<view class="work-box">
				<text class="company-name-words">慕课网平台系统</text>
				<text class="work-year-words">2019.09-至今</text>
			</view>
			<text class="position-words" style="margin-top: 6px;">Java开发</text>
			<text class="project-exp-content">职责：\n负责团队开发协调各项工作。\n业绩：\n成功上线app与各大平台，并且达到百万级并发。\n其他：\n获得各大奖项，优秀领导者、优秀员工等。</text>
		</view>
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view> -->
		
		<view class="title-box">
			<image src="../../../static/icons/hr/point.png" class="point-icon"></image>
			<text class="title-words">资格证书</text>
		</view>
		<view class="tags-box">
			<view class="cand-tags-wrapper" v-for="(c, index) in credentialsArr" :key="c.id">
				<text class="cand-tag">{{c}}</text>
			</view>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="title-box">
			<image src="../../../static/icons/hr/point.png" class="point-icon"></image>
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
		
		<!-- <view class="work-wrapper">
			<view class="work-box">
				<text class="company-name-words">南京大学</text>
				<text class="work-year-words">2008.09-2012.06</text>
			</view>
			<text class="project-exp-content">本科·计算机信息管理</text>
		</view> -->
		
		<!-- <view class="line-wrapper" style="margin: 20px 0; padding: 0 20px;"><view class="line" style="width: 100%;"></view></view> -->
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				resume: {},
				credentialsArr: [],
				skillsArray: [],
				lastWorkExp: {},
				edu: "",
				
				currentUserInfo: null,
				resumeUserInfo: null,
				workYears: 0,
				age: 18,
				sex: "保密",
				
				isLike: 0,
				
				background:{backgroundColor:'#fd5365'},
				height:0,
				navbarRight:0,
				opacity: 0,
				scrollY: 0,
				
				resumeExpectList: []
			}
		},
		onLoad(option) {
			let res =uni.getSystemInfoSync()
			this.height = res.windowHeight;
			this.navbarRight = res.windowWidth;
			
			// this.initMyJobExpectList();
			
			var resumeUserId = option.resumeUserId;
			// 如果resumeUserId为空，表示是自己预览（默认），如果不为空，则根据传来的id查询
			if (resumeUserId == null || resumeUserId == undefined || resumeUserId == "") {
				resumeUserId = getApp().getUserInfoSession().id;
			}
			
			// 查询用户信息
			this.getResumeUserInfo(resumeUserId);
			
			// 查询用户简历信息
			this.getMyResume(resumeUserId);
		},
		onShow() {
			// var currentUserInfo = getApp().getUserInfoSession();
			// this.currentUserInfo = currentUserInfo;
			// this.initShowUserInfo(currentUserInfo);
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
			
			getResumeUserInfo(resumeUserId) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + resumeUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var resumeUserInfo = result.data.data;
							me.resumeUserInfo = resumeUserInfo;
							
							me.initShowUserInfo(resumeUserInfo);
						}
					}
				})
			},
			
			initMyJobExpectList(resumeId, resumeUserId) {
			
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				// var resumeId = this.resumeId;
				
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
			
			formatDateTime(timeStr) {
				if (timeStr == null || timeStr == undefined || timeStr == "") {
					return "";
				}
				var arr = timeStr.split("T");
				return arr[0] + " " + arr[1];
			},
			
			initShowUserInfo(user) {
				console.log(user);
				var birthday = user.birthday;
				var age = app.getAge(birthday);
				// console.log("age = " + age);
				this.age = age;
				
				var startWorkDate = user.startWorkDate;
				var workYears = app.getAge(startWorkDate);
				this.workYears = workYears;
				
				var sex = user.sex;
				if (sex == 1) {
					sex = "男";
				} else if (sex == 0) {
					sex = "女";
				} else {
					sex = "保密"
				}
				this.sex = sex;
			},
			
			getMyResume(resumeUserId){
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
							
							me.initMyJobExpectList(resume.id, resumeUserId);
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
			
			goback() {
				uni.navigateBack({
					delta: 1
				})
			},
			
			like() {
				this.isLike = 1;
			},
			
			unlike() {
				this.isLike = 0;
			},
			
			editJob() {
				uni.navigateTo({
					url: "./publishNewJob/publishNewJob",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
		}
	}
</script>

<style>
	@import url("previewResumePage.css");
</style>
