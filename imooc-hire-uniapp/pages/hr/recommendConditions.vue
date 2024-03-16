<!-- 筛选条件页 -->
<template>
	<view>
		<view class="vip-big-box">
			
			<view class="vip-box">
				<image src="../../static/icons/vip2.png" style="width: 30px;height: 18px;align-self: center; border-radius: 4px;"></image>
				<text class="vip-words">慕聘专享高级筛选特权</text>
			</view>
			
			<view class="title-box">
				<text class="title-words">年龄</text>
				
				<!-- <view class="age-box">
					<text class="age-words">16</text>
					<text class="age-words">60</text>
				</view> -->
				
				<view class="age-slider">
					<!-- <slider value="16" @change="sliderChange" activeColor="#dea075" min="16" max="60" step="1"/> -->
					
					<range-slider
					  :value="conditions.ageRange"
					  :min="rangeMin"
					  :max="rangMax"
					  :step="1"
					  :bar-height="3"
					  :block-size="26"
					  background-color="#EEEEF6"
					  active-color="#dea075"
					  :format="format"
					  :decorationVisible="true"
					  @change="handleRangeChange"
					></range-slider>
				</view>
			</view>
		
			<view class="title-box">
				<text class="title-words">性别</text>
				
				<view class="tag-wrapper">
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.sex == -1}" @click="chooseSex(-1)">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.sex == 1}" @click="chooseSex(1)">
						<text class="tag-text">男</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.sex == 0}" @click="chooseSex(0)">
						<text class="tag-text">女</text>
					</view>
				</view>
			</view>
			
			<!-- <view class="title-box">
				<text class="title-words">院校</text>
				
				<view class="tag-wrapper">
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.school == '不限'}" @click="chooseSchool('不限')">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.school == '985'}" @click="chooseSchool('985')">
						<text class="tag-text">985</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.school == '211'}" @click="chooseSchool('211')">
						<text class="tag-text">211</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.school == '双一流院校'}" @click="chooseSchool('双一流院校')">
						<text class="tag-text">双一流院校</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.school == '留学'}" @click="chooseSchool('留学')">
						<text class="tag-text">留学</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.school == '国内外名校'}" @click="chooseSchool('国内外名校')">
						<text class="tag-text">国内外名校</text>
					</view>
				</view>
			</view> -->
		
		
			<view class="title-box">
				<text class="title-words">活跃度</text>
				
				<view class="tag-wrapper">
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.activeTime == ''}" @click="chooseActiveTime('')">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.activeTime == 'just'}" @click="chooseActiveTime('just')">
						<text class="tag-text">刚刚活跃</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.activeTime == 'today'}" @click="chooseActiveTime('today')">
						<text class="tag-text">今日活跃</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.activeTime == 'threeDays'}" @click="chooseActiveTime('threeDays')">
						<text class="tag-text">三天内活跃</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.activeTime == 'thisWeek'}" @click="chooseActiveTime('thisWeek')">
						<text class="tag-text">本周活跃</text>
					</view>
					<view :class="{'tag-box': true, 'tag-box-selected': conditions.activeTime == 'thisMonth'}" @click="chooseActiveTime('thisMonth')">
						<text class="tag-text">本月活跃</text>
					</view>
				</view>
			</view>
			
			
		</view>
		
		<view class="common-big-box">
			
			<view class="title-box">
				<text class="common-title-words">工作经验</text>
				
				<view class="tag-wrapper">
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.workYears == ''}" @click="chooseWorkYears('')">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.workYears == 'less1'}" @click="chooseWorkYears('less1')">
						<text class="tag-text">1年以下</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.workYears == 'between13'}" @click="chooseWorkYears('between13')">
						<text class="tag-text">1-3年</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.workYears == 'between35'}" @click="chooseWorkYears('between35')">
						<text class="tag-text">3-5年</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.workYears == 'between510'}" @click="chooseWorkYears('between510')">
						<text class="tag-text">5-10年</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.workYears == 'more10'}" @click="chooseWorkYears('more10')">
						<text class="tag-text">10年以上</text>
					</view>
				</view>
			</view>
			
			<view class="title-box">
				<text class="common-title-words">学历要求</text>
				<!-- ["初中", "高中", "中专/技校", "大专", "本科", "硕士", "MBA/EMBA", "博士"] -->
				<view class="tag-wrapper">
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == ''}" @click="chooseEducation('')">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '初中'}" @click="chooseEducation('初中')">
						<text class="tag-text">初中</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '中专/技校'}" @click="chooseEducation('中专/技校')">
						<text class="tag-text">中专/技校</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '高中'}" @click="chooseEducation('高中')">
						<text class="tag-text">高中</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '大专'}" @click="chooseEducation('大专')">
						<text class="tag-text">大专</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '本科'}" @click="chooseEducation('本科')">
						<text class="tag-text">本科</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '硕士'}" @click="chooseEducation('硕士')">
						<text class="tag-text">硕士</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == 'MBA/EMBA'}" @click="chooseEducation('MBA/EMBA')">
						<text class="tag-text">MBA/EMBA</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.education == '博士'}" @click="chooseEducation('博士')">
						<text class="tag-text">博士</text>
					</view>
				</view>
			</view>
			
			<view class="title-box">
				<text class="common-title-words">薪资待遇</text>
				
				<view class="tag-wrapper">
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == ''}" @click="chooseSalary('')">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'less5k'}" @click="chooseSalary('less5k')">
						<text class="tag-text">5k以下</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'between5k10k'}" @click="chooseSalary('between5k10k')">
						<text class="tag-text">5-10k</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'between10k15k'}" @click="chooseSalary('between10k15k')">
						<text class="tag-text">10-15k</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'between15k20k'}" @click="chooseSalary('between15k20k')">
						<text class="tag-text">15-20k</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'between20k30k'}" @click="chooseSalary('between20k30k')">
						<text class="tag-text">20-30k</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'between30k50k'}" @click="chooseSalary('between30k50k')">
						<text class="tag-text">30-50k</text>
					</view>
					<view :class="{'common-tag-box': true, 'common-tag-box-selected': conditions.salary == 'more50k'}" @click="chooseSalary('more50k')">
						<text class="tag-text">50k以上</text>
					</view>
				</view>
			</view>
			
			<view class="title-box">
				<text class="common-title-words">求职状态</text>
				
				<view class="tag-wrapper">
					<view :class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == ''}" @click="chooseJobStatus('')">
						<text class="tag-text">不限</text>
					</view>
					<view v-for="(status, index) in resumeOpenStatusList" :key="status.itemKey"
						:class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == status.itemValue}" 
						@click="chooseJobStatus(status.itemValue)">
						<text class="tag-text">{{status.itemValue}}</text>
					</view>
					
					
					<!-- <view :class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == 'all'}" @click="chooseJobStatus('all')">
						<text class="tag-text">不限</text>
					</view>
					<view :class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == 'onLookNew'}" @click="chooseJobStatus('onLookNew')">
						<text class="tag-text">在职，看看新机会</text>
					</view>
					<view :class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == 'offLookNew'}" @click="chooseJobStatus('offLookNew')">
						<text class="tag-text">离职，正在找工作</text>
					</view>
					<view :class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == 'onUrgentLook'}" @click="chooseJobStatus('onUrgentLook')">
						<text class="tag-text">在职，急寻新工作</text>
					</view>
					<view :class="{'common-tag-box-status': true, 'common-tag-box-status-selected': conditions.jobStatus == 'noPlan'}" @click="chooseJobStatus('noPlan')">
						<text class="tag-text">在职，暂无跳槽计划</text>
					</view> -->
				</view>
			</view>
			
		</view>
		
		<view class="option-wrapper">
			<view class="btn-clear-wrapper" @click="clear()">
				<text class="btn-clear-words">重置</text>
			</view>
			
			<view class="btn-confirm-wrapper" @click="confirm()">
				<text class="btn-confirm-words">确认</text>
			</view>
		</view>
		
	</view>
