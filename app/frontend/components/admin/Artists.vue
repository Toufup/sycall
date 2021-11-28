<template>
    <v-container id="artists-group">
        <AddButton
            :moduleName="'アーティスト'"
            :inputValue="inputValue"
            :emitEventName="'sendToArtistList'"
            @sendToArtistList="renderToArtistList"
            @resetInput="resetInput"
            :apiPath="'/api/admin/artists'"
            :paramsType="'artist'"
        >
            <template v-slot:formArea>
                <v-col cols="12">
                    <v-text-field label="名前" required color="maccha"
                        v-model="inputValue"
                    ></v-text-field>
                </v-col>
            </template>
        </AddButton>
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
                    <v-dialog max-width="600px" :value="dialogDeleteId === artist.id" class="rounded-xl">
                        <template v-slot:activator="{on}">
                            <v-btn depressed rounded color="pink" class="black--text mx-2" 
                            v-on="on" @click="confirm(artist.id)"
                            >
                                <v-icon left color="black">mdi-delete</v-icon>削除
                            </v-btn>
                        </template>
                        <v-card>
                            <v-card-title>
                                <h3>本当に削除しますか？</h3>
                            </v-card-title>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn depressed rounded color="black" class="white--text mx-2" @click="dialogDeleteId = false">
                                    キャンセル
                                </v-btn>
                                <v-btn depressed rounded color="pink" class="black--text mx-2" @click="destroyArtist(artist.id)">
                                    <v-icon left color="black">mdi-delete</v-icon>削除
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                </v-list-item>
                <v-divider></v-divider>
            </div>
        </v-list>
        <!-- <v-pagination v-model="page" :length="5" circle color="maccha"></v-pagination> -->
    </v-container>
</template>

<script>
    import AddButton from './AddButton.vue'
    import axios from 'axios'
    export default {
        name: "Artists",
        components: {
            AddButton,
        },
        data() {
            return {
                inputValue: "",
                artists: [],
                dialogDeleteId: false,
                page: 1,
            }
        },
        methods: {
            renderToArtistList(value){
                this.artists.push({
                    id: this.artists.slice(-1)[0].id + 1,
                    name: value
                })
            },
            resetInput(){
                this.inputValue = "";
            },
            // TODO AA CRUD の関数は抽出して共通化した方がいいです
            
            confirm(id){
                this.dialogDeleteId = id
            },
            destroyArtist(id){
                this.dialogDeleteId = false
                axios.delete(`/api/admin/artists/${id}`)
                .then(() => {
                    this.artists = this.artists.filter((e) => {
                        return e.id !== id;
                    });
                })
                .catch(err => {
                    console.error(err); 
                })
            },
        },
        mounted() {
            axios.get("/api/admin/artists")
            .then(res => {
                this.artists = res.data
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
