<template>
    <div class="app-container">
        <el-button v-if="isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="primary" @click="handleDownload">
            <svg-icon icon-class="excel" /> 导出到Excel
        </el-button>

        <el-button v-if="!isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="warning" @click="goBuyVip">
            <svg-icon icon-class="money" /> 导出到Excel
        </el-button>

        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="60">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.jobId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column min-width="100px" align="center" label="候选人">
                <template slot-scope="scope">
                    <span>{{ scope.row.candName }}</span>
                </template>
            </el-table-column>

            <el-table-column width="90px" align="center" label="照片">
                <template slot-scope="scope">
                    <el-image style="width: 60px; height: 60px; border-radius: 40px;" :src="scope.row.candFace">
                        <div slot="placeholder"></div>
                    </el-image>
                </template>
            </el-table-column>

            <el-table-column width="150px" align="center" label="面试岗位">
                <template slot-scope="scope">
                    <span>{{ scope.row.jobName }}</span>
                </template>
            </el-table-column>

            <el-table-column width="130px" align="center" label="面试状态">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{ row.status == 1 ? "等待接受" : "" }}
                        {{ row.status == 2 ? "接受面试" : "" }}
                        {{ row.status == 3 ? "拒绝面试" : "" }}
                        {{ row.status == 4 ? "取消面试" : "" }}
                        {{ row.status == 5 ? "面试通过" : "" }}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="170px" align="center" label="面试时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.interviewTime }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="180px" align="left" label="备注">
                <template slot-scope="scope">
                    <span>{{ scope.row.remark }}</span>
                </template>
            </el-table-column>


            <!-- <el-table-column align="center" label="操作" width="140">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-view" @click="showResumeInfoDialog(scope.row.candUserId)">
                        查看
                    </el-button>
                </template>
            </el-table-column> -->
        </el-table>

        <pagination v-show="total > 0" 
            :total="total" 
            :page.sync="listQuery.page" 
            :limit.sync="listQuery.limit"
            @pagination="getList"/>

        <el-dialog :visible.sync="dialogJobInfoVisible" title="简历预览" width="600px" top="5vh">

            <div style="width: 520px; margin-left: 20px;">
                <div class="first-wrapper">
                    <div>
                        <div style="font-size: 20px; font-weight: bold;">
                            {{resume.name}}
                        </div>
                        <div style="margin-top: 10px;">
                            {{resume.age}}岁 · 工作{{resume.workYears}}年
                        </div>
                        <div style="margin-top: 10px;">
                            {{resume.city}} · {{resume.education}}
                        </div>
                    </div>

                    <div>
                        <el-image style="width: 80px; height: 80px; border-radius: 40px;" :src="resume.face">
                            <div slot="placeholder"></div>
                        </el-image>
                    </div>
                </div>

                <div class="second-wrapper">
                    <div style="margin-top: 10px;">
                        <i class="el-icon-phone" /> {{resume.mobile}}
                    </div>
                    <div style="margin-top: 10px;">
                        <svg-icon icon-class="email" /> {{resume.email}}
                    </div>
                </div>

                <div class="third-wrapper" style="margin-top: 30px;">
                    <div style="font-size: 18px; font-weight: bold;">
                        优势亮点
                    </div>
                    <div style="margin-top: 0px;">
                        <!-- {{resume.advantages1}} -->
                        <p v-html="resume.advantageHtml" style="line-height: 22px;"></p>
                    </div>
                </div>

                <div class="fourth-wrapper" style="margin-top: 20px;">
                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div style="font-size: 18px; font-weight: bold;">
                            求职意向
                        </div>
                        <div style="font-size: 14px; color: gray; align-self: center;">
                            {{resume.jobStatus}}
                        </div>
                    </div>
                    <div v-for="intention in resume.jobIntention" :key="intention.jobTitle" style="margin-top: 18px; ">
                        <div style="display: flex; flex-direction: row; justify-content: space-between;">
                            <div style="font-size: 15px; font-weight: bold;">
                                {{intention.jobTitle}} · {{intention.city}}
                            </div>
                            <div style="font-size: 14px; color: gray; align-self: center; font-weight: bold; color: orange;">
                                {{intention.salary}}
                            </div>
                        </div>
                        <div style="margin-top: 10px; display: flex; flex-direction: row; justify-content: flex-start;">
                            <el-tag v-for="industry in intention.industry" :key="industry" :type="tagType" style="margin-right: 15px;">
                                {{industry}}
                            </el-tag>
                        </div>
                    </div>
                </div>

                <div class="sixth-wrapper" style="margin-top: 40px;">
                    <div style="font-size: 18px; font-weight: bold;">
                        工作经历
                    </div>
                    <div v-for="work in resume.workHistory" :key="work.company" style="margin-top: 25px;">
                        <div>
                            <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                <div style="font-size: 16px; font-weight: bold;">
                                    {{work.company}}
                                </div>
                                <div style="font-size: 14px; color: gray; align-self: center;">
                                    {{work.beginDate}} - {{work.endDate}}
                                </div>
                            </div>
                        </div>
                        <div style="">
                            <div style="margin-top: 6px; font-size: 14px; font-weight: bold; color: gray;">
                                {{work.jobTitle}} · {{work.department}}
                            </div>
                            <div style="margin-top: 6px; font-size: 14px; color: gray;">
                                薪资：{{work.salary}}元 x {{work.salaryMonth}}薪
                            </div>
                            <div style="margin-top: 6px; font-size: 14px; color: gray;">
                                汇报对象：{{work.superiorPerson}}
                            </div>
                            <div style="margin-top: 6px; font-size: 14px; color: gray;">
                                下属人数：{{work.subordinatesCounts}}
                            </div>
                        </div>
                        <div style="margin-top: 0px;">
                            <!-- {{resume.advantages1}} -->
                            <p v-html="work.workContent1" style="line-height: 22px;"></p>
                        </div>  
                    </div>
                </div>

                <div class="fifth-wrapper" style="margin-top: 30px;">
                    <div style="font-size: 18px; font-weight: bold;">
                        项目经验
                    </div>
                    <div v-for="project in resume.projectExp" :key="project.name" style="margin-top: 25px;">
                        <div>
                            <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                <div style="font-size: 16px; font-weight: bold;">
                                    {{project.name}}
                                </div>
                                <div style="font-size: 14px; color: gray; align-self: center;">
                                    {{project.beginDate}} - {{project.endDate}}
                                </div>
                            </div>
                        </div>
                        <div style="margin-top: 10px; font-size: 14px; font-weight: bold; color: gray;">
                            {{project.belongCompany}} · {{project.jobTitle}}
                        </div>

                        <div style="margin-top: 15px; font-size: 15px; color: gray;">
                            项目描述
                        </div>
                        <div style="margin-top: 0px;">
                            <p v-html="project.description1" style="line-height: 22px;"></p>
                        </div>  

                        <div style="margin-top: 15px; font-size: 15px; color: gray;">
                            项目业绩
                        </div>
                        <div style="margin-top: 0px;">
                            <p v-html="project.achievement1" style="line-height: 22px;"></p>
                        </div>  
                    </div>
                </div>

                <div class="seventh-wrapper" style="margin-top: 20px;">
                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div style="font-size: 18px; font-weight: bold;">
                            教育经历
                        </div>
                    </div>
                    <div v-for="education in resume.educationHistory" :key="education.school" style="display: flex; flex-direction: row; margin-top: 10px; ">
                        <!-- <el-image style="width: 300px; height: 230px; margin-right: 20px;" :src="require('@/assets/static/company/company1.png')" :fit="imgFit"></el-image> -->
                        <el-image style="padding: 4px; width: 50px; height: 50px; border-radius: 50px; align-self: center;" :src="require('@/assets/static/university.png')">
                            <div slot="placeholder"></div>
                        </el-image>
                        <div style="margin-top: 18px; margin-left: 20px; display: flex; flex-direction: column; justify-content: space-between;">
                            <div style="font-size: 16px; font-weight: bold;">
                                {{education.school}}
                            </div>
                            <div style="margin-top: 6px; font-size: 15px; color: gray;">
                                {{education.education}} · {{education.major}}
                            </div>
                            <div style="margin-top: 6px; font-size: 15px; color: gray;">
                                {{education.beginDate}} - {{education.endDate}}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <span slot="footer" class="dialog-footer">
                <!-- <el-button @click="dialogJobInfoVisible = false">取 消</el-button> -->
                <router-link v-if="isVip" target="_blank" to="/resume/download">
                    <el-button type="success"><svg-icon icon-class="pdf" /> 下载PDF简历</el-button>
                </router-link>
                <el-button v-if="!isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="warning" @click="goBuyVip">
                    <svg-icon icon-class="money" /> 下载PDF简历
                </el-button>

                <el-button v-if="isVip" type="primary" style="margin:0 0 20px 20px;" @click="downloadWord"><svg-icon icon-class="form" /> 下载Word简历</el-button>
                <el-button v-if="!isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="warning" @click="goBuyVip">
                    <svg-icon icon-class="money" /> 下载Word简历
                </el-button>

                <el-button type="info" @click="dialogJobInfoVisible = false">关闭页面</el-button>
            </span>
        </el-dialog>


    </div>
