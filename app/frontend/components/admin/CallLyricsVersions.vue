<template>
    <v-container id="call-versions-group">
        <v-dialog max-width="600px" v-model="dialog" class="rounded-xl">
            <template v-slot:activator="{on}">
                <v-btn depressed rounded color="primary" class="black--text" v-on="on">
                    <v-icon left color="black">mdi-plus-circle</v-icon>追加
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <h3>バージョンを追加する</h3>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-autocomplete label="曲名" required color="maccha"
                                    item-color="maccha"
                                ></v-autocomplete>
                            </v-col>
                            <v-col cols="12">
                                <v-text-field label="ソース（URL）" required color="maccha"></v-text-field>
                            </v-col>
                            <v-col cols="12">
                                <v-select label="言語" required color="maccha" item-color="maccha"
                                    :items="languages" item-text="language" item-value="value"
                                ></v-select>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn depressed rounded color="black" class="white--text mx-2" @click="dialog = false">
                        キャンセル
                    </v-btn>
                    <v-btn depressed rounded color="primary" class="black--text mx-2" @click="dialog = false">
                        <v-icon left color="black">mdi-plus-circle</v-icon>追加
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
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
                ],
                languages: [
                    {language: "Japanese", value: "japanese"},
                    {language: "Korean", value: "korean"},
                    {language: "Romanized", value: "romanized"},
                    {language: "English", value: "english"},
                ],
                dialog: false,
            }
        },
    }
</script>
