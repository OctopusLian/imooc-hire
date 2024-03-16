<template>
    <div class="app-container">
        <el-button v-if="isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="primary" @click="handleDownload">
            <svg-icon icon-class="excel" /> 导出到Excel
        </el-button>

        <el-button v-if="!isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="warning" @click="goBuyVip">
            <svg-icon icon-class="money" /> 导出到Excel
        </el-button>

        <el-table v-loading="listLoading" :data="list" border fit style="width: 100%" >
            <el-table-column align="center" label="序号" width="80">
                <template slot-scope="scope">
                    <span>{{ scope.$index + 1 }}</span>
                    <!-- <span>{{ scope.row.companyId }}</span> -->
                </template>
            </el-table-column>

            <el-table-column min-width="220px" align="center" label="职位名称">
                <template slot-scope="scope">
                    <span>{{ scope.row.jobName }}</span>
                </template>
            </el-table-column>

            <el-table-column min-width="130px" align="center" label="职位类别">
                <template slot-scope="scope">
                    <span>{{ scope.row.jobType }}</span>
                </template>
            </el-table-column>

            <el-table-column width="110px" align="center" label="薪资">
                <template slot-scope="scope">
                    <span>{{ scope.row.beginSalary }}-{{ scope.row.endSalary }} · {{ scope.row.monthlySalary }}薪</span>
                </template>
            </el-table-column>

            <el-table-column min-width="120px" align="center" label="学历要求">
                <template slot-scope="scope">
                    <span>{{ scope.row.edu }}</span>
                </template>
            </el-table-column>

            <el-table-column width="110px" align="center" label="状态">
                <template slot-scope="{ row }">
                    <el-tag :type="row.status | statusFilter">
                        {{row.status == 1 ? "招聘中" : ""}}
                        {{row.status == 2 ? "已关闭" : ""}}
                        {{row.status == 3 ? "违规删除" : ""}}
                    </el-tag>
                </template>
            </el-table-column>

            <el-table-column width="200px" align="center" label="发布时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.createTime }}</span>
                </template>
            </el-table-column>

            <el-table-column width="200px" align="center" label="更新时间">
                <template slot-scope="scope">
                    <span>{{ scope.row.updatedTime }}</span>
                </template>
            </el-table-column>

            <el-table-column align="center" label="操作" width="120">
                <template slot-scope="scope">
                    <el-button type="primary" size="small" icon="el-icon-view" @click="renderJobInfo(scope.row.id)">
                        查看
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" 
            :total="total" 
            :page.sync="listQuery.page" 
            :limit.sync="listQuery.limit"
            @pagination="getJobList"/>
            <!-- getPagedList -->

        <el-dialog :visible.sync="dialogJobInfoVisible" title="职位信息" width="750px" top="5vh">
            
            <el-form ref="dataForm" label-width="80px" :model="temp" size="mini" label-position="left" style="width: 500px; margin-left:50px;">
                <el-form-item label="职位名称">
                    {{jobInfo.jobName}}
                </el-form-item>

                <el-form-item label="职位类型">
                    {{jobInfo.jobType}}
                </el-form-item>
                
                <el-form-item label="职位薪资">
                    {{jobInfo.beginSalary}}-{{jobInfo.endSalary}}K · {{jobInfo.monthlySalary}}薪
                </el-form-item>

                <el-form-item label="职位标签">
                    {{jobInfo.tags}}
                </el-form-item>
                
                <el-form-item label="工作经验">
                    {{jobInfo.expYears}}
                </el-form-item>

                <el-form-item label="学历要求">
                    {{jobInfo.edu}}
                </el-form-item>

                <el-form-item label="工作城市">
                    {{jobInfo.city}}
                </el-form-item>

                <el-form-item label="工作地址">
                    {{jobInfo.address}}
                </el-form-item>

                <el-form-item label="职位详情" style="width: 620px;">
                    <p style="line-height: 23px;margin-top:5px;" v-html="jobInfo.jobDesc">
                    </p>
                </el-form-item>

                <el-form-item label="职位状态">
                    {{jobInfo.status == 1 ? "招聘中" : ""}}
                    {{jobInfo.status == 2 ? "已关闭" : ""}}
                    {{jobInfo.status == 3 ? "违规删除" : ""}}
                </el-form-item>

                <el-form-item label="举报缘由" style="color: red;" v-if="jobInfo.status == 3">
                    {{jobInfo.reportReason}}
                </el-form-item>

            </el-form>

            <span slot="footer" class="dialog-footer">
                <!-- <el-button @click="dialogJobInfoVisible = false">取 消</el-button> -->
                <!-- <router-link v-if="isVip" target="_blank" to="/pdf/download"> -->
                <router-link v-if="isVip" target="_blank" :to="{path:'/pdf/download' , query :{jobId:jobInfo.id}}">
                    <el-button type="success"><svg-icon icon-class="pdf" /> 下载PDF文件</el-button>
                </router-link>
                <el-button v-if="!isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="warning" @click="goBuyVip">
                    <svg-icon icon-class="money" /> 下载PDF文件
                </el-button>

                <el-button v-if="isVip" type="primary" style="margin:0 0 20px 20px;" @click="downloadWord"><svg-icon icon-class="form" /> 下载Word文件</el-button>
                <el-button v-if="!isVip" :loading="downloadLoading" style="margin:0 0 20px 20px;" type="warning" @click="goBuyVip">
                    <svg-icon icon-class="money" /> 下载Word文件
                </el-button>

                <el-button type="info" @click="dialogJobInfoVisible = false">关闭页面</el-button>
            </span>
        </el-dialog>


    </div>
