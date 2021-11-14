<template>
    <v-container fluid id="practice-body" px-16 py-0>
        <!-- TODO AA コンポーネント間のデータのやりとりが増え、Pubsubだと手続きは統一感がないため、Vuexを導入しよう！ -->
        <Video 
            :artist="artist"
            :song="song"
            :videoId="videoId"
        ></Video>
        <Subtitle
            :lyricsLines="lyricsLines"
        ></Subtitle>
    </v-container>
</template>

<script>
    import Video from './Video.vue'
    import Subtitle from './Subtitle.vue'

    export default {
        name: "PracticeBody",
        components: {
            Video,
            Subtitle,
        },
        data() {
            return {
                song: "Make you happy",
                artist: "NiziU",
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
            }
        },
    }
</script>
