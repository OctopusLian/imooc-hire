<template>
    <div class="components-container">
        <aside>
            新候选人刷新设置 - 天数阈值
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
        <div style="width: 100%; display: flex; flex-direction: row; justify-content: center;margin-top: 30px;margin-bottom: 10px;">
            <el-form label-width="100px" size="mini" label-position="left">
                <label class="label" for="endValInput">天数阈值: 
                    <input v-model.number="setEndVal" type="number" name="endVaInput"/>
                </label>
                <div class="startBtn example-btn" @click="start">设置</div>
            </el-form>
        </div>

        <aside>
            <span style="font-size: 12px; color: gray;"><i class="el-icon-info"></i> 备注：候选人在1天内刷新简历，则符合条件会出现在HR的‘新候选人’中。设置为2天，则昨天和今天刷新简历的候选人则满足条件，以此类推~</span>
            <br/>
            admin设置天数后，则更新到zk，微服务（zk客户端）监听到以后，则获得配置的天数，
            设置到本地缓存中CaffeineCache中（可以参考https://zhuanlan.zhihu.com/p/109226599，https://www.jianshu.com/p/15d0a9ce37dd），
            HR点击‘新候选人’，先从本地缓存中获得天数，根据天数去查询近期N天内刷新的候选人简历，并显示出来。
            此做法不使用redis可以降低高并发时对redis的压力，提升吞吐量。并且使用本地缓存可以加速访问。
            如果某些业务同时结合那么，也可以称之为多级缓存。
        </aside>
    </div>
</template>

<script>
import countTo from "vue-count-to";

export default {
    name: "settingsOptions",
    components: { countTo },
    data() {
        return {
            setStartVal: 0,
            setEndVal: 1,
            setDuration: 1500,
            setDecimals: 0,
            setSeparator: ",",
            setSuffix: " 天",
            setPrefix: "",
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
            if (this.setEndVal) {
                return this.setEndVal;
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
    },
    methods: {
        start() {
            this.$refs.example.start();
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
    margin-left: 20px;
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

