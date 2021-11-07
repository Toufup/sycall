<template>
    <v-container fluid id="practice-body" px-16 py-0>
        <v-row justify="center" id="info" class="my-0">
            <v-icon left color="pink">mdi-music-circle</v-icon>
            <h4 class="pink--text text-center">練習中：{{artist}} - {{song}}</h4>
        </v-row>
        <v-row id="video" justify="center">
            <v-img src="https://dummyimage.com/1920x1080/323232/ff94ce" :aspect-ratio="16/9" max-width="820"></v-img>
        </v-row>
        <v-row align="center" id="subtitle" justify="center">
            <v-col cols="auto">
                <v-tooltip top>
                    <template v-slot:activator="{ on, attrs }">
                        <v-btn fab color="white" @click="see" v-bind="attrs" v-on="on">
                            <v-icon x-large color="maccha">mdi-{{seeButton}}</v-icon>
                        </v-btn>
                    </template>
                    <span>字幕ON/OFF</span>
                </v-tooltip>
            </v-col>
            <v-col cols="9" class="px-0">
                <v-sheet v-show="this.isVisible" color="white rounded-pill px-5 py-2">
                    <h2 class="text-center">どんなのがいい？笑顔にしたいのに<span class="pink">（NiziU!）</span></h2>
                </v-sheet>
            </v-col>
            <v-col cols="auto">
                <v-speed-dial open-on-hover transition="slide-y-reverse-transition"
                    direction="top">
                    <template v-slot:activator>
                        <v-btn fab color="white">
                            <v-icon x-large >mdi-chevron-up</v-icon>
                        </v-btn>
                    </template>
                    <v-btn fab color="white">
                        <v-icon x-large color="maccha">mdi-rewind</v-icon>
                    </v-btn>
                    <v-btn fab color="white">
                        <v-icon x-large color="maccha">mdi-fast-forward</v-icon>
                    </v-btn>
                    <v-btn fab color="white" @click="like">
                        <v-icon x-large color="pink">mdi-{{likeButton}}</v-icon>
                    </v-btn>
                </v-speed-dial>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import {hearts} from '../src/effects/hearts'
    export default {
        name: "PracticeBody",
        data() {
            return {
                song: "Make you happy",
                artist: "NiziU",
                isLiked: false,
                isVisible: true,
            }
        },
        computed: {
            likeButton(){
                return this.isLiked ? "heart" : "heart-outline";
            },
            seeButton(){
                return this.isVisible ? "eye" : "eye-off";
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

</style>
