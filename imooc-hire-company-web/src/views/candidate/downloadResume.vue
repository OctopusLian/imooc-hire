<template>
    <div v-loading.fullscreen.lock="fullscreenLoading" class="main-article" element-loading-text="PDF下载">
        <div style="padding-top: 50px;">
            <div style="width: 620px; margin-left: 50px;">
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
                        <el-image style="width: 80px; height: 80px; border-radius: 40px;" :fit="fit" :src="resume.face">
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
                        <p v-html="resume.advantages1" style="line-height: 22px;"></p>
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
                            <el-tag v-for="industry in intention.industry" :key="industry" :type="info" style="margin-right: 15px;">
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
                        <el-image style="padding: 4px; width: 50px; height: 50px; border-radius: 50px; align-self: center;" :fit="fit" :src="require('@/assets/static/university.png')">
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
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            fullscreenLoading: true,

            resume: {
                name: "王大锤",
                age: "28",
                workYears: "10",
                jobStatus: "在职，急寻新工作",
                city: "北京",
                education: "本科",
                
                mobile: "13966668888",
                email: "admin@123.com",

                face: "http://www.itzixi.com/img/arrow.png?imageView2/1/w/80/h/80",

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
                        salary: "14~20K·16薪",
                        industry: ["互联网/电子商务", "游戏行业", "金融保险"]
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
                        superiorPerson: "总经理",
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
                        superiorPerson: "总经理",
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
                        name: "物流app",
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
                        name: "物流app",
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
                        name: "物流app",
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
    mounted() {
        this.fetchData();
    },
    methods: {
        fetchData() {
            document.title = this.resume.name + "简历";
            setTimeout(() => {
                this.fullscreenLoading = false;
                this.$nextTick(() => {
                    window.print();
                });
            }, 3000);
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
</style>