<template>
    <v-container fluid id="practice-body" px-16 py-0>
        <v-row justify="center" id="info" class="my-0">
            <v-icon left color="pink" id="music-circle-icon">mdi-music-circle</v-icon>
            <h4 class="pink--text text-center">練習中：{{artist}} - {{song}}</h4>
        </v-row>
        <v-row id="video" justify="center">
            <v-img src="https://dummyimage.com/1920x1080/323232/ff94ce" :aspect-ratio="16/9" max-width="820"></v-img>
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
                <v-sheet v-show="this.isVisible" color="white rounded-pill px-5 py-2">
                    <h2 class="text-center black--text">どんなのがいい？笑顔にしたいのに<span class="pink">（NiziU!）</span></h2>
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
