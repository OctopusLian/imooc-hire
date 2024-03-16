<!-- 工作内容/职责/业绩 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">工作内容/职责/业绩</text>
				<text class="title-two">突出你在职公司期间的工作内容、工作职责或者工作业绩~</text>
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
				placeholder: '例如：\n1. 工作的内容...\n2. 取得的业绩...\n3. 获得的表彰...',
				advantageLength: 0,
				contentHtml: "",
				contentText: "",
			}
		},
		onShow() {
			
		},
		onLoad(options) {
			var contentHtml = options.contentHtml;
			if (contentHtml == undefined || contentHtml == null) {
				this.contentHtml = "";
			} else {
				this.contentHtml = contentHtml;
			}
			
			this.contentText = options.contentText;
			console.log(options);
			this.calLength(this.contentText);
		},
		onNavigationBarButtonTap() {
			this.saveWorkContent();
		},
		methods:{
			saveWorkContent() {
				console.log(this.contentHtml);
				console.log(this.contentText);
				
				uni.setStorageSync("workContentHtml", this.contentHtml);
				uni.setStorageSync("workContentText", this.contentText);
				
				uni.navigateBack({
					delta: 1
				})
			},
			
			entering(e) {
				var editorCtx = this.editorCtx;
				// console.log(222333);
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
				// console.log(this.contentHtml)
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
	@import url("workContent.css");
</style>
