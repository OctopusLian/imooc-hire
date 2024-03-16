<!-- 项目描述 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">项目描述</text>
				<text class="title-two">描述该项目，展示你的项目经验，突出你的项目成果或业绩~</text>
			</view>
			
			<editor 
				id="editor" 
				class="ql-container editor-content" 
				:placeholder="placeholder" 
				@ready="onEditorReady"
				@input="entering"></editor>
				
			<view class="last-block">
				<view>
					<text :class="{'enter-length-words': advantageLength <= 300, 'enter-length-words-max': advantageLength > 300}">{{advantageLength}}</text>
					<text class="max-length-words">/300</text>
				</view>
			</view>
			
			<view class="line-wrapper" style="margin: 10px 0 20px 0;"><view class="line" style="width: 100%;"></view></view>
			
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				placeholder: '例如：\n1. 项目概况...\n2. 人员分工...\n3. 我的职责...',
				advantageLength: 0,
				contentHtml: "",
				contentText: "",
			}
		},
		onShow() {
			
		},
		onLoad(options) {
			this.contentHtml = options.contentHtml;
			this.contentText = options.contentText;
			console.log(options);
			this.calLength(this.contentText);
		},
		onNavigationBarButtonTap() {
			this.saveProjectContent();
		},
		methods:{
			saveProjectContent() {
				// console.log(this.contentHtml);
				// console.log(this.contentText);
				
				uni.setStorageSync("projectContentHtml", this.contentHtml);
				uni.setStorageSync("projectContentText", this.contentText);
				
				uni.navigateBack({
					delta: 1
				})
			},
			
			entering(e) {
				var editorCtx = this.editorCtx;
				// console.log(e);
				this.contentHtml = e.detail.html;
				this.contentText = e.detail.text;
				
				this.calLength(e.detail.text);
			},
			
			calLength(contentText) {
				var text = contentText;
				var tempArr = text.split("\n");
				var tempText = "";
				for (var i = 0 ; i < tempArr.length ; i ++) {
					if (tempArr[i] != null && tempArr[i] != "" && tempArr[i] != undefined) {
						tempText += tempArr[i];
					}
				}
				// console.log(tempText);
				this.advantageLength = tempText.length;
			},
			
			onEditorReady() {
				uni.createSelectorQuery().select('#editor').context((res) => {
				  this.editorCtx = res.context;
				  console.log(this.contentHtml);
				  this.editorCtx.setContents({
					html: this.contentHtml
				  });
				}).exec()
			},
		}
	}
</script>

<style>
	@import url("projectContent.css");
</style>
