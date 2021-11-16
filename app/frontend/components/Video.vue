<template>
    <div id="video-area">
        <v-row justify="center" id="info" class="my-0">
            <v-icon left color="mainColor" id="music-circle-icon">mdi-music-circle</v-icon>
            <h4 class="white--text text-center">練習中：{{artist}} - {{song}}</h4>
        </v-row>
        <v-row id="video" justify="center">
            <v-sheet class="ma-0" id="video-player" width="820" color="transparent">
                <youtube fitParent ref="youtube" :video-id="videoId" @playing="playing" @paused="paused" @ended="ended"
                    :player-vars="playerVars"
                ></youtube>
            </v-sheet>
        </v-row>
    </div>
</template>

<script>
    import party from "party-js";
    import Pubsub from 'pubsub-js'
    import {mapActions, mapGetters} from 'vuex'
    export default {
        name: "Video",
        data() {
            return {
                playerVars: {
                    autoplay: 1,
                    // YouTube のロゴを表示させない
                    modestbranding: 1,
                },
                callBackgroundColor: null,
                openingAudio: new Audio(require('../audio/OP_5s.mp3')),
            }
        },
        props: {
            artist: {
                type: String,
                required: true,
            },
            song: {
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
        },
        methods: {
            ...mapActions(["getVideoCurrentTime"]),
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
                } else if (this.openingAudio.paused && this.openingAudio.ended) {
                    return
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
                clearInterval(this.partyLoopProcessId);
                const windowWidth = window.innerWidth;
                const windowHeight = window.innerHeight;
                for (let i = 0; i < 3; i++) {
                    party.confetti(this.createMouseEvent(windowWidth, windowHeight))
                }
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
