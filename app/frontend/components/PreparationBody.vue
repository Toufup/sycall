<template>
    <v-container fluid id="preparation-body">
        <v-sheet class="mainColor rounded-xl mx-16">
            <v-container px-16 py-8>
                <div class="mb-4">
                    <h1 class="black--text">どのコールを練習しますか？</h1>
                    <p class="gray--text mb-2" v-if="callLyricsCount">
                        追加済みのコール数：{{callLyricsCount}} 。随時更新中♪
                    </p>
                    <v-alert v-show="showCallAlert" dense rounded color="primary" 
                        icon="mdi-information-outline" class="mb-2">
                        コールを選択してください
                    </v-alert>
                </div>
                <Search @checkCallError="setHasCallErrorFlag"></Search>
                <div id="musicVideo">
                    <h1 class="black--text">どのミュージックビデオで練習しますか？</h1>
                    <v-alert v-if="showNoUrlAlert" dense rounded color="primary" 
                        icon="mdi-information-outline" class="mb-2">
                        URLを入力してください。
                    </v-alert>
                    <v-alert v-if="showUrlFormatAlert" dense rounded color="primary" 
                        icon="mdi-information-outline" class="mb-2">
                        URLの形式が正しくありません。YouTubeの動画リンクを正しく入力してください。
                    </v-alert>
                    <v-container v-if="selectedCallInfo">
                        <v-row>
                            <v-col cols="6" v-if="recommendUrl">
                                <v-sheet outlined class="rounded-xl pa-4" color="white">
                                    <div class="d-flex flex-nowrap flex-row align-center">
                                        <v-btn depressed fab color="pink" class="mr-2 circle-btn">
                                            <v-icon large color="black">mdi-thumb-up</v-icon>
                                        </v-btn>
                                        <p class="black--text mt-2 mb-0">
                                            {{selectedCallInfo.artist}} - {{selectedCallInfo.title}} のおすすめミュージックビデオ
                                        </p>
                                    </div>
                                    <v-chip class="mt-2 maccha--text" link outlined color="maccha"
                                        @click="videoUrl = recommendUrl"
                                    >
                                        {{recommendUrl}}
                                    </v-chip>
                                </v-sheet>
                            </v-col>
                            <v-col cols="6" v-if="guideUrl">
                                <v-sheet outlined class="rounded-xl pa-4" color="white">
                                    <div class="d-flex flex-nowrap flex-row align-center">
                                        <v-btn depressed fab color="primary" class="mr-2 circle-btn">
                                            <v-icon large color="black">mdi-check-decagram</v-icon>
                                        </v-btn>
                                        <p class="black--text mt-2 mb-0">
                                            初めての練習ですか？ {{selectedCallInfo.artist}} - {{selectedCallInfo.title}} の応援声付き動画でスタートしましょう
                                        </p>
                                    </div>
                                    <v-chip class="mt-2 maccha--text" link outlined color="maccha"
                                        @click="videoUrl = guideUrl"
                                    >
                                        {{guideUrl}}
                                    </v-chip>
                                </v-sheet>
                            </v-col>
                        </v-row>
                    </v-container>
                    <v-text-field placeholder="おすすめのYouTube動画リンクを使用するか、好きな動画のリンクを貼り付ける" 
                        clearable clear-icon="mdi-close-circle" hide-details
                        background-color="white" color="maccha" rounded outlined
                        prepend-inner-icon="mdi-youtube" class="my-2" v-model.trim="videoUrl"
                    ></v-text-field>
                </div>
                <v-row id="start-button" justify="center" align="center">
                    <v-btn color="primary" class="my-4 black--text"
                        depressed x-large rounded width="170px"
                        @click="toPractice($event)"
                    >START</v-btn>
                </v-row>
            </v-container>
        </v-sheet>
    </v-container>
</template>

<script>
    import axios from 'axios'
    import {mapGetters, mapActions} from 'vuex'
    import {hearts} from '../src/effects/hearts'
    import Search from './Search.vue'
    export default {
        name: "PreparationBody",
        data() {
            return {
                callLyricsCount: null,
                videoUrl: "",
                showNoUrlAlert: false,
                showUrlFormatAlert: false,
                hasCallError: false,
                showCallAlert: false,
            }
        },
        computed: {
            ...mapGetters(["videoId", "selectedCallInfo"]),
            recommendUrl(){
                return this.selectedCallInfo.recommend
            },
            guideUrl(){
                return this.selectedCallInfo.guide
            },
            hasNoUrlError(){
                return this.videoUrl ? false : true
            },
            hasUrlFormatError(){
                const urlReg = /^(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+([\S]{11})([\S]*$)/
                if (this.hasNoUrlError) {
                    return false
                } else {
                    return urlReg.test(this.videoUrl) ? false : true
                }
            },
        },
        components: {
            Search,
        },
        methods: {
            ...mapActions(["sendVideoUrl"]),
            toPractice(event){
                hearts(event.target);
                this.showNoUrlAlert = this.hasNoUrlError ? true : false;
                this.showUrlFormatAlert = this.hasUrlFormatError ? true : false;
                this.showCallAlert = this.hasCallError ? true : false;
                if (!this.hasNoUrlError && !this.hasUrlFormatError && !this.hasCallError) {
                    this.sendVideoUrl(this.videoUrl)
                    setTimeout(() => {
                        this.$router.push({
                            path: "/practice",
                        })
                    }, 90);
                }
            },
            setHasCallErrorFlag(hasSelected){
                this.hasCallError = hasSelected ? false : true;
            },
        },
        mounted() {
            document.title = "コール選択 | Sycall"
            axios.get("/calls/get_lyrics_count")
            .then(res => {
                this.callLyricsCount = res.data.lyrics.count
            })
        },
    }
</script>

<style scoped>
    .circle-btn{
        pointer-events: none;
    }
</style>
