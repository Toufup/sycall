<template>
    <v-container fluid id="practice-body" px-16 py-0>
        <Video 
            :artist="selectedCallInfo.artist"
            :title="selectedCallInfo.title"
            :bpm="selectedCallInfo.bpm"
            :videoId="videoId"
        ></Video>
        <Subtitle
            :lyricsLines="lyricsLines"
        ></Subtitle>
    </v-container>
</template>

<script>
    import axios from 'axios'
    import {mapGetters} from 'vuex'
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
                lyricsLines: [],
            }
        },
        computed: {
            ...mapGetters(["selectedCallInfo", "videoId"]),
        },
        created() {
            axios.get("/calls/get_lyrics",{params: {callId: this.selectedCallInfo.id}})
            .then(res => {
                this.lyricsLines = res.data
            })
        },
        mounted() {
            document.title = `練習中: ${this.selectedCallInfo.artist} - ${this.selectedCallInfo.title} | Sycall`
        },
    }
</script>
