<template>
    <v-container fluid id="practice-body" px-16 py-0>
        <v-row justify="center" id="info" class="my-0">
            <v-icon left color="pink" id="music-circle-icon">mdi-music-circle</v-icon>
            <h4 class="pink--text text-center">練習中：{{artist}} - {{song}}</h4>
        </v-row>
        <v-row id="video" justify="center">
            <v-sheet class="ma-0" id="video-player" width="820" color="transparent">
                <youtube fitParent ref="youtube" :video-id="videoId" @playing="playing" @paused="paused"
                    :player-vars="playerVars"
                ></youtube>
            </v-sheet>
        </v-row>
        <v-row align="center" id="subtitle" justify="center">
            <v-col cols="auto">
                <v-tooltip top>
                    <template v-slot:activator="{on}">
                        <v-btn depressed fab color="white" @click="see" v-on="on">
                            <v-icon x-large color="maccha">mdi-{{seeButton}}</v-icon>
                        </v-btn>
                    </template>
                    <span>字幕ON/OFF</span>
                </v-tooltip>
            </v-col>
            <v-col cols="9" class="px-0">
                <v-sheet v-show="this.isVisible" color="white rounded-pill px-5 py-2" min-height="56px" id="lyrics-wrapper">
                    <h2 class="text-center black--text">{{currentLyric}}</h2>
                </v-sheet>
            </v-col>
            <v-col cols="auto">
                <v-speed-dial direction="top" open-on-hover transition="slide-y-reverse-transition" v-model="isSpeedDialActive">
                    <template v-slot:activator>
                        <v-btn depressed fab color="white">
                            <v-icon x-large color="black">mdi-{{optionButton}}</v-icon>
                        </v-btn>
                    </template>
                    <v-btn depressed fab color="white" class="demoBtn">
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-icon x-large color="maccha" v-on="on">icon-rewind-1</v-icon>
                            </template>
                            <span>字幕1秒巻き戻し</span>
                        </v-tooltip>
                    </v-btn>
                    <v-btn depressed fab color="white">
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-icon x-large color="maccha" v-on="on">icon-fast-forward-1</v-icon>
                            </template>
                            <span>字幕1秒早送り</span>
                        </v-tooltip>
                    </v-btn>
                    <v-btn depressed fab color="white" @click.stop="like($event)" >
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-icon x-large color="pink" v-on="on">mdi-{{likeButton}}</v-icon>
                            </template>
                            <span>お気に入り</span>
                        </v-tooltip>
                    </v-btn>
                </v-speed-dial>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import '../images/icomoon/style.css'
    import {hearts} from '../src/effects/hearts'
    export default {
        name: "PracticeBody",
        data() {
            return {
                song: "Make you happy",
                artist: "NiziU",
                isLiked: false,
                isVisible: true,
                isSpeedDialActive: false,
                videoId: "CN11U5t83Ro",
                lyricsLines: [
                    {
                        "time": 1.694,
                        "lyric": " 【マコ・リオ・マヤ・リク・アヤカ・マユカ】"
                    },
                    {
                        "time": 4.725,
                        "lyric": " 【リマ・ミイヒ・ニナ・We NiziU】"
                    },
                    {
                        "time": 7.848,
                        "lyric": " Nothing ヒミツなら nothing"
                    },
                    {
                        "time": 13.763,
                        "lyric": " 【Something】 特別なモノあげるのに【全部！】"
                    },
                    {
                        "time": 19.753,
                        "lyric": " どんなのがいい? 笑顔にしたいのに【NiziU！】"
                    },
                    {
                        "time": 25.723,
                        "lyric": " That thing 探し出す キミのために【WithU！】"
                    },
                    {
                        "time": 31.773,
                        "lyric": " もう ねぇねぇ 何見て"
                    },
                    {
                        "time": 33.976,
                        "lyric": " 何聴いて 幸せ?"
                    },
                    {
                        "time": 36.971,
                        "lyric": " 話してみて すべてね【フ〜〜〜！！】"
                    },
                    {
                        "time": 42.324,
                        "lyric": " Ooh, I just wanna make you happy"
                    },
                    {
                        "time": 44.707,
                        "lyric": " あ〜もう! 笑ってほしい【ウ〜ハピハピ！】"
                    },
                    {
                        "time": 49.177,
                        "lyric": " 忘れちゃった笑顔も"
                    },
                    {
                        "time": 51.78,
                        "lyric": " 大丈夫 ちゃんと取り戻して【ウ〜ハピハピ！】"
                    },
                    {
                        "time": 55.326,
                        "lyric": " その笑顔見てるとき ほんと幸せ"
                    },
                    {
                        "time": 61.126,
                        "lyric": " What do you want? 【want！】"
                    },
                    {
                        "time": 62.604,
                        "lyric": " What do you need? 【need！】"
                    },
                    {
                        "time": 64.19,
                        "lyric": " Anything, everything"
                    },
                    {
                        "time": 67.043,
                        "lyric": " You tell me"
                    },
                    {
                        "time": 69.259,
                        "lyric": " Gave me きれいな恋 gave me"
                    },
                    {
                        "time": 75.275,
                        "lyric": " 【Held me】 小さなこの手繋いで【NiziU！】"
                    },
                    {
                        "time": 81.245,
                        "lyric": " 大切よ ひとりきりにはさせないよ【WithU！】"
                    },
                    {
                        "time": 87.23,
                        "lyric": " Take me この私 全部あげたいの【全部！】"
                    },
                    {
                        "time": 93.092,
                        "lyric": " バレバレの【ハート】"
                    },
                    {
                        "time": 95.47399999999999,
                        "lyric": " 私だけの【カード】"
                    },
                    {
                        "time": 98.521,
                        "lyric": " 忘れずに そばに来て【フ〜〜〜！！】"
                    },
                    {
                        "time": 103.806,
                        "lyric": " Ooh, I just wanna make you happy"
                    },
                    {
                        "time": 106.327,
                        "lyric": " あ〜もう! 笑ってほしい【ウ〜ハピハピ！】"
                    },
                    {
                        "time": 110.689,
                        "lyric": " 忘れちゃった笑顔も"
                    },
                    {
                        "time": 113.27000000000001,
                        "lyric": " 大丈夫 ちゃんと取り戻して【ウ〜ハピハピ！】"
                    },
                    {
                        "time": 116.84100000000001,
                        "lyric": " その笑顔見てるとき ほんと幸せ"
                    },
                    {
                        "time": 122.626,
                        "lyric": " What do you want? 【want！】"
                    },
                    {
                        "time": 124.113,
                        "lyric": " What do you need? 【need！】"
                    },
                    {
                        "time": 125.621,
                        "lyric": " Anything, everything"
                    },
                    {
                        "time": 128.621,
                        "lyric": " You tell me"
                    },
                    {
                        "time": 129.343,
                        "lyric": " Tell me like 【OOH-AHH】"
                    },
                    {
                        "time": 130.87,
                        "lyric": " FANCY me 【do not】"
                    },
                    {
                        "time": 132.267,
                        "lyric": " Be ICY I'm 【so hot】"
                    },
                    {
                        "time": 133.69,
                        "lyric": " No good-bye, baby 【good-bye】"
                    },
                    {
                        "time": 135.408,
                        "lyric": " Tell me like 【OOH-AHH】"
                    },
                    {
                        "time": 136.805,
                        "lyric": " FANCY me 【do not】"
                    },
                    {
                        "time": 138.188,
                        "lyric": " Be ICY I'm 【so hot】"
                    },
                    {
                        "time": 139.689,
                        "lyric": " No good-bye, baby 【good-bye】"
                    },
                    {
                        "time": 141.188,
                        "lyric": " キミがくれる安心"
                    },
                    {
                        "time": 142.221,
                        "lyric": " 寄り添って 休めるための場所【Hey！】"
                    },
                    {
                        "time": 144.221,
                        "lyric": " 光が満ちて Feel いつだって"
                    },
                    {
                        "time": 145.699,
                        "lyric": " 夢見てるの一緒【Hey！】"
                    },
                    {
                        "time": 147.202,
                        "lyric": " 完全 Sweet なメロディー"
                    },
                    {
                        "time": 148.339,
                        "lyric": " 本当に癒してくるセオリー"
                    },
                    {
                        "time": 149.789,
                        "lyric": " Put it on repeat 聴いて 【ずっと ずっと】"
                    },
                    {
                        "time": 151.689,
                        "lyric": " You're my 【favorite song】"
                    },
                    {
                        "time": 153.223,
                        "lyric": " Ooh, I just wanna make you happy"
                    },
                    {
                        "time": 155.855,
                        "lyric": " あ〜もう! 笑ってほしい【ウ〜ハピハピ！】"
                    },
                    {
                        "time": 160.175,
                        "lyric": " 忘れちゃった笑顔も"
                    },
                    {
                        "time": 162.721,
                        "lyric": " 大丈夫 ちゃんと取り戻して【ウ〜ハピハピ！】"
                    },
                    {
                        "time": 166.324,
                        "lyric": " その笑顔見てるとき ほんと幸せ"
                    },
                    {
                        "time": 172.103,
                        "lyric": " What do you want? 【want！】"
                    },
                    {
                        "time": 173.617,
                        "lyric": " What do you need? 【need！】"
                    },
                    {
                        "time": 175.129,
                        "lyric": " Anything, everything"
                    },
                    {
                        "time": 178.117,
                        "lyric": " You tell me"
                    }
                ],
                currentLyric: "",
                playerVars: {
                    autoplay: 1,
                    // YouTube のロゴを表示させない
                    modestbranding: 1,
                },
                currentTime: 0,
            }
        },
        computed: {
            likeButton(){
                return this.isLiked ? "heart" : "heart-outline";
            },
            seeButton(){
                return this.isVisible ? "eye" : "eye-off";
            },
            optionButton(){
                return this.isSpeedDialActive ? "chevron-up" : "dots-vertical"
            },
            player(){
                return this.$refs.youtube.player
            },
        },
        watch: {
            currentTime(nowValue){
                for (let i = 0; i < this.lyricsLines.length; i++) {
                    const line = this.lyricsLines[i];
                    // TODO 「-1」はオフセット値、字幕の再生位置を調整するためのもの。次のブランチでボタンに紐付ける予定。
                    if (nowValue - 1 >= line.time) {
                        this.currentLyric = line.lyric
                    }
                }
            }
        },
        methods: {
            like(event){
                if (!this.isLiked) {
                    hearts(event.target);
                }
                this.isLiked = !this.isLiked;
            },
            see(){
                this.isVisible = !this.isVisible;
            },
            playing(){
                this.processId = setInterval(() => {
                    this.player.getCurrentTime().then((time)=>{
                        this.currentTime = time;
                    })
                }, 50);
            },
            paused(){
                clearInterval(this.processId)
            },
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
