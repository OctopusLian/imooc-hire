<!-- 技能标签 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper">
				<view class="big-title-wrapper">
					<text class="title-one">我的技能天赋</text>
					<view class="counts-wrapper">
						<text>(</text>
						<text :class="{'length-red': tagsArray.length > 30, 'length-green': tagsArray.length <= 30}">{{tagsArray.length}}</text>
						<text>/30</text>
						<text>)</text>
					</view>
				</view>
				<text class="title-two">你所精通的技能天赋，可以获得更多招聘者的青睐~</text>
			</view>
			
			<view class="company-wrapper">
				<input
					class="company-input"
					type="text" 
					:value="tag" 
					:model="tag" 
					placeholder="请输入技能名称"
					placeholder-class="placeholder"
					maxlength="12"
					@input="enterMe"/>
				
				<view class="btn-add-wrapper" @click="addTag()">
					<text class="btn-add-words">添加</text>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
			<view class="tags-wrapper">
				<view class="tag-selected" v-for="(t, index) in tagsArray" :key="index">
					<text class="tag-words-selected">{{t}}</text>
					<image src="../../../static/icons/hr/tag-delete.png" class="x" @click="deleteOneTag(index)"></image>
				</view>
				
				<!-- <view class="tag-selected">
					<text class="tag-words-selected">大数据</text>
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
				tag: "",
				tagsArray: [], 
				resumeId: "",
			}
		},
		onShow() {
			
		},
		onLoad(options) {
			var resumeId = options.resumeId;
			if (resumeId != null && resumeId != "" && resumeId != undefined) {
				this.resumeId = resumeId;
			} else {
				this.resumeId = "";
			}
			
			var skills = options.skills;
			if (skills != null && skills != "" && skills != undefined) {
				this.skills = skills;
				this.dealSkills(skills);
			} else {
				this.skills = "";
			}
		},
		onNavigationBarButtonTap() {
			this.saveQualification();
		},
		methods:{
			dealSkills(skills) {
				var arr = skills.split(",");
				// console.log(arr);
				
				var tagsArray = [];
				for (var i = 0 ; i < arr.length ; i ++) {
					if (arr[i] != null && arr[i] != "" && arr[i] != undefined) {
						tagsArray.push(arr[i]);
					}
				}
				this.tagsArray = tagsArray;
			},
			
			saveQualification() {
				if (this.tagsArray.length < 1) {
					uni.showModal({
						title: "请至少添加1个技能天赋~",
						cancelText: "取消",
						confirmText: "确定",
						confirmColor: "#31B9B3",
						success(e) {
							return;
						}
					});
					return;
				}
				
				if (this.tagsArray.length > 20) {
					uni.showModal({
						title: "只能添加最多20个技能天赋噢~",
						cancelText: "取消",
						confirmText: "确定",
						confirmColor: "#31B9B3",
						success(e) {
							return;
						}
					});
					return;
				}
				// uni.setStorageSync("tagsArray", this.tagsArray);
				// console.log(this.tagsArray)
				
				var tagsArray = this.tagsArray;
				
				var myTags = ",";
				for (var i = 0; i < tagsArray.length ; i ++) {
					myTags += tagsArray[i];
					myTags += ",";
				}
				// console.log(myTags)
				
					var me = this;
					var userId = app.getUserInfoSession().id;
					
					var pendingInfo = {
						"id": this.resumeId,
						"userId": userId,
						"skills": myTags,
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
								// this.resume = resume;
								
								uni.showToast({
									title: "修改成功~",
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
			
			
			enterMe(e) {
				this.tag = e.detail.value;
			},
			
			addTag() {
				if(this.tag == "" || this.tag == undefined) {
					uni.showToast({
						icon: "none",
						title: "技能名称不能为空"
					})
					return;
				}
				
				this.tagsArray.push(this.tag);
				this.tag = "";
			},
			
			deleteOneTag(index) {
				this.tagsArray.splice(index, 1);
			}
		
			
		}
	}
</script>

<style>
	@import url("qualification.css");
</style>
