<!-- 求职期望 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">想找什么样的工作？</text>
				<text class="title-two">添加多个求职期望，获得更多精准的工作机遇</text>
			</view>
			
			<view v-for="(expect, index) in resumeExpectList" :key="index" class="expect-wrapper" @click="gotoExpectDetail(expect.id)">
				<view class="left-part">
					<text class="position-text">[{{expect.city}}] {{expect.jobName}}</text>
					<text class="position-desc-text">{{expect.beginSalary}}k-{{expect.endSalary}}k {{expect.industry}}</text>
				</view>
				
				<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
			</view>
		
			<!-- <view class="expect-wrapper" @click="gotoExpectDetail('id1002')">
				<view class="left-part">
					<text class="position-text">[北京] 项目经理</text>
					<text class="position-desc-text">30k-35k 电子商务/互联网</text>
				</view>
				
				<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
			</view>
			
			<view class="expect-wrapper" @click="gotoExpectDetail('id1003')">
				<view class="left-part">
					<text class="position-text">[北京] Java高级开发</text>
					<text class="position-desc-text">30k-35k 电子商务/互联网</text>
				</view>
				
				<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
			</view> -->
			
			
			<view class="add-expect-box" @click="gotoExpectDetail()">
				<image src="../../../static/icons/candidate/icon-comment-publis.png" class="icon-add" @click=""></image>
				<text class="expect-text">添加求职期望</text>
			</view>
		
			<view class="work-status" @click="changeWorkStatus()">
				<text class="work-status-text">求职状态</text>
				
				<view class="operate-status">
					<text class="position-status-text">{{currentStatus}}</text>
					<image src="../../../static/icons/right-arrow-gray.png" class="right-arrow"></image>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				currentStatus: "离职，正在找工作",
				statusList:[],
				statusList2: [
					"离职，正在找工作",
					"在职，急寻新工作",
					"在职，看看新机会",
					"在职，暂无跳槽打算",
				],
				resumeOpenStatusList: [],
				
				resumeId: "",
				resumeStatus: "",
				resumeExpectList: [],
			}
		},
		onShow() {
			this.initMyJobExpectList();
			this.getResumeOpenStatusList();
		},
		onLoad(options) {
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.resumeId = resumeId;
			}
			// console.log(resumeId);
			
			var resumeStatus = options.resumeStatus;
			if (resumeStatus != null && resumeStatus != "" && resumeStatus != undefined) {
				this.currentStatus = resumeStatus;
			}
		},
		methods:{
			getResumeOpenStatusList() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/dataDict/app/getDataByCode?typeCode=ResumeOpenStatus",
					success(result) {
						
						if (result.data.status == 200) {
							var resumeOpenStatusList = result.data.data;
							console.log(resumeOpenStatusList);
							me.resumeOpenStatusList = resumeOpenStatusList;
							
							for (var i = 0 ; i < resumeOpenStatusList.length ; i ++) {
								me.statusList.push(resumeOpenStatusList[i].itemValue);
							}
							
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
			
			initMyJobExpectList() {
			
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
					url: serverUrl + "/resume/getMyResumeExpectList?resumeId=" + resumeId + "&userId=" + userId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							var resumeExpectList = result.data.data;
							console.log(resumeExpectList);
							me.statusList = [];
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
			
			changeWorkStatus() {
				var me = this;
				uni.showActionSheet({
					itemList: this.statusList,
					success(e) {
						// console.log(e)
						me.currentStatus = me.statusList[e.tapIndex];
						
						me.modifyStatus(me.currentStatus);
					}
				});
				
			},
			
			modifyStatus(currentStatus) {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var pendingInfo = {
					"id": this.resumeId,
					"userId": userId,
					"status": currentStatus,
				};
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/resume/modify",
					data: pendingInfo,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							// var resume = result.data.data;
							// console.log(resume);
							
							uni.showToast({
								title: "修改成功~",
								duration: 2000,
								success() {
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
			
			gotoCompanyPhoto() {
				uni.navigateTo({
					url: "./companyPhoto",
					animationType: "slide-in-bottom"
				});
			},
			
			gotoExpectDetail(expectId) {
				
				// console.log(expectId);
				
				var resumeId = this.resumeId;
				
				if (expectId != null && expectId != "" && expectId != undefined) {
					
					var resumeExpectList = this.resumeExpectList;
					var resumeExpect = {};
					for (var i = 0 ; i < resumeExpectList.length ; i ++) {
						if (expectId == resumeExpectList[i].id) {
							resumeExpect = resumeExpectList[i];
						}
					}
					
					uni.navigateTo({
						url: "./expectDetail?expectId=" + expectId + "&resumeId=" + resumeId + "&resumeExpectStr=" + JSON.stringify(resumeExpect),
						animationType: "slide-in-bottom"
					});
				} else {
					
					var length = this.resumeExpectList.length;
					if (length >= 3) {
						uni.showModal({
							title: "每位求职者最多只能发布三个求职期望",
							cancelText: "取消",
							confirmText: "确定",
							confirmColor: "#31B9B3",
							success(e) {
								return;
							}
						});
						return;
					}
					
					
					
					uni.navigateTo({
						url: "./expectDetail?resumeId=" + resumeId,
						animationType: "slide-in-bottom"
					});
				}
			},
		}
	}
</script>

<style>
	@import url("jobExpect.css");
</style>
