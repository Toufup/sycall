<template>
    <div id="video-area">
        <v-row justify="center" id="info" class="my-0">
            <v-icon left color="mainColor" id="music-circle-icon">mdi-music-circle</v-icon>
            <h4 class="white--text text-center">練習中：{{artist}} - {{song}}</h4>
        </v-row>
        <v-row id="video" justify="center">
            <v-sheet class="ma-0" id="video-player" width="820" color="transparent">
                <youtube fitParent ref="youtube" :video-id="videoId" @playing="playing" @paused="paused"
                    :player-vars="playerVars"
                ></youtube>
            </v-sheet>
        </v-row>
    </div>
</template>

<script>
    import Pubsub from 'pubsub-js'
    export default {
        name: "Video",
        data() {
            return {
                playerVars: {
                    autoplay: 1,
                    // YouTube のロゴを表示させない
                    modestbranding: 1,
                },
                demo: "hello",
            }
        },
        props: {
            artist: {
                type: String,
                required: true,
            },
            song: {
                type: String,
                required: true,
            },
            videoId: {
                type: String,
                required: true,
            },
        },
        computed: {
            player(){
                return this.$refs.youtube.player
            },
        },
        methods: {
            playing(){
                this.processId = setInterval(() => {
                    this.player.getCurrentTime().then((time)=>{
                        Pubsub.publish("catchVideoCurrentTime", time)
                    })
                }, 250);
            },
            paused(){
                clearInterval(this.processId)
            },
        },
        beforeDestroy() {
            clearInterval(this.processId)
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
