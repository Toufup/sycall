<template>
    <v-container id="call-versions-group">
        <!-- <v-dialog max-width="600px" v-model="dialog" class="rounded-xl">
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
        </v-dialog> -->
        <AddButton
            :moduleName="moduleName"
            :apiPath="apiPath"
            @startAdding="getAddFormat"
            :addFormat="addFormat"
            @addItem="addToLyricsVersionsList"
        >
            <template v-if="addFormat" v-slot:formAddArea>
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        v-model="addFormat.song.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="ソース（URL）" required color="maccha"
                        v-model="addFormat.lyrics_version.source"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-select label="言語" required color="maccha" item-color="maccha"
                        :items="languages" item-text="text" item-value="value"
                        v-model="addFormat.language.name"
                    ></v-select>
                </v-col>
            </template>
        </AddButton>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'file-document'"
            :items="lyricsVersions"

            @destroyItem="destroyFromLyricsVersionsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateLyricsVersionsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.song.title}}</v-list-item-title>
                <v-list-item-subtitle>ソース：{{item.lyrics_version.source}}</v-list-item-subtitle>
                <v-list-item-subtitle>言語：{{item.language.name}}</v-list-item-subtitle>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        v-model="editFormat.song.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="アーティスト" required color="maccha"
                        v-model="editFormat.artist.name"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="BPM（任意）" color="maccha"
                        v-model="editFormat.song.bpm"
                    ></v-text-field>
                </v-col>
            </template>
        </List>
    </v-container>
</template>

<script>
    import AddButton from './AddButton.vue'
    import List from './List.vue'
    import axios from 'axios'
    export default {
        name: "CallLyricsVersions",
        data() {
            return {
                apiPath: "/api/admin/lyrics_versions",
                addFormat: null,
                editFormat: null,
                lyricsVersions: [],
                languages: [
                    {text: "Japanese", value: "japanese"},
                    {text: "Korean", value: "korean"},
                    {text: "Romanized", value: "romanized"},
                    {text: "English", value: "english"},
                ],
                moduleName: "バージョン",
            }
        },
        components: {
            AddButton,
            List,
        },
        methods: {
            getAddFormat(){
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToLyricsVersionsList(obj){
                const addObj = obj
                addObj.id = this.lyricsVersions.slice(-1)[0].id + 1
                this.lyricsVersions.push(addObj)
                this.addFormat = null;
            },
            destroyFromLyricsVersionsList(id){
                this.lyricsVersions = this.lyricsVersions.filter((e) => {
                    return e.id !== id;
                });
            },
        },
        mounted() {
            axios.get(this.apiPath)
            .then(res => {
                this.lyricsVersions = res.data
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
