<!-- 编辑简历页 -->
<template>
	<view>
		
		<view class="me-wrapper">
			<view class="name-box">
				<view class="edit-area">
					<text class="name-words">{{currentUserInfo.nickname}}</text>
					<image src="../../../static/icons/icon-edit-3.png" class="icon-edit" @click="gotoMyInfo()"></image>
				</view>
				
				<text class="desc-words">{{workYears}}年以上经验 · {{age}}岁 · {{sex}} {{edu == "" ? "" : '· ' + edu}}</text>
			</view>
			
			<image :src="currentUserInfo.face" class="small-face"></image>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0px 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="info-box" style="margin-top: 30px;">
			<view class="edit-area" style="justify-content: space-between;">
				<text class="lable-words">个人优势</text>
				<image src="../../../static/icons/icon-edit-3.png" class="icon-edit" @click="gotoMyAdvantage()"></image>
			</view>
			<!-- <text class="desc-words" style="margin-top: 12px;">3年开发经验，精通各种技术，非常厉害，架构师大数据啥都精通，来吧，招我把，哈哈哈哈哈哈。三年海王，老厉害了，符合我们公司文化！</text> -->
			<text class="desc-words" style="margin-top: 12px;">{{(resume.advantage == null || resume.advantage == '' || resume.advantage == undefined ) ? '暂未填写...' : resume.advantage}}</text>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0px 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="info-box" style="margin-top: 30px;">
			<view class="edit-area" style="justify-content: space-between;">
				<text class="lable-words">工作经验</text>
				<image src="../../../static/icons/icon-add.png" class="icon-edit" @click="gotoWorkHistroy()"></image>
			</view>
		</view>
		
		<view class="work-wrapper" v-for="(workExp, index) in resume.workExpList" :key="workExp.id" @click="gotoEditWorkHistroy(workExp.id)">
			<view class="work-box">
				<text class="company-name-words">{{workExp.companyName}}</text>
				
				<view class="update-area">
					<text class="work-year-words">{{workExp.beginDate}} - {{workExp.endDate}}</text>
					<image src="../../../static/icons/right-arrow-gray.png" class="icon-edit-small"></image>
				</view>
			</view>
			<text class="position-words" style="margin-top: 6px;">{{workExp.position}}·{{workExp.department}}·{{workExp.industry}}</text>
			<text class="work-exp-content">{{workExp.content}}</text>
		</view>
		
		<!-- <view class="work-wrapper">
			<view class="work-box">
				<text class="company-name-words">北京慕课网科技有限公司</text>
				
				<view class="update-area">
					<text class="work-year-words">2019.09-至今</text>
					<image src="../../../static/icons/right-arrow-gray.png" class="icon-edit-small"></image>
				</view>
			</view>
			<text class="position-words" style="margin-top: 6px;">Java高级开发·技术部</text>
			<text class="work-exp-content">3年开发经验，精通各种技术，非常厉害，架构师大数据啥都精通，来吧，招我把，哈哈哈哈哈哈。三年海王，老厉害了，符合我们公司文化！</text>
		</view> -->
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0px 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="info-box" style="margin-top: 30px;">
			<view class="edit-area" style="justify-content: space-between;">
				<text class="lable-words">项目经验</text>
				<image src="../../../static/icons/icon-add.png" class="icon-edit" @click="gotoProjectExperience()"></image>
			</view>
		</view>
		
		<view class="work-wrapper" v-for="(projectExp, index) in resume.projectExpList" :key="projectExp.id" @click="gotoEditProjectExp(projectExp.id)">
			<view class="work-box">
				<text class="company-name-words">{{projectExp.projectName}}</text>
				
				<view class="update-area">
					<text class="work-year-words">{{projectExp.beginDate}} - {{projectExp.endDate}}</text>
					<image src="../../../static/icons/right-arrow-gray.png" class="icon-edit-small"></image>
				</view>
			</view>
			<text class="position-words" style="margin-top: 6px;">{{projectExp.roleName}}</text>
			<text class="work-exp-content">{{projectExp.content}}</text>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0px 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="info-box" style="margin-top: 30px;">
			<view class="edit-area" style="justify-content: space-between;">
				<text class="lable-words">教育经历</text>
				<image src="../../../static/icons/icon-add.png" class="icon-edit" @click="gotoMyEducation()"></image>
			</view>
		</view>
		
		<view class="work-wrapper" v-for="(edu, index) in resume.educationList" :key="edu.id" @click="gotoEditMyEducation(edu.id)">
			<view class="work-box">
				<text class="company-name-words">{{edu.school}}</text>
				
				<view class="update-area">
					<text class="work-year-words">{{edu.beginDate}} - {{edu.endDate}}</text>
					<image src="../../../static/icons/right-arrow-gray.png" class="icon-edit-small"></image>
				</view>
			</view>
			<text class="position-words" style="margin-top: 4px;">{{edu.education}} · {{edu.major}}</text>
		</view>
		
		<!-- <view class="work-wrapper">
			<view class="work-box">
				<text class="company-name-words">南开大学</text>
				
				<view class="update-area">
					<text class="work-year-words">2019.09-至今</text>
					<image src="../../../static/icons/right-arrow-gray.png" class="icon-edit-small"></image>
				</view>
			</view>
			<text class="position-words" style="margin-top: 4px;">研究生 · 计算机软件</text>
		</view> -->
		
		<view class="line-wrapper" style="margin: 20px 0; padding: 0px 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="info-box" style="margin-top: 30px;">
			<view class="edit-area" style="justify-content: space-between;">
				<text class="lable-words" @click="gotoQualification">资格证书</text>
				<image src="../../../static/icons/icon-add.png" class="icon-edit" @click="gotoQualification"></image>
			</view>
		</view>
		<view class="tags-box">
			<view class="cand-tags-wrapper" v-for="(c, index) in credentialsArr" :key="c.id" @click="gotoQualification">
				<text class="cand-tag">{{c}}</text>
			</view>
			<!-- <view class="cand-tags-wrapper">
				<text class="cand-tag">PMP</text>
			</view> -->
		</view>
		
		<view class="line-wrapper" style="margin: 30px 0 20px 0; padding: 0px 20px;"><view class="line" style="width: 100%;"></view></view>
		
		<view class="info-box" style="margin-top: 30px;">
			<view class="edit-area" style="justify-content: space-between;">
				<text class="lable-words" @click="gotoTechTags()">技能标签</text>
				<image src="../../../static/icons/icon-add.png" class="icon-edit" @click="gotoTechTags()"></image>
			</view>
		</view>
		<view class="tags-box">
			<view class="cand-tags-wrapper" v-for="(s, index) in skillsArray" :key="s.id" @click="gotoTechTags()">
				<text class="cand-tag">{{s}}</text>
			</view>
			<!-- <view class="cand-tags-wrapper">
				<text class="cand-tag">Java</text>
			</view> -->
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		components: {
		},
		data() {
			return {
				resume: {},
				credentialsArr: [],
				skillsArray: [],
				edu: "",
				
				currentUserInfo: null, 
				workYears: 0,
				age: 18,
				sex: "保密",
			}
		},
		onShow() {
			this.getMyResume();
			
			var currentUserInfo = getApp().getUserInfoSession();
			this.currentUserInfo = currentUserInfo;
			this.initShowUserInfo(currentUserInfo);
		},
		onNavigationBarButtonTap() {
			this.previewResume();
		},
		methods: {
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
			
			getMyResume(){
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/queryMyResume?userId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var resume = result.data.data;
							console.log(resume);
							me.resume = resume;
							
							var credentials = resume.credentials;
							var skills = resume.skills;
							var educationList = resume.educationList;
							me.dealCredentials(credentials);
							me.dealSkills(skills);
							me.dealEdu(educationList);
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
			
			gotoTechTags() {
				var resumeId = this.resume.id;
				console.log(resumeId);
				uni.navigateTo({
					url: "techTags?resumeId=" + resumeId + "&skills=" + this.resume.skills,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoQualification() {
				// var credentials = this.resume.credentials;
				var resumeId = this.resume.id;
				// console.log(credentials);
				uni.navigateTo({
					url: "qualification?resumeId=" + resumeId + "&credentials=" + this.resume.credentials,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoMyEducation() {
				var resumeId = this.resume.id;
				uni.navigateTo({
					url: "myEducation?resumeId=" + resumeId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoEditMyEducation(eduId) {
				var resumeId = this.resume.id;
				uni.navigateTo({
					url: "myEducation?resumeId=" + resumeId + "&eduId=" + eduId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoProjectExperience() {
				var resumeId = this.resume.id;
				uni.navigateTo({
					url: "projectExperience?resumeId=" + resumeId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoEditProjectExp(projectExpId) {
				var resumeId = this.resume.id;
				// return;
				uni.navigateTo({
					url: "projectExperience?resumeId=" + resumeId + "&projectExpId=" + projectExpId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoWorkHistroy() {
				// console.log(this.resume)
				var resumeId = this.resume.id;
				// return;
				uni.navigateTo({
					url: "workHistroy?resumeId=" + resumeId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoEditWorkHistroy(workExpId) {
				var resumeId = this.resume.id;
				// return;
				uni.navigateTo({
					url: "workHistroy?resumeId=" + resumeId + "&workExpId=" + workExpId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoMyAdvantage() {
				var resume = this.resume;
				var advantageHtml = resume.advantageHtml; 
				var advantageText = resume.advantage;
				advantageHtml = (advantageHtml==undefined || advantageHtml==null || advantageHtml=='') ? "" : advantageHtml;
				advantageText = (advantageText==undefined || advantageText==null || advantageText=='') ? "" : advantageText;
				// var advantageHtml = "<ul>"
				// 				+ "<li>插入的 html 中事件绑定会被移除</li>"
				// 				+ "<li>formats 中的 color 属性会统一以 hex 格式返回</li>"
				// 				+ "<li>粘贴时仅纯文本内容会被拷贝进编辑器</li>"
				// 				+ "<li>插入 html 到编辑器内时，编辑器会删除一些不必要的标签，以保证内容的统一。例如<code>&lt;p&gt;&lt;span&gt;xxx&lt;/span&gt;&lt;/p&gt;</code>会改写为<code>&lt;p&gt;xxx&lt;/p&gt;</code></li>"
				// 				+ "<li>编辑器聚焦时页面会被上推，系统行为以保证编辑区可见</li>"
				// 				+ "<li>H5端会动态引入依赖  加载，如过依赖加载较慢，可以下载下来放在自己的服务器或 CDN 服务商，然后在 自定义模板</a> head 内引入。</li>"
				// 				+ "<li>不能直接插入视频，编辑时可以采用视频封面占位，并在图片属性中保存视频信息，预览时再还原为视频。</li>"
				// 				+ "</ul>"; 
				// var advantageText = "插入的 html 中事件绑定会被移除"
				// 					+ "formats 中的 color 属性会统一以 hex 格式返回"
				// 					+ "粘贴时仅纯文本内容会被拷贝进编辑器"
				// 					+ "插入 html 到编辑器内时，编辑器会删除一些不必要的标签，以保证内容的统一。例如ee";
				// console.log(resume);
				// return;
				uni.navigateTo({
					url: "myAdvantage?resumeId=" + resume.id + "&advantageHtml=" + advantageHtml + "&advantageText=" + advantageText,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			previewResume() {
				uni.navigateTo({
					url: "previewResumePage",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoMyInfo() {
				uni.navigateTo({
					url: "../../hr/hrInfo?type=" + this.userType.candidate,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},

		}
	}
</script>

<style>
	@import url("editResume.css");
</style>
