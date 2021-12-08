<template>
    <div id="lyrics-area">
        <h2 class="text-center black--text" 
            v-for="line in lyricsLines" :key="line.time" v-show="showLyric(line)"
        >
            <!-- v-forで回ってきた1行の歌詞を、どのようなHTMLタグで作成するか条件分岐する -->
            <span v-for="(word, index) in splitedLyric(line.lyric)" :key="index">
                <!-- 歌詞がコール歌詞だと検出したら、背景を着色する -->
                <span v-if="matchCallLyrics(word)"
                    :style="{backgroundColor:callBackgroundColor}"
                >
                    {{word}}
                </span>
                <!-- 歌詞が合唱コール歌詞だと検出したら、文字を着色する -->
                <span v-else-if="matchChorusCallLyrics(word)"
                    :style="{color:darkCallBackgroundColor}"
                >
                    {{ word.replace("{", "").replace("}", "") }}
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
                darkCallBackgroundColor: null,
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
                // コール箇所（三角括弧）にマッチする
                const callReg = /【.*?】/g;
                // 合唱コール箇所（波括弧）にマッチする
                const chorusReg = /{.*?}/g;
                // コール箇所があれば
                if (callReg.test(lyric) || chorusReg.test(lyric)) {
                    // コール箇所以外にマッチするもの
                    const notCallReg = /[^【】{}]+(?=[【{][^【】{}]+[】}])|[^【】{}]+$/g
                    
                    // コール箇所
                    const callLyrics = lyric.match(callReg)
                    // 合唱コール箇所
                    const chorusCallLyrics = lyric.match(chorusReg)
                    // コールではない箇所
                    const notCallLyrics = lyric.match(notCallReg)

                    // 上記3種類の歌詞を整理するための入れ物
                    const indexLyrics = {}

                    // indexはコール歌詞が元の歌詞において初めて現れたインデックス
                    if (callLyrics) {
                        for(let i=0;i<callLyrics.length;i++){
                            const index = lyric.indexOf(callLyrics[i])
                            indexLyrics[index] = callLyrics[i]
                        }
                    }
                    // indexは合唱コール歌詞が元の歌詞において初めて現れたインデックス
                    if (chorusCallLyrics) {
                        for(let i=0;i<chorusCallLyrics.length;i++){
                            const index = lyric.indexOf(chorusCallLyrics[i])
                            indexLyrics[index] = chorusCallLyrics[i]
                        }
                    }
                    // indexは通常の歌詞が元の歌詞において初めて現れたインデックス
                    if (notCallLyrics) {
                        for(let b=0;b<notCallLyrics.length;b++){
                            const index = lyric.indexOf(notCallLyrics[b])
                            indexLyrics[index] = notCallLyrics[b]
                        }
                    }
    
                    // 次の処理では配列が望ましいので、下記にように変換する
                    const resultArray = Object.keys(indexLyrics).map(function(key){
                        return indexLyrics[key]
                    })
    
                    return resultArray
                } else {
                    // コール箇所がなければそのまま出す
                    return [lyric]
                }
            },
            matchCallLyrics(word){
                const callReg = /【.*?】/g;
                return callReg.test(word)
            },
            matchChorusCallLyrics(word){
                const chorusReg = /{.*?}/g;
                return chorusReg.test(word)
            },
        },
        mounted() {
            // 第一引数はsubscribeの名前で、実際は使わないので「_」でポジションをとってくれている。
            Pubsub.subscribe("catchCallBackgroundColor", (_, color)=>{
                this.callBackgroundColor = color;
            })
            Pubsub.subscribe("catchDarkCallBackgroundColor", (_, color)=>{
                this.darkCallBackgroundColor = color;
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
