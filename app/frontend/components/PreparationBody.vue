<template>
    <v-container fluid id="preparation-body">
        <v-sheet class="mainColor rounded-xl mx-16">
            <v-container px-16 py-8>
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
                    <v-text-field placeholder="YouTube動画のリンクを貼り付ける" 
                        autofocus clearable clear-icon="mdi-close-circle"
                        background-color="white" color="maccha" rounded outlined
                        prepend-inner-icon="mdi-youtube" class="mt-2" v-model.trim="videoUrl"
                    ></v-text-field>
                </div>
                <div>
                    <h1 class="black--text">どのコールで練習しますか？</h1>
                    <v-alert v-show="showCallAlert" dense rounded color="primary" 
                        icon="mdi-information-outline" class="mb-2">
                        コールを選択してください
                    </v-alert>
                </div>
                <Search @checkCallError="setHasCallErrorFlag"></Search>
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
    import {hearts} from '../src/effects/hearts'
    import Search from './Search.vue'
    export default {
        name: "PreparationBody",
        data() {
            return {
                videoUrl: "",
                showNoUrlAlert: false,
                showUrlFormatAlert: false,
                hasCallError: false,
                showCallAlert: false,
            }
        },
        computed: {
            hasNoUrlError(){
                return this.videoUrl ? false : true
            },
            hasUrlFormatError(){
                const urlReg = /^(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}$/
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
            toPractice(event){
                hearts(event.target);
                // URL が入力されていないと、アラートを表示する
                this.showNoUrlAlert = this.hasNoUrlError ? true : false;
                // URL の形式が正しくないと、アラートを表示する
                this.showUrlFormatAlert = this.hasUrlFormatError ? true : false;
                // コールが選択されていないと、アラートを表示する
                this.showCallAlert = this.hasCallError ? true : false;
                // 次のページに遷移する（プログラム的vue-router）
                // TODO C バリデーションを満たす場合にのみ遷移できる条件分岐を書く
                setTimeout(() => {
                    this.$router.push({
                        path: "/practice",
                    })
                    
                }, 90);
            },
            setHasCallErrorFlag(hasSelected){
                this.hasCallError = hasSelected ? false : true;
            },
        },
    }
</script>

<style scoped>
</style>
