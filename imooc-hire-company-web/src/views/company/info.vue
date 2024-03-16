<template>
    <div class="app-container">
            
        <el-form ref="dataForm" label-width="80px" :model="temp" size="mini" label-position="left" style="width: 880px; margin-top: 20px; margin-left:50px;">
            <el-form-item label="企业名称">
                <!-- <img :src="require('@/assets/static/logo.png')" class="sidebar-logo"> -->
                <img :src="companyInfo.logo" class="sidebar-logo">
                {{companyInfo.companyName}}
            </el-form-item>

            <el-form-item label="对外昵称">
                {{companyInfo.shortName}}
            </el-form-item>
            
            <el-form-item label="人员规模">
                {{companyInfo.peopleSize}}
            </el-form-item>

            <el-form-item label="办公地址">
                {{companyInfo.address}}
            </el-form-item>

            <el-form-item label="公司性质">
                {{companyInfo.nature}}
            </el-form-item>

            <el-form-item label="所在行业">
                {{companyInfo.industry}}
            </el-form-item>

            <el-form-item label="融资阶段">
                {{companyInfo.financStage}}
            </el-form-item>

            <el-form-item label="工作时间">
                {{companyInfo.workTime}}
            </el-form-item>

            <el-form-item label="公司简介">
                {{companyInfo.introduction}}
            </el-form-item>

            <el-form-item label="公司优势">
                <!-- {{companyInfo.advantage}} -->
                <span v-for="a in advantageList" :key="a.id" style="margin-right: 6px;">
                    {{a.itemValue}}
                </span>
            </el-form-item>
            <el-form-item label="公司福利">
                <!-- {{companyInfo.benefits}} -->
                <span v-for="b in benefitsList" :key="b.id" style="margin-right: 6px;">
                    {{b.itemValue}}
                </span>
            </el-form-item>
            <el-form-item label="薪资福利">
                <!-- {{companyInfo.bonus}} -->
                <span v-for="b in bonusList" :key="b.id" style="margin-right: 6px;">
                    {{b.itemValue}}
                </span>
            </el-form-item>
            <el-form-item label="补助津贴">
                <!-- {{companyInfo.subsidy}} -->
                <span v-for="s in subsidyList" :key="s.id" style="margin-right: 6px;">
                    {{s.itemValue}}
                </span>
            </el-form-item>



            <el-form-item label="法人代表">
                {{companyInfo.legalRepresentative}}
            </el-form-item>
            <el-form-item label="注册资本">
                {{companyInfo.registCapital}}
            </el-form-item>
            <el-form-item label="注册地址">
                {{companyInfo.registPlace}}
            </el-form-item>
            <el-form-item label="成立日期">
                {{companyInfo.buildDate}}
            </el-form-item>

            <el-form-item label="公司相册" class="pics">
                <el-image 
                    v-for="img in companyImgList" :key="img" 
                    style="width: 300px; height: 230px; margin-right: 20px;" 
                    :src="img" 
                    :fit="imgFit"
                    :preview-src-list="companyImgList"></el-image>
                <!-- <el-image style="width: 300px; height: 230px; margin-right: 20px;" :src="require('@/assets/static/company/company1.png')" :fit="imgFit"></el-image> -->
                <!-- <el-image style="width: 300px; height: 230px; margin-right: 20px;" :src="require('@/assets/static/company/company2.png')" :fit="imgFit"></el-image>
                <el-image style="width: 300px; height: 230px; margin-right: 20px;" :src="require('@/assets/static/company/company3.png')" :fit="imgFit"></el-image>
                <el-image style="width: 300px; height: 230px; margin-right: 20px;" :src="require('@/assets/static/company/company4.png')" :fit="imgFit"></el-image>
                <el-image style="width: 300px; height: 230px; margin-right: 20px;" :src="require('@/assets/static/company/company5.png')" :fit="imgFit"></el-image> -->
            </el-form-item>

            <el-form-item label="营业执照">
                <a :href="require('@/assets/static/yyzz.png')" target="_blank">
                    <img :src="companyInfo.bizLicense" class="yyzz">
                </a>
            </el-form-item>

        </el-form>

    </div>
</template>

<script>
import { getCompanyInfo, getPhotos, getItemsByKeys } from '@/api/company';

export default {
    name: "companyInfo",
    data() {
        return {
            temp: {},
            imgFit: "contain",     // fill / contain / cover / none / scale-down
            companyImgList: [
                require('@/assets/static/company/company1.png'),
                require('@/assets/static/company/company2.png'),
                require('@/assets/static/company/company3.png'),
                require('@/assets/static/company/company4.png'),
                require('@/assets/static/company/company5.png'),
            ],

            companyInfo: {},

            advantageList: [],
            benefitsList: [],
            bonusList: [],
            subsidyList: [],
        };
    },
    created() {
        this.initCompanyInfo();
    },
    methods: {
        initCompanyInfo() {
            getCompanyInfo().then(response => {
                var companyInfo = response.data;
                console.log(companyInfo);
                this.companyInfo = companyInfo;

                var advantage = companyInfo.advantage == null ? "" : companyInfo.advantage;
				var benefits = companyInfo.benefits == null ? "" : companyInfo.benefits; 
				var bonus = companyInfo.bonus == null ? "" : companyInfo.bonus;
				var subsidy = companyInfo.subsidy == null ? "" : companyInfo.subsidy;

                var advantageArr = advantage.split(",");
				var benefitsArr = benefits.split(",");
				var bonusArr = bonus.split(",");
				var subsidyArr = subsidy.split(",");

                var bo = {
					"advantage": advantageArr,
					"benefits": benefitsArr,
					"bonus": bonusArr,
					"subsidy": subsidyArr
				}

                getItemsByKeys(bo).then(response => {
                    var vo = response.data;
                    console.log(vo);
                    this.advantageList = vo.advantageList;
                    this.benefitsList = vo.benefitsList;
                    this.bonusList = vo.bonusList;
                    this.subsidyList = vo.subsidyList;
                });
            });

            getPhotos().then(response => {
                console.log(response);
                var photos = response.data.photos;
                console.log(photos);
                var arr = photos.split(",");
                this.companyImgList = arr;
            });
        }
    },
};
</script>

<style scoped>
.pics {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: flex-start;
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