</template>

<script>
import { getInterviewList, isVip, queryMyResume } from '@/api/company';
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination
import { outExportExcel } from '@/utils/excel';
import table2excel from 'js-table2excel'

import docxtemplater from 'docxtemplater'
import PizZip from 'pizzip'
import JSZipUtils from 'jszip-utils'
import {saveAs} from 'file-saver'
// const fs = require('fs')

export default {
    name: "interviewList",
    components: { Pagination, outExportExcel },
    filters: {
        statusFilter(status) {
            const statusMap = {
                "1": "warning",
                "2": "gray",
                "3": "danger",
                "4": "info",
                "5": "success",

                "在职，看看新机会": "danger",
                "离职，正在找工作": "success",
                "在职，暂无跳槽计划": "info",
                "在职，急寻新工作": "warning",
            };
            return statusMap[status];
        },
    },
    data() {
        
        return {
            imageArrayBuffer: null,

            isVip: false,
            tagType: "",
            
            downloadLoading: false,
            filename: '面试记录表',
            autoWidth: true,
            bookType: 'xlsx',

            dialogVisible: false,
            dialogJobInfoVisible: false,
            dialogType: "create",

            destroyOnClose: true,

            adminInfo: {
                name: "",
                password: "",
                desc: "",
            },

            dataStart: '',
            dataEnd: '',

            temp: {},

            list: null,
            total: 0,
            listLoading: true,
            listQuery: {
                page: 1,
                limit: 10,
                type: undefined,
            },

            resume: {
                name: "王大锤",
                age: "28",
                workYears: "10",
                city: "北京",
                education: "本科",
                
                mobile: "13966668888",
                email: "admin@123.com",

                // face: "http://www.itzixi.com/img/arrow.png",
                face: "http://192.168.1.176:9000/orders/cat.png",

                //优势亮点
                advantages1: "PMP认证,SUN认证SCJP,MCP微软认证; <br>"
                            + "熟练掌握JAVA开发语言；<br>"
                            + "擅长使用微服务SpringCloud,SpringBoot,Spring,MyBatis等开源框架；<br>"
                            + "熟悉maven,redis,es,zookeeper,nginx,fastDFS,minio,quartz,RabbitMQ等中间件；<br>"
                            + "了解Hadoop,hdfs,mapreduce,spark,scala,finlk等大数据技术;<br>"
                            + "掌握Mysql,MariaDB,MSSQL关系型数据库；<br>"
                            + "严格遵循开发规范，重视代码的可重用性和可维护型以及可伸缩性；<br>"
                            + "微信个人公众号：【风间影月】；<br/>"
                            + "个人技术博客：http://www.cnblogs.com/leechenxiang。<br>",
                advantages: "PMP认证,SUN认证SCJP,MCP微软认证; \n"
                            + "熟练掌握JAVA开发语言；\n"
                            + "擅长使用微服务SpringCloud,SpringBoot,Spring,MyBatis等开源框架；\n"
                            + "熟悉maven,redis,es,zookeeper,nginx,fastDFS,minio,quartz,RabbitMQ等中间件；\n"
                            + "了解Hadoop,hdfs,mapreduce,spark,scala,finlk等大数据技术;\n"
                            + "掌握Mysql,MariaDB,MSSQL关系型数据库；\n"
                            + "严格遵循开发规范，重视代码的可重用性和可维护型以及可伸缩性；\n"
                            + "微信个人公众号：【风间影月】；\n"
                            + "个人技术博客：http://www.cnblogs.com/leechenxiang。\n",

                jobStatus: "在职，急寻新工作",
                jobIntention: [
                    {
                        jobTitle: "项目经理",
                        city: "北京",
                        salary: "14~16K·14薪",
                        industry: ["互联网/计算机", "游戏行业", "金融保险"]
                    },
                    {
                        jobTitle: "Java高级开发",
                        city: "北京",
                        salary: "14~20K·18薪",
                        industry: ["物流/电商/计算机", "游戏行业", "金融保险"]
                    }
                ],

                workHistory: [
                    {
                        company: "慕课网有限公司",
                        beginDate: "2016-06",
                        endDate: "至今",
                        jobTitle: "项目经理",
                        department: "技术部",
                        salary: "16000",        // 月薪
                        salaryMonth: "14",      // 多少个月薪资
                        superior: "总经理",
                        subordinatesCounts: "10",
                        // 工作职责与业绩
                        workContent1: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; <br>"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; <br>"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 <br>",
                        workContent: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; \n"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; \n"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 \n"
                    },
                    {
                        company: "王大锤有限公司",
                        beginDate: "2018-06",
                        endDate: "2020-06",
                        jobTitle: "项目经理",
                        department: "技术部",
                        salary: "16000",        // 月薪
                        salaryMonth: "14",      // 多少个月薪资
                        superior: "总经理",
                        subordinatesCounts: "10",
                        workContent1: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; <br>"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; <br>"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 <br>",
                        workContent: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; \n"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; \n"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 \n"
                    }
                ],

                projectExp: [
                    {
                        name: "物流app1",
                        beginDate: "2018-06",
                        endDate: "2020-06",
                        belongCompany: "王大锤有限公司",
                        jobTitle: "项目经理",
                        // 项目描述
                        description1: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; <br>"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; <br>"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 <br>",
                        description: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; \n"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; \n"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 \n",
                        // 项目业绩
                        achievement1: "成功上线app，获得各政企事业单位的好评，获得物流运行万物互联互运的美称； <br>"
                                    + "通过项目获得2000万美元的融资。 <br>",
                        achievement: "成功上线app，获得各政企事业单位的好评，获得物流运行万物互联互运的美称； \n"
                                    + "通过项目获得2000万美元的融资。 \n"
                    },
                    {
                        name: "物流app3",
                        beginDate: "2018-06",
                        endDate: "2020-06",
                        belongCompany: "王大锤有限公司",
                        jobTitle: "项目经理",
                        // 项目描述
                        description1: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; <br>"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; <br>"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 <br>",
                        description: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; \n"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; \n"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 \n",
                        // 项目业绩
                        achievement1: "成功上线app，获得各政企事业单位的好评，获得物流运行万物互联互运的美称； <br>"
                                    + "通过项目获得2000万美元的融资。 <br>",
                        achievement: "成功上线app，获得各政企事业单位的好评，获得物流运行万物互联互运的美称； \n"
                                    + "通过项目获得2000万美元的融资。 \n"
                    },
                    {
                        name: "物流app2",
                        beginDate: "2018-06",
                        endDate: "2020-06",
                        belongCompany: "王大锤有限公司",
                        jobTitle: "项目经理",
                        // 项目描述
                        description1: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; <br>"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; <br>"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 <br>",
                        description: "负责项目架构搭建，产品需求分析设计，数据库设计，项目计划制定，项目推进，服务器架设解决方案，组织团队建设; \n"
                                    + "我们后端团队主要工作为负责手机端的后端功能与对接，以及管理平台搭建及维护; \n"
                                    + "主要实现：订单模块，sso单点登录，分布式会话，用户画像与分析，权限模块，高可用与高并发方案等。 \n",
                        // 项目业绩
                        achievement1: "成功上线app，获得各政企事业单位的好评，获得物流运行万物互联互运的美称； <br>"
                                    + "通过项目获得2000万美元的融资。 <br>",
                        achievement: "成功上线app，获得各政企事业单位的好评，获得物流运行万物互联互运的美称； \n"
                                    + "通过项目获得2000万美元的融资。 \n"
                    },
                ],

                educationHistory: [
                    {
                        school: "清华池大学",
                        education: "本科",
                        major: "计算机管理",
                        beginDate: "2018-06",
                        endDate: "2022-06",
                    },
                    {
                        school: "西南大学",
                        education: "研究生",
                        major: "计算机管理",
                        beginDate: "2018-06",
                        endDate: "2022-06",
                    }
                ]
            }
        };
    },
    created() {
        this.getList();
        this.queryMyCompanyIsVip();
    },
    methods: {
        queryMyCompanyIsVip() {
            isVip().then(response => {
                console.log(response);
                var isVip = response.data;
                this.isVip = isVip;
            })
        },

        // 把图片转为base64格式
        imageToBase64ArrayBuffer(imageUrl) {
            let _this = this //防止function里指代不明确
            let image = new Image()
            image.crossOrigin = ''
            image.src = imageUrl
            image.onload = function () {
                // _this.base64Temp = _this.$getBase64Image(image)
                // var aaa = _this.$getBase64Image(image);
                var imageArrayBuffer = _this.base64DataURLToArrayBuffer(_this.$getBase64Image(image))
                _this.imageArrayBuffer = imageArrayBuffer;
            }    
        },

        //获取base64格式图片
        base64DataURLToArrayBuffer(dataURL) {
            debugger;
            const base64Regex = /^data:image\/(png|jpg|svg|svg);base64,/;
            if (!base64Regex.test(dataURL)) {
                return false;
            }
            const stringBase64 = dataURL.replace(base64Regex, "");
            let binaryString;
            if (typeof window !== "undefined") {
                binaryString = window.atob(stringBase64);
            } else {
                binaryString = Buffer.from(stringBase64, "base64").toString("binary");
            }
            const len = binaryString.length;
            const bytes = new Uint8Array(len);
            for (let i = 0; i < len; i++) {
                const ascii = binaryString.charCodeAt(i);
                bytes[i] = ascii;
            }
            return bytes.buffer;
        },


        downloadWord(){
            var ImageModule = require('open-docxtemplater-image-module');

            var resume = this.resume;
            // resume.face = this.face64;

            // 点击导出word
            let _this = this;
            // 读取并获得模板文件的二进制内容
            // @/assets/
            JSZipUtils.getBinaryContent("resume.docx",function(error, content) {
                // exportTemplate.docx是模板。我们在导出的时候，会根据此模板来导出对应的数据
                // 抛出异常
                if (error) {
                    throw error;
                }

                var imageOpts = {
                    getImage(tagValue, tagName) { //获取base64格式图片
                        // console.log(tagValue);
                        // return _this.base64DataURLToArrayBuffer(tagValue);

                        return _this.imageArrayBuffer;
                    },
                    getSize(img, tagValue, tagName) { //返回图片大小，长*宽
                        return [80, 80];
                    },
                }

                // 创建一个PizZip实例，内容为模板的内容
                let zip = new PizZip(content);
                // 创建并加载docxtemplater实例对象
                // let doc = new docxtemplater(zip, { 
                //     linebreaks: true,
                //     modules: [new ImageModule(imageOpts)],
                // }) 
                let doc = new docxtemplater();
                doc.attachModule(new ImageModule(imageOpts))
                    .loadZip(zip);
                doc.setOptions({ linebreaks:true});


                // 设置模板变量的值
                doc.setData(resume);

                try {
                    // 用模板变量的值替换所有模板变量
                    doc.render();
                } catch (error) {
                    // 抛出异常
                    let e = {
                        message: error.message,
                        name: error.name,
                        stack: error.stack,
                        properties: error.properties
                    };
                    throw error;
                }
                // 生成一个代表docxtemplater对象的zip文件（不是一个真实的文件，而是在内存中的表示）
                let out = doc.getZip().generate({
                    type: "blob",
                    mimeType:"application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                });
                // 将目标文件对象保存为目标类型的文件，并命名
                saveAs(out, "简历信息.docx");
            });
        },

        goBuyVip() {
            // this.$message({
            //     message: "请购买充值VIP后方可下载文件~",
            //     type: "warning",
            //     showClose: true,
            //     duration: 2000,
            // });

            this.$notify({
                title: "下载失败",
                message: "请充值VIP后下载文件",
                type: "warning",
                duration: 2500,
            });
        },

        handleDownload() {
            const columnData= [
                { title: '序号', key: 'id', type: 'text' },
                { title: '候选人', key: 'candName', type: 'text' },
                { title: '照片',  key: 'candFace', type: 'image', width: 80, height: 80 },
                { title: '面试岗位',  key: 'jobName', type: 'text' },
                { title: '状态',  key: 'status', type: 'text' },
                { title: '面试时间',  key: 'interviewTime', type: 'text' },
                { title: '备注',  key: 'remark', type: 'text' },
            ];

            var list = this.list;

            for (var i = 0 ; i < list.length ; i ++) {
                var tmp = list[i];
                tmp.id = i + 1;
                if (tmp.status == 1) {
                    tmp.status = "等待接受";
                } else if (tmp.status == 2) {
                    tmp.status = "接受面试";
                } else if (tmp.status == 3) {
                    tmp.status = "拒绝面试";
                } else if (tmp.status == 4) {
                    tmp.status = "取消面试";
                } else if (tmp.status == 5) {
                    tmp.status = "面试通过";
                }
            }

            var excelName = '面试记录';                      //文件名称
            table2excel(columnData, list, excelName);      //生成Excel表格，自动下载
        },

        handleDownload2() {
            this.downloadLoading = true
            // import('@/utils/Export2Excel').then(excel => {
            import('@/components/vendor/Export2Excel').then(excel => {
                const tHeader = ['序号', '候选人', '照片', '面试岗位', '状态', '面试时间', '备注']
                const filterVal = ['id', 'candName', 'candFace', 'jobName', 'status', 'interviewTime', 'remark']
                const list = this.list
                // console.log(list);
                const data = this.formatJson(filterVal, list)
                // console.log(data);
                // console.log(excel);
                excel.export_json_to_excel({
                    header: tHeader,
                    data,
                    filename: this.filename,
                    autoWidth: this.autoWidth,
                    bookType: this.bookType
                })
                this.downloadLoading = false
            })
        },
        formatJson(filterVal, jsonData) {
            return jsonData.map(v => filterVal.map(j => {
                return v[j]
            }))
        },

        showResumeInfoDialog(candUserId) {
            this.dialogJobInfoVisible = true;

            // 查询简历相关信息
            this.listLoading = true;
            queryMyResume(candUserId).then(response => {
                console.log(response);
                var resume = response.data;
                this.resume = resume;

                this.listLoading = false;
            })

            // 把简历图片改成base64
            this.imageToBase64ArrayBuffer(this.resume.face);
        },

        getPagedList() {
            this.$notify({
                title: "查看失败",
                message: "非VIP会员不可查看3个月前历史数据",
                type: "warning",
                duration: 2500,
            });
        },

        getPagedListVIPError() {
            this.$notify({
                title: "查看失败",
                message: "非VIP会员仅支持查看前3页内容",
                type: "warning",
                duration: 2500,
            });
        },

        getList() {

            var page = this.listQuery.page;
            console.log("page = " + page);
            if (page > 3) {
                this.getPagedListVIPError();
                return;
            }

            this.listLoading = true;
            getInterviewList(this.listQuery).then(response => {
                console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },

        getList2() {
            this.listLoading = false;
            // this.list = response.data.items
            this.total = 50;

            var candidateList = {
                candidateId: "1810107M6XAAG2FW",
                name: "风间影月",
                jobStatus: "在职，急寻新工作",
                city: "北京",
                age: 18,
                education: "本科",
                salary: "14~16K·14薪",
                workYears: "10",
                expectJobTitle: "项目经理",
                sendTime: "2022-02-22 16:15:55",
            };
            var arr = []; 
            arr.length = 10;
            arr.fill(candidateList)
            this.list = arr;
            // console.log(this.list);
        },
    },
};
</script>

<style scoped>
.first-wrapper {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.second-wrapper {
    display: flex;
    flex-direction: column;
}
.third-wrapper {
    display: flex;
    flex-direction: column;
}
.fourth-wrapper {
    display: flex;
    flex-direction: column;
}
.fifth-wrapper {
    display: flex;
    flex-direction: column;
}
.sixth-wrapper {
    display: flex;
    flex-direction: column;
}
.seventh-wrapper {
    display: flex;
    flex-direction: column;
}

.edit-input {
    padding-right: 100px;
}
.cancel-btn {
    position: absolute;
    right: 15px;
    top: 10px;
}
.sidebar-logo {
    width: 30px;
    height: 30px;
    vertical-align: middle;
}
.yyzz {
    width: 160px;
    height: 200px;
}
.line{
    text-align: center;
}
</style>
