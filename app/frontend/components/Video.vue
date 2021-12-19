<template>
    <div id="video-area" class="mx-16">
        <v-row justify="center" align="center" id="info" class="my-0">
            <v-col cols="auto" class="py-0">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-btn depressed fab color="white" v-on="on" @click="pageBack">
                            <v-icon x-large color="maccha">mdi-arrow-left</v-icon>
                        </v-btn>
                    </template>
                    <span>戻る</span>
                </v-tooltip>
            </v-col>
            <v-col cols="10">
                <h3 class="white--text text-center">
                    <v-icon left color="mainColor" id="music-circle-icon">mdi-music-circle</v-icon>
                    練習中：{{artist}} - {{title}}
                </h3>
            </v-col>
            <v-col cols="auto" class="py-0">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-btn depressed fab color="white" :href="shareTwitter" target="_blank" v-on="on">
                            <v-icon x-large color="#1DA1F2">mdi-twitter</v-icon>
                        </v-btn>
                    </template>
                    <span>Twitterにシェア</span>
                </v-tooltip>
            </v-col>
        </v-row>
        <v-row id="video" justify="center">
            <v-sheet class="ma-0" id="video-player" width="80%" color="transparent">
                <youtube fitParent ref="youtube" :video-id="videoId" @playing="playing" @paused="paused" @ended="ended"
                    :player-vars="playerVars"
                ></youtube>
            </v-sheet>
        </v-row>
        <v-dialog max-width="800" v-model="ratingDialog">
            <v-card color="mainColor">
                <Rating :shareTwitter="shareTwitter"></Rating>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
    import party from "party-js";
    import Pubsub from 'pubsub-js'
    import Rating from './Rating.vue'
    import {mapActions, mapMutations, mapGetters} from 'vuex'
    export default {
        name: "Video",
        components: {
            Rating
        },
        data() {
            return {
                playerVars: {
                    autoplay: 1,
                    // YouTube のロゴを表示させない
                    modestbranding: 1,
                },
                callBackgroundColor: null,
                openingAudio: new Audio(require('../audio/OP_5s.mp3')),
                twitter: {
                    formDialog: false,
                    tweet: "https://twitter.com/intent/tweet",
                    url: "https://sycall.app/",
                },
                ratingDialog: false,
            }
        },
        props: {
            artist: {
                type: String,
                required: true,
            },
            title: {
                type: String,
                required: true,
            },
            bpm: {
                type: Number,
                required: true,
            },
            videoId: {
                type: String,
                required: true,
            },
        },
        computed: {
            ...mapGetters(["videoCurrentTime"]),
            player(){
                return this.$refs.youtube.player
            },
            twitterText(){
                return ` Sycall で ${this.artist} のコールを練習しています🎉 `
            },
            twitterHashtags(){
                return `sycall,サイコール,${this.artist},${this.title.replace(/\s+/g, "").toLowerCase()}`
            },
            shareTwitter(){
                return this.twitter.tweet + 
                        "?text=" + this.twitterText + 
                        "&url=" + this.twitter.url + 
                        "&hashtags=" + this.twitterHashtags
            }
        },
        methods: {
            ...mapActions(["getVideoCurrentTime"]),
            ...mapMutations(["updateVideoCurrentTime"]),
            pageBack(){
                this.$router.back();
            },
            createMouseEvent(x, y){
                return new MouseEvent("partyEvent", {
                    // 画面の幅の10％〜90％の間にエフェクトが出現する
                    clientX: Math.random() * (x * 0.9 - x * 0.1) + (x * 0.1),
                    // 画面の高さの10％〜90％の間（headerとfooterの間）にエフェクトが出現する
                    clientY: Math.random() * (y * 0.9 - y * 0.1) + (y * 0.1)
                })
            },
            playing(){
                // YouTubeの現在再生時間を取得する
                this.videoTimeProcessId = setInterval(() => {
                    this.getVideoCurrentTime(this.player)
                }, 250);

                // ランダムな場所に星の爆けるエフェクト
                const windowWidth = window.innerWidth;
                const windowHeight = window.innerHeight;
                clearInterval(this.partyLoopProcessId);
                this.partyLoopProcessId = setInterval(() => {
                    party.sparkles(this.createMouseEvent(windowWidth, windowHeight),{
                        color: party.variation.gradientSample(
                            party.Gradient.simple(
                                party.Color.fromHex(this.callBackgroundColor),
                                party.Color.fromHex("#fffa6e")
                            )
                        )
                    })
                    // bpmをもとにループする間隔を計算。8拍子で1回。
                }, 60 / this.bpm * 1000 * 8);

                // 最初に叫ぶサウンドを再生
                if (this.videoCurrentTime === 0) {
                    this.openingAudio.currentTime = 0
                    this.openingAudio.play()
                } else if (this.videoCurrentTime >= this.openingAudio.duration) {
                    this.openingAudio.currentTime = 0
                    this.openingAudio.pause()
                } else if (this.openingAudio.paused) {
                    this.openingAudio.play()
                }
            },
            paused(){
                clearInterval(this.videoTimeProcessId);
                clearInterval(this.partyLoopProcessId);
                this.openingAudio.pause()
            },
            // 動画の最後に紙吹雪をランダムに出現させる
            ended(){
                clearInterval(this.videoTimeProcessId);
                clearInterval(this.partyLoopProcessId);
                const windowWidth = window.innerWidth;
                const windowHeight = window.innerHeight;
                for (let i = 0; i < 3; i++) {
                    party.confetti(this.createMouseEvent(windowWidth, windowHeight))
                }
                this.ratingDialog = true
            }
        },
        mounted() {
            Pubsub.subscribe("catchCallBackgroundColor", (_, color)=>{
                this.callBackgroundColor = color;
            })
        },
        beforeDestroy() {
            clearInterval(this.videoTimeProcessId)
            clearInterval(this.partyLoopProcessId)
            this.openingAudio.pause()
            this.openingAudio.currentTime = 0
            this.updateVideoCurrentTime(0)
        },
    }
</script>

<style scoped>
    #music-circle-icon{
        animation: rotate 2s linear infinite;
    }
    @keyframes rotate {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(360deg);
        }
    }
</style>
