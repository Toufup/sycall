<template>
    <v-container id="artists-group">
        <v-dialog max-width="600px" v-model="dialog" class="rounded-xl">
            <template v-slot:activator="{on}">
                <v-btn depressed rounded color="primary" class="black--text mx-2" v-on="on">
                    <v-icon left color="black">mdi-plus-circle</v-icon>追加
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <h3>アーティストを追加する</h3>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-text-field label="名前" required color="maccha"></v-text-field>
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
            <div id="artist" v-for="artist in artists" :key="artist.id">
                <v-list-item>
                    <v-list-item-icon>
                        <v-icon large color="maccha">mdi-account-music</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title class="black--text">{{artist.name}}</v-list-item-title>
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
        <!-- <v-pagination v-model="page" :length="5" circle color="maccha"></v-pagination> -->
    </v-container>
</template>

<script>
    export default {
        name: "Artists",
        data() {
            return {
                artists: [
                    {id: 1, name: "ITZY"},
                    {id: 2, name: "TWICE"},
                    {id: 3, name: "NiziU"},
                    {id: 4, name: "BLACKPINK"},
                    {id: 5, name: "EVERGLOW"},
                ],
                dialog: false,
                page: 1,
            }
        },
        methods: {
            addArtist(){

            }
        },
    }
</script>
