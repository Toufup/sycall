<template>
    <v-container id="call-lyrics-group">
        <v-dialog max-width="600px" v-model="dialog" class="rounded-xl">
            <template v-slot:activator="{on}">
                <v-btn depressed rounded color="primary" class="black--text" v-on="on">
                    <v-icon left color="black">mdi-plus-circle</v-icon>追加
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <h3>歌詞を追加する</h3>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-autocomplete label="バージョン" required color="maccha"
                                    item-color="maccha"
                                ></v-autocomplete>
                            </v-col>
                            <v-col cols="12">
                                <v-textarea label="歌詞" required color="maccha"></v-textarea>
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
            <div id="song" v-for="lyric in callLyrics" :key="lyric.id">
                <v-list-item>
                    <v-list-item-icon>
                        <v-icon large color="maccha">mdi-music-box</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title class="black--text">{{lyric.song_title}}</v-list-item-title>
                        <v-list-item-subtitle>歌詞：{{lyric.body.slice(0,35)}}...</v-list-item-subtitle>
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
        name: "CallLyrics",
        data() {
            return {
                callLyrics: [
                    {id: 1, song_title: "Make you happy", body: 
                        "[00:01.694] 【マコ・リオ・マヤ・リク・アヤカ・マユカ】\n[00:04.725] 【リマ・ミイヒ・ニナ・We NiziU】\n[00:07.848] Nothing ヒミツなら nothing\n[00:13.763] 【Something】 特別なモノあげるのに【全部！】\n[00:19.753] どんなのがいい? 笑顔にしたいのに【NiziU！】\n[00:25.723] That thing 探し出す キミのために【WithU！】\n[00:31.773] もう ねぇねぇ 何見て\n"
                    },
                ],
                dialog: false,
            }
        },
    }
</script>
