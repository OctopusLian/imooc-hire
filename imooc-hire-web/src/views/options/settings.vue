<template>
    <div class="components-container">
        <div>
            <aside>
                候选人（求职者）每日最大刷新简历的次数限制
            </aside>
            <count-to
                ref="example"
                :start-val="_startVal"
                :end-val="_endVal"
                :duration="_duration"
                :decimals="_decimals"
                :separator="_separator"
                :prefix="_prefix"
                :suffix="_suffix"
                :autoplay="true"
                class="example"
            />
            <!-- display: flex; flex-direction: row; justify-content: center; -->
            <div style="width: 100%; display: flex; flex-direction: row; justify-content: center;margin-top: 20px;margin-bottom: 10px;">
                <el-form label-width="100px" size="mini" label-position="left">
                    <label class="label" for="endValInput">次数阈值: 
                        <input v-model.number="maxRefreshResumeCounts" type="number" name="endVaInput"/>
                    </label>
                    <div class="startBtn example-btn" @click="setNewMaxRefreshResumeCounts">设置</div>
                </el-form>
            </div>

            <aside>
                <span style="font-size: 12px; color: gray;"><i class="el-icon-info"></i> 备注：候选人（求职者）每天可以刷新的最大次数，目的降低候选人有事没事刷简历，也可以提高招聘人员的筛选率~</span>
                <!-- <span style="font-size: 12px; color: gray;"><i class="el-icon-info"></i> 备注：候选人在1天内刷新简历，则符合条件会出现在HR的‘新候选人’中。设置为2天，则昨天和今天刷新简历的候选人则满足条件，以此类推~</span> -->
            </aside>
        </div>

        <div style="margin-top: 50px; padding-bottom: 30px;">
            <aside>
                充值秒杀参数设置
            </aside>
            <div style="width: 100%; display: flex; flex-direction: row; justify-content: space-around;margin-top: 30px;margin-bottom: 10px;">
                <count-to
                    ref="payHour"
                    :start-val="_startValHour"
                    :end-val="_endValHour"
                    :duration="_durationHour"
                    :suffix="_suffixHour"
                    :autoplay="true"
                    class="example"
                />
                <count-to
                    ref="payNum"
                    :start-val="_startValNum"
                    :end-val="_endValNum"
                    :duration="_durationNum"
                    :suffix="_suffixNum"
                    :autoplay="true"
                    class="example"
                />
                <count-to
                    ref="payPrice"
                    :start-val="_startValPrice"
                    :end-val="_endValPrice"
                    :duration="_durationPrice"
                    :suffix="_suffixPrice"
                    :autoplay="true"
                    class="example"
                />
            </div>
            <!-- display: flex; flex-direction: row; justify-content: center; -->
            <div style="width: 100%; display: flex; flex-direction: row; justify-content: space-around;margin-top: 5px;margin-bottom: 10px;">
                <el-form label-width="100px" size="mini" label-position="left">
                    <label class="label" for="endValInput">开始时间: 
                        <input v-model.number="pay.hourEndVal" type="number" name="endVaInput"/>
                    </label>
                    <div class="startBtn example-btn" @click="startHour">设置</div>
                </el-form>

                <el-form label-width="100px" size="mini" label-position="left">
                    <label class="label" for="endValInput">库存件数: 
                        <input v-model.number="pay.numEndVal" type="number" name="endVaInput"/>
                    </label>
                    <div class="startBtn example-btn" @click="startNum">设置</div>
                </el-form>

                <el-form label-width="100px" size="mini" label-position="left">
                    <label class="label" for="endValInput">秒杀价格: 
                        <input v-model.number="pay.priceEndVal" type="number" name="endVaInput"/>
                    </label>
                    <div class="startBtn example-btn" @click="startPrice">设置</div>
                </el-form>
            </div>

            <aside>
                <span style="font-size: 12px; color: gray;"><i class="el-icon-info"></i> 备注：每天几点开始秒杀活动，总计秒杀的件数设置，每件秒杀的价格设置~</span>
            </aside>
        </div>
    </div>
</template>

<script>
import countTo from "vue-count-to";
import { getMaxRefreshResumeCounts, modifyMaxResumeRefreshCounts } from '@/api/settings';

