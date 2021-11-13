<template>
    <div id="lyrics-area">
        <h2 class="text-center black--text" 
            v-for="line in lyricsLines" :key="line.time" v-show="showLyric(line)"
        >
            <!-- v-forで回ってきた1行の歌詞を、どのようなHTMLタグで作成するか条件分岐する -->
            <!-- しかしその前に、この1行の歌詞はそもままでは条件分岐できない（どの言葉がコールの部分か区別がないため） -->
            <!-- ゆえに一回splitedLyricメソッドで加工し、返ってきたもので条件分岐する -->
            <span v-for="(word, index) in splitedLyric(line.lyric)" :key="index">
                <!-- 歌詞がコール歌詞だと検出したら、特殊なクラスを付与する -->
                <span v-if="matchCallLyrics(word)"
                    :style="{backgroundColor:callBgc}"
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
    import Pubsub from 'pubsub-js'
    export default {
        name: "Lyrics",
        data() {
            return {
                currentTime: 0,
                timeOffset: 0,
            }
        },
        props: {
            lyricsLines: {
                type: Array,
                required: true,
            },
            callBgc: {
                type: String,
                required: true,
            }
        },
        methods: {
            showLyric(line){
                const nextLineIndex = this.lyricsLines.indexOf(line) + 1
                // もし次のライン（歌詞）がない場合（つまりnextLineIndexと配列の要素数と同じ）：
                if (nextLineIndex === this.lyricsLines.length &&
                    this.currentTime + this.timeOffset >= line.time) {
                    return true
                }
                const nextLine = this.lyricsLines[nextLineIndex]
                if (this.currentTime + this.timeOffset >= line.time && 
                    this.currentTime + this.timeOffset <= nextLine.time) {
                    return true
                }
            },
            splitedLyric(lyric){
                // コール箇所（中括弧）にマッチする
                const callReg = /【.*?】/g;
                // コール箇所があれば歌詞の分断処理に入る、そうでなければそのまま配列に入れてreturn
                if (callReg.test(lyric)) {
                    // コール箇所以外にマッチする
                    const notCallReg = /[^【】]+(?=【[^【】]+】)|[^【】]+$/g
                    
                    // コール箇所の歌詞だけが入っている配列、
                    const callLyrics = lyric.match(callReg)
                    // そうでない歌詞だけが入っている配列
                    const notCallLyrics = lyric.match(notCallReg)

                    // 上記両方を入れる容器を用意する
                    const indexLyrics = {}
    
                    // まずはコール歌詞を入れていく、キー名はコール歌詞が元の歌詞で初めて現れたインデックス
                    for(let i=0;i<callLyrics.length;i++){
                        const index = lyric.indexOf(callLyrics[i])
                        indexLyrics[index] = callLyrics[i]
                    }
                    for(let b=0;b<notCallLyrics.length;b++){
                        const index = lyric.indexOf(notCallLyrics[b])
                        indexLyrics[index] = notCallLyrics[b]
                    }
    
                    // 上記の処理で全ての歌詞を「コールの歌詞」「そうでない歌詞」に分割できた
                    // しかしindexLyricsはオブジェクトで、次のステップでは配列が望ましいので、下記にように変換する
                    const resultArray = Object.keys(indexLyrics).map(function(key){
                        return indexLyrics[key]
                    })
    
                    // 結果をreturnする
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
            Pubsub.subscribe("catchVideoCurrentTime", (_, time)=>{
                this.currentTime = time;
            })
        },
        beforeDestroy() {
            PubSub.clearAllSubscriptions();
        },
    }
</script>
