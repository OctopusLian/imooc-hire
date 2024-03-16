<!-- 我的优势/特长/亮点 -->
<template>
	<view>
		<view class="card-box">
			
			<view class="title-wrapper" style="margin-bottom: 20px;">
				<text class="title-one">我的优势</text>
				<text class="title-two">突出你的优势、特长、亮点，让用人单位更好的发现你吧~</text>
			</view>
			
			<editor 
				id="editor" 
				class="ql-container editor-content" 
				:placeholder="placeholder" 
				@ready="onEditorReady"
				@input="entering"></editor>
				
			<view class="last-block">
				<view>
					<text :class="{'enter-length-words': advantageLength <= 1000, 'enter-length-words-max': advantageLength > 1000}">{{advantageLength}}</text>
					<text class="max-length-words">/1000</text>
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
				placeholder: '请输入你的优势亮点...',
				advantageLength: 0,
				advantageHtml: "",
				advantageText: "",
			}
		},
		onShow() {
			
		},
		onLoad(options) {
			this.advantageHtml = options.advantageHtml;
			this.advantageText = options.advantageText;
			this.resumeId = options.resumeId;
			
			console.log(options);
			this.calLength(this.advantageText);
		},
		onNavigationBarButtonTap() {
			this.editAdvantage();
		},
		methods:{
			editAdvantage() {
				var me = this;
				var userId = app.getUserInfoSession().id;
				var advantageHtml = this.advantageHtml;
				var advantageText = this.advantageText;
				
				if (advantageHtml == null || advantageHtml == "" || advantageHtml == undefined 
					|| advantageText == null || advantageText == "" || advantageText == undefined) {
					uni.showToast({
						icon: "none",
						title: "内容不能为空~"
					})
					return;
				}
				
				var pendingInfo = {
					"id": this.resumeId,
					"userId": userId,
					"advantage": advantageText,
					"advantageHtml": advantageHtml,
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
			
			saveAdvantageContent2() {
				console.log(this.advantageHtml);
				console.log(this.advantageText);
			},
			
			entering(e) {
				var editorCtx = this.editorCtx;
				// console.log(e);
				this.advantageHtml = e.detail.html;
				this.advantageText = e.detail.text;
				
				this.calLength(e.detail.text);
			},
			
			calLength(advantageText) {
				var text = advantageText;
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
				  console.log(this.advantageHtml);
				  this.editorCtx.setContents({
					html: this.advantageHtml
				  });
				}).exec()
			},
		}
	}
</script>

<style>
	@import url("myAdvantage.css");
</style>
