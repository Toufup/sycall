<template>
    <v-container fluid id="practice-body" px-16 py-0>
        <Video 
            :artist="artist"
            :song="song"
            :bpm="bpm"
            :videoId="videoId"
        ></Video>
        <Subtitle
            :lyricsLines="lyricsLines"
        ></Subtitle>
    </v-container>
</template>

<script>
    import axios from 'axios'
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
                bpm: 160,
                lyricsLines: [],
            }
        },
        props: {
            videoId: {
                type: String,
                required: true,
            },
            callId: {
                type: Number,
                required: true,
            }
        },
        created() {
            axios.get("/calls/get_lyrics",{params: {callId: this.callId}})
            .then(res => {
                this.lyricsLines = res.data
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
