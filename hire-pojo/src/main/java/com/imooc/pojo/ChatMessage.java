
package com.imooc.pojo;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 聊天信息存储表
 * </p>
 *
 * @author 风间影月
 * @since 2022-09-04
 */
public class ChatMessage implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 发送者的用户id
     */
    private String senderId;

    /**
     * 接受者的用户id
     */
    private String receiverId;

    /**
     * 消息接受者的类型，是HR还是求职者，目的为了让前端不同页面接受判断并且处理显示
     */
    private Integer receiverType;

    /**
     * 聊天内容
     */
    private String msg;

    /**
     * 消息类型，有文字类、图片类、视频类...等，详见枚举类
     */
    private Integer msgType;

    /**
     * 消息的聊天时间，既是发送者的发送时间、又是接受者的接受时间
     */
    private LocalDateTime chatTime;

    /**
     * 标记存储数据库，用于历史展示。每超过1分钟，则显示聊天时间，前端可以控制时间长短
     */
    private Integer showMsgDateTimeFlag;

    /**
     * 视频地址
     */
    private String videoPath;

    /**
     * 视频宽度
     */
    private Integer videoWidth;

    /**
     * 视频高度
     */
    private Integer videoHeight;

    /**
     * 视频时间
     */
    private Integer videoTimes;

    /**
     * 语音地址
     */
    private String voicePath;

    /**
     * 语音时长
     */
    private Integer speakVoiceDuration;

    /**
     * 语音消息标记是否已读未读，true: 已读，false: 未读
     */
    private Boolean isRead;

    /**
     * 候选人用户id
     */
    private String resumeUserId;

    /**
     * 简历名称（候选人名称）  
简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息
     */
    private String resumeName;

    /**
     * 候选人职位  
简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息
     */
    private String resumePosition;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public String getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }

    public Integer getReceiverType() {
        return receiverType;
    }

    public void setReceiverType(Integer receiverType) {
        this.receiverType = receiverType;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getMsgType() {
        return msgType;
    }

    public void setMsgType(Integer msgType) {
        this.msgType = msgType;
    }

    public LocalDateTime getChatTime() {
        return chatTime;
    }

    public void setChatTime(LocalDateTime chatTime) {
        this.chatTime = chatTime;
    }

    public Integer getShowMsgDateTimeFlag() {
        return showMsgDateTimeFlag;
    }

    public void setShowMsgDateTimeFlag(Integer showMsgDateTimeFlag) {
        this.showMsgDateTimeFlag = showMsgDateTimeFlag;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public Integer getVideoWidth() {
        return videoWidth;
    }

    public void setVideoWidth(Integer videoWidth) {
        this.videoWidth = videoWidth;
    }

    public Integer getVideoHeight() {
        return videoHeight;
    }

    public void setVideoHeight(Integer videoHeight) {
        this.videoHeight = videoHeight;
    }

    public Integer getVideoTimes() {
        return videoTimes;
    }

    public void setVideoTimes(Integer videoTimes) {
        this.videoTimes = videoTimes;
    }

    public String getVoicePath() {
        return voicePath;
    }

    public void setVoicePath(String voicePath) {
        this.voicePath = voicePath;
    }

    public Integer getSpeakVoiceDuration() {
        return speakVoiceDuration;
    }

    public void setSpeakVoiceDuration(Integer speakVoiceDuration) {
        this.speakVoiceDuration = speakVoiceDuration;
    }

    public Boolean getIsRead() {
        return isRead;
    }

    public void setIsRead(Boolean isRead) {
        this.isRead = isRead;
    }

    public String getResumeUserId() {
        return resumeUserId;
    }

    public void setResumeUserId(String resumeUserId) {
        this.resumeUserId = resumeUserId;
    }

    public String getResumeName() {
        return resumeName;
    }

    public void setResumeName(String resumeName) {
        this.resumeName = resumeName;
    }

    public String getResumePosition() {
        return resumePosition;
    }

    public void setResumePosition(String resumePosition) {
        this.resumePosition = resumePosition;
    }

    @Override
    public String toString() {
        return "ChatMessage{" +
        "id=" + id +
        ", senderId=" + senderId +
        ", receiverId=" + receiverId +
        ", receiverType=" + receiverType +
        ", msg=" + msg +
        ", msgType=" + msgType +
        ", chatTime=" + chatTime +
        ", showMsgDateTimeFlag=" + showMsgDateTimeFlag +
        ", videoPath=" + videoPath +
        ", videoWidth=" + videoWidth +
        ", videoHeight=" + videoHeight +
        ", videoTimes=" + videoTimes +
        ", voicePath=" + voicePath +
        ", speakVoiceDuration=" + speakVoiceDuration +
        ", isRead=" + isRead +
        ", resumeUserId=" + resumeUserId +
        ", resumeName=" + resumeName +
        ", resumePosition=" + resumePosition +
        "}";
    }
}
