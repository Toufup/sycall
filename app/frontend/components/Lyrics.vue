<template>
    <div id="lyrics-area">
        <h2 class="text-center black--text" 
            v-for="line in lyricsLines" :key="line.time" v-show="showLyric(line)"
        >
            <!-- v-forで回ってきた1行の歌詞を、どのようなHTMLタグで作成するか条件分岐する -->
            <span v-for="(word, index) in splitedLyric(line.lyric)" :key="index">
                <!-- 歌詞がコール歌詞だと検出したら、特別なstyleとバインドする -->
                <span v-if="matchCallLyrics(word)"
                    :style="{backgroundColor:callBackgroundColor}"
                >
                    {{word}}
                </span>
                <!-- そうでない歌詞はそのまま展示する -->
                <span v-else>{{word}}</span>
            </span>
        </h2>
    </div>
</template>

<script>
    import {mapGetters} from 'vuex'
    import Pubsub from 'pubsub-js'
    export default {
        name: "Lyrics",
        data() {
            return {
                timeOffset: 0,
                callBackgroundColor: null,
            }
        },
        props: {
            lyricsLines: {
                type: Array,
                required: true,
            },
        },
        computed: {
            ...mapGetters(["videoCurrentTime"]),
        },
        methods: {
            showLyric(line){
                const nextLineIndex = this.lyricsLines.indexOf(line) + 1
                // 次のライン（歌詞）がない場合（つまりnextLineIndexと配列の要素数と同じ）：
                if (nextLineIndex === this.lyricsLines.length &&
                    this.videoCurrentTime + this.timeOffset >= line.time) {
                    return true
                }
                const nextLine = this.lyricsLines[nextLineIndex]
                if (this.videoCurrentTime + this.timeOffset >= line.time && 
                    this.videoCurrentTime + this.timeOffset <= nextLine.time) {
                    return true
                }
            },
            splitedLyric(lyric){
                // コール箇所（中括弧）にマッチする
                const callReg = /【.*?】/g;
                // コール箇所があれば
                if (callReg.test(lyric)) {
                    // コール箇所以外にマッチするもの
                    const notCallReg = /[^【】]+(?=【[^【】]+】)|[^【】]+$/g
                    
                    const callLyrics = lyric.match(callReg)
                    const notCallLyrics = lyric.match(notCallReg)

                    const indexLyrics = {}
    
                    // indexはコール歌詞が元の歌詞で初めて現れたインデックス
                    for(let i=0;i<callLyrics.length;i++){
                        const index = lyric.indexOf(callLyrics[i])
                        indexLyrics[index] = callLyrics[i]
                    }
                    for(let b=0;b<notCallLyrics.length;b++){
                        const index = lyric.indexOf(notCallLyrics[b])
                        indexLyrics[index] = notCallLyrics[b]
                    }
    
                    // 次の処理では配列が望ましいので、下記にように変換する
                    const resultArray = Object.keys(indexLyrics).map(function(key){
                        return indexLyrics[key]
                    })
    
                    return resultArray
                } else {
                    return [lyric]
                }
            },
            matchCallLyrics(word){
                const callReg = /【.*?】/g;
                return callReg.test(word)
            },
        },
        mounted() {
            // 第一引数はsubscribeの名前で、実際は使わないので「_」でポジションをとってくれている。
            Pubsub.subscribe("catchCallBackgroundColor", (_, color)=>{
                this.callBackgroundColor = color;
            })
        },
        beforeUpdate() {
            Pubsub.subscribe("catchTimeOffset", (_, offset)=>{
                this.timeOffset = offset;
            })
        },
        beforeDestroy() {
            PubSub.clearAllSubscriptions();
        },
    }
</script>
