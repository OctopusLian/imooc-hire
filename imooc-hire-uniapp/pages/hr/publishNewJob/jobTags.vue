<!-- 职位标签 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<view class="big-title-wrapper">
					<text class="title-one">职位标签</text>
					<view class="counts-wrapper">
						<text>(</text>
						<text :class="{'length-red': tagsArray.length > 10, 'length-green': tagsArray.length <= 10}">{{tagsArray.length}}</text>
						<text>/10</text>
						<text>)</text>
					</view>
				</view>
				
				<text class="title-two">合适的职位标签有助于被检索，更有助于突出显示给候选人</text>
			</view>
			
			<view class="company-wrapper">
				<input
					class="company-input"
					type="text" 
					:value="tag" 
					:model="tag" 
					placeholder="请输入标签"
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
				</view>
				
				<view class="tag-selected">
					<text class="tag-words-selected">人工智能</text>
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
			}
		},
		onNavigationBarButtonTap() {
			if (this.tagsArray.length > 10) {
				uni.showModal({
					title: "只能添加最多10个职位标签噢~",
					cancelText: "取消",
					confirmText: "确定",
					confirmColor: "#31B9B3",
					success(e) {
						return;
					}
				});
				return;
			}
			// console.log(this.jobDescription);
			uni.setStorageSync("tagsArray", this.tagsArray);
			
			uni.navigateBack({
				delta: 1
			})
		},
		onShow() {
		},
		onLoad(options) {
			var tags = options.tags;
			if (tags != null && tags != "" && tags != undefined) {
				var tempArr = tags.split(",");
				for (var i = 0 ; i < tempArr.length ; i ++) {
					if (tempArr[i] != null && tempArr[i] != "" && tempArr[i] != undefined) {
						this.tagsArray.push(tempArr[i]);
					}
				}
			}	
		},
		methods: {
			enterMe(e) {
				this.tag = e.detail.value;
			},
			
			addTag() {
				if(this.tag == "" || this.tag == undefined) {
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
	@import url("jobTags.css");
</style>
