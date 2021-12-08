<template>
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
                            v-model="callBackgroundColor" :swatches="swatches"
                            popover-x="left" close-on-select shapes="circles"
                            @input="sendColor"
                        ></v-swatches>
                    </v-sheet>
                </template>
                <span>コールの背景色</span>
            </v-tooltip>
        </v-btn>
    </v-speed-dial>
</template>

<script>
    import {hearts} from '../src/effects/hearts'
    import VSwatches from 'vue-swatches'
    import Pubsub from 'pubsub-js'

    export default {
        name: "LyricsFunctions",
        components: {
            VSwatches,
        },
        data() {
            return {
                isLiked: false,
                isSpeedDialActive: true,
                swatches:[
                    "#ff94ce", "#ff9eff", "#c1c1ff", "#99ffff", "#b2ffd8", "#d8ffb2", "#ffffb2", "#ffe0c1"
                ],
                darkColorList: {
                    "#ff94ce": "#d14f8d", 
                    "#ff9eff": "#c456d6", 
                    "#c1c1ff": "#786edc", 
                    "#99ffff": "#2e9bd1", 
                    "#b2ffd8": "#42d270", 
                    "#d8ffb2": "#97cc44", 
                    "#ffffb2": "#e4ca32", 
                    "#ffe0c1": "#e6934c"
                },
                callBackgroundColor: "#ff94ce",
                timeOffset: 0,
            }
        },
        computed: {
            likeButton(){
                return this.isLiked ? "heart" : "heart-outline";
            },
            optionButton(){
                return this.isSpeedDialActive ? "chevron-up" : "dots-vertical"
            },
            darkCallBackgroundColor(){
                return this.darkColorList[this.callBackgroundColor]
            }
        },
        methods: {
            like(event){
                if (!this.isLiked) {
                    hearts(event.target);
                }
                this.isLiked = !this.isLiked;
            },
            rewind(){
                this.timeOffset -= 0.5
                Pubsub.publish("catchTimeOffset", this.timeOffset)
            },
            forward(){
                this.timeOffset += 0.5
                Pubsub.publish("catchTimeOffset", this.timeOffset)
            },
            sendColor(){
                Pubsub.publish("catchCallBackgroundColor", this.callBackgroundColor)
                Pubsub.publish("catchDarkCallBackgroundColor", this.darkCallBackgroundColor)
            }
        },
        mounted() {
            Pubsub.publish("catchCallBackgroundColor", this.callBackgroundColor)
            Pubsub.publish("catchDarkCallBackgroundColor", this.darkCallBackgroundColor)
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
