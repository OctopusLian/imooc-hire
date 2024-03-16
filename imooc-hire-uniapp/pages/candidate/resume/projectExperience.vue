<!-- 项目经验 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">项目名称</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="projectExp.projectName" 
						:model="projectExp.projectName" 
						placeholder="请填写项目名称"
						placeholder-class="placeholder"
						maxlength="36"
						@input="typingContentProjectName"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">担任职务</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="projectExp.roleName" 
						:model="projectExp.roleName" 
						placeholder="请填写职务"
						placeholder-class="placeholder"
						maxlength="12"
						@input="typingContentRoleName"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">项目时间</text>
				
				<view class="job-day-wrapper">
					<picker mode="multiSelector" :range="firstDayRange" :value="projectExp.beginDate" @change="bindJobFirstDayChange"
						:class="projectExp.beginDate == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{projectExp.beginDate == "" ? "请选择" : projectExp.beginDate}}</view>
					</picker>
					
					<text class="day-split">—</text>
				
					<picker mode="multiSelector" :range="lastDayRange" :value="projectExp.endDate" @change="bindJobLastDayChange"  @columnchange="changeLastDay"
						:class="projectExp.endDate == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{projectExp.endDate == "" ? "请选择" : projectExp.endDate}}</view>
					</picker>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">项目描述</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="projectExp.content" 
						:model="projectExp.content" 
						placeholder="请填写项目描述"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoProjectContent(projectExp.contentHtml, projectExp.content)"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoProjectContent(projectExp.contentHtml, projectExp.content)"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="btn-next-wrapper" v-if="projectExp.id != null && projectExp.id != '' && projectExp.id != undefined" @click="deleteProjectExp()">
				<text class="btn-next-words">删除项目经验</text>
			</view>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			const date = new Date()
			const years = []
			const year = date.getFullYear()
			const lastDayYears = []
			const months = []
			const month = date.getMonth() + 1
			const days = []
			const day = date.getDate()
			for (let i = 1990; i <= date.getFullYear(); i++) {
				years.unshift(i)
			}
			for (let i = 1990; i <= date.getFullYear(); i++) {
				lastDayYears.unshift(i)
			}
			lastDayYears.unshift("至今")
			for (let i = 1; i <= 12; i++) {
				months.push(i)
			}
			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			return {
				projectExp: {
				    "id": "",
				    "userId": "",
				    "resumeId": "",
				    "projectName": "",
				    "roleName": "",
				    "beginDate": "",
				    "endDate": "",
				    "content": "",
				    "contentHtml": ""
				},
				projectName: "",
				position: "",
				jobFirstDay: "开始时间",
				jobLastDay: "结束时间",
				projectContentHtml: "",
				projectContent: "",
				
				years,
				lastDayYears,
				year,
				months,
				month,
				days,
				day,
				firstDayRange: [
					years, 
					months
				],
				lastDayRange: [
					lastDayYears, 
					// months
				]
			}
		},
		onShow() {
			var projectContentHtml = uni.getStorageSync("projectContentHtml");
			if (projectContentHtml != undefined && projectContentHtml != "" && projectContentHtml != null) {
				this.projectExp.contentHtml = projectContentHtml;
			}
			//  else {
			// 	this.projectContentHtml = "";
			// }
	
			var projectContentText = uni.getStorageSync("projectContentText");
			console.log(projectContentText);
			if (projectContentText != undefined && projectContentText != "" && projectContentText != null) {
				this.projectExp.content = projectContentText;
			} 
			// else {
			// 	this.projectContent = "";
			// }
	
		},
		onLoad(options) {
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.projectExp.resumeId = resumeId;
			} else {
				this.projectExp.resumeId = "";
			}
			console.log(resumeId);
			
			var projectExpId = options.projectExpId;
			if (projectExpId != null && projectExpId != "" && projectExpId != undefined) {
				this.projectExp.id = projectExpId;
				// 查询当前单个工作经历
				console.log(this.projectExp);
			} else {
				this.projectExp.id = "";
			}
			
			this.getProjectExp();
		},
		onNavigationBarButtonTap() {
			this.saveProjectExperience();
		},
		methods:{
			getProjectExp() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				var projectExpId = this.projectExp.id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/getProjectExp?projectExpId=" + projectExpId + "&userId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var projectExp = result.data.data;
							console.log(projectExp);
							if (projectExp != null) {
								me.projectExp = projectExp;
							}
							// me.initInfo();
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
			
			typingContentRoleName(e) {
				var event = e;
				this.projectExp.roleName= e.detail.value;
			},
			
			typingContentProjectName(e) {
				var event = e;
				this.projectExp.projectName= e.detail.value;
			},
			
			saveProjectExperience() {
				// console.log(this.contentHtml);
				// console.log(this.contentText);
				
				
					var me = this;
					var userId = app.getUserInfoSession().id;
					
					var projectExp = this.projectExp;
					projectExp.userId = userId;
					console.log(projectExp);
					
					if (projectExp.projectName == null || projectExp.projectName == "" || projectExp.projectName == undefined) {
						uni.showToast({
							icon: "none",
							title: "项目名称不能为空~"
						})
						return;
					}
					
					if (projectExp.roleName == null || projectExp.roleName == "" || projectExp.roleName == undefined) {
						uni.showToast({
							icon: "none",
							title: "职务不能为空~"
						})
						return;
					}
					
					if (projectExp.beginDate == null || projectExp.beginDate == "" || projectExp.beginDate == undefined
						|| projectExp.endDate == null || projectExp.endDate == "" || projectExp.endDate == undefined) {
						uni.showToast({
							icon: "none",
							title: "项目时间不能为空~"
						})
						return;
					}
					
					if (projectExp.contentHtml == null || projectExp.contentHtml == "" || projectExp.contentHtml == undefined
						|| projectExp.content == null || projectExp.content == "" || projectExp.content == undefined) {
						uni.showToast({
							icon: "none",
							title: "项目描述不能为空~"
						})
						return;
					}
					
					var serverUrl = app.globalData.serverUrl;
					uni.request({
						method: "POST",
						header: {
							headerUserId: userId,
							headerUserToken: app.getUserSessionToken()
						},
						url: serverUrl + "/resume/editProjectExp",
						data: projectExp,
						success(result) {
							// console.log(result);
							if (result.data.status == 200) {
								// var resume = result.data.data;
								// console.log(resume);
								// this.resume = resume;
								
								uni.removeStorageSync("projectContentHtml");
								uni.removeStorageSync("projectContentText");
								
								uni.showToast({
									title: "保存成功~",
									duration: 2000,
									success() {
										uni.navigateBack({
											delta: 1,
											animationType: "fade-out"
										})
									}
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
			
			changeLastDay(e) {
				var column = e.detail.column;
				var newIndex = e.detail.value;
				if (column == 0 && newIndex == 0) {
					this.lastDayRange = [
						this.lastDayYears
					]
				} else {
					this.lastDayRange = [
						this.lastDayYears, this.months
					]
				}
			},
			
			
			bindJobLastDayChange(e) {
				var selectedArray = e.detail.value;
				console.log(selectedArray);
				console.log(selectedArray.length);
				var yearIndex = selectedArray[0];
				
				if (yearIndex == 0) {
					this.projectExp.endDate = this.lastDayRange[0][yearIndex];
				} else {
					var monthIndex = selectedArray[1];
					
					var year = this.lastDayRange[0][yearIndex];
					var month = this.lastDayRange[1][monthIndex];
					
					this.projectExp.endDate = year + "-" + (month < 10 ? '0' + month : month);
				}
				
			},
			
			bindJobFirstDayChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				
				var year = this.firstDayRange[0][yearIndex];
				var month = this.firstDayRange[1][monthIndex];
				
				this.projectExp.beginDate = year + "-" + (month < 10 ? '0' + month : month);
			},
			
			editWorkContent() {
				var contentHtml = "<ul>"
								+ "<li>插入的 html 中事件绑定会被移除</li>"
								+ "<li>formats 中的 color 属性会统一以 hex 格式返回</li>"
								+ "<li>粘贴时仅纯文本内容会被拷贝进编辑器</li>"
								+ "<li>插入 html 到编辑器内时，编辑器会删除一些不必要的标签，以保证内容的统一。例如<code>&lt;p&gt;&lt;span&gt;xxx&lt;/span&gt;&lt;/p&gt;</code>会改写为<code>&lt;p&gt;xxx&lt;/p&gt;</code></li>"
								+ "<li>编辑器聚焦时页面会被上推，系统行为以保证编辑区可见</li>"
								+ "<li>H5端会动态引入依赖  加载，如过依赖加载较慢，可以下载下来放在自己的服务器或 CDN 服务商，然后在 自定义模板</a> head 内引入。</li>"
								+ "<li>不能直接插入视频，编辑时可以采用视频封面占位，并在图片属性中保存视频信息，预览时再还原为视频。</li>"
								+ "</ul>"; 
				var contentText = "插入的 html 中事件绑定会被移除"
									+ "formats 中的 color 属性会统一以 hex 格式返回"
									+ "粘贴时仅纯文本内容会被拷贝进编辑器"
									+ "插入 html 到编辑器内时，编辑器会删除一些不必要的标签，以保证内容的统一。例如ee";
				this.gotoWorkContent(contentHtml, contentText)
			},
			
			gotoProjectContent(contentHtml, contentText) {
				uni.navigateTo({
					url: "projectContent?contentHtml=" + contentHtml + "&contentText=" + contentText,
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoJobType() {
				uni.navigateTo({
					url: "../../hr/publishNewJob/chooseJobType",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			bindSalaryChange(e) {
				var selectedArray = e.detail.value;
				var startSalaryIndex = selectedArray[0];
				var endSalaryIndex = selectedArray[1];
				
				var startSalary = this.salaryRange[0][startSalaryIndex];
				var endSalary = this.salaryRange[1][endSalaryIndex];
				
				this.salary = startSalary.split("K")[0] + "-" + endSalary;
			},
			
			deleteProjectExp() {
				var me = this;
				var projectExpId = this.projectExp.id;
				console.log(projectExpId);
				
				uni.showModal({
					title: "确认删除该项目经验？",
					cancelText: "取消",
					confirmText: "确定",
					confirmColor: "#31B9B3",
					success(e) {
						if (e.confirm) {
							
								
								var userId = app.getUserInfoSession().id;
								
								var serverUrl = app.globalData.serverUrl;
								uni.request({
									method: "POST",
									header: {
										headerUserId: userId,
										headerUserToken: app.getUserSessionToken()
									},
									url: serverUrl + "/resume/deleteProjectExp?projectExpId=" + projectExpId + "&userId=" + userId,
									success(result) {
										// console.log(result);
										if (result.data.status == 200) {
											uni.navigateBack({
												delta: 1
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
							
						}
					}
				});
				
			}
		}
	}
</script>

<style>
	@import url("projectExperience.css");
</style>
