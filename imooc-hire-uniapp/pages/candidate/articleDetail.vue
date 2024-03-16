<!-- 文章详情页 -->
<template>
	<view>
		
		<view class="navigation-bar" style="background-color: #ffffff; z-index: 8888;">
			<view class="nav-left-part">
				<image src="../../static/icons/hr/icon-goback.png" class="back-icon" @click="goback()"></image>
				
				<image src="../../static/images/me.png" class="nav-face" :style="{opacity: opacity }"></image>
				<text class="nav-name-words" :style="{opacity: opacity }">{{article.publisher}}</text>
			</view>
			
			<!-- <image v-show="zan == 0" src="../../static/icons/candidate/icon-unzan.png" class="like-icon" @click="zanMe()"></image>
			<image v-show="zan == 1" src="../../static/icons/candidate/icon-zan.png" class="like-icon" @click="unzanMe()"></image> -->
		</view>
		
		<view class="article-wrapper">
			<text class="title">{{article.title}}</text>
			
			<view class="publisher" style="">
				<image :src="article.publisherFace" class="publisher-face"></image>
				
				<view class="publisher-box" style="">
					<view class="publisher-one" style="">
						<text class="publisher-name">{{article.publisher}}</text>
						<view class="original-box" style="">
							<text class="original-text">原创</text>
						</view>
					</view>
					<view class="publisher-two">
						<text class="publish-time">{{article.publishTime}}</text>
					</view>
				</view>
			</view>
			
			<rich-text :nodes="graceFormat(article.content)" preview="true" class="article-content"></rich-text>
		</view>
		
		<view class="line-wrapper" style="margin: 20px 0;" v-if="showComment"><view class="line" style="width: 100%;height: 4px"></view></view>
		
		<view class="comment-box" v-if="showComment">
			
			<view class="total-comment-counts">
				<text>10809 条记录</text>
			</view>
			
			<view class="comment-user-wrapper">
				<view class="comment-user-info">
					<view class="comment-user-box">
						<image src="../../static/images/me.png" class="comment-user-face"></image>
						
						<view class="comment-user">
							<view class="comment-one">
								<text class="comment-name">风间影月</text>
							</view>
							
							<text class="position-words">技术经理·10年</text>
						</view>
					</view>
					
					
					<view class="zan-box">
						<text class="zan-text">{{graceNumber(1234)}}</text>
						<image v-show="zan == 0" src="../../static/icons/candidate/icon-unzan.png" class="zan-icon" @click="zanMe()"></image>
						<image v-show="zan == 1" src="../../static/icons/candidate/icon-zan.png" class="zan-icon" @click="unzanMe()"></image>
					</view>
				</view>
				
				<view class="comment-content" @click="doComment()">
					<text class="comment-content-text">哈哈哈笑死我了哈哈哈笑死我了哈哈哈笑死我了哈哈哈笑死我了哈哈哈笑死我了</text>
					<text class="comment-time-text">{{DateUtil.toShowTimeFormat("2022-05-05 22:32:06")}}</text>
				</view>
			</view>
			
			<view class="sub-comment-user-wrapper">
				<block>
					<view class="comment-user-info">
						<view class="comment-user-box">
							<image src="../../static/images/me.png" class="sub-comment-user-face"></image>
							
							<view class="comment-user">
								<view class="sub-comment-one">
									<text class="sub-comment-name">风间影月</text>
								</view>
							</view>
						</view>
						
						
						<view class="zan-box">
							<text class="zan-text">{{graceNumber(99984)}}</text>
							<image v-show="zan == 0" src="../../static/icons/candidate/icon-unzan.png" class="zan-icon" @click="zanMe()"></image>
							<image v-show="zan == 1" src="../../static/icons/candidate/icon-zan.png" class="zan-icon" @click="unzanMe()"></image>
						</view>
					</view>
					
					<view class="sub-comment-content" @click="reply()">
						<text class="comment-content-text">哈哈哈笑死我了哈哈哈笑死我了哈哈哈笑死我了哈哈哈fewf笑死我了哈哈哈笑死我acs了</text>
						<text class="comment-time-text">{{DateUtil.toShowTimeFormat("2022-01-05 22:32:06")}}</text>
					</view>
				</block>
				
				<block>
					<view class="comment-user-info">
						<view class="comment-user-box">
							<image src="../../static/images/me.png" class="sub-comment-user-face"></image>
							
							<view class="comment-user">
								<view class="sub-comment-one">
									<text class="sub-comment-name">风间影月</text>
									<image src="../../static/icons/candidate/arrow-reply.png" class="icon-arrow-reply"></image>
									<text class="sub-comment-name">三刀流索隆</text>
								</view>
							</view>
						</view>
						
						
						<view class="zan-box">
							<text class="zan-text">{{graceNumber(99984)}}</text>
							<image v-show="zan == 0" src="../../static/icons/candidate/icon-unzan.png" class="zan-icon" @click="zanMe()"></image>
							<image v-show="zan == 1" src="../../static/icons/candidate/icon-zan.png" class="zan-icon" @click="unzanMe()"></image>
						</view>
					</view>
					
					<view class="sub-comment-content" @click="reply()">
						<text class="comment-content-text">哈哈哈笑死我了哈哈哈笑死我了哈哈哈笑死我了哈哈哈fewf笑死我了哈哈哈笑死我acs了</text>
						<text class="comment-time-text">{{DateUtil.toShowTimeFormat("2022-01-05 22:32:06")}}</text>
					</view>
				</block>
				
				<view class="more-sub-comments">
					<text class="show-more-sub-words">展开更多回复</text>
				</view>
			</view>
			
			<view class="more-comments">
				<text class="show-more-words">展开更多评论</text>
			</view>
		</view>
		
		<view v-show="commentFocus" class="" style="width: 100%;height: 100%; background-color: gainsboro;position: fixed;top: 0px; z-index: 9999;opacity: 30%;">
		</view>
		
		
		<!-- 评论输入框 -->
		<view class="comment-wrapper" style="background-color: white;z-index: 99999;" v-if="showComment">
			<view class="line-wrapper" style="margin-bottom: 10px;"><view class="line" style="width: 100%;height: 1px"></view></view>
			
			<view class="comment-line">
				<input 
					class="comment-input" 
					placeholder-class="placeholder-class"
					:placeholder="placeholder" 
					cursor-spacing="10px"
					v-model="currentComment"
					confirm-type="done"
					:focus="commentFocus"
					@focus="focus"
					@blur="blur">
				
				<view style="display: flex;flex-direction: column;justify-content: center;">
					<image src="../../static/icons/candidate/icon-comment-publis.png" class="icon-comment" @click="doCommentPublish()"></image>
				</view>
			</view>
			
			<!-- #ifndef H5 -->
			<view class="reply-user-wrapper" v-show="commentFocus">
				<image src="../../static/images/me.png" class="reply-user-face"></image>
				<image src="../../static/icons/candidate/arrow-right-top.png" class="face-arrow"></image>
			</view>
			<!-- #endif -->
		</view>
		
		
	</view>
</template>

<script>
	var app = getApp();
	import RichContentUtil  from '@/components/RichContentUtil.js';
	export default {
		components: {
			RichContentUtil
		},
		data() {
			return {
				showComment: false,
				
				commentWrapperBlack: true,
				commentWrapperWhite: false,
				commentBoxBlack: true,
				commentBoxWhite: false,
				
				currentComment: "",
				placeholder: "我来说两句...",
				
				commentFocus: false,
				
				zan: 0,
				hrInfo: {},
				article: {
					"articleId": "1003",
					"title": "这是一个很长的大标题~~！！这是一个很长的大很长的大标题~",
					"content": '<p>在虚拟机vmware中往往克隆一个新的系统后，要去修改静态ip，直接使用的话可能会不尽如人意，ip也是需要管理起来的。</p>'
								+ '<p>在这里以Centos 7.x 为例，centos6.x的网卡静态ip方式可以搜我以前的博客（cnblog）。</p>'
								+ '<ol>'
								+ '<li><p>查看网卡信息</p>'
								+ '<pre highlighted="true"><code class="language-text hljs language-plaintext">ip link show'
								+ '</code></pre>'
								+ '<p><img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610546-1101045216.jpg" alt="" style="" class="medium-zoom-image"><br>'
								+ 'ens33 是我的网卡名称，每个人的都不一样，有的也叫eth0，另外一个红框就是你的网卡地址了。把这个网卡地址复制下俩，临时保存：<code>00:0c:29:c8:49:60</code>。</p></li>'
								+ '<li><p>执行如下命令，修改网卡地址：</p>'
								+ '<pre highlighted="true"><code class="language-text hljs language-plaintext">vim /etc/udev/rules.d/70-persistent-ipoib.rules'
								+ '</code></pre>'
								+ '<p><img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610481-1879297238.jpg" alt="" style="" class="medium-zoom-image"><br>'
								+ '把注释打开，再把<code>ATTR{address}</code>修改为你的网卡地址<code>00:0c:29:c8:49:60</code>，修改后如下图：<br>'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610466-1323929994.jpg" alt="" style="" class="medium-zoom-image"></p></li>'
								+ '<li><p>修改ip信息：</p>'
								+ '<pre highlighted="true"><code class="language-text hljs language-plaintext">vim /etc/sysconfig/network-scripts/ifcfg-ens33'
								+ '</code></pre>'
								+ '<p>如下图，把IPADDR修改为你所想要的内网静态ip（需要注意，要和你的网段一致），然后还有一个<code>HWADDR</code>如果没有，则新增一个，然后再把之前的网卡地址加上，即可。<br>'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610475-1415043294.jpg" alt="" style="" class="medium-zoom-image"></p></li>'
								+ '<li><p>这是最后一步，目前的ip并没有发生更改，还是克隆之前的ip<br>'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610536-1254578151.jpg" alt="" style="" class="medium-zoom-image">需要重启电脑或者刷新网络，直接了当就reboot就行。。。</p>'
								+ '<p>ooOoOoOo 等等启动 oOoOoOoo</p></li>'
								+ '<li><p>启动完毕，测试连接</p>'
								+ '<ul>'
								+ '<li>填入你的ip，以及端口号还有用户名'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610653-1911805189.jpg" alt="" style="" class="medium-zoom-image"></li>'
								+ '<li>设置你的会话名称：'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610654-1701116130.jpg" alt="" style="" class="medium-zoom-image"></li>'
								+ '<li><p>双击这个会话：</p>'
								+ '<p><img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610486-612127044.jpg" alt="" style="" class="medium-zoom-image">     </p></li>'
								+ '<li><p>输入密码：默认都是root<br>'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610650-121800341.jpg" alt="" style="" class="medium-zoom-image"></p></li>'
								+ '<li><p>进入后，可以看到ip已经OK了<br>'
								+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610714-1379928223.jpg" alt="" style="" class="medium-zoom-image"></p></li>'
								+ '</ul></li>'
								+ '</ol>'
								+ '<h3 id="toc_0">Tips<button class="cnblogs-toc-button" title="显示目录导航" aria-expanded="false"></button></h3>'
								+ '<p>内网的网络，虚拟机使用桥接，如果你在公司和家里都是相同网段的话，只是有线无线的区别，那么可以采用自动检测即可。<br>'
									+ '<img src="https://img2018.cnblogs.com/blog/841496/202003/841496-20200308123610555-302466791.jpg" alt="" style="" class="medium-zoom-image"></p>'
								+ '<h3 id="toc_1">关于内网互通原则<button class="cnblogs-toc-button" title="显示目录导航" aria-expanded="false"></button></h3>'
								+ '<p>很多小伙伴都在看我的课程，由于分布式环境，那么一定要保证内网互动，不互通那么会请求不了，比如请求图片服务器，搭建lvsIP漂移等</p>'
								+ '<ul>'
								+ '<li>内网互通原则：'
								+ '<ul>'
								+ '<li>1. 虚拟机中linux与本地都要关闭防火墙，设置静态ip（注意不要网络冲突）</li>'
								+ '<li>2. 文件服务器（即虚拟机要和本地电脑互通）</li>'
								+ '<li>3. 所有计算机节点的网段保证一致，比如 192.168.1.xxx，172.10.10.xxx</li>'
								+ '<li>4. 手机和你的电脑要在同一个网络，同一个wifi，网段要检查是否一致</li>'
								+ '<li>5. 客户端请求的serverUrl一定要写你电脑的内网IP，如果写localhost，那么手机是请求不了的</li>'
								+ '<li>6. 主机ping虚拟机，虚拟机ping主机，都要保证OK</li>'
								+ '<li>注意: 如果你的电脑使用的校内网络，可能会导致无法访问</li>'
								+ '</ul></li>'
								+ '</ul>',
					"readCounts": 800,
					"publisher": "风间影月",
					"publishTime": "2022-05-01 22:22:06",
					"cover": ["../../static/icons/candidate/eye.png"]
				},
					
					
				background:{backgroundColor:'#fd5365'},
				height:0,
				navbarRight:0,
				opacity: 0,
				scrollY: 0,
			}
		},
		onShow() {
			
		},
		onPageScroll : function(e) {
		    // console.log("滚动距离为：" + e.scrollTop);
			var that = this,
				scrollY = e.scrollTop;
			var opacity = scrollY / 200;
			opacity = opacity > 1 ? 1 : opacity;
			that.$set(that, 'opacity', opacity);
			that.$set(that, 'scrollY', scrollY);
			if (that.lock) {
				that.$set(that, 'lock', false);
				return;
			}
		},
		onLoad(params) {
			var articleId = params.articleId;
			this.getDetail(articleId);
			this.readArticle(articleId);
		},
		methods: {
			getDetail(articleId) {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/article/app/detail?articleId=" + articleId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var detail = result.data.data;
							console.log(detail);
							me.article = detail;
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
			
			readArticle(articleId) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/article/app/read?userId=" + userId + "&articleId=" + articleId,
					success(result) {
						console.log(result);
						if (result.data.status == 200) {
							
						} else {
							
						}
					}
				})
				
			},
			
			doCommentPublish() {
				this.blur();
				this.currentComment = "";
			},
			
			doComment() {
				this.placeholder = "评论给 @风间影月";
				this.commentFocus = true;
			},
			
			reply() {
				this.placeholder = "回复 @三刀流索隆";
				this.commentFocus = true;
			},
			
			focus() {
				this.commentFocus = true;
			},
			
			blur() {
				this.commentFocus = false;
				this.placeholder = "我来说两句...";
			},
			
			graceNumber(num) {
				return app.graceNumber(num);
			},
			
			graceFormat(content) {
				return RichContentUtil.format(content);
			},
			
			zanMe() {
				this.zan = 1;
			},
			
			unzanMe() {
				this.zan = 0;
			},
			
			goback() {
				uni.navigateBack({
					delta: 1
				})
			},
		}
	}
</script>

<style>
	@import url("articleDetail.css");
</style>
