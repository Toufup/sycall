<template>
    <v-container px-16 id="top-page-body">
        <Banner></Banner>
        <v-row justify="center" class="mt-8">
            <h1 class="mainColor--text">最高なコールを！</h1>
        </v-row>
        <v-row justify="center">
            <h3 class="white--text">
                Sycall は K-POP のコール練習を楽しくする。「最高」な「コール」を決めて推しを応援しよう！
            </h3>
            <h3 class="white--text">
                ユーザ登録不要で 2 ステップでスタート。今すぐ始めよう！
            </h3>
        </v-row>
        <v-row justify="center">
            <v-btn depressed x-large rounded color="primary" class="mt-4 mx-2 black--text" 
                @click="toPreparation($event)"
            >
                Try Now!
            </v-btn>
            <v-dialog max-width="800" v-model="dialogGuide">
                <template v-slot:activator="{on}">
                    <v-btn depressed x-large rounded color="white" class="mt-4 mx-2 black--text" v-on="on"
                        @click="dialogGuide = true; carousel = 0;"
                    >
                        <h3>使い方</h3>
                    </v-btn>
                </template>
                <v-card color="mainColor">
                    <v-card-title>
                        <h3>Step{{carousel + 1}} / 5</h3>
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
        </v-row>
    </v-container>
</template>

<script>
    import Banner from './Banner.vue'
    import {hearts} from '../src/effects/hearts'
    export default {
        name: "TopPageBody",
        components: {
            Banner
        },
        data() {
            return {
                dialogGuide: false,
                carousel: 0,
                guidePics: [
                    {src: require('../images/step1.png')},
                    {src: require('../images/step2.png')},
                    {src: require('../images/step3.png')},
                    {src: require('../images/step4.png')},
                    {src: require('../images/step5.png')}
                ],
                guideText: [
                    "コール と お好きなミュージックビデオ を選んでスタートしよう",
                    "①【色付き文字】→ 被せて歌う ②【背景色付き文字】→ 適切なタイミングで叫ぶ",
                    "覚えてきたら、字幕をオフにしてみよう",
                    "歌詞のタイミングが合わない時は調整できる",
                    "コールの色を好きな色に変えてみよう！"
                ]
            }
        },
        computed: {
            hasPrev(){
                return this.carousel === 0 ? false : true
            },
            hasNext(){
                return this.carousel === 4 ? false : true
            },
            isLast(){
                return this.carousel === 4 ? true : false
            },
        },
        methods: {
            toPreparation(event){
                hearts(event.target);
                setTimeout(() => {
                    this.$router.push({
                        path: "/preparation",
                    })
                }, 90);
            },
        },
        mounted() {
            document.title = "K-POPコール練習アプリ | Sycall"
        },
    }
</script>

<style scoped>
    h1{
        font-size: 80px;
    }
    p{
        color: #f5f5f7;
    }
    #guide-pics{
        width: 100%;
    }
</style>
