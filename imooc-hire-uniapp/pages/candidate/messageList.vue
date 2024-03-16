<!-- HR 的消息列表页面 -->
<template>
	<view>
		
		<view class="navigation-bar" style="z-index: 77777;">
			
			<view class="nav-left">
				<image src="../../static/icons/hr/icon-goback.png" class="back-icon" @click="goBack"></image>
			</view>
			
			<view class="nav-middle">
				<text class="page-title">{{currentSourceUserInfo.nickname}}</text>
				<text class="page-info">{{currentSourceUserInfo.position}}</text>
			</view>
			
			<view class="nav-right">
				<image src="../../static/icons/hr/white-face.png" class="white-icon"></image>
			</view>
		</view>
		
		<view class="speaking-list-box" v-show="isSpeaking" style="z-index: 88888;background-color: rgba(25, 25, 25, 0.8);">
			<!-- <image src="../../static/icons/speak/speaking-1.gif" v-show="speakingType == 1" class="icon-speaking" mode="heightFix"></image> -->
			<!-- <image src="../../static/icons/speak/speaking-1.gif" v-show="speakingType == 2" class="icon-speaking" mode="heightFix"></image> -->
			<image src="../../static/icons/speak/speaking-1.gif" v-show="speakingType == 3" class="icon-speaking" mode="heightFix"></image>
			
			<view class="cancel-block-box" v-show="speakingType == 1 || speakingType == 2">
				<view :class="{'cancel-block-wrapper': speakingType == 3, 'cancel-block-wrapper-start': speakingType == 1, 'cancel-block-wrapper-end': speakingType == 2}">
					<view class="cancel-suit" v-show="speakingType == 1">
						<view class="cancel-block">
							<image src="../../static/icons/speak/speach.gif" class="icon-cancel-speaking" mode="heightFix"></image>
						</view>
						<image src="../../static/icons/speak/chat-cancel-arrow.png" class="chat-cancel-arrow"></image>
					</view>
					
					<view class="cancel-suit" v-show="speakingType == 2">
						<view class="towords-block">
							<image src="../../static/icons/speak/speach.gif" class="icon-cancel-speaking" mode="heightFix"></image>
						</view>
						<image src="../../static/icons/speak/chat-towords-arrow.png" class="chat-cancel-arrow"></image>
					</view>
				</view>
			</view>
			
			<view class="speaking-bottom-wrapper">
				<view class="speaking-options-wrapper">
					<view class="options-part">
						<text v-show="speakingType == 1" class="options-part-text">松开 取消</text>
						<image src="../../static/icons/speak/icon-cancel-speak.png" v-show="speakingType != 1" class="icon-wen-text"></image>
						<image src="../../static/icons/speak/icon-cancel-speak-touched.png" v-show="speakingType == 1" class="icon-wen-text-touched"></image>
					</view>
					
					<view class="options-part">
						<text v-show="speakingType == 2" class="options-part-text">转文字</text>
						<image src="../../static/icons/speak/icon-word-text.png" v-show="speakingType != 2" class="icon-wen-text"></image>
						<image src="../../static/icons/speak/icon-word-text-touched.png" v-show="speakingType == 2" class="icon-wen-text-touched"></image>
					</view>
				</view>
				
				<text v-show="speakingType == 3" class="release-send-text">松开 发送</text>
				<image id="iconSpeakingBottom" src="../../static/icons/speak/speaking-bottom-touched.png" v-show="speakingType == 3" class="icon-speaking-bottom" mode="scaleToFill"></image>
				<image id="iconSpeakingBottom" src="../../static/icons/speak/speaking-bottom.png" v-show="speakingType != 3" class="icon-speaking-bottom" mode="scaleToFill"></image>
				<image src="../../static/icons/speak/icon-middle-speaker.png" class="icon-middle-speaker"></image>
			</view>
		</view>
		
		 <!-- @touchstart="fingerstart" @touchend="fingerend" -->
		<view class="msg-list-box" style="width: 100%;">
			<!-- :style="{height: height+'px'}" -->
			<!-- @scrolltoupper="loadMorePagedMsg" -->
			<!-- scroll-with-animation="false" -->
			<scroll-view 
				id="msgScrollList" 
				class="msg-list-wrapper" 
				:style="{height: height+'px'}" 
				scroll-y 
				:scroll-top="scrollTop"
				:scroll-into-view="scrollIntoIndex"
				scroll-anchoring="true"
				@scrolltoupper="loadMorePagedMsg"
				@touchstart="touchStart" 
				@touchend="touchEnd">
				<!-- style="overflow-anchor: none;" -->
				
				<view id="msgViewList" class="msg-view-list">
					<view class="line-wrapper" style=""><view class="line" style="margin-top: 10px;width: 100%;height: 1px"></view></view>
					<!-- <text>{{isLoadingMsg}}</text> -->
					<view class="loading-wrapper" v-show="isLoadingMsg">
						<image src="../../static/icons/loading2.gif" class="icon-msg-loading"></image>
					</view>
					
					<block v-for="(m, index) in allMSGList" :key="index">
						<!-- <text style="margin-left: 30px;">showMsgDateTimeFlag = {{m.showMsgDateTimeFlag}}</text> -->
						
						<view class="msg-time-wrapper" v-show="m.showMsgDateTimeFlag == 1">
							<!-- <text>{{m.msgDateTime}}</text> -->
							<text>{{DateUtil.formatWeekDatetime(new Date(Date.parse(m.chatTime)))}}</text>
							<!-- <text style="margin-left: 30px;">showMsgDateTimeFlag = {{m.showMsgDateTimeFlag}}</text> -->
						</view>
						
						<!-- 文字表情消息 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.WRODS && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								
								<view class="msg-box-right">
									<rich-text :nodes="replaceAndShowFace(m.msgContent)" preview="true" class="msg-content-right"></rich-text>
									<image src="../../static/icons/chat-right-arrow.png" class="chat-right-arrow"></image>
								</view>
								
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.WRODS && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								
								<view class="msg-box-left">
									<image src="../../static/icons/chat-left-arrow.png" class="chat-left-arrow"></image>
									<rich-text :nodes="replaceAndShowFace(m.msgContent)" preview="true" class="msg-content-left"></rich-text>
								</view>
							</view>
						</view>
			
						<!-- 语音消息 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.VOICE && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								
								<view class="msg-box-right">
									<!-- <view class="msg-content-right-speak" style=""> -->
									<!-- @click="playVoice(tempFlag[0])" -->
									<view 
										:class="{'msg-content-right-speak': index != voiceActiveIndex, 'msg-content-right-speak-touched': index == voiceActiveIndex}"
										@touchstart="touchstartRightVoice(index)"
										@touchend="touchendRightVoice()"
										@click="playVoice(index, m.msgId)"
										class="msg-content-right-speak" style="">
										<text class="seconds-right" :style="{'width': ((m.speakVoiceDuration/speakMaxSeconds)*speakMaxWidth+36) + 'upx'}">{{m.speakVoiceDuration}}″</text>
										
										
										<!-- <text>{{voicePlayObject["voiceIsPlay"+testId1]}}</text> -->
										
										<image src="../../static/icons/speak/msg-left-spearker.png" v-show="voicePlayingIndex != index"  class="icon-speaker"></image>
										<image src="../../static/icons/speak/msg-left-spearking.gif" v-show="voicePlayingIndex == index"  class="icon-speaker"></image>
										<!-- <image src="../../static/icons/speak/msg-left-spearker.png" v-show="!voicePlayObject['voiceIsPlay'+tempFlag[0]]"  class="icon-speaker"></image>
										<image src="../../static/icons/speak/msg-left-spearking.gif" v-show="voicePlayObject['voiceIsPlay'+tempFlag[0]]"  class="icon-speaker"></image> -->
									</view>
									
									<image src="../../static/icons/chat-right-arrow.png" v-show="index != voiceActiveIndex" class="chat-right-arrow"></image>
									<image src="../../static/icons/chat-right-arrow-touched.png" v-show="index == voiceActiveIndex" class="chat-right-arrow"></image>
								</view>
								
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.VOICE && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left" style="max-width: 96%;">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								
								<view class="msg-box-left">
									<image src="../../static/icons/chat-left-arrow.png" v-show="index != voiceActiveIndex" class="chat-left-arrow"></image>
									<image src="../../static/icons/chat-left-arrow-touched.png" v-show="index == voiceActiveIndex" class="chat-left-arrow"></image>
									<!-- <view class="msg-content-left-speak"> -->
									<view 
										:class="{'msg-content-left-speak': index != voiceActiveIndex, 'msg-content-left-speak-touched': index == voiceActiveIndex}"
										@touchstart="touchstartLeftVoice(index)"
										@touchend="touchendLeftVoice()"
										@click="playVoice(index, m.msgId)"
										class="msg-content-left-speak">
										
										<image src="../../static/icons/speak/msg-right-spearker.png" v-show="voicePlayingIndex != index" class="icon-speaker"></image>
										<image src="../../static/icons/speak/msg-right-spearking.gif" v-show="voicePlayingIndex == index" class="icon-speaker"></image>
										
										<text class="seconds-left" :style="{'width': ((m.speakVoiceDuration/speakMaxSeconds)*speakMaxWidth+36) + 'upx'}">{{m.speakVoiceDuration}}″</text>
									</view>
									
									<image v-show="!m.isRead" src="../../static/icons/speak/msg-voice-unread.png" class="icon-msg-voice-unread"></image>
								</view>
							</view>
						</view>
						
						<!-- 语音转文字的等待加载效果 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.MSG_LOADING && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								<image src="../../static/icons/loading2.gif" class="chat-msg-loading"></image>
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<!-- 照片 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.IMAGE && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								<image :src="m.msgContent" @click="previewImage(m.msgContent)" mode="heightFix" class="chat-image-right"></image>
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.IMAGE && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								<image :src="m.msgContent" @click="previewImage(m.msgContent)" mode="heightFix" class="chat-image-left"></image>
							</view>
						</view>
						
						<!-- 视频 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.VIDEO && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								
								<view class="video-cover-box" @click="watchVideo(m.videoPath, m.videoWidth, m.videoHeight)">
									<image :src="m.msgContent" mode="heightFix" class="chat-video-right"></image>
									<view class="play-box">
										<view class="gray-mask"></view>
										<image src="../../static/icons/msg/icon-viode-play.png" class="icon-viode-play"></image>
									</view>
									<text class="video-times">{{transformTimes(m.videoTimes)}}</text>
								</view>
								
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.VIDEO && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								
								<view class="video-cover-box-left" @click="watchVideo(m.videoPath, m.videoWidth, m.videoHeight)">
									<image :src="m.msgContent" mode="heightFix" class="chat-video-right"></image>
									<view class="play-box">
										<view class="gray-mask"></view>
										<image src="../../static/icons/msg/icon-viode-play.png" class="icon-viode-play"></image>
									</view>
									<text class="video-times">{{transformTimes(m.videoTimes)}}</text>
								</view>
							</view>
						</view>
						
						<!-- 候选人发简历 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.RESUME && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								
								<view class="msg-box-right">
									<view class="msg-content-right">
										<text class="">这是我的简历，合适的话可以随时联系我~</text>
										
										<view class="resume-wrapper" @click="showResumeDetail(m.resumeUserId)">
											<image src="../../static/icons/chat-my-resume.png" class="icon-my-resume"></image>
											<view class="resume-words-wrapper">
												<text class="resume-name-words">{{m.resumeName}}的简历</text>
												<text class="resume-position-words">{{m.resumePosition}}</text>
											</view>
										</view>
									</view>
									<image src="../../static/icons/chat-right-arrow.png" class="chat-right-arrow"></image>
								</view>
								
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.RESUME && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								
								<view class="msg-box-left">
									<image src="../../static/icons/chat-left-arrow.png" class="chat-left-arrow"></image>
									
									<view class="msg-content-left">
										<text class="">这是我的简历，合适的话可以随时联系我~</text>
										
										<view class="resume-wrapper"  @click="showResumeDetail(m.resumeUserId)">
											<image src="../../static/icons/chat-my-resume.png" class="icon-my-resume"></image>
											<view class="resume-words-wrapper">
												<text class="resume-name-words">{{m.resumeName}}的简历</text>
												<text class="resume-position-words">{{m.resumePosition}}</text>
											</view>
										</view>
									</view>
								</view>
							</view>
						</view>
						
						<!-- 面试邀约 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.INVITE && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								
								<view class="msg-box-right">
									<view class="msg-content-right">
										<text class="">您好，诚邀您来我司面试~</text>
										
										<view class="resume-wrapper" @click="showInterviewDetail(m.msgContent)">
											<image src="../../static/icons/icon-info.png" class="icon-info"></image>
											<view class="resume-words-wrapper">
												<text class="resume-name-words">面试邀约</text>
												<text class="resume-position-words">查看详情</text>
											</view>
										</view>
									</view>
									<image src="../../static/icons/chat-right-arrow.png" class="chat-right-arrow"></image>
								</view>
								
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-time-wrapper" v-if="m.msgType == MSGTYPE.MSG_INTERVIEW_CANCEL && userIdentityType == 1">
							<text>您已取消面试</text>
						</view>
						<view :id="m.elementId" class="msg-time-wrapper" v-if="m.msgType == MSGTYPE.MSG_INTERVIEW_CANCEL && userIdentityType == 2">
							<text>对方已取消面试</text>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.INVITE && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								
								<view class="msg-box-left">
									<image src="../../static/icons/chat-left-arrow.png" class="chat-left-arrow"></image>
									
									<view class="msg-content-left">
										<text class="">您好，诚邀您来我司面试~</text>
										
										<view class="resume-wrapper" @click="showInterviewDetail(m.msgContent)">
											<image src="../../static/icons/icon-info.png" class="icon-info"></image>
											<view class="resume-words-wrapper">
												<text class="resume-name-words">面试邀约</text>
												<text class="resume-position-words">查看详情</text>
											</view>
										</view>
									</view>
								</view>
							</view>
						</view>
											
						<view :id="m.elementId" class="msg-time-wrapper" v-if="m.msgType == MSGTYPE.MSG_INTERVIEW_ACCEPT && userIdentityType == 1">
							<text>对方已接受面试</text>
						</view>
						<view :id="m.elementId" class="msg-time-wrapper" v-if="m.msgType == MSGTYPE.MSG_INTERVIEW_ACCEPT && userIdentityType == 2">
							<text>您已接受面试</text>
						</view>
						
						<view :id="m.elementId" class="msg-time-wrapper" v-if="m.msgType == MSGTYPE.MSG_INTERVIEW_REFUSE && userIdentityType == 1">
							<text>对方已拒绝面试</text>
						</view>
						<view :id="m.elementId" class="msg-time-wrapper" v-if="m.msgType == MSGTYPE.MSG_INTERVIEW_REFUSE && userIdentityType == 2">
							<text>您已拒绝面试</text>
						</view>
						
						<!-- 录用通知 -->
						<view :id="m.elementId" class="msg-line-right" v-if="m.msgType == MSGTYPE.JOBOFFER && m.msgSource == MSGSOURCE.SENDER">
							<view class="every-msg-right">
								
								<view class="msg-box-right">
									<view class="msg-content-right">
										<text class="">您已通过面试，稍后将有HR联系并沟通入职流程~</text>
										
										<view class="resume-wrapper">
											<image src="../../static/icons/chat-interview-success.png" class="icon-my-resume"></image>
											<view class="resume-words-wrapper">
												<text class="resume-name-words">通过面试</text>
												<text class="resume-position-words">即将录用</text>
											</view>
										</view>
									</view>
									<image src="../../static/icons/chat-right-arrow.png" class="chat-right-arrow"></image>
								</view>
								
								<image :src="meInfo.face" class="face-icon"></image>
							</view>
						</view>
						
						<view :id="m.elementId" class="msg-line-left" v-if="m.msgType == MSGTYPE.JOBOFFER && m.msgSource == MSGSOURCE.RECEIVER">
							<view class="every-msg-left">
								<image :src="currentSourceUserInfo.face" class="face-icon"></image>
								
								<view class="msg-box-left">
									<image src="../../static/icons/chat-left-arrow.png" class="chat-left-arrow"></image>
									
									<view class="msg-content-left">
										<text class="">您已通过面试，稍后将有HR联系并沟通入职流程~</text>
										
										<view class="resume-wrapper">
											<image src="../../static/icons/chat-interview-success.png" class="icon-my-resume"></image>
											<view class="resume-words-wrapper">
												<text class="resume-name-words">通过面试</text>
												<text class="resume-position-words">即将录用</text>
											</view>
										</view>
									</view>
								</view>
							</view>
						</view>
						
					</block>
					
					
					<view v-show="isSpeaking" class="line-wrapper" style=""><view class="line" style="margin-bottom: 20px;width: 100%;height: 166px"></view></view>
					
					<view id="lastLine" class="line-wrapper" style=""><view class="line" style="margin-bottom: 20px;width: 100%;height: 1px"></view></view>
				</view>
				
				<view id="lastLineBottom" class="line-wrapper" style=""><view class="line" style="margin-bottom: 20px;width: 100%;height: 1px"></view></view>
				
			</scroll-view>
		</view>
		
		<!-- 消息输入框 -->
		<view class="message-wrapper" :style="{'margin-bottom': msgBoxBottom + 'px'}" ref="footer" id="footer">
			<view class="line-wrapper" style="margin-bottom: 10px;"><view class="line" style="width: 100%;height: 1px"></view></view>
			
			<view class="message-line">
				<image src="../../static/icons/hr/icon-speak.png" v-show="!isSpeak" class="icon-speak" :style="{'align-self': alignSelf}" @click="showSpeak()"></image>
				<image src="../../static/icons/hr/icon-keyboard.png" v-show="isSpeak" class="icon-speak" :style="{'align-self': alignSelf}" @click="showKeyboard()"></image>
				
				<!-- :auto-height="autoHeight" -->
				<textarea
					v-show="!isSpeak"
					id="msgTextarea" 
					ref="msgTextarea" 
					value="" 
					maxlength="512" 
					fixed="true"
					class="message-input"
					placeholder="新信息" 
					placeholder-class="placeholder-class"
					v-model="msgContent"
					cursor-spacing="600"
					confirm-type="send"
					:style="{height: msgHeight+'px'}"
					:focus="messageFocus"
					confirm-hold
					scroll-with-animation="true"
					@confirm="sendMsg"
					@linechange="linechange"
					@focus="focus"
					@blur="blur"/>
					
					<!-- class="speak-box" -->
					<!-- @longpress="speakingDisplay" -->
				<view 
					:class="{'speak-box':!speakTouched, 'speak-box-touched': speakTouched}"
					@touchstart.prevent="touchstartSpeak"
					@touchend="touchendSpeak"
					@touchmove="touchMoveSpeak"
					v-show="isSpeak">
					<text class="speak-word">{{!speakTouched ? speakWordsStart : speakWordsEnd}}</text>
				</view>
					<!-- @linechange="linechange" -->
					<!-- @input="typingMsg" -->
				
				<view class="icons-wrapper" :style="{'align-self': alignSelf}">
					<image src="../../static/icons/hr/msg-emoji.png" v-show="!isFace" class="icon-message" @click="showFaceBoard()"></image>
					<image src="../../static/icons/hr/icon-keyboard2.png" v-show="isFace" class="icon-keyboard" @click="showKeyboard()"></image>
					<image src="../../static/icons/hr/msg-options.png" class="icon-message" @click="showPlusBoard()"></image>
				</view>
			</view>
		</view>
		
		 <!-- :style="{'bottom': msgBoxBottom + 'px'}" -->
		 <!-- :style="{'height': faceBoardHeight + 'px'}" -->
		<view class="face-board-wrapper" :animation="animationData" style="height: 365px">
			<scroll-view class="face-box" scroll-y="true">
				<view class="all-face">
					<text class="all-face-words">最近使用</text>
				</view>
				
				<view class="latest-face">
					<block v-for="(face, index) in latestFaceList" :key="'latest_face_' + index">
						<image :src="'../../static/images/gif/' + face + '.gif'" @click="enterFace(face)" style="" class='emoji-iamge-board'/>
					</block>
				</view>
				
				
				<view class="all-face">
					<text class="all-face-words">所有表情</text>
				</view>
				
				<view class="emoji-wrapper">
					<block v-for="(face, index) in faceArray" :key="'face_' + index">
						<image :src="'../../static/images/gif/' + face + '.gif'"  style="" @click="enterFace(face)" class='emoji-iamge-board'/>
					</block>
					<!-- 补全最后一行 -->
					<!-- <block v-for="(face, index) in faceLineCounts - faceArray.length%3" :key="'blank_face_' + index">
						<view class="emoji-iamge-board"></view>
					</block> -->
				</view>
			</scroll-view>
			
			<!-- background-color: rgba(255, 255, 255, 0.8); -->
			<view class="face-operator-wrapper" 
				:style="{'height': faceOperatorHeight + 'px'}" 
				style="background-color: rgba(255, 255, 255, 0);">
				
				<view class="btn-operator" style="background-color: #FFFFFF;" @click="deleteWords">
					<image src="../../static/icons/icon-del-word1.png" v-show="!faceOperatorBtnShow" class="icon-del-word"></image>
					<image src="../../static/icons/icon-del-word2.png" v-show="faceOperatorBtnShow" class="icon-del-word"></image>
				</view>
				
				<view class="btn-operator" v-show="!faceOperatorBtnShow" style="margin-left: 10px;background-color: #FFFFFF;">
					<text class="btn-send-text">发送</text>
				</view>
				<view class="btn-operator" v-show="faceOperatorBtnShow" style="margin-left: 10px;background-color: #31B9B3;" @click="sendMsg">
					<text class="btn-send-text" style="color: #FFFFFF;">发送</text>
				</view>
			</view>
			<!-- <image src="../../static/icons/account.png" mode=""></image> -->
		</view>
		
		<view class="plus-board-wrapper" :animation="plusAnimationData" style="height: 265px">
			<view class="plus-icons-box">
				
				<view class="plus-item" @click="choosePhoto()">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-choose-photo.png" v-show="!faceOperatorBtnShow" class="plus-icon"></image>
					</view>
					<text class="plus-words">照片</text>
				</view>
				
				<view class="plus-item" @click="takePhoto()">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-take-photo.png" v-show="!faceOperatorBtnShow" class="plus-icon"></image>
					</view>
					<text class="plus-words">拍照片</text>
				</view>
				
				<view class="plus-item" @click="chooseVideo()">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-choose-video.png" v-show="!faceOperatorBtnShow" class="plus-icon2"></image>
					</view>
					<text class="plus-words">视频</text>
				</view>
				
				<view class="plus-item" @click="takeVideo()">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-take-video.png" v-show="!faceOperatorBtnShow" class="plus-icon2"></image>
					</view>
					<text class="plus-words">拍视频</text>
				</view>
				
				<view class="plus-item" @click="sendResume()" v-if="userIdentityType == 2">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-send-resume.png" v-show="!faceOperatorBtnShow" class="plus-icon"></image>
					</view>
					<text class="plus-words">发简历</text>
				</view>
				
				<view class="plus-item" @click="createInterviewInvite()" v-if="userIdentityType == 1">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-send-invite.png" v-show="!faceOperatorBtnShow" class="plus-icon2"></image>
					</view>
					<text class="plus-words">面试邀约</text>
				</view>
				
				<view class="plus-item" @click="interviewSuccess()" v-if="userIdentityType == 1">
					<view class="plus-icons-wrapper">
						<image src="../../static/icons/msg/icon-offer.png" v-show="!faceOperatorBtnShow" class="plus-icon2"></image>
					</view>
					<text class="plus-words">通过面试</text>
				</view>
				
			</view>
			
		</view>
		
	</view>
