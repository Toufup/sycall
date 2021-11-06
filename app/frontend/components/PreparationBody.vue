<template>
    <v-container fluid id="preparation-body">
        <v-sheet class="mainColor rounded-xl mx-16">
            <v-container px-16 py-8>
                <div id="musicVideo">
                    <h2 class="black--text">どのミュージックビデオで練習しますか？</h2>
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
                        background-color="white" color="primary" rounded outlined
                        prepend-inner-icon="mdi-youtube" class="mt-2" v-model.trim="videoUrl"
                    ></v-text-field>
                </div>
                <Search></Search>
                <v-row id="start-button" justify="center" align="center">
                    <v-btn color="primary" class="my-4 black--text"
                        depressed x-large rounded width="170px"
                        @click="start"
                    >START</v-btn>
                </v-row>
            </v-container>
        </v-sheet>
    </v-container>
</template>

<script>
    import Search from './Search.vue'
    export default {
        name: "PreparationBody",
        data() {
            return {
                videoUrl: "",
                showNoUrlAlert: false,
                showUrlFormatAlert: false,
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
            start(){
                // URL が入力されていないと、アラートを表示する
                this.showNoUrlAlert = this.hasNoUrlError ? true : false;
                // URL の形式が正しくないと、アラートを表示する
                this.showUrlFormatAlert = this.hasUrlFormatError ? true : false;
                // 次のページに遷移する（プログラム的vue-router）
            }
        },
    }
</script>

<style scoped>
</style>
