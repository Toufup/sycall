<template>
    <div id="subtitle-area">
        <v-row align="center" justify="center">
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
                    <Lyrics
                        :lyricsLines="lyricsLines"
                        :callBgc="callBgc"
                    ></Lyrics>
                </v-sheet>
            </v-col>
            <v-col cols="auto">
                <v-speed-dial direction="top" open-on-click transition="slide-y-reverse-transition" v-model="isSpeedDialActive">
                    <template v-slot:activator>
                        <v-btn depressed fab color="white">
                            <v-icon x-large color="black">mdi-{{optionButton}}</v-icon>
                        </v-btn>
                    </template>
                    <v-btn depressed fab color="white" @click.stop="rewind">
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-icon x-large color="maccha" v-on="on">mdi-redo</v-icon>
                            </template>
                            <span>字幕0.5秒遅らせる</span>
                        </v-tooltip>
                    </v-btn>
                    <v-btn depressed fab color="white" @click.stop="forward">
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-icon x-large color="maccha" v-on="on">mdi-undo</v-icon>
                            </template>
                            <span>字幕0.5秒早める</span>
                        </v-tooltip>
                    </v-btn>
                    <v-btn depressed fab color="white" @click.stop="like($event)">
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-icon x-large color="pink" v-on="on">mdi-{{likeButton}}</v-icon>
                            </template>
                            <span>お気に入り</span>
                        </v-tooltip>
                    </v-btn>
                    <v-btn depressed fab color="white" @click.stop>
                        <v-tooltip top>
                            <template v-slot:activator="{on}">
                                <v-sheet v-on="on" color="transparent">
                                    <v-swatches id="color-picker" 
                                        v-model="callBgc" :swatches="swatches"
                                        popover-x="left" close-on-select shapes="circles"
                                    ></v-swatches>
                                </v-sheet>
                            </template>
                            <span>コールの背景色</span>
                        </v-tooltip>
                    </v-btn>
                </v-speed-dial>
            </v-col>
        </v-row>
    </div>
</template>

<script>
    import {hearts} from '../src/effects/hearts'
    import VSwatches from 'vue-swatches'

    import Lyrics from './Lyrics.vue'

    export default {
        name: "Subtitle",
        components: {
            Lyrics,
            VSwatches,
        },
        data() {
            return {
                isVisible: true,
                isLiked: false,
                isSpeedDialActive: false,
                callBgc: "#ff94ce",
                swatches:[
                    "#ff94ce", "#ff9eff", "#c1c1ff", "#99ffff", "#b2ffd8", "#d8ffb2", "#ffffb2", "#ffe0c1"
                ],
            }
        },
        props: {
            lyricsLines: {
                type: Array,
                required: true,
            }
        },
        computed: {
            seeButton(){
                return this.isVisible ? "eye" : "eye-off";
            },
            likeButton(){
                return this.isLiked ? "heart" : "heart-outline";
            },
            optionButton(){
                return this.isSpeedDialActive ? "chevron-up" : "dots-vertical"
            },
        },
        methods: {
            see(){
                this.isVisible = !this.isVisible;
            },
            like(event){
                if (!this.isLiked) {
                    hearts(event.target);
                }
                this.isLiked = !this.isLiked;
            },
            rewind(){
                this.timeOffset -= 0.5
            },
            forward(){
                this.timeOffset += 0.5
            },
        },
    }
</script>

<style scoped>
    #color-picker{
        left: -1.5px;
        top: 2px;
        background-color: transparent;
    }
</style>
