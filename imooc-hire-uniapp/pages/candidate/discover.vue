<!-- 发现页 -->
<template>
	<view>
		
		<block v-for="(article, index) in articleList" :key="index">
			<view class='news' @click='showDetail(article.id)'>
			  <view class='news-title' v-if="article.articleCover == null || article.articleCover == ''">{{article.title}}</view>
			  <view class='pic-words' v-if="article.articleCover != null && article.articleCover != ''">
			    <view class='news-title title-words'>{{article.title}}</view>
			    <image :src="article.articleCover" class='cover'></image>
			  </view>
			  <view class='publish'>
			    <view class='publisher'>{{article.publisher}}</view>
			    <view class='create-time'>{{DateUtil.toShowTimeFormat(formatDateTime(article.publishTime))}}</view>
				<view class='read-counts' style="">
					<image src='../../static/icons/candidate/eye.png' class='eye'></image>
					<text class="read-text">{{graceNumber(article.readCounts)}}</text>
				</view>
			  </view>
			</view>
			<view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view>
		</block>
		
		<!-- 新闻列表 -->
		<!-- 纯文字 -->
		<!-- <view class='news' data-newsid='10088' @click='showDetail'>
		  <view class='news-title'>这是一个很长的大标题~~！！这是一个很长的大很长的大很长的大标题~</view>
		  <view class='publish'>
		    <view class='publisher'>NEXT 学院</view>
		    <view class='create-time'>刚刚</view>
			<view class='read-counts' style="">
				<image src='../../static/icons/candidate/eye.png' class='eye'></image>
				<text class="read-text">999</text>
			</view>
		  </view>
		</view> -->
		
		<!-- <view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view> -->
		
		<!-- 三图新闻 -->
		<!-- <view class='news'>
			<view class='news-title'>这是一个很长的大标题~~！！这是一个很长的大很长的大标题~</view>
			<view class='img-set'>
				<image src='http://itzixi.com:88/group1/M00/00/02/CpoxxFwE7k-ANI2kAAReVsBN3Kw664.png' class='cover'></image>
				<image src='http://itzixi.com:88/group1/M00/00/02/CpoxxFwE7k-ANI2kAAReVsBN3Kw664.png' class='cover'></image>
				<image src='http://itzixi.com:88/group1/M00/00/02/CpoxxFwE7k-ANI2kAAReVsBN3Kw664.png' class='cover'></image>
			</view>
			<view class='publish' style="">
				<view class='publisher'>NEXT 学院</view>
				<view class='create-time'>三天前</view>
				<view class='read-counts' style="">
					<image src='../../static/icons/candidate/eye.png' class='eye'></image>
					<text class="read-text">10w</text>
				</view>
			</view>
		</view> -->
		
		<!-- <view class="line-wrapper" style="margin: 20px 0;"><view class="line" style="width: 100%;"></view></view> -->
		
		<!-- 单图新闻 -->
		<!-- <view class='news'>
		  <view class='pic-words'>
		    <view class='news-title title-words'>这是一个很长的大标题~~！！这是一个很长的大标题~</view>
		    <image src='http://itzixi.com:88/group1/M00/00/02/CpoxxFwE7k-ANI2kAAReVsBN3Kw664.png' class='cover'></image>
		  </view>
		  <view class='publish'>
		    <view class='publisher'>NEXT 学院</view>
		    <view class='create-time'>2022-01-01</view>
			<view class='read-counts' style="">
				<image src='../../static/icons/candidate/eye.png' class='eye'></image>
				<text class="read-text">9k</text>
			</view>
		  </view>
		</view> -->
		
	</view>
</template>

<script>
	var app = getApp();
	export default {
		data() {
			return {
				page: 1,	// 默认第1页
				limit: 10,	// 每页显示10条
				total: 0,	// 总共多少页
				articleList: [
				],
			}
		},
		onShow() {
			
		},
		onPullDownRefresh() {
			// this.articleList = this.articleList.slice(1,3);
			
			this.getPagedList(1);
			uni.stopPullDownRefresh();
		},
		onReachBottom() {
			// this.articleList = this.articleList.concat(this.articleList);
			var page = this.page + 1;
			var total = this.total;
			// console.log("total=" + total)
			if (page > total) {
				return;
			}
			this.getPagedList(page);
		},
		onLoad() {
			this.getPagedList(1, "", this.selectedJobId);
		},
		methods: {
			showDetail(id) {
				uni.navigateTo({
					url: "articleDetail?articleId=" + id,
					animationType: "slide-in-bottom",
				});
			},
			
			formatDateTime(dateTime) {
				if (dateTime == null || dateTime == '' || dateTime == undefined) {
					return "";
				}
				var arr = dateTime.split("T");
				var times = arr[0] + " " + arr[1];
				return times;
			},
			
			graceNumber(num) {
				if (num == null || num == "" || num == undefined) {
					return 0;
				}
				return app.graceNumber(num);
			},
			
			getPagedList(page) {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/article/app/list?page=" + page + "&limit=10",
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							me.page = result.data.data.page;
							// console.log(list);
							
							console.log(list);
							if (page == 1) {
								me.articleList = [];
							}
							me.articleList = me.articleList.concat(list);
							console.log(me.articleList);
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
		}
	}
</script>

<style>
	@import url("discover.css");
</style>
