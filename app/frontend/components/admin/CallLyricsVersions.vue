<template>
    <v-container id="call-versions-group">
        <v-btn depressed rounded color="primary" class="black--text">
            <v-icon left color="black">mdi-plus-circle</v-icon>追加
        </v-btn>
        <v-list>
            <div id="song" v-for="ver in lyricsVersions" :key="ver.id">
                <v-list-item>
                    <v-list-item-icon>
                        <v-icon large color="maccha">mdi-file-document</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title class="black--text">{{ver.song_title}}</v-list-item-title>
                        <v-list-item-subtitle>ソース：{{ver.source}}</v-list-item-subtitle>
                        <v-list-item-subtitle>言語：{{ver.language}}</v-list-item-subtitle>
                    </v-list-item-content>
                    <v-btn depressed rounded color="mainColor" class="black--text mx-2">
                        <v-icon left color="black">mdi-pencil</v-icon>編集
                    </v-btn>
                    <v-btn depressed rounded color="pink" class="black--text mx-2">
                        <v-icon left color="black">mdi-delete</v-icon>削除
                    </v-btn>
                </v-list-item>
                <v-divider></v-divider>
            </div>
        </v-list>
    </v-container>
</template>

<script>
    export default {
        name: "CallLyricsVersions",
        data() {
            return {
                lyricsVersions: [
                    {id: 1, song_title: "DALLA DALLA", source: "https://genius.com/Genius-romanizations-itzy-dalla-dalla-romanized-lyrics", language: "Romanized"},
                    {id: 2, song_title: "Make you happy", source: "https://genius.com/Niziu-make-you-happy-lyrics", language: "Japanese"},
                    {id: 3, song_title: "ICY", source: "https://genius.com/Genius-romanizations-itzy-icy-romanized-lyrics", language: "Romanized"},
                ]
            }
        },
    }
</script>