</template>

<script>
	var app = getApp();
	import RangeSlider from '@/components/range-slider/range-slider.vue';
	export default {
		components: {
			RangeSlider
		},
		data() {
			return {
				isVip: false,
				
				statusList:[],
				resumeOpenStatusList: [],
				
				rangeMin: 0,
				rangMax: 65,
				// rangeValue: [22, 50],
				
				conditions: {
					ageRange: [0, 65],
					sex: -1,	// -1：不限 	1：男  0：女
					// school: "不限",
					activeTime: "", 		// '': 不限， just: 刚刚， today: 今日， threeDays: 三天内， thisWeek: 本周， thisMonth: 本月
					workYears: "", 			// '': 不限， less1: 1年以下， between13: 1-3年， between35: 3-5年， between510: 5-10年，more10: 10年以上，
					education: "", 		// '': 不限， junior: 初中及以下， technical: 中专/技校， high: 高中， juniorCollege: 大专，underGraduate: 本科，master: 硕士，MBA: MBA，doctor: 博士
					salary: "",			// '': 不限， less5k: 5k以下， between5k10k: 5-10k，between10k15k: 10-15k，between15k20k: 15-20k，between20k30k: 20-30k，between30k50k: 30-50k，more50k: 50k以上，
					jobStatus: "", 		// '': 不限， onLookNew: 在职，看看新机会， offLookNew: 离职，正在找工作，onUrgentLook: 在职，急寻新工作， noPlan: 在职，暂无跳槽计划
				},
			}
		},
		onLoad(e) {
			this.getResumeOpenStatusList();
			
			this.queryIsVip();
		},
		onShow() {
			var searchResumesConditions = uni.getStorageSync("searchResumesConditions");
			console.log(searchResumesConditions);
			if (searchResumesConditions != undefined && searchResumesConditions != "" && searchResumesConditions != null) {
				this.conditions = JSON.parse(searchResumesConditions);
			}
		},
		methods: {
			queryIsVip() {
				// console.log("queryIsVip");
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				var companyId = app.getUserInfoSession().hrInWhichCompanyId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/company/isVip?companyId=" + companyId,
					success(result) {
						
						if (result.data.status == 200) {
							var isVip = result.data.data;
							console.log(isVip);
							me.isVip = isVip;
							console.log(typeof(isVip));
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
			
			clear() {
				var conditions = {
					ageRange: [0, 65],
					sex: -1,
					// school: "不限",
					activeTime: "",
					workYears: "",
					education: "",
					salary: "",
					jobStatus: ""
				};
				this.conditions = conditions;
				uni.removeStorageSync("searchResumesConditions");
				uni.setStorageSync("searchResumeNeedRefresh", "yes");
			},
			
			confirm() {
				var isVip = this.isVip;
				
				// ageRange: [0, 65],
				// sex: -1,	// -1：不限 	1：男  0：女
				// activeTime: "",
				
				var conditions = this.conditions;
				
				if (conditions.ageRange[0] != 0 || conditions.ageRange[1] != 65 || conditions.sex != -1 || conditions.activeTime != "") {
					if (!isVip) {
						uni.showModal({
							title: "[特权筛选服务] \n需至企业后端开通VIP会员~",
							cancelText: "取消",
							confirmText: "确定",
							confirmColor: "#31B9B3",
							success(e) {
								return;
							}
						});
						return;
					}
				}
				
				console.log(conditions);
				uni.setStorageSync("searchResumesConditions", JSON.stringify(conditions));
				
				uni.setStorageSync("searchResumeNeedRefresh", "yes");
				
				uni.navigateBack({
					delta: 1
				})
			},
			
			chooseSex(sex) {
				this.conditions.sex = sex;
			},
			
			chooseSchool(school) {
				this.conditions.school = school;
			},
			
			chooseActiveTime(activeTime) {
				this.conditions.activeTime = activeTime;
			},
			
			chooseWorkYears(workYears) {
				this.conditions.workYears = workYears;
			},
			
			chooseEducation(education) {
				this.conditions.education = education;
			},
			
			chooseSalary(salary) {
				this.conditions.salary = salary;
			},
			
			chooseJobStatus(jobStatus) {
				this.conditions.jobStatus = jobStatus;
			},
			
			
			
			format(val) {
				return val + '岁'
			},
			handleRangeChange(e) {
				// this.rangeValue = e
				this.conditions.ageRange = e;
			},
			
			
			sliderChange(e) {
				console.log('value 发生变化：' + e.detail.value);
			}
		}
	}
</script>

<style>
	@import url("recommendConditions.css");
</style>