export default {
    name: "settingsOptions",
    components: { countTo },
    data() {
        return {
            setStartVal: 0,
            // setEndVal: 1,
            maxRefreshResumeCounts: 1,
            setDuration: 1500,
            setDecimals: 0,
            setSeparator: ",",
            setSuffix: " 次",
            setPrefix: "每日 ",

            version: 0,

            pay: {
                hourStartVal: 0,
                hourEndVal: 1,
                hourDuration: 1500,
                hourSuffix: " 时",

                numStartVal: 0,
                numEndVal: 1,
                numDuration: 1500,
                numSuffix: " 件",

                priceStartVal: 0,
                priceEndVal: 1,
                priceDuration: 1500,
                priceSuffix: " 元",
            }
        };
    },
    computed: {
        _startVal() {
            if (this.setStartVal) {
                return this.setStartVal;
            } else {
                return 0;
            }
        },
        _endVal() {
            if (this.maxRefreshResumeCounts) {
                return this.maxRefreshResumeCounts;
            } else {
                return 0;
            }
        },
        _duration() {
            if (this.setDuration) {
                return this.setDuration;
            } else {
                return 100;
            }
        },
        _decimals() {
            if (this.setDecimals) {
                if (this.setDecimals < 0 || this.setDecimals > 20) {
                    alert("digits argument must be between 0 and 20");
                    return 0;
                }
                return this.setDecimals;
            } else {
                return 0;
            }
        },
        _separator() {
            return this.setSeparator;
        },
        _suffix() {
            return this.setSuffix;
        },
        _prefix() {
            return this.setPrefix;
        },



        _startValHour() {
            if (this.pay.hourStartVal) {
                return this.pay.hourStartVal;
            } else {
                return 0;
            }
        },
        _endValHour() {
            if (this.pay.hourEndVal) {
                return this.pay.hourEndVal;
            } else {
                return 0;
            }
        },
        _durationHour() {
            if (this.pay.hourDuration) {
                return this.pay.hourDuration;
            } else {
                return 100;
            }
        },
        _suffixHour() {
            return this.pay.hourSuffix;
        },


        _startValNum() {
            if (this.pay.numStartVal) {
                return this.pay.numStartVal;
            } else {
                return 0;
            }
        },
        _endValNum() {
            if (this.pay.numEndVal) {
                return this.pay.numEndVal;
            } else {
                return 0;
            }
        },
        _durationNum() {
            if (this.pay.numDuration) {
                return this.pay.numDuration;
            } else {
                return 100;
            }
        },
        _suffixNum() {
            return this.pay.numSuffix;
        },


        _startValPrice() {
            if (this.pay.priceStartVal) {
                return this.pay.priceStartVal;
            } else {
                return 0;
            }
        },
        _endValPrice() {
            if (this.pay.priceEndVal) {
                return this.pay.priceEndVal;
            } else {
                return 0;
            }
        },
        _durationPrice() {
            if (this.pay.priceDuration) {
                return this.pay.priceDuration;
            } else {
                return 100;
            }
        },
        _suffixPrice() {
            return this.pay.priceSuffix;
        },
    },
    created() {
        this.initMaxRefreshResumeCounts();
    },
    methods: {
        initMaxRefreshResumeCounts() {
            this.listLoading = true;
            getMaxRefreshResumeCounts().then(response => {
                // console.log(response);
                var maxRefreshResumeCounts = response.data.maxResumeRefreshCounts;
                var version = response.data.version;
                // console.log("maxRefreshResumeCounts = " + maxRefreshResumeCounts);
                // console.log("version = " + version);
                this.maxRefreshResumeCounts = maxRefreshResumeCounts;
                this.version = version;
            })
        },

        setNewMaxRefreshResumeCounts() {
            
            this.listLoading = true;
            var bo = {
                maxCounts: this.maxRefreshResumeCounts,
                version: this.version
            };
            modifyMaxResumeRefreshCounts(bo).then(response => {
                console.log(response);
                var version = response.data;
                this.version = version;

                this.$notify({
                    title: "成功",
                    message: "参数修改成功~",
                    type: "success",
                    duration: 2000,
                });

                this.$refs.example.start();
            });
            this.listLoading = false;
        },

        // start() {
        //     this.$refs.example.start();
        // },
        startHour() {
            this.$refs.payHour.start();
        },
        startNum() {
            this.$refs.payNum.start();
        },
        startPrice() {
            this.$refs.payPrice.start();
        },
        // pauseResume() {
        //     this.$refs.example.pauseResume();
        // },
    },
};
</script>

<style scoped>
.example-btn {
    display: inline-block;
    margin-bottom: 0;
    font-weight: 500;
    text-align: center;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    border: 1px solid transparent;
    white-space: nowrap;
    line-height: 1.5;
    padding: 4px 15px;
    font-size: 12px;
    border-radius: 4px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    -webkit-transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
    transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
    position: relative;
    color: rgba(0, 0, 0, 0.65);
    background-color: #fff;
    border-color: #d9d9d9;
}

.example-btn:hover {
    color: #4ab7bd;
    background-color: #fff;
    border-color: #4ab7bd;
}
.example {
    font-size: 50px;
    color: #f6416c;
    display: block;
    margin: 10px 0;
    text-align: center;
    font-size: 80px;
    font-weight: 500;
}

.label {
    color: #2f4f4f;
    font-size: 16px;
    display: inline-block;
    margin: 15px 10px 15px 0;
}

input {
    position: relative;
    display: inline-block;
    padding: 4px 7px;
    width: 70px;
    height: 28px;
    cursor: text;
    font-size: 12px;
    line-height: 1.5;
    color: rgba(0, 0, 0, 0.65);
    background-color: #fff;
    background-image: none;
    border: 1px solid #d9d9d9;
    border-radius: 4px;
    -webkit-transition: all 0.3s;
    transition: all 0.3s;
}

.startBtn {
    margin-left: 5px;
    font-size: 20px;
    color: #30b08f;
    background-color: #fff;
}

.startBtn:hover {
    background-color: #30b08f;
    color: #fff;
    border-color: #30b08f;
}

.pause-resume-btn {
    font-size: 20px;
    color: #e65d6e;
    background-color: #fff;
}

.pause-resume-btn:hover {
    background-color: #e65d6e;
    color: #fff;
    border-color: #e65d6e;
}
</style>

