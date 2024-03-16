<!-- 工作经历/经验 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">公司名称</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="workExp.companyName" 
						:model="workExp.companyName" 
						placeholder="请填写公司名称"
						placeholder-class="placeholder"
						maxlength="36"
						@input="typingContent"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name">
				<text class="field-lable-words">所在行业</text>
				
				<view class="field-wrapper" style="">
					<input
						class="company-input"
						type="text" 
						:value="workExp.industry" 
						:model="workExp.industry" 
						placeholder="请选择行业"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoIndustry()"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoIndustry()"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">在职时间</text>
				
				<view class="job-day-wrapper">
					<!-- <input
						class="job-day-input"
						type="text" 
						:value="jobFirstDay" 
						:model="jobFirstDay" 
						placeholder="入职时间"
						placeholder-class="placeholder"
						maxlength="12"/> -->
					<!-- <picker mode="multiSelector" :range="firstDayRange" :value="jobFirstDay" @change="bindJobFirstDayChange"
						:class="jobFirstDay == '请选择' ? 'picker' : 'picker-words'">
						<view class="field-words">{{jobFirstDay}}</view>
					</picker> -->
					<picker mode="multiSelector" :range="firstDayRange" :value="workExp.beginDate" @change="bindJobFirstDayChange"
						:class="workExp.beginDate == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{workExp.beginDate == "" ? "请选择" : workExp.beginDate}}</view>
					</picker>
					
					<text class="day-split">—</text>
				
					<picker mode="multiSelector" :range="lastDayRange" :value="workExp.endDate" @change="bindJobLastDayChange"  @columnchange="changeLastDay"
						:class="workExp.endDate == '' ? 'picker' : 'picker-words'">
						<view class="field-words">{{workExp.endDate == "" ? "请选择" : workExp.endDate}}</view>
					</picker>
					<!-- <input
						class="job-day-input"
						type="text" 
						:value="jobLastDay" 
						:model="jobLastDay" 
						placeholder="离职时间"
						placeholder-class="placeholder"
						maxlength="12"/> -->
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">职位名称</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="workExp.position" 
						:model="workExp.position" 
						placeholder="请填写职位"
						placeholder-class="placeholder"
						maxlength="12"
						@input="typingContentPosition"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">所属部门</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="workExp.department" 
						:model="workExp.department" 
						placeholder="请填写部门"
						placeholder-class="placeholder"
						maxlength="12"
						@input="typingContentDepartment"/>
					<!-- <image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image> -->
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="block-name" style="margin-top: 20px;" >
				<text class="field-lable-words">职责业绩</text>
				
				<view class="field-wrapper">
					<input
						class="company-input"
						type="text" 
						:value="workExp.content" 
						:model="workExp.content" 
						placeholder="请填写内容/职责/业绩"
						placeholder-class="placeholder"
						disabled="true"
						maxlength="12"
						@click="gotoWorkContent(workExp.contentHtml, workExp.content)"/>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow" @click="gotoWorkContent(workExp.contentHtml, workExp.content)"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="btn-next-wrapper" v-if="workExp.id != null && workExp.id != '' && workExp.id != undefined" @click="deleteWorkExp()">
				<text class="btn-next-words">删除工作经历</text>
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
				workExp: {
					"id": "",
					"userId": "",
					"resumeId": "",
					"companyName": "",
					"industry": "",
					"beginDate": "",
					"endDate": "",
					"position": "",
					"department": "",
					"content": "",
					"contentHtml": ""
				},
				companyName: "",
				position: "",
				jobFirstDay: "请选择",
				jobLastDay: "请选择",
				workCity: "",
				industry: "",
				departmentName: "",
				workContentHtml: "",
				workContent: "",
				
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
			// this.getWorkExp();
			// var selectedJobType = uni.getStorageSync("selectedJobType");
			// // console.log(selectedJobType);
			// if (selectedJobType != undefined && selectedJobType != "" && selectedJobType != null) {
			// 	this.jobType = selectedJobType;
			// } else {
			// 	this.jobType = "";
			// }
			
			
	// 		var industry = uni.getStorageSync("selectedIndustry");
	// 		if (industry != undefined && industry != "") {
	// 			this.workExp.industry = industry;
	// 		} else {
	// 			this.workExp.industry = ""
	// 		}
	
	
	// 		var workContentHtml = uni.getStorageSync("workContentHtml");
	// 		if (workContentHtml != undefined && workContentHtml != "" && workContentHtml != null) {
	// 			this.workExp.contentHtml = workContentHtml;
	// 		} else {
	// 			this.workExp.contentHtml = "";
	// 		}
				
	// 		var workContentText = uni.getStorageSync("workContentText");
	// 		// console.log(workContentText);
	// 		if (workContentText != undefined && workContentText != "" && workContentText != null) {
	// 			this.workExp.content = workContentText;
	// 		} else {
	// 			this.workExp.content = "";
	// 		}
			
			this.initInfo();
			
		},
		onLoad(options) {
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.workExp.resumeId = resumeId;
			} else {
				this.workExp.resumeId = "";
			}
			console.log(resumeId);
			
			
			var workExpId = options.workExpId;
			if (workExpId != null && workExpId != "" && workExpId != undefined) {
				this.workExp.id = workExpId;
				// 查询当前单个工作经历
				console.log(this.workExp);
			} else {
				this.workExp.id = "";
			}
			
			this.getWorkExp();
		},
		onNavigationBarButtonTap() {
			this.saveWorkHistroy();
		},
		methods:{
			initInfo() {
				var industry = uni.getStorageSync("selectedIndustry");
				if (industry != undefined && industry != "") {
					this.workExp.industry = industry;
				} else {
					// this.workExp.industry = ""
				}
					
				console.log(this.workExp);
				var workContentHtml = uni.getStorageSync("workContentHtml");
				if (workContentHtml != undefined && workContentHtml != "" && workContentHtml != null) {
					this.workExp.contentHtml = workContentHtml;
				} else {
					// this.workExp.contentHtml = "";
				}
				console.log(this.workExp);
					
				var workContentText = uni.getStorageSync("workContentText");
				// console.log(workContentText);
				if (workContentText != undefined && workContentText != "" && workContentText != null) {
					this.workExp.content = workContentText;
				} else {
					// this.workExp.content = "";
				}
			},
			
			getWorkExp() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				var workExpId = this.workExp.id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/getWorkExp?workExpId=" + workExpId + "&userId=" + userId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var workExp = result.data.data;
							console.log(workExp);
							if (workExp != null) {
								me.workExp = workExp;
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
			
			saveWorkHistroy() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var workExp = this.workExp;
				workExp.userId = userId;
				console.log(workExp);
				
				if (workExp.companyName == null || workExp.companyName == "" || workExp.companyName == undefined) {
					uni.showToast({
						icon: "none",
						title: "公司名称不能为空~"
					})
					return;
				}
				
				if (workExp.industry == null || workExp.industry == "" || workExp.industry == undefined) {
					uni.showToast({
						icon: "none",
						title: "所在行业不能为空~"
					})
					return;
				}
				
				if (workExp.beginDate == null || workExp.beginDate == "" || workExp.beginDate == undefined
					|| workExp.endDate == null || workExp.endDate == "" || workExp.endDate == undefined) {
					uni.showToast({
						icon: "none",
						title: "在职时间不能为空~"
					})
					return;
				}
				
				if (workExp.position == null || workExp.position == "" || workExp.position == undefined) {
					uni.showToast({
						icon: "none",
						title: "职位不能为空~"
					})
					return;
				}
				
				if (workExp.department == null || workExp.department == "" || workExp.department == undefined) {
					uni.showToast({
						icon: "none",
						title: "所属部门不能为空~"
					})
					return;
				}

				if (workExp.contentHtml == null || workExp.contentHtml == "" || workExp.contentHtml == undefined
					|| workExp.content == null || workExp.content == "" || workExp.content == undefined) {
					uni.showToast({
						icon: "none",
						title: "职责业绩不能为空~"
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
					url: serverUrl + "/resume/editWorkExp",
					data: workExp,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							// var resume = result.data.data;
							// console.log(resume);
							// this.resume = resume;
							
							uni.removeStorageSync("workContentHtml");
							uni.removeStorageSync("workContentText");
							uni.removeStorageSync("selectedIndustry");
							
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
			
			typingContentDepartment(e) {
				var event = e;
				this.workExp.department = e.detail.value;
			},
			
			typingContentPosition(e) {
				var event = e;
				this.workExp.position = e.detail.value;
			},
			
			typingContent(e) {
				var event = e;
				this.workExp.companyName = e.detail.value;
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
					this.workExp.endDate = this.lastDayRange[0][yearIndex];
				} else {
					var monthIndex = selectedArray[1];
					
					var year = this.lastDayRange[0][yearIndex];
					var month = this.lastDayRange[1][monthIndex];
					
					this.workExp.endDate = year + "-" + (month < 10 ? '0' + month : month);
				}
				
			},
			
			bindJobFirstDayChange(e) {
				var selectedArray = e.detail.value;
				var yearIndex = selectedArray[0];
				var monthIndex = selectedArray[1];
				
				var year = this.firstDayRange[0][yearIndex];
				var month = this.firstDayRange[1][monthIndex];
				
				this.workExp.beginDate = year + "-" + (month < 10 ? '0' + month : month);
			},
			
			editWorkContent() {
				this.workExp.contentHtml = "<ul>"
								+ "<li>插入的 html 中事件绑定会被移除</li>"
								+ "<li>formats 中的 color 属性会统一以 hex 格式返回</li>"
								+ "<li>粘贴时仅纯文本内容会被拷贝进编辑器</li>"
								+ "<li>插入 html 到编辑器内时，编辑器会删除一些不必要的标签，以保证内容的统一。例如<code>&lt;p&gt;&lt;span&gt;xxx&lt;/span&gt;&lt;/p&gt;</code>会改写为<code>&lt;p&gt;xxx&lt;/p&gt;</code></li>"
								+ "<li>编辑器聚焦时页面会被上推，系统行为以保证编辑区可见</li>"
								+ "<li>H5端会动态引入依赖  加载，如过依赖加载较慢，可以下载下来放在自己的服务器或 CDN 服务商，然后在 自定义模板</a> head 内引入。</li>"
								+ "<li>不能直接插入视频，编辑时可以采用视频封面占位，并在图片属性中保存视频信息，预览时再还原为视频。</li>"
								+ "</ul>"; 
				this.workExp.content = "插入的 html 中事件绑定会被移除"
									+ "formats 中的 color 属性会统一以 hex 格式返回"
									+ "粘贴时仅纯文本内容会被拷贝进编辑器"
									+ "插入 html 到编辑器内时，编辑器会删除一些不必要的标签，以保证内容的统一。例如ee";
				this.gotoWorkContent(this.workExp.contentHtml, this.workExp.content)
			},
			
			gotoWorkContent(contentHtml, contentText) {
				
				// console.log(contentHtml);
				// console.log(contentText);
				// return;
				
				uni.navigateTo({
					url: "workContent?contentHtml=" + contentHtml + "&contentText=" + contentText,
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
			
			goArea() {
				uni.navigateTo({
					url: "../chooseProvince",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			gotoIndustry() {
				uni.navigateTo({
					url: "../../company/chooseIndustry",
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
			
			deleteWorkExp() {
				var me = this;
				var workExpId = this.workExp.id;
				console.log(workExpId);
				
				uni.showModal({
					title: "确认删除该工作经验？",
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
									url: serverUrl + "/resume/deleteWorkExp?workExpId=" + workExpId + "&userId=" + userId,
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
	@import url("workHistroy.css");
</style>