</template>

<script>
import { getCompanyJobList, getJobInfo, isVip } from '@/api/company';
import Pagination from "@/components/Pagination"; // Secondary package based on el-pagination
import { outExportExcel } from '@/utils/excel';

import docxtemplater from 'docxtemplater'
import PizZip from 'pizzip'
import jszip from 'pizzip'
import JSZipUtils from 'jszip-utils'
import {saveAs} from 'file-saver'

export default {
    name: "jobsList",
    components: { Pagination, outExportExcel },
    filters: {
        statusFilter(status) {
            const statusMap = {
                1: "success",
                2: "warning",
                3: "danger",
                // 1: "success",
                // 2: "danger",
                // 3: "warning",
                // 已删除: "info",
            };
            return statusMap[status];
        },
    },
    data() {
        
        return {
            isVip: false,
            
            downloadLoading: false,
            filename: '职位列表',
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
            jobInfo: {},

            list: null,
            total: 0,
            listLoading: true,
            listQuery: {
                page: 1,
                limit: 10
            },

            jobExample: {
                title: "Java 高级开发工程",
                company: "慕课网科技公司",
                publisher: "风间影月",
                industry: "互联网/计算机",
                introduction: "职责描述\n"
                        + "1、理解产品定义，并在整个项目过程中予以持续把握；\n"
                        + "2、向各职能部门提出人力资源申请，组建项目团队，维持项目团队的在业务进展中的可用性/稳定性；\n"
                        + "3、在立项初期举行风险评估，在项目进行过程中对风险防范措施予以落实；持续防范项目风险；\n"
                        + "4、协调公司技术资源，参考研发部门的专业意见，从项目整体角度作出决定；跟踪问题解决状况，并及时汇报管理层；\n"
                        + "5、协调和评估生产中的具体问题，权衡客户与公司利益，及时给出最优解决方案；\n"
                        + "6、对项目的进度和质量负责，针对项目中的问题须及时收集并发布，组织相关人员第一时间给出解决方案并监督落实；\n"
                        + "7、依照公司流程，协同相关部门成员，负责项目按时按质并在项目预算及成本要求范围内，完成量产和订单交付。\n"
                        + "\n"
                        + "任职要求：\n"
                        + "1、本科及以上学历；\n"
                        + "2、至少2年以上电子消费类产品项目管理或团队领导经验，手机相关行业尤佳；\n"
                        + "3、具备项目管理理论。"
            }
        };
    },
    created() {
        this.getJobList();
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

        getJobList() {

            var page = this.listQuery.page;
            console.log("page = " + page);
            if (page > 3) {
                this.getPagedListVIPError();
                return;
            }

            this.listLoading = true;
            getCompanyJobList(this.listQuery).then(response => {
                console.log(response);
                var grid = response.data;
                this.list = grid.rows;
                this.total = grid.records;
                this.listLoading = false
            })
        },

        renderJobInfo(jobId) {
            this.dialogJobInfoVisible = true;

            var params = {
                jobId: jobId
            }
            getJobInfo(params).then(response => {
                console.log(response);
                var jobInfo = response.data;

                var jobDesc = jobInfo.jobDesc;
                // jobDesc = jobDesc.replaceAllStr("\n", "<br/>")
                jobDesc = this.replaceAllStr(jobDesc, "\n", "<br/>")

                jobInfo.jobDesc = jobDesc;
                this.jobInfo = jobInfo;
            })
        },

        replaceAllStr(sourceStr, findStr, repStr) {
            String.prototype.replaceAll = function (FindText, RepText) {
                return this.replace(new RegExp(findStr, "g"), repStr);
            }

            // 把所有imooc替换成lee
            sourceStr = sourceStr.replaceAll(findStr, repStr)
            return sourceStr;
        },

        downloadWord() {
            var job = this.jobInfo;

            var status = job.status;
            if (status == 1) {
                job.statusVal = "招聘中";
            } else if (status == 2) {
                job.statusVal = "已关闭";
            } else if (status == 3) {
                job.statusVal = "违规删除";
            }

            var jobDesc = job.jobDesc;
            jobDesc = this.replaceAllStr(jobDesc, "<br/>", "\n");
            job.jobDesc = jobDesc;

            // 点击导出word
            let _this = this;
            // 读取并获得模板文件的二进制内容
            // @/assets/
            JSZipUtils.getBinaryContent("job.docx",function(error, content) {
                // exportTemplate.docx是模板。我们在导出的时候，会根据此模板来导出对应的数据
                // 抛出异常
                if (error) {
                    throw error;
                }

                // 创建一个PizZip实例，内容为模板的内容
                let zip = new PizZip(content);
                // 创建并加载docxtemplater实例对象
                let doc = new docxtemplater();
                doc.loadZip(zip).setOptions({ linebreaks:true});

                // 设置模板变量的值
                doc.setData(job);

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
                var fileName = "职位信息-" + job.jobName + ".docx";
                saveAs(out, fileName);
            });
        },

        downloadWord2(){
            var user = {
                name: "lee",
                age: 18,
                skills: "java, html, css"
            };

            var job = this.jobExample;

            // 点击导出word
            let _this = this;
            // 读取并获得模板文件的二进制内容
            // @/assets/
            JSZipUtils.getBinaryContent("job.docx",function(error, content) {
                // exportTemplate.docx是模板。我们在导出的时候，会根据此模板来导出对应的数据
                // 抛出异常
                if (error) {
                    throw error;
                }

                // 创建一个PizZip实例，内容为模板的内容
                let zip = new PizZip(content);
                // 创建并加载docxtemplater实例对象
                // let doc = new docxtemplater();
                // doc.loadZip(zip);
                // let doc = new docxtemplater(zip, { linebreaks: true }) 
                let doc = new docxtemplater();
                doc.loadZip(zip).setOptions({ linebreaks:true});

                // doc.setOptions({
                //     linebreaks: true,
                // });


                // 设置模板变量的值
                // doc.setData(user);
                doc.setData(job);

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
                saveAs(out, "职位信息.docx");
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
                type: "error",
                duration: 2500,
            });
        },

        handleDownload() {
            this.downloadLoading = true
            // import('@/utils/Export2Excel').then(excel => {
            import('@/components/vendor/Export2Excel').then(excel => {
                const tHeader = ['序号', '职位名称', '职位类别', '薪资', '学历要求', '状态','发布时间', '更新时间']
                const filterVal = ['jobId', 'jobName', 'jobType', 'salary', 'edu', 'status', 'createTime', 'updatedTime']
                const list = this.list
                console.log(list);
                const data = this.formatJson(filterVal, list)
                console.log(data);
                console.log(excel);
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
            var counts = 0;
            return jsonData.map(v => filterVal.map(j => {
                // console.log("j = " + j)
                // console.log("v = " + v)
                // console.log("v[j] = " + v[j])

                if (j == "jobId") {
                    return ++counts;
                }

                if (j == "salary") {
                    return v["beginSalary"] + "-" + v["endSalary"] + "K·" + v["monthlySalary"] + "薪";
                    // { scope.row.beginSalary }}-{{ scope.row.endSalary }} · {{ scope.row.monthlySalary }}
                }

                if (j == "status") {
                    var status = v[j];
                    if (status == 1) {
                        return "招聘中";
                    } else if (status == 2) {
                        return "已关闭";
                    } else if (status == 3) {
                        return "违规删除";
                    }
                }
                
                return v[j]
            }))
        },

        showJobInfoDialog() {
            this.dialogJobInfoVisible = true;
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
            this.listLoading = false;
            // this.list = response.data.items
            this.total = 50;

            var jobsList = {
                jobId: "1810107M6XAAG2FW",
                title: "Java高级工程",
                publishTime: "2022-02-22 16:15:55",
                publisher: "风间影月",
                status: "已关闭",     // 招聘中，待发布，已关闭
            };
            var arr = []; 
            arr.length = 10;
            arr.fill(jobsList)
            this.list = arr;
            console.log(this.list);
        },
    },
};
</script>

<style scoped>
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