</template>

<script>
	const app = getApp();
	import common from "@/components/Common.js";
	export default {
		components: {
			common
		},
		data() {
			const MSGTYPE = {
				WRODS: 1,				// 1: 文字表情消息
				IMAGE: 2,				// 2: 图片
				VOICE: 3,				// 3: 语音
				VIDEO: 4,				// 4: 视频
				RESUME: 5,				// 5: 简历
				JOBOFFER: 6,			// 6: 录用通知
				INVITE: 7,				// 7: 面试邀约
				MSG_INTERVIEW_CANCEL: 71,		// 71： HR取消面试
				MSG_INTERVIEW_REFUSE: 72,		// 72： 候选人拒绝面试
				MSG_INTERVIEW_ACCEPT: 73,		// 73： 候选人接受面试
				MSG_LOADING: 911,		// 911： 消息长时间等待加载效果
			};
			const MSGSOURCE = {		// 消息来源，消息是谁发的
				RECEIVER: 1,		// 1: 接受者
				SENDER: 2,			// 2: 发送者
			};
			const speakMaxWidth = 380;
			const speakSeconds = 1;
			const speakMaxSeconds = 60;
			const speakMaxSeconds30 = 30;
			const speakRealWidth = (speakSeconds / speakMaxSeconds30) * speakMaxWidth;
			const faceArray = [
				"001", "002", "003", "004", "005", "006", "007", "008", "009", "010", 
				"011", "012", "013", "014", "015", "016", "017", "018", "019", "020", 
				"021", "022", "023", "024", "025", "026", "027", "028", "029", "030", 
				"031", "032", "033", "034", "035", "036", "037", "038", "039", "040", 
				"041", "042", "043", "044", "045", "046", "047", "048", "049", "050", 
				"051", "052", "053", "054", "055", "056", "057", "058", "059", "060", 
				"061", "062", "063"
			];
			
			// #ifdef APP-PLUS
			const recorderManager = uni.getRecorderManager();
			// const innerAudioContext = uni.createInnerAudioContext();
			// innerAudioContext.autoplay = true;
			// #endif
			
			var CHAT = app.globalData.CHAT;
			return {
				userIdentityType: 2		,// 默认为2
				
				isPlus: false,	// 是否点击[+]号拉出操作面板
				plusAnimationData: {},
				
				// #ifdef APP-PLUS
				recorderManager,
				innerAudioContext: null,
				recorderVoice: {
					voicePath: '',
					speakVoiceDuration: 0,
				},
				// #endif
				voiceActiveIndex: -1,
				voicePlayingIndex: -1,
				lastVoicePlayingId: -1,
				
				allMSGList:[],
				MSGTYPE,
				MSGSOURCE,
				isLoadingMsg: false,
				scrollIntoIndex: "",
				
				// 用于控制每条消息是否要显示时间，超过1分钟则显示消息时间，
				// 每次发送或者接受的消息时间需要保存到本地，如果当前消息时间超过本地时间1分钟，
				// 也就是msgDateTime-msgLocalDateTime>1分钟，则显示消息时间，并且格式化时间
				msgLocalDateTime: null,		
				
				testId1: "1",
				testId2: "2",
				testId3: "3",
				
				speakMaxWidth,
				speakSeconds,
				speakMaxSeconds,
				speakMaxSeconds30,
				speakRealWidth,
				
				msgVoiceRead: true,
				// msgVoiceRead: false,
				
				// voiceIsPlay: false,
				voiceIsPlay: true,
				voicePlayObject: null,
				tempFlag: [],
				
				leftVoiceTouched: false,
				rightVoiceTouched: false,
				
				speakContent: "<img src='../../static/icons/speak/msg-left-spearking.gif' class='icon-speaker'/>",
				faceContent: "笑死我了~~[001]笑死我了~~[002]笑死我了~~[003]",
				faceContent2: "笑死我了~~[004]笑死我了~~[005]笑死我了~~[006]",
				// <img src='../../static/images/gif/11摔东西.gif' class='emoji-iamge'/>
				faceArray,

				unReadCounts: 1,
				
				scrollHeight: 500,
				
				
				messageFocus: false,
				autoHeight: true,
				msgHeight: 0,
				
				msgContent: "",
				isSpeak: false,		// 状态切换，界面显示图标
				isFace: false,		// 状态切换，界面显示图标
				isSpeaking: false,	// 表示是否按住底部中央按钮，正在说话
				
				speakingType: 3,	// 1:取消发送语音 2:语音转文字 3:松开发送语音
				
				msgBoxBottom: 0,	// 底部消息输入栏的高度
				faceBoardHeight: 0,	// 表情包面板的高度
				animationData: {},
				faceLineCounts: 10, // 每行可以显示多少个表情，动态计算
				cursor: 0, 			// 光标位置，用于textarea显示信息表情拼接
				faceOperatorHeight: 0,
				faceOperatorBtnShow: false,		// 用于控制表情面板右下侧的按钮是否显示
				latestFaceList: [],			// 最近使用的表情列表
				
				touchStartX: 0,  // 触屏起始点x  
				touchStartY: 0,  // 触屏起始点y  
				
				alignSelf: "center",
				// alignSelf: "flex-end",
				speakTouched: false,
				speakWordsStart: "按住 说话",
				speakWordsEnd: "松开 结束",
				
				height: 0,
				speakingBoxHeight: 0,
				pageHeight: 0,
				footerHeight: 0,
				keyBoardHeight: 0,
				
				scrollTop: 0,
				// keyboardOn: false,
				
				// HR用户id，候选人的聊天对象
				hrUserId: "",
				currentSourceUserInfo: {},
				// 当前消息发送者
				meInfo: app.getUserInfoSession(),
				
				CHAT,
				
				page: 1,	// 默认第1页
				total: 0,	// 总共多少页
			}
		},
		onShow() {
			if (!app.globalData.chatSocketOpen) {
				app.reConnect();
			}
			
			var me = this;
			var userType = uni.getStorageSync('userType');
			// 如果没有，默认设置为候选人
			if (userType == undefined || userType == "" || userType == null) {
				me.userIdentityType = me.userType.candidate;
			} else {
				if (userType == me.userType.hr) {
					me.userIdentityType = me.userType.hr;
				} else {
					me.userIdentityType = me.userType.candidate;
				}
			}
		// 	var animation = uni.createAnimation({
		// 		duration: 1000,
		// 		timingFunction: 'ease',
		// 	})
		
		// 	this.animation = animation
		
		// console.log("this.latestFaceList = " + this.latestFaceList);
			var latestFaceList = uni.getStorageSync("latestFaceList");
			if (latestFaceList != null && latestFaceList != undefined && latestFaceList != "") {
				// console.log(latestFaceList);
				this.latestFaceList = latestFaceList;
			} else {
				latestFaceList = [];
				this.latestFaceList = [];
			}
			
			// console.log(this.latestFaceList);
			
			// TODO 如果历史表情list，超过每行宽度（表情list），则减少1个表情，递归
			var faceWidth = 0;
			for (var i = 0 ; i < latestFaceList.length ; i ++) {
				faceWidth += 80;
			}
			var historyWidth = faceWidth + 10*2 + (latestFaceList.length-1)*10;
			// console.log("historyWidth = " + historyWidth);
			
			// var sys = uni.getSystemInfoSync();
			// var windowWidth = sys.windowWidth;
			// console.log("start latestFaceList = " + latestFaceList);
			// 如果 historyWidth > windowWidth，则减少1个
			latestFaceList = this.popFaceListInit(latestFaceList, historyWidth);
			// if (historyWidth > windowWidth) {
			// 	latestFaceList.pop();
			// }
			// console.log("end latestFaceList = " + latestFaceList);
			this.latestFaceList = latestFaceList;
			// X*80 + (X-1)*10 + 10*2 = 屏幕宽度
			
			
			// var sss = this.getTimeWidth(69);
			// console.log("sss = " + sss);
			
			// 获得创建面试邀约后的面试id
			var interviewId = uni.getStorageSync("interviewId");
			// console.log("onShow - interviewId = " + interviewId);
			if (interviewId != null && interviewId != undefined && interviewId != "") {
				// console.log(latestFaceList);
				// this.interviewId = interviewId;
				this.sendInterviewInvite(interviewId);
			} else {
				// this.interviewId = "";
			}
			
			// HR取消面试
			var cancel_interviewId = uni.getStorageSync("cancel_interviewId");
			console.log("onShow - cancel_interviewId = " + cancel_interviewId);
			if (cancel_interviewId != null && cancel_interviewId != undefined && cancel_interviewId != "") {
				this.cancelInterviewInvite(cancel_interviewId);
			}
			
			// 候选人接受面试
			var accept_interviewId = uni.getStorageSync("accept_interviewId");
			console.log("onShow - accept_interviewId = " + accept_interviewId);
			if (accept_interviewId != null && accept_interviewId != undefined && accept_interviewId != "") {
				this.acceptInterviewInvite(accept_interviewId);
			}
			
			// 候选人拒绝面试
			var refuse_interviewId = uni.getStorageSync("refuse_interviewId");
			console.log("onShow - refuse_interviewId = " + refuse_interviewId);
			if (refuse_interviewId != null && refuse_interviewId != undefined && refuse_interviewId != "") {
				this.refuseInterviewInvite(refuse_interviewId);
			}
			
			// 获得当前聊天的HR基本信息
			this.getSourceUserInfo();
		},
		onReady() {
			//获取整个页面的高度，从而计算出页面可用的高度，因为使用了自定义的navbar所以this.pageHeight不是单纯的res.windowHeight。（ps: uview组件的navbar高度是固定的44px,不包括statusBarHeight）
			uni.getSystemInfo({
				success: (res) => {
					// this.pageHeight = res.windowHeight - res.statusBarHeight - 56;
					
					// #ifdef H5
					this.pageHeight = res.windowHeight - res.statusBarHeight - 56;
					// #endif
					// #ifdef APP-PLUS
					this.pageHeight = res.windowHeight - res.statusBarHeight - 42;
					// #endif
					
					this.speakingBoxHeight = res.windowHeight;
					
					
					// 计算表情面板 每行可以放多少个 = （屏幕宽度 - padding左右的10+10） / 表情宽度
					// X*80 + (X-1)*10 + 10*2 = 屏幕宽度
					// X*80 + 10*X-10 + 10*2 = 屏幕宽度
					// X*80 + 10*X-10 + 10*2 = 屏幕宽度
					// X*90 + 10*2 - 10 +  = 屏幕宽度
					// 每行可以放多少个 = （屏幕宽度 - 10*2 +10 ） / 90
					// console.log("res.windowWidth = " + res.windowWidth);
					// console.log("res.windowWidth = " + res.windowWidth);
					// this.windowWidth = res.windowWidth;
					var faceLineCounts = Math.floor((res.windowWidth - 10*2 + 10) / 90); // 这只是一个大致的，因为可变的部分不清楚，后续的历史表情可以计算
					// console.log("faceLineCounts = " + faceLineCounts);
					this.faceLineCounts = faceLineCounts;
				}
			})
			
			
			uni.getSystemInfo({
				success: (res) => {
					
					const query = uni.createSelectorQuery().in(this);
					query.select('#footer').boundingClientRect(data => {
						// console.log(data);
						
						var windowHeight = res.windowHeight;
						var windowWidth = res.windowWidth;
						var middleWindowWidth = windowWidth / 2;
						var footerTop = parseInt(data.top);
						
						// console.log("windowHeight = " + windowHeight);
						// console.log("windowWidth = " + windowWidth);
						// console.log("middleWindowWidth = " + middleWindowWidth);
						// console.log("footerTop = " + footerTop); 
						
						this.windowHeight = windowHeight;
						this.windowWidth = windowWidth;
						this.middleWindowWidth = middleWindowWidth;
						this.footerTop = footerTop;
					}).exec();
					
				}
			})
			
			this.scrollToBottom();
		},
		onLoad(options) {
			this.initListener();
			
			this.initRecorder();
			// #ifdef APP-PLUS
			// this.initRecorder();
			// #endif
			
			
			// TODO 初始化所有语音的播放标记
			var tempFlag = [this.testId1, this.testId2, this.testId3];
			var obj = new Object();
			for (var i = 0 ; i < tempFlag.length ; i ++) {
				obj["voiceIsPlay" + tempFlag[i]] = false;
			}
			// console.log(obj)
			// obj["voiceIsPlay" + this.testId1] = false;
			// obj["voiceIsPlay" + this.testId2] = false;
			
			this.tempFlag = tempFlag;
			this.voicePlayObject = obj;
			
			
			
			var hrUserId = options.hrUserId;
			if (hrUserId != null && hrUserId != "" && hrUserId != undefined) {
				this.hrUserId = hrUserId;
				console.log("hrUserId=" + hrUserId);
			}
			
			var me = this;
			// this.CHAT.onMessage(function(res){
			// 	// console.log('message.vue 收到服务器内容：' + res.data);
			// 	me.dealReceiveMsg(JSON.parse(res.data));
			// });	
			
			this.getMsgList(1);
			
			// 进入页面，则清理标记为全部已读
			this.clearMyUnReadCounts();
			
			uni.$on("receiveMsgInMsgListVue", function(data) {
				// console.log('监听receiveMsgInMsgListVue：' + data);
				me.dealReceiveMsg(JSON.parse(data));
				me.dealReceiveMsgSlef(JSON.parse(data));	// 多端都能收到信息
			});
			
			uni.$on("reFetchMsgListFromFirstPage", function(data) {
				me.getMsgList(1);
			});
		},
		watch: {		
			isSpeaking(newValue, oldValue) {
				// 监听正在讲话
				if (newValue) {
					// true则开始录音
					this.startRecord();
				} else {
					// flase则停止录音
					this.endRecord();
					// 判断当前是否取消发送，还是语音转文字
				}
			},
			msgContent(newValue, oldValue) {
				if (newValue.length > 0) {
					this.faceOperatorBtnShow = true;
				} else if (newValue.length <= 0) {
					this.faceOperatorBtnShow = false;
				}
			},
			messageFocus(newValue, oldValue) {
				var me = this;
				// console.log("messageFocus oldValue = " + oldValue);
				// console.log("messageFocus newValue = " + newValue);
				if (newValue) {
					// setTimeout(()=>{
						// me.$nextTick(() => {
							me.scrollToBottom();
							this.isFace = false;
							this.isPlus = false;
						// })
					// }, 500)
				}
			},
			isPlus(newValue, oldValue) {
				// 初始化表情面板动画
				var animation = uni.createAnimation({
					timingFunction: 'linear',
				})
				this.plusAnimation = animation;
				
				var defaultHeight = 265;
				if (newValue) {
					this.msgBoxBottom = defaultHeight;
					// this.faceBoardHeight = this.msgBoxBottom;
					this.height = this.height - this.msgBoxBottom;
					
					this.plusAnimation.translateY(-defaultHeight).step({ duration: 300 })
					this.plusAnimationData = this.plusAnimation.export()
					// this.animationData = animation.export();
				} else if (!newValue) {
					this.msgBoxBottom = 0;
					// this.faceBoardHeight = 0;
					this.height = this.height + defaultHeight;
					
					this.plusAnimation.translateY(defaultHeight).step({ duration: 300 })
					this.plusAnimationData = this.plusAnimation.export()
				}
				
				this.$nextTick(() => {
				    this.scrollToBottom()
				})
			},
			isFace(newValue, oldValue) {
				// 初始化表情面板动画
				var animation = uni.createAnimation({
					timingFunction: 'linear',
				})
				this.animation = animation;
				
				
				var defaultHeight = 365;
				// this.faceBoardHeight = this.defaultHeight;
				if (newValue) {
					this.msgBoxBottom = defaultHeight;
					// this.faceBoardHeight = this.msgBoxBottom;
					this.height = this.height - this.msgBoxBottom;
					this.faceOperatorHeight = 80;	// 开启退格和发送
					
					this.animation.translateY(-defaultHeight).step({ duration: 300 })
					this.animationData = this.animation.export()
					// this.animationData = animation.export();
				} else if (!newValue) {
					this.msgBoxBottom = 0;
					
					if (this.isPlus) {
						// 如果当前打开加号面板，那么此时整合开着表情面板，则输入框随着加号面板的高度
						this.msgBoxBottom = 265;
					}
					
					// this.faceBoardHeight = 0;
					this.height = this.height + defaultHeight;
					this.faceOperatorHeight = 0;	// 关闭退格和发送
					
					this.animation.translateY(defaultHeight).step({ duration: 300 })
					this.animationData = this.animation.export()
				}
				
				this.$nextTick(() => {
				    this.scrollToBottom()
				})
			},
		},
		onUnload() {
			this.destoryListener();
			uni.$off("receiveMsgInMsgListVue");
			uni.$off("reFetchMsgListFromFirstPage");
		},
		mounted() {
			//这里获取footer元素的高度，根据不同平台用的方式不同，对于uniapp的dom定位方法应该是通用的。特别注意，一定要在this.$nextTick方法里写，不然可能页面还没渲染出footer元素
			this.$nextTick(() => {
				// #ifdef H5
				this.footerHeight = this.$refs.footer.$el.offsetHeight;
				// console.log(this.footerHeight)
				this.height = this.pageHeight - this.footerHeight;
				// this.height = this.pageHeight-30;
				// #endif
				// #ifdef APP-PLUS
				uni.createSelectorQuery().in(this).select("#footer").boundingClientRect((data) => {
					this.footerHeight = data.height;
					this.height = this.pageHeight - this.footerHeight;
					// this.height = this.pageHeight;
				}).exec()
				// #endif
				// console.log("this.footerHeight = " + this.footerHeight);
			})
		},
		methods: {
			getMsgList(page) {
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var senderId = this.hrUserId;
				var receiverId = userId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/chat/list/" + senderId + "/" + receiverId + "?page=" + page + "&pageSize=20",
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var list = result.data.data.rows;
							me.total = result.data.data.total;
							me.page = result.data.data.page;
							console.log(list);
							
							var newMsgList = [];
							for (var i = 0 ; i < list.length ; i ++) {
								var tmpMsg = list[i];
								
								var msgItem = new Object();
								msgItem["elementId"] = "scrollIntoIndex_" + tmpMsg.id;		// 用于标记，给滚动list做滚动定位
								
								msgItem["msgId"] = tmpMsg.id;
								msgItem["msgContent"] = tmpMsg.msg;
								msgItem["msgType"] = tmpMsg.msgType;
								
								if (tmpMsg.senderId == userId) {
									msgItem["msgSource"] = me.MSGSOURCE.SENDER;
								} else {
									msgItem["msgSource"] = me.MSGSOURCE.RECEIVER;
								}
								
								msgItem["chatTime"] = tmpMsg.chatTime;
								msgItem["showMsgDateTimeFlag"] = tmpMsg.showMsgDateTimeFlag;
								
								msgItem["videoPath"] = tmpMsg.videoPath;
								msgItem["videoWidth"] = tmpMsg.videoWidth;
								msgItem["videoHeight"] = tmpMsg.videoHeight;
								msgItem["videoTimes"] = tmpMsg.videoTimes;
								
								msgItem["voicePath"] = tmpMsg.voicePath;
								msgItem["speakVoiceDuration"] = tmpMsg.speakVoiceDuration;
								msgItem["isRead"] = tmpMsg.isRead;
								
								msgItem["resumeUserId"] = tmpMsg.resumeUserId;
								msgItem["resumeName"] = tmpMsg.resumeName;
								msgItem["resumePosition"] = tmpMsg.resumePosition;
								
								newMsgList.push(msgItem);
							}
							
							console.log(newMsgList);
							if (page == 1) {
								me.allMSGList = [];
							}
							// me.allMSGList = me.allMSGList.concat(newMsgList);
							me.allMSGList = newMsgList.concat(me.allMSGList);
							
							if (page != 1) {
								me.$nextTick(() => {
									me.scrollIntoIndex = '';
									setTimeout(()=>{
										me.scrollIntoIndex = newMsgList[newMsgList.length-1].elementId;
										console.log(me.scrollIntoIndex);
									}, 100)
								});
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
			
			dealReceiveMsgSlef(msgJSON) {
					var chatMsg = msgJSON.chatMsg;
					var chatTime = msgJSON.chatTime;
					var senderId = chatMsg.senderId;
					var receiverId = chatMsg.receiverId;
					
					
					var receiverType = chatMsg.receiverType;
					
					console.log("senderId = " + senderId);
					console.log("receiverId = " + receiverId);
					// 如果消息发送者不是当前页面正在聊天的，则不处理
					if (senderId == this.meInfo.id && receiverId == this.hrUserId) {
						console.log("进来了~~~");
					} else {
						return;
					}
					
					var msgItem = new Object();
					msgItem["msgContent"] = chatMsg.msg;
					msgItem["msgType"] = chatMsg.msgType;
					msgItem["msgSource"] = this.MSGSOURCE.SENDER;
					msgItem["chatTime"] = msgJSON.chatTime;
					msgItem["showMsgDateTimeFlag"] = chatMsg.showMsgDateTimeFlag;
					
					msgItem["videoPath"] = chatMsg.videoPath;
					msgItem["videoWidth"] = chatMsg.videoWidth;
					msgItem["videoHeight"] = chatMsg.videoHeight;
					msgItem["videoTimes"] = chatMsg.videoTimes;
					
					msgItem["voicePath"] = chatMsg.voicePath;
					msgItem["speakVoiceDuration"] = chatMsg.speakVoiceDuration;
					msgItem["isRead"] = chatMsg.isRead;
					
					msgItem["resumeUserId"] = chatMsg.resumeUserId;
					msgItem["resumeName"] = chatMsg.resumeName;
					msgItem["resumePosition"] = chatMsg.resumePosition;
					
					console.log(msgJSON);
					
					var tempList = this.allMSGList;
					tempList.push(msgItem);
					this.allMSGList = tempList;
					// console.log(this.allMSGList)
					// common.playReceiveSound();
					
					this.$nextTick(() => {
						this.scrollToBottom();
					});
				
			},
			
			// 处理接受消息
			dealReceiveMsg(msgJSON) {
				// 每次接收到消息，需要则表示，用户在当前聊天用户的消息都被已读
				this.clearMyUnReadCounts();
				
				console.log(msgJSON);
				var chatMsg = msgJSON.chatMsg;
				var chatTime = msgJSON.chatTime;
				var senderId = chatMsg.senderId;
				
				
				var receiverType = chatMsg.receiverType;
				if (receiverType != 2) {
					return;
				}
				
				// 如果消息发送者不是当前页面正在聊天的，则不处理
				if (senderId != this.hrUserId) {
					return;
				}
				
				// 消息类型
				// var action = msgJSON.action;
				// if () {
					
				// }
				
				var msgItem = new Object();
				msgItem["msgId"] = chatMsg.msgId;
				msgItem["msgContent"] = chatMsg.msg;
				msgItem["msgType"] = chatMsg.msgType;
				msgItem["msgSource"] = this.MSGSOURCE.RECEIVER;
				msgItem["chatTime"] = msgJSON.chatTime;
				msgItem["showMsgDateTimeFlag"] = chatMsg.showMsgDateTimeFlag;
				
				msgItem["videoPath"] = chatMsg.videoPath;
				msgItem["videoWidth"] = chatMsg.videoWidth;
				msgItem["videoHeight"] = chatMsg.videoHeight;
				msgItem["videoTimes"] = chatMsg.videoTimes;
				
				msgItem["voicePath"] = chatMsg.voicePath;
				msgItem["speakVoiceDuration"] = chatMsg.speakVoiceDuration;
				
				console.log(msgJSON);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playReceiveSound();
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			
			clearMyUnReadCounts() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var oppositeId = this.hrUserId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/chat/clearMyUnReadCounts?myId=" + userId + "&oppositeId=" + oppositeId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							
						}
					}
				})
			},
			
			getSourceUserInfo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				var hrUserId = this.hrUserId;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/userinfo/get?userId=" + hrUserId,
					success(result) {
						// console.log(result);
						if (result.data.status == 200) {
							var currentSourceUserInfo = result.data.data;
							me.currentSourceUserInfo = currentSourceUserInfo;
							// console.log(currentSourceUserInfo);
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
			
			// 记录每个人的最后一条消息，记录在本地，用于显示聊天列表
			saveLastestMsgToLocal(msgContent, chatTime) {
				var sourceUser = this.currentSourceUserInfo;
				
				var lastMsg = {
					sourceUserId: sourceUser.id,		// 源头用户，聊天对象，这里是候选人
					name: sourceUser.nickname,
					face: sourceUser.face,
					msgContent: msgContent,
					chatTime: chatTime,
					unReadCounts: 0
				}
				console.log(lastMsg);
				// 先获得本地存储与候选人聊天的list，如果没有则新创建
				var lastestHrUserChatList = uni.getStorageSync("lastestHrUserChatList");
				if (lastestHrUserChatList == null || lastestHrUserChatList == undefined || lastestHrUserChatList == "") {
					lastestHrUserChatList = [];
				}
				
				// 循环判断，如果存在，则剔除，放入最新的
				var dealMsg = false;
				for ( var i = 0 ; i < lastestHrUserChatList.length ; i ++) {
					var tmp = lastestHrUserChatList[i];
					if (tmp.sourceUserId == lastMsg.sourceUserId) {
						lastestHrUserChatList.splice(i, 1);
						dealMsg = true;
						break;
					}
				}
				// if (!dealMsg) {
					lastestHrUserChatList.unshift(lastMsg);
				// }
				uni.setStorageSync("lastestHrUserChatList", lastestHrUserChatList);
				// uni.removeStorageSync("lastestHrUserChatList");
			},
			
			interviewSuccess() {
				var msgItem = {};
				var msgItem = new Object();
				
				msgItem["msgContent"] = "";
				msgItem["msgType"] = this.MSGTYPE.JOBOFFER;
				msgItem["msgSource"] = this.MSGSOURCE.RECEIVER;
				
				msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			
			acceptInterviewInvite(accept_interviewId) {
				var msgItem = {};
				var msgItem = new Object();
				
				msgItem["msgContent"] = accept_interviewId;
				msgItem["msgType"] = this.MSGTYPE.MSG_INTERVIEW_ACCEPT;
				// msgItem["msgSource"] = this.MSGSOURCE.RECEIVER;
				
				// msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				// 保存最后一条消息到本地
				msgItem = this.dealMsgDateTime(msgItem);
				this.saveLastestMsgToLocal("[面试接受]", msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.MSG_INTERVIEW_ACCEPT, accept_interviewId, 0, "", null, null, null, null, null);
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
				
				uni.removeStorageSync("accept_interviewId");
			},
			
			refuseInterviewInvite(refuse_interviewId) {
				var msgItem = {};
				var msgItem = new Object();
				
				msgItem["msgContent"] = refuse_interviewId;
				msgItem["msgType"] = this.MSGTYPE.MSG_INTERVIEW_REFUSE;
				// msgItem["msgSource"] = this.MSGSOURCE.RECEIVER;
				
				// msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				// 保存最后一条消息到本地
				msgItem = this.dealMsgDateTime(msgItem);
				this.saveLastestMsgToLocal("[面试拒绝]", msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.MSG_INTERVIEW_REFUSE, refuse_interviewId, 0, "", null, null, null, null, null);
				
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
				
				uni.removeStorageSync("refuse_interviewId");
			},
			
			cancelInterviewInvite(cancel_interviewId) {
				var msgItem = {};
				var msgItem = new Object();
				
				msgItem["msgContent"] = cancel_interviewId;
				msgItem["msgType"] = this.MSGTYPE.MSG_INTERVIEW_CANCEL;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				
				// msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
				
				uni.removeStorageSync("cancel_interviewId");
			},
			
			createInterviewInvite() {
				uni.navigateTo({
					// url: "interview/interviewDetail",
					url: "interview/createInterview",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},
			
			showInterviewDetail(interviewId) {
				// console.log("showInterviewDetail - interviewId = " + interviewId);
				
				uni.navigateTo({
					url: "../hr/interview/interviewDetail?interviewId=" + interviewId + "&hrUserId=" + this.hrUserId,
					animationType: "slide-in-bottom",
					success() {
					}
				});
				
			},
			
			sendInterviewInvite(interviewId) {
				// console.log("sendInterviewInvite - interviewId = " + interviewId);
				
				var msgItem = {};
				var msgItem = new Object();
				
				msgItem["msgContent"] = interviewId;
				msgItem["msgType"] = this.MSGTYPE.INVITE;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				
				msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
				
				uni.removeStorageSync("interviewId");
			},
			
			showResumeDetail(id) {
				console.log(id)
				uni.navigateTo({
					url: "../candidate/resume/previewResumePage?resumeUserId=" + id,
					animationType: "slide-in-bottom",
					success() {
					}
				});
				
			},
			
			watchVideo(src, width, height) {
				console.log("watchVideo...")
				// var videoPreview = {
				// 	src: src,
				// 	width: width,
				// 	height: height
				// };
				uni.navigateTo({
					// url: "msgVideo?src=" + src + "&width=" + width + "&height=" + height,
					url: "../hr/msgVideo?src=" + src + "&width=" + width + "&height=" + height,
					animationType: "fade-in",
					success(e) {
						console.log(e)
					},
					fail(e) {
						console.log(e)
					}
				});
			},
			
			transformTimes(seconds) {
				var min = Math.floor(seconds / 60);
				if (min < 10) {
					min = "0" + min;
				}
				var sec = seconds % 60;
				if (sec < 10) {
					sec = "0" + sec;
				}
				sec = (sec+"").split(".")[0];
				return min + ":" + sec;
			},
			
			chooseVideo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseVideo({
					sourceType: ['album'],
					success: function (res) {
						var videoPath = res.tempFilePath;
						var videoWidth = parseInt(res.width);
						var videoHeight = parseInt(res.height);
						var videoTimes = parseInt(res.duration);	// 单位：秒
						
						// 先发一个等待loading的效果msg到列表，优化用户体验
						var currentMsgIndex = me.sendMsgLoading();
						
						console.log(res);
						// 上传到后端，并且获得视频封面图（ffmpeg截帧）
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							method: "post",
							url: serverUrl + "/file/uploadChatVideo?userId=" + userId,
							filePath: videoPath,
							name: 'file',  
							success: (result) => {
								console.log(result);
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									console.log(res);
									if (res.status == 200) {
										var videoMsgVO = res.data;
										// console.log(videoMsgVO);
										// me.sendPhotoMsg(videoUrl);
										me.sendVideoMsg(videoMsgVO.cover, videoMsgVO.videoPath, videoWidth, videoHeight, videoTimes, currentMsgIndex);
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'none'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
								
								// me.sendVideoMsg(cover, videoPath, videoWidth, videoHeight, videoTimes, currentMsgIndex);
							},  
							fail: (res) => {  
								console.log("发送视频失败");  
							}  
						}); 
					}
				});
			},
			
			takeVideo() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				uni.chooseVideo({
					sourceType: ['camera'],
					success: function (res) {
						var videoPath = res.tempFilePath;
						var videoWidth = parseInt(res.width);
						var videoHeight = parseInt(res.height);
						var videoTimes = parseInt(res.duration);	// 单位：秒
						
						// 先发一个等待loading的效果msg到列表，优化用户体验
						var currentMsgIndex = me.sendMsgLoading();
						
						console.log(res);
						// 上传到后端，并且获得视频封面图（ffmpeg截帧）
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							method: "post",
							url: serverUrl + "/file/uploadChatVideo?userId=" + userId,
							filePath: videoPath,
							name: 'file',  
							success: (result) => {
								console.log(result);
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									console.log(res);
									if (res.status == 200) {
										var videoMsgVO = res.data;
										// console.log(videoMsgVO);
										// me.sendPhotoMsg(videoUrl);
										me.sendVideoMsg(videoMsgVO.cover, videoMsgVO.videoPath, videoWidth, videoHeight, videoTimes, currentMsgIndex);
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'none'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
								
								// me.sendVideoMsg(cover, videoPath, videoWidth, videoHeight, videoTimes, currentMsgIndex);
							},  
							fail: (res) => {  
								console.log("发送视频失败");  
							}  
						}); 
					}
				});
			},
			takePhoto() {
				var me = this;
				// var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
					sourceType: ["camera"],
					success: (e) => {
						var photo = e.tempFilePaths[0];
						// me.sendPhotoMsg(photo);
						// return;
						uni.saveImageToPhotosAlbum({
							filePath: photo,
							success: function (e) {
								var imgUrl = e.path;
								// 上传
								me.uploadPhotoImg(imgUrl);
							}
						});
					}
				})
			},
			choosePhoto() {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				
				uni.chooseImage({
					count: 1,
					sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
					sourceType: ["album"],
					success: (e) => {
						var photo = e.tempFilePaths[0];
						// me.sendPhotoMsg(photo);
						// return;
						
						me.uploadPhotoImg(photo);
					}
				})
			},
			
			uploadPhotoImg(photo) {
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				// 上传
				var serverUrl = app.globalData.serverUrl;
				uni.uploadFile({
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/file/uploadChatPhoto?userId=" + userId,
					name: "file",
					filePath: photo,
					success(result) {
						// console.log("result = " + result);
						if (result.statusCode == 200) {
							var res = JSON.parse(result.data);
							// console.log("res = " + res);
							if (res.status == 200) {
								var imgUrl = res.data;
								// console.log("imgUrl = " + imgUrl);
								me.sendPhotoMsg(imgUrl);
							} else {
								uni.showToast({
									title: res.msg,
									icon: 'none'
								})
							}
						} else {
							uni.showToast({
								title: "上传失败",
								icon: 'error'
							})
						}
					}
				})
			},
			
			sendVideoMsg(cover, videoPath, videoWidth, videoHeight, videoTimes, currentMsgIndex) {
				// console.log("sendVideoMsg.cover = " + cover);  
				if (!app.globalData.chatSocketOpen) {
					app.reConnect();
					return;
				}
				
				var tempList = this.allMSGList;
				tempList.splice(currentMsgIndex, 1);
				
				var msgItem = {};
				var msgItem = new Object();
				msgItem["msgContent"] = cover;
				msgItem["videoPath"] = videoPath;
				msgItem["videoWidth"] = videoWidth;
				msgItem["videoHeight"] = videoHeight;
				msgItem["videoTimes"] = videoTimes;
				msgItem["msgType"] = this.MSGTYPE.VIDEO;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				console.log(msgItem)
				
				// 消息时间（公用化）
				msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				common.playSendSound();
				
				// 保存最后一条消息到本地
				var msgContent = "[视频]";
				this.saveLastestMsgToLocal(msgContent, msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.VIDEO, cover, msgItem.showMsgDateTimeFlag, videoPath, videoWidth, videoHeight, videoTimes, null, null);
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			sendPhotoMsg(imageSrc) {
				if (!app.globalData.chatSocketOpen) {
					app.reConnect();
					return;
				}
				
				var msgItem = {};
				var msgItem = new Object();
				msgItem["msgContent"] = imageSrc;
				msgItem["msgType"] = this.MSGTYPE.IMAGE;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				console.log(msgItem)
				
				// 消息时间（公用化）
				msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				common.playSendSound();
				
				// 保存最后一条消息到本地
				var msgContent = "[图片]";
				this.saveLastestMsgToLocal(msgContent, msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.IMAGE, imageSrc, msgItem.showMsgDateTimeFlag, "", null, null, null, null, null);
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			
			// 初始化录音器
			initRecorder() {
				let self = this;
				// #ifdef APP-PLUS
				this.recorderManager.onStop(function (res) {
					console.log("self.speakingType = " + self.speakingType);
					
					// 超过60s自动关闭，所以需要设置isSpeaking为false
					self.isSpeaking = false;
					
					// console.log('recorder stop' + JSON.stringify(res));
					if (self.speakingType == undefined || self.speakingType == null || self.speakingType == "") {
						self.speakingType = 3
					}
					
					if (self.speakingType == 3) {
						// 停止获得终止时间，并且计算时间差
						var recordEndTime = new Date();
						var recordStartTime = self.recordStartTime;
						// console.log("recordEndTime = " + recordEndTime.getTime());
						// console.log("recordStartTime = " + recordStartTime.getTime());
						var timeDiff = recordEndTime.getTime() - recordStartTime.getTime();
						// console.log("timeDiff = " + timeDiff);
						var timeDiffSeconds = Math.round(timeDiff / 1000);
						// 时间差即为录制音频的市场
						// self.recorderVoice.speakVoiceDuration = timeDiffSeconds;
						// console.log("this.recorderVoice.speakVoiceDuration = " + self.recorderVoice.speakVoiceDuration);
						// 超过60s自动关闭，所以需要设置isSpeaking为false
						// self.isSpeaking = false;
						
						// self.recorderVoice.voicePath = res.tempFilePath;
						
						if (timeDiffSeconds < 1) {
							uni.showToast({
								icon: "none",
								title: "说话时间太短..."
							})
							return;
						}
						
						var recorderVoice = new Object();
						recorderVoice["speakVoiceDuration"] = timeDiffSeconds;
						recorderVoice["voicePath"] = res.tempFilePath;
						
						// TODO 音频上传到服务器
						var me = this;
						var userId = getApp().getUserInfoSession().id;
						// 上传
						var serverUrl = app.globalData.serverUrl;
						uni.uploadFile({
							header: {
								headerUserId: userId,
								headerUserToken: app.getUserSessionToken()
							},
							url: serverUrl + "/file/uploadChatVoice?userId=" + userId,
							name: "file",
							filePath: res.tempFilePath,
							success(result) {
								// console.log(result);
								if (result.statusCode == 200) {
									var res = JSON.parse(result.data);
									// console.log(res);
									if (res.status == 200) {
										var voiceUrl = res.data;
										console.log("voiceUrl = " + voiceUrl);
										// 发送语音消息
										self.sendVoiceMsg(voiceUrl, timeDiffSeconds);
									} else {
										uni.showToast({
											title: res.msg,
											icon: 'none'
										})
									}
								} else {
									uni.showToast({
										title: "上传失败",
										icon: 'error'
									})
								}
							}
						})
						
						
						// 发送语音消息
						// self.sendVoiceMsg(recorderVoice);
					} else if (self.speakingType == 1) {
						// 取消语音，啥都不干
					} else if (self.speakingType == 2) {
						// 语音转文字
						var voicePath = res.tempFilePath;
						
						// self.audio2dataURL(voicePath);
						// 先发一个等待loading的效果msg到列表，优化用户体验
						var currentMsgIndex = self.sendMsgLoading();
						
						self.uploadVoiceFile(voicePath, currentMsgIndex);
					}
					
					// 恢复类型
					self.speakingType = 3;
				});
				// #endif
				
				var innerAudioContext = uni.createInnerAudioContext();
				this.innerAudioContext = innerAudioContext;
				this.innerAudioContext.autoplay = true;
				
				this.innerAudioContext.onEnded(function (res) {
					// console.log('innerAudioContext end' + JSON.stringify(res));
					// 播放停止，设置播放的开关为-1
					self.voicePlayingIndex = -1;
				});
			},
			
			sendMsgLoading() {
				var msgItem = {};
				var msgItem = new Object();
				msgItem["msgContent"] = "";
				msgItem["msgType"] = this.MSGTYPE.MSG_LOADING;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				console.log(msgItem)
				
				// 消息时间（公用化）临时loading消息不需要显示时间
				// msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				var currentMsgIndex = tempList.length - 1;
				// common.playSendSound();
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
				
				return currentMsgIndex;
			},
			
			uploadVoiceFile(voicePath, currentMsgIndex){
				var me = this;
				var userId = getApp().getUserInfoSession().id;
				// 上传
				var serverUrl = app.globalData.serverUrl;
				uni.uploadFile({  
					method: "post",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/speech/uploadVoice",
					filePath: voicePath,
					name: 'file',  
					success: (res) => {  
						var word = res.data;
						var wordMsg = JSON.parse(word);
						console.log("上传音频成功"+word);  
						me.sendMsgTransFromVoice(wordMsg.data, currentMsgIndex);
					},  
					fail: (res) => {  
						console.log("上传音频失败"+JSON.stringify(res));  
						me.sendMsgTransFromVoice("", currentMsgIndex);
					}  
				});  
			},
			
			sendMsgTransFromVoice(msgContent, currentMsgIndex) {
				if (!app.globalData.chatSocketOpen) {
					app.reConnect();
					return;
				}
				
				var tempList = this.allMSGList;
				tempList.splice(currentMsgIndex, 1);
				
				console.log("识别结果 = " + msgContent);
				if (msgContent == "" || msgContent == undefined || msgContent == null) {
					// 为空删除loading效果
					// var tempList = this.allMSGList;
					// tempList.splice(currentMsgIndex, 1);
					return;
				}
				// 以下是老代码，没有loading效果的代码
				// console.log("识别结果 = " + msgContent);
				// console.log(typeof(msgContent))
				var msgItem = {};
				var msgItem = new Object();
				// msgItem["msgContent"] = msgContent[0];
				msgItem["msgContent"] = msgContent;
				msgItem["msgType"] = this.MSGTYPE.WRODS;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				console.log(msgItem)
				
				// 消息时间（公用化）
				msgItem = this.dealMsgDateTime(msgItem);
				
				// var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				// 保存最后一条消息到本地
				this.saveLastestMsgToLocal(msgContent, msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.WRODS, msgContent, msgItem.showMsgDateTimeFlag, "", null, null, null, null, null);
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			
			// data:audio/vnd.wave;base64,
			//  data:application/PCM;base64,
			transform2Words() {
				var postData = {
					format: 'pcm', //语音文件的格式，pcm/wav/amr/m4a。不区分大小写。推荐pcm文件
					rate: 16000, //	采样率，16000，固定值 此处文档参数16000，达不到这种高保真音频，故 使用8000
					// rate: 8000, //	采样率，16000，固定值 此处文档参数16000，达不到这种高保真音频，故 使用8000
					dev_pid: 1537,//普通话
					channel: 1, //声道数，仅支持单声道，请填写固定值 1
					cuid: 'fengjianyingyue', //用户唯一标识，用来区分用户，计算UV值。建议填写能区分用户的机器 MAC 地址或 IMEI 码，长度为60字符以内。
					token: this.token,
					speech: this.adioFileData, //本地语音文件的的二进制语音数据 ，需要进行base64 编码。与len参数连一起使用。
					len: this.adioSize //本地语音文件的的字节数，单位字节 init
				}
				// console.log(JSON.stringify(postData) + '1111')
				//调用语音识别接口
				uni.request({
					url: 'http://vop.baidu.com/server_api', //仅为示例，并非真实接口地址。
					data: postData,
					header: {
						// 'content-type': 'Content-Type: audio/pcm;rate=16000' //自定义请求头信息
						'content-type': 'application/json' //自定义请求头信息
					},
					method: 'POST',
					success: (res) => {
						this.resContent = res.data
						console.log("识别结果 = " + JSON.stringify(res.data));
						this.sendMsgTransFromVoice(res.data.result);
						
						// this.text = 'request success';
					}
				})
			},
			
			
			
			startRecord() {
				// console.log('开始录音');
				this.recorderManager.start({  
					// duration: 59000,
                    sampleRate:16000,//采样率，App、小程序  
					// sampleRate: 8000,//采样率，App、小程序  
                     //encodeBitRate:96000,//仅小程序支持编码码率   
                    numberOfChannels:1,  
                    // format:'PCM',//格式 aac/mp3/wav/PCM，App默认值为mp3，小程序默认值aac  
                });
				// 开始记录时间
				var recordStartTime = new Date();
				this.recordStartTime = recordStartTime;
			},
			endRecord() {
				// console.log('录音结束');
				this.recorderManager.stop();
			},
			playVoice2() {
				console.log('播放录音');
	
				if (this.recorderVoice && this.recorderVoice.voicePath) {
					this.innerAudioContext.src = this.recorderVoice.voicePath;
					this.innerAudioContext.play();
				}
			},
				
			voiceDisplay(index) {
				// console.log('index = ' + index);
				var voiceMsg = this.allMSGList[index];
				// console.log('voiceMsg = ' + JSON.stringify(voiceMsg));
				console.log(voiceMsg);
				var voicePath = voiceMsg.voicePath;
				// console.log('voicePath = ' + voicePath);
				
				if (voicePath) {
					console.log(this.innerAudioContext);
					this.innerAudioContext.src = voicePath;
					this.innerAudioContext.play();
					
					// 移除未读标记
					voiceMsg["isRead"] = true;
					var tempList = this.allMSGList;
					tempList.splice(index, 1, voiceMsg);
					this.allMSGList = tempList;
					// console.log(this.allMSGList);
					// TODO 更新消息状态到后端
				}
			},	
			playVoice(index, msgId) {
				var lastVoicePlayingId = this.voicePlayingIndex;
				if (lastVoicePlayingId == index) {
					// 如果上一个播放的和即将要播放的index相同，代表点击他同一个，则停止播放
					this.voicePlayingIndex = -1;
					this.innerAudioContext.stop();
				} else {
					this.voicePlayingIndex = index;
					this.voiceDisplay(index);
				}
				
				// 调用后端，修改语音已读
				
				var me = this;
				var userId = app.getUserInfoSession().id;
				
				var serverUrl = app.globalData.serverUrl;
				uni.request({
					method: "POST",
					header: {
						headerUserId: userId,
						headerUserToken: app.getUserSessionToken()
					},
					url: serverUrl + "/chat/signRead/" + msgId,
					success(result) {
						// console.log(result);
	
						if (result.data.status == 200) {
							
						} else {
							uni.showToast({
								title: result.data.msg,
								icon: "none",
								duration: 3000
							});
						}
					}
				});
				
				return;
				var lastPlayingId = this.nowPlayingId;		// 上一个正在播放的id	
				var thisPlayingId = "voiceIsPlay"+msgId;	// 当前即将要播放的id
				
				// 如果thisPlayingId == lastPlayingId，停止播放
				if (lastPlayingId == thisPlayingId) {
					this.voicePlayObject["voiceIsPlay"+msgId] = false;
				}
				// 如果thisPlayingId ！= lastPlayingId，播放当前，并且停止上一个语音
				if (lastPlayingId != thisPlayingId) {
					this.voicePlayObject[lastPlayingId] = false;
					this.voicePlayObject[thisPlayingId] = true;
				}
				
				this.nowPlayingId = "voiceIsPlay"+msgId;	// 设置正在播放的id
				
				
				// var isPlaying = !this.voicePlayObject["voiceIsPlay"+msgId];
				// this.voicePlayObject["voiceIsPlay"+msgId] = isPlaying;
				// if (isPlaying) {
				// 	this.nowPlayingId = "voiceIsPlay"+msgId;	// 正在播放的id
				// }
				
				// console.log(this.voicePlayObject);
				// this.voicePlayObject["voiceIsPlay"+msgId] = true;
				// console.log(this.voicePlayObject);
				// console.log(this.voicePlayObject["voiceIsPlay"+msgId]);
			},
					
			enterFace(faceId) {
				// var tc = this.$refs.msgTextarea;
				// var tclen = tc.value.length;
				// tc.focus();
				
				var cursor = this.cursor;
				var msgContent = this.msgContent;
				
				// if (msgContent == null || msgContent == '' || msgContent == undefined) {
					
				// }
				
				var frontPart = msgContent.substring(0, cursor);
				var backPart = msgContent.substring(cursor);
				// console.log("frontPart = " + frontPart);
				// console.log("backPart = " + backPart);
				var faceSign = "[" + faceId + "]";
				this.cursor = this.cursor + faceSign.length;
				this.msgContent = frontPart + faceSign + backPart;
				
				//把face存入本地list
				var latestFaceList = this.latestFaceList;
				// 判断，如果faceId已经存在，删除他，把新的放入
				latestFaceList = this.removeOldItem(latestFaceList, faceId);
				console.log(latestFaceList)
				latestFaceList.unshift(faceId);	// 把点击的表情放在第一个，也就是最近使用的，作为数组开头元素
				latestFaceList = this.popFaceList(latestFaceList);
				this.latestFaceList = latestFaceList;	// 刷新历史头像列表
				uni.setStorageSync("latestFaceList", latestFaceList);	// 存入缓存，以便下次进来后可以使用
			},
			removeOldItem(latestFaceList, faceId) {
				for (var i = 0 ; i < latestFaceList.length ; i ++) {
					var tmpId = latestFaceList[i];
					if (tmpId == faceId) {
						latestFaceList.splice(i, 1);
						console.log("break = " + latestFaceList)
						break;
					}
				}
				console.log("out = " + latestFaceList)
				return latestFaceList;
			},
			popFaceListInit(latestFaceList, historyWidth) {
				var sys = uni.getSystemInfoSync();
				var windowWidth = sys.windowWidth;
				// console.log("historyWidth = " + historyWidth);
				// console.log("windowWidth = " + windowWidth);
				// if (historyWidth > windowWidth) {
				if ( (historyWidth - windowWidth) > 80) {
					// console.log("pop~~~");
					latestFaceList.pop();
					historyWidth -= 80;
					return this.popFaceListInit(latestFaceList, historyWidth);
				} else {
					return latestFaceList;
				}
			},
			popFaceList(latestFaceList) {
				if (latestFaceList.length > this.faceLineCounts) {
					// 如果当前最近使用的头像超过[每行做多显示表情的个数]，则删除最早的一个，也就是数组末尾
					latestFaceList.pop();
					// 递归函数是函数的自身调用，返回需要连函数要一起返回，否则为undefined
					return this.popFaceList(latestFaceList);
				} else {
					return latestFaceList;
				}
			},
			
			loadMorePagedMsg() {
				this.isLoadingMsg = true;
				// console.log(111)
				setTimeout(()=>{
					// var msgContent = "矮油~不错噢~！[016]";
					// var msgItem = {};
					// var msgItem = new Object();
					// msgItem["msgContent"] = msgContent;
					// msgItem["msgType"] = this.MSGTYPE.WRODS;
					// msgItem["msgSource"] = this.MSGSOURCE.SENDER;
					
					// var msgContent2 = "矮油~不错噢~！[016]";
					// var msgItem2 = {};
					// var msgItem2 = new Object();
					// msgItem2["msgContent"] = msgContent2;
					// msgItem2["msgType"] = this.MSGTYPE.WRODS;
					// msgItem2["msgSource"] = this.MSGSOURCE.RECEIVER;
					
					// var tempList = [];
					// tempList.push(msgItem);
					// tempList.push(msgItem2);
					
					// var allMSGList = tempList.concat(this.allMSGList);
					// console.log(allMSGList);
					// // this.allMSGList = allMSGList;
					// this.allMSGList = allMSGList;
					
					var page = this.page + 1;
					var total = this.total;
					if (page > total) {
						uni.showToast({
							title: "没有更多消息了~",
							icon: "none"
						});
						this.isLoadingMsg = false;
						return;
					}
					this.getMsgList(page);
					
					this.isLoadingMsg = false;
				}, 1)
				
				// this.scrollToTop();
			},
			
			deleteWords() {
				var msgContent = this.msgContent;
				if (msgContent == "" || msgContent == undefined || msgContent == null) {
					return;
				}
				
				// 获得当前的光标位置
				var cursor = this.cursor;
				
				// 向前5位截取字符串
				var start = cursor - 5;
				var end = cursor;
				
				// 截取中括号内的表情号
				var faceMask = msgContent.substring(start, end);
				console.log("faceMask = " + faceMask);
				
				// 根据 '['  ']' 分割字符串，获取中括号内容
				var leftArray = faceMask.split("[");
				var rightArray = faceMask.split("]");
				// console.log("leftArray = " + leftArray.length);
				// console.log("rightArray = " + rightArray.length);
				
				var faceBody = null;
				if (leftArray.length == 2 && rightArray.length == 2) {
					var faceTemp = leftArray[1].split("]");
					var faceBody = faceTemp[0];
					console.log("faceTemp = " + faceTemp);
					console.log("faceBody = " + faceBody);
				}
				
				// 判断截取后的表情是否包含在表情列表
				var isFaceExist = false;
				if (faceBody != null && faceBody != undefined && faceBody != "") {
					var faceArray = this.faceArray;
					var isFaceExist = faceArray.includes(faceBody);
					console.log("isFaceExist = " + isFaceExist);
				}
				
				// 如果存在，则从text内容中删除该表情，否则只删除1个字符
				if (isFaceExist) {
					var contentArray = msgContent.split(faceMask);
					this.msgContent = contentArray[0] + contentArray[1];
					// 删除后，光标前移5格
					this.cursor = cursor - faceMask.length;
				} else {
					var leftContent = msgContent.substring(0, cursor-1);
					var rightContent = msgContent.substring(cursor, msgContent.length);
					console.log("leftContent = " + leftContent);
					console.log("rightContent = " + rightContent);
					this.msgContent = leftContent + rightContent;
					// 删除后，光标前移1格
					this.cursor = cursor - 1;
				}
			},
			sendVoiceMsg(voicePath, speakVoiceDuration) {
				if (!app.globalData.chatSocketOpen) {
					app.reConnect();
					return;
				}
				
				var msgItem = {};
				var msgItem = new Object();
				msgItem["msgContent"] = "";	// 预留拓展，语音转文字可以同时存文字+语音
				msgItem["voicePath"] = voicePath;
				msgItem["speakVoiceDuration"] = speakVoiceDuration;
				// msgItem["recorderVoice"] = recorderVoice;
				msgItem["msgType"] = this.MSGTYPE.VOICE;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				msgItem["isRead"] = false;
				
				// 消息时间（公用化）
				msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList);
				common.playSendSound();
				
				// 保存最后一条消息到本地
				this.saveLastestMsgToLocal("[语音]", msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.VOICE, "", msgItem.showMsgDateTimeFlag, "", null, null, null, voicePath, speakVoiceDuration);
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			dealMsgDateTime(msgItem) {
				var datetime = new Date();
				var nowTimeStr = this.DateUtil.formatDateToStr(datetime);
				msgItem["chatTime"] = nowTimeStr;
				
				// 获得allMSGList中最新的一条数据，获得他的[发送时间]
				var tempList = this.allMSGList;
				if (tempList != null && tempList != undefined && tempList.length > 0) {
					var lastMsg = tempList[tempList.length-1];
					var lastMsgDateTime = lastMsg.chatTime;
					
					// console.log("nowTimeStr = " + nowTimeStr);
					// console.log("lastMsgDateTime = " + lastMsgDateTime);
					
					var nowTime = this.DateUtil.formatCompareDatetime(nowTimeStr, lastMsgDateTime);
					if (nowTime == null) {
						// 为空表示发送时间小时1分钟，则标记这个时间不需要显示
						msgItem["showMsgDateTimeFlag"] = 0;	// 标记存储数据库，用于历史展示
					} else {
						// 不为空，则需要显示时间
						msgItem["showMsgDateTimeFlag"] = 1;	// 标记存储数据库，用于历史展示
					}
					
				} else {
					// 如果allMSGList为空，则当前必定显示时间，因为这是你们之间发送的第一条信息
					// console.log("datetime = " + datetime);
					var nowTime = this.DateUtil.formatWeekDatetime(datetime);
					// msgItem["msgDateTime"] = nowTime;	// 页面显示的消息时间
					msgItem["showMsgDateTimeFlag"] = 1;	// 标记存储数据库，用于历史展示，是否要显示消息的标记时间
				}
				return msgItem;
			},
			sendResume() {
				
				var me = this;
				var meInfo = this.meInfo;
				var myNickname = meInfo.nickname;
				var myPosition = meInfo.position;
				
				var msgContent = {
					"name": myNickname,
					"position": myPosition
				}
				
				var msgItem = {};
				var msgItem = new Object();
				
				msgItem["msgContent"] = msgContent;
				msgItem["msgType"] = this.MSGTYPE.RESUME;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				
				msgItem["resumeUserId"] = meInfo.id;
				msgItem["resumeName"] = myNickname;
				msgItem["resumePosition"] = myPosition;
				
				msgItem = this.dealMsgDateTime(msgItem);
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
					// private String resumeUserId;				// 候选人id
					// private String resumeName;				// 简历名称（候选人名称）
					// private String resumePosition;			// 候选人职位
				
				// 保存最后一条消息到本地
				this.saveLastestMsgToLocal("[简历]", msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.RESUME, "", msgItem.showMsgDateTimeFlag, "", null, null, null, null, null);
				
				
				this.$nextTick(() => {
					this.scrollToBottom();
				});
			},
			
			sendMsg(e) {
				
				if (!app.globalData.chatSocketOpen) {
					app.reConnect();
					return;
				}
				
				var msgContent = this.msgContent;
				// var msgContent = e.detail.value;
				// console.log(msgContent)
				
				if (msgContent == "" || msgContent == undefined || msgContent == null) {
					return;
				}
				
				var msgItem = {};
				var msgItem = new Object();
				msgItem["msgContent"] = msgContent;
				msgItem["msgType"] = this.MSGTYPE.WRODS;
				msgItem["msgSource"] = this.MSGSOURCE.SENDER;
				
				// 消息时间（公用化），处理时间
				msgItem = this.dealMsgDateTime(msgItem);
				console.log(msgItem)
				
				var tempList = this.allMSGList;
				tempList.push(msgItem);
				this.allMSGList = tempList;
				// console.log(this.allMSGList)
				common.playSendSound();
				
				// 保存最后一条消息到本地
				this.saveLastestMsgToLocal(msgContent, msgItem.chatTime);
				
				// 发送到server通信
				this.sendMSGToServer(this.MSGTYPE.WRODS, msgContent, msgItem.showMsgDateTimeFlag, "", null, null, null, null, null);
				
				this.msgContent = "";
				// this.msgHeight = 22;
				this.resetMSGTextareaHeight();
				this.blur();
				this.cursor = 0;
				
				// setTimeout(()=>{
				this.$nextTick(() => {
					this.scrollToBottom();
				});
				// }, 100)
			},
			
			// 把消息发送到后端，进行通信
			sendMSGToServer(msgType, msg, showMsgDateTimeFlag, videoPath, videoWidth, videoHeight, videoTimes, voicePath, speakVoiceDuration) {
				var chatMsg = {
					senderId: this.meInfo.id,
					receiverId: this.hrUserId,
					receiverType: 1,		// 此处，接受者为 HR
					msg: msg,
					msgType: msgType,
					showMsgDateTimeFlag: showMsgDateTimeFlag,
					videoPath: videoPath,
					videoWidth: videoWidth,
					videoHeight: videoHeight,
					videoTimes: videoTimes,
					voicePath: voicePath,
					speakVoiceDuration: speakVoiceDuration,
				}
				
				if (msgType == this.MSGTYPE.RESUME) {
					var meInfo = this.meInfo;
					var myNickname = meInfo.nickname;
					var myPosition = meInfo.position;
					
					chatMsg.resumeUserId = meInfo.id;
					chatMsg.resumeName = myNickname;
					chatMsg.resumePosition = myPosition;
				}
				
				var dataContent = {
					// msgType: msgType,
					chatMsg: chatMsg,
				}
				var msgPending = JSON.stringify(dataContent);
				
				app.globalData.CHAT.send({
					data: msgPending
				});
			},
			
			speakingDisplay() {
				this.isSpeaking = true;
				this.scrollToBottom();
			},
			
			replaceAndShowFace(msg) {
				// console.log(msg);
				// 处理表情
				let temp = []
				let reg = /\[.*?\]/g
				// console.log(temp = reg.exec(msg));
				while((temp = reg.exec(msg))){
					let str = temp[0].substring(1,temp[0].length-1)
					// console.log(temp = reg.exec(msg));
					if(str){
						let value = str
						// <img src='../../static/images/gif/11摔东西.gif' class='emoji-iamge'/>
						let html = `<img src='../../static/images/gif/${value}.gif' class='emoji-iamge'/>`;
						// let html = `<img src='${config.imgUrl}/emoji/d_${value}.gif' style='width:18px;height:18px;vertical-align: middle;'></img>`
						msg = msg.replace(temp[0],html)
					}
				}
				// console.log(msg);
				return msg;
			},

			
			previewImage(url) {
				uni.previewImage({
					urls: [url]
				})
			},
			
			//滚动到底部
			scrollToBottom() {
				
				this.$nextTick(() => {
					// console.log("$nextTick");
					this.scrollIntoIndex = '';
					setTimeout(()=>{
						this.scrollIntoIndex = 'lastLineBottom';
					}, 100)
				});
				
			 //    let query = uni.createSelectorQuery().in(this)
			 //    query.select('#msgScrollList').boundingClientRect()
			 //    query.select('#msgViewList').boundingClientRect()
			 //    query.exec((res) => {
			 //    //如果子元素高度大于父元素高度(显示高度)
				// // console.log("res[1].height = " + res[1].height);
				// // console.log("res[0].height = " + res[0].height);
			 //    if (res[1].height > res[0].height) {
			 //      //计算出二者差值就是需要滚动的距离
			 //       this.scrollTop = res[1].height - res[0].height
			 //    }
			 //  })
			},
			//滚动到顶部
			scrollToTop() {
			    this.scrollTop = 0;
			},
			
			msgScroll() {
				this.blur();
			},
			
			initListener() {
				//监听键盘的高度变化，让sroll-view的高度随之变化
				uni.onKeyboardHeightChange(res => {
					// setTimeout(()=>{
						let keyBoardHeight = res.height
						if (this.keyBoardHeight == 0 && keyBoardHeight > 0) {
							this.keyBoardHeight = keyBoardHeight
						}
						
						// console.log("keyBoardHeight = " + keyBoardHeight);
						if (keyBoardHeight > 0 && keyBoardHeight >200) {
							// console.log(this.height);
							this.height = this.height - this.keyBoardHeight;
							// console.log(this.height);

							// 此处有bug，多减了一次，所以通过keyBoardHeight >200来控制次数,keyBoardHeight肯定在各个手机端上大于200的高度
						} else if (keyBoardHeight <= 0) {
							// console.log(this.height);
							this.height = this.height + this.keyBoardHeight;
							// console.log(this.height);
						}
						
					// }, 500)
				})
			},
			destoryListener() {
				uni.offKeyboardHeightChange((res) => {
					console.log("offKeyboardHeightChange...")
				})
			},
			
			touchstartLeftVoice(index) {
				// this.leftVoiceTouched = true;
				this.voiceActiveIndex = index;
			},
			touchendLeftVoice() {
				// this.leftVoiceTouched = false;
				this.voiceActiveIndex = -1;
			},
			
			touchstartRightVoice(index) {
				// this.rightVoiceTouched = true;
				this.voiceActiveIndex = index;
			},
			touchendRightVoice() {
				// this.rightVoiceTouched = false;
				this.voiceActiveIndex = -1;
			},
			
			touchstartSpeak(e) {
				this.speakTouched = true;
				this.speakingDisplay();				
			},
			touchendSpeak() {
				this.speakTouched = false;
				this.isSpeaking = false;
				
				// console.log(this.speakingType);
				
				// // 恢复类型
				// this.speakingType = 3;
			},
			touchMoveSpeak(e) {
				var fingerPoint = e.changedTouches[0];
				// console.log(fingerPoint);
				var clientX = fingerPoint.clientX;
				var clientY = fingerPoint.clientY;
				
				var windowHeight = this.windowHeight;
				var windowWidth = this.windowWidth;
				var middleWindowWidth = this.middleWindowWidth;
				var footerTop = this.footerTop;
				var upPartHeight = footerTop - 66;
				
				// console.log("windowHeight = " + windowHeight);
				// console.log("windowWidth = " + windowWidth);
				// console.log("middleWindowWidth = " + middleWindowWidth);
				// console.log("footerTop = " + footerTop);
				// console.log("upPartHeight = " + upPartHeight);
				
				if (clientX <= middleWindowWidth && clientX > 0 && clientY <= upPartHeight && clientY > 0) {
					this.speakingType = 1;
					// console.log("取消发送~");
				} else if (clientX > middleWindowWidth && clientX <= windowWidth && clientY <= upPartHeight && clientY > 0) {
					this.speakingType = 2;
					// console.log("发送文本~");
				} else if (clientY > upPartHeight && clientY < windowHeight) {
					this.speakingType = 3;
					// console.log("松开发送语音~");
				} else {
					// 不符合直接取消
				}
			},
			
			
			/**  
			* 触摸开始  
			**/  
			touchStart(e) {  
				// console.log("触摸开始")  
				this.touchStartX = e.touches[0].clientX;  
				this.touchStartY = e.touches[0].clientY; 
				this.blur();
				this.hideFaceBoard();
			},  
			/**  
			* 触摸结束  
			**/  
			touchEnd(e) {  
				return;
				// console.log("触摸结束")  
				let deltaX = e.changedTouches[0].clientX - this.touchStartX;  
				let deltaY = e.changedTouches[0].clientY - this.touchStartY;  
				if (Math.abs(deltaX) > 50 && Math.abs(deltaX) > Math.abs(deltaY)) {  
					if (deltaX >= 0) {  
						console.log("左滑")  
					} else {  
						console.log("右滑")  
					}  
				} else if(Math.abs(deltaY) > 50&& Math.abs(deltaX) < Math.abs(deltaY)) {  
					if (deltaY < 0) {  
						console.log("上滑")  
						this.blur();
					} else {  
						console.log("下滑")  
						this.blur();
					}  
				} else {  
					console.log("可能是误触！")  
				}  
			},  
			
			
			showSpeak() {
				
				// #ifdef H5
				uni.showModal({
					title: "网页浏览器不支持，请使用App发送语音~",
					cancelText: "取消",
					confirmText: "确定",
					confirmColor: "#31B9B3",
					success(e) {
						return;
					}
				});
				return;
				// #endif
				
				this.isSpeak = true;
				this.isFace = false;
				this.alignSelf = "center";
				this.blur();
			},
			hideFaceBoard() {
				this.isFace = false;
				
				this.isPlus = false;
			},
			showFaceBoard() {
				this.isFace = true;
				this.isSpeak = false;
				
				this.isPlus = false;
				
				// 底部表情panel展示
				// 尝试用 this.height 的一半来定义表情panel的高度
			},
			showPlusBoard() {
				this.isPlus = !this.isPlus;
				if (!this.isPlus) {
					this.showKeyboard();
				}
				if (this.isPlus) {
					this.isFace = false;
				}
			},
			showKeyboard() {
				this.isSpeak = false;
				this.isFace = false;
				this.isPlus = false;
				this.alignSelf = "flex-end";
				setTimeout(()=>{
					this.focus();
				}, 250)
				// this.focus();
			},
			
			linechange(e) {
				// console.log(e);
				var me = this;
				var lineCount = e.detail.lineCount;
				if (lineCount <= 5) {
					var msgHeight = me.msgHeight + 22;
					me.msgHeight = msgHeight;
				}
				if (lineCount > 1) {
					me.alignSelf = "flex-end";
				}
				
				uni.createSelectorQuery().in(this).select("#msgTextarea").boundingClientRect(data => {
				  // console.log(JSON.stringify(data))
				  if (lineCount > 5 && data.height < 118) {
					  me.msgHeight = 118;
				  }
				}).exec();
			},
			
			resetMSGTextareaHeight() {
				var me = this;
				uni.createSelectorQuery().in(this).select("#msgTextarea").boundingClientRect(data => {
					// console.log(data.height);
					if (data.height > 30) {
					  me.msgHeight = 0;
					}
				}).exec();
			},
			
			typingMsg(e) {
				// console.log(e);
				// uni.createSelectorQuery().select('#msgTextarea').boundingClientRect(data) => {
				// 	console.log(data);
				// }).exec();
				var me = this;
				uni.createSelectorQuery().in(this).select("#msgTextarea").boundingClientRect(data => {
				  console.log(JSON.stringify(data))
				  // {"id":"","dataset":{},"left":12,"right":308,"top":12,"bottom":315,"width":296,"height":303}
				  // this.heightEle = data.height
				  if (data.height > 96) {
						me.autoHeight = false;
				  }
				}).exec();
			},
			moveStop() {},
			focus() {
				this.messageFocus = true;
				// 需要使用$nextTick延时调用，否则没有效果
				// this.$nextTick(() => {
				//     this.scrollToBottom()
				// })
				// setTimeout(()=>{
				// 	console.log("this.scrollToBottom()");
				// 	this.scrollToBottom()
				// }, 150)
			},
			blur(e) {
				this.messageFocus = false;
				// console.log(e);
				if (e != undefined && e != null) {
					var cursor = e.detail.cursor;		// 失去焦点时，获得当前光标所在的文本段落位置
					this.cursor = cursor;
				}
			},
			goBack() {
				uni.navigateBack({
					delta: 1
				})
			},
			
			showNewRefreshResume() {
				uni.navigateTo({
					url: "statistics/newRefreshResume",
					animationType: "slide-in-bottom",
					success() {
					}
				});
			},

		}
	}
</script>

<style>
	@import url("messageList.css");
	/* .textarea {
		line-height: 20px;
	} */
</style>

