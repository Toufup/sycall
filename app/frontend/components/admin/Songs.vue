<template>
    <v-container id="songs-group">
        <v-btn depressed rounded color="primary" class="black--text">
            <v-icon left color="black">mdi-plus-circle</v-icon>追加
        </v-btn>
        <v-list>
            <div id="song" v-for="song in songs" :key="song.id">
                <v-list-item>
                    <v-list-item-icon>
                        <v-icon large color="maccha">mdi-music-clef-treble</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title class="black--text">{{song.title}}</v-list-item-title>
                        <v-list-item-subtitle>アーティスト：{{song.artist}}</v-list-item-subtitle>
                        <v-list-item-subtitle>BPM：{{song.bpm}}</v-list-item-subtitle>
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
        name: "Songs",
        data() {
            return {
                songs: [
                    {id: 1, title: "DALLA DALLA", artist: "ITZY", bpm: 125},
                    {id: 2, title: "WANNABE", artist: "ITZY", bpm: 122},
                    {id: 3, title: "Feel Special", artist: "TWICE", bpm: 129},
                    {id: 4, title: "Make you happy", artist: "ITZY", bpm: 160},
                    {id: 5, title: "Chopstick", artist: "ITZY", bpm: 141},
                ]
            }
        },
    }
</script>
