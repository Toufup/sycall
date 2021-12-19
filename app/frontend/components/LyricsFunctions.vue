<template>
    <div>
        <v-speed-dial direction="top" open-on-click transition="slide-y-reverse-transition" v-model="isSpeedDialActive">
            <template v-slot:activator>
                <v-btn depressed fab color="white">
                    <v-icon x-large color="black">mdi-{{optionButton}}</v-icon>
                </v-btn>
            </template>
            <v-btn depressed fab color="white" @click.stop="rewind">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-icon x-large color="maccha" v-on="on">mdi-redo</v-icon>
                    </template>
                    <span>字幕0.5秒遅らせる</span>
                </v-tooltip>
            </v-btn>
            <v-btn depressed fab color="white" @click.stop="forward">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-icon x-large color="maccha" v-on="on">mdi-undo</v-icon>
                    </template>
                    <span>字幕0.5秒早める</span>
                </v-tooltip>
            </v-btn>
            <!-- ユーザー機能を実装していないためお気に入り機能を一旦コメントアウト -->
            <!-- <v-btn depressed fab color="white" @click.stop="like($event)">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-icon x-large color="pink" v-on="on">mdi-{{likeButton}}</v-icon>
                    </template>
                    <span>お気に入り</span>
                </v-tooltip>
            </v-btn> -->
            <v-btn depressed fab color="white" @click="dialogGuide = true; carousel = 0;">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-icon x-large color="maccha" v-on="on">mdi-help-circle</v-icon>
                    </template>
                    <span>ヘルプ</span>
                </v-tooltip>
            </v-btn>
            <v-btn depressed fab color="white" @click.stop>
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-sheet v-on="on" color="transparent">
                            <v-swatches id="color-picker" 
                                v-model="callBackgroundColor" :swatches="swatches"
                                popover-x="left" close-on-select shapes="circles"
                                @input="sendColor"
                            ></v-swatches>
                        </v-sheet>
                    </template>
                    <span>コールの背景色</span>
                </v-tooltip>
            </v-btn>
        </v-speed-dial>
        <v-dialog max-width="800" v-model="dialogGuide">
            <v-card color="mainColor">
                <v-card-title>
                    <h3>Step{{carousel + 1}} / 4</h3>
                </v-card-title>
                <v-card-text class="pb-0">
                    <v-carousel v-model="carousel" class="rounded-t-xl" width="600" height="400"
                        hide-delimiters :show-arrows="false"
                    >
                        <v-carousel-item
                            v-for="(pic, index) in guidePics" :key="index"
                        >
                            <img :src="pic.src" id="guide-pics"/>
                        </v-carousel-item>
                    </v-carousel>
                    <v-list class="rounded-b-xl">
                        <v-list-item>
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{guideText[carousel]}}
                                </v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                    </v-list>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <div class="mb-2">
                        <v-btn depressed rounded x-large color="white" class="black--text mx-2" 
                            @click="carousel -= 1" v-show="hasPrev"
                        >
                            BACK
                        </v-btn>
                        <v-btn depressed rounded x-large color="primary" class="black--text mx-2" 
                            @click="carousel += 1" v-show="hasNext"
                        >
                            NEXT
                        </v-btn>
                        <v-btn depressed rounded x-large color="primary" class="black--text mx-2" 
                            @click="dialogGuide = false" v-show="isLast"
                        >
                            OK!
                        </v-btn>
                    </div>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
    import {mapMutations} from 'vuex'
    import {hearts} from '../src/effects/hearts'
    import VSwatches from 'vue-swatches'
    import Pubsub from 'pubsub-js'

    export default {
        name: "LyricsFunctions",
        components: {
            VSwatches,
        },
        data() {
            return {
                isLiked: false,
                isSpeedDialActive: true,
                swatches:[
                    "#ff94ce", "#ff9eff", "#c1c1ff", "#99ffff", "#b2ffd8", "#d8ffb2", "#ffffb2", "#ffe0c1"
                ],
                darkColorList: {
                    "#ff94ce": "#d14f8d", 
                    "#ff9eff": "#c456d6", 
                    "#c1c1ff": "#786edc", 
                    "#99ffff": "#2e9bd1", 
                    "#b2ffd8": "#42d270", 
                    "#d8ffb2": "#97cc44", 
                    "#ffffb2": "#e4ca32", 
                    "#ffe0c1": "#e6934c"
                },
                callBackgroundColor: "#ff94ce",
                dialogGuide: false,
                carousel: 0,
                guidePics: [
                    {src: require('../images/step2.png')},
                    {src: require('../images/step3.png')},
                    {src: require('../images/step4.png')},
                    {src: require('../images/step5.png')}
                ],
                guideText: [
                    "①【色付き文字】→ 被せて歌う ②【背景色付き文字】→ 適切なタイミングで叫ぶ",
                    "覚えてきたら、字幕をオフにしてみよう",
                    "歌詞のタイミングが合わない時は調整できる",
                    "コールの色を好きな色に変えてみよう！"
                ],
                timeOffset: 0,
            }
        },
        computed: {
            likeButton(){
                return this.isLiked ? "heart" : "heart-outline";
            },
            optionButton(){
                return this.isSpeedDialActive ? "chevron-up" : "dots-vertical"
            },
            darkCallBackgroundColor(){
                return this.darkColorList[this.callBackgroundColor]
            },
            hasPrev(){
                return this.carousel === 0 ? false : true
            },
            hasNext(){
                return this.carousel === 3 ? false : true
            },
            isLast(){
                return this.carousel === 3 ? true : false
            },
        },
        methods: {
            ...mapMutations(["openSnackbar", "closeSnackbar"]),
            like(event){
                if (!this.isLiked) {
                    hearts(event.target);
                }
                this.isLiked = !this.isLiked;
            },
            rewind(){
                this.timeOffset -= 0.5
                Pubsub.publish("catchTimeOffset", this.timeOffset)
                this.closeSnackbar()
                this.$nextTick(() => {
                    this.openSnackbar({
                        text: "0.5秒遅らせた",
                        icon: "redo",
                        timeout: 1000,
                    })
                })
            },
            forward(){
                this.timeOffset += 0.5
                Pubsub.publish("catchTimeOffset", this.timeOffset)
                this.closeSnackbar()
                this.$nextTick(() => {
                    this.openSnackbar({
                        text: "0.5秒早めた",
                        icon: "undo",
                        timeout: 1000,
                    })
                })
            },
            sendColor(){
                Pubsub.publish("catchCallBackgroundColor", this.callBackgroundColor)
                Pubsub.publish("catchDarkCallBackgroundColor", this.darkCallBackgroundColor)
            }
        },
        mounted() {
            Pubsub.publish("catchCallBackgroundColor", this.callBackgroundColor)
            Pubsub.publish("catchDarkCallBackgroundColor", this.darkCallBackgroundColor)
        },
    }
</script>

<style scoped>
    #color-picker{
        left: -1.5px;
        top: 2px;
        background-color: transparent;
    }
    #guide-pics{
        width: 100%;
    }
</style>
