<!-- 职位描述 -->
<template>
	<view>
		
		<view class="card-box">
			
			<view class="title-wrapper">
				<text class="title-one">职位描述</text>
				<text class="title-two">请对当前职位进行详尽的描述</text>
			</view>
			
			<view class="company-wrapper">
				<!-- <input
					class="company-input"
					type="text" 
					:value="companyName" 
					:model="companyName" 
					placeholder="请填入营业执照上的公司名称"
					placeholder-class="placeholder"
					maxlength="30"
					@input="typingContent"/> -->
				<textarea 
					class="textarea" 
					maxlength="2000"
					:placeholder="jobDescriptionPlaceholder" 
					placeholder-class="placeholder"
					v-model="jobDescription"></textarea>
			</view>
			
			
			<view class="tips-box">
				<view class="tips">
					<text class="tip-zero">注意事项</text>
					<text class="tip-item">1. 请勿填写QQ、微信、电话等联系方式</text>
					<text class="tip-item">2. 请勿填写带有性别歧视、地域歧视等内容</text>
					<text class="tip-item">3. 务必用词恰当，请勿违反劳动法相关内容</text>
				</view>
			</view>
		
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				companyName: "",
				wordsLength: 0,
				disabled: true,
				
				companyExist: false,
				companyCheck: false,
				
				jobDescription: "",
				jobDescriptionPlaceholder: "1. 工作内容 \n2. 任务说明 \n3. 特别说明",
			}
		},
		onNavigationBarButtonTap() {
			console.log(this.jobDescription);
			uni.setStorageSync("jobDescription", this.jobDescription);
			
			uni.navigateBack({
				delta: 1
			})
		},
		onShow() {
			this.wordsLength = this.companyName.length;
		},
		onLoad(options) {
			var jobDesc = options.jobDesc;
			this.jobDescription = jobDesc;
		},
		methods: {
			typingContent(e) {
				var event = e;
				this.companyName = e.detail.value;
				this.wordsLength = this.companyName.length;
				
				if (this.wordsLength > 0) {
					this.disabled = false;
				}
			},
			
			next() {
				
			}
		}
	}
</script>

<style>
	@import url("jobDesc.css");
</style>
