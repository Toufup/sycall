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
                    ></Lyrics>
                </v-sheet>
            </v-col>
            <v-col cols="auto">
                <LyricsFunctions></LyricsFunctions>
            </v-col>
        </v-row>
    </div>
</template>

<script>
    import Lyrics from './Lyrics.vue'
    import LyricsFunctions from './LyricsFunctions.vue'

    export default {
        name: "Subtitle",
        components: {
            Lyrics,
            LyricsFunctions,
        },
        data() {
            return {
                isVisible: true,
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
        },
        methods: {
            see(){
                this.isVisible = !this.isVisible;
            },
        },
    }
</script>
