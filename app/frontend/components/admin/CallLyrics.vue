<template>
    <v-container id="call-lyrics-group">
        <AddButton
            :moduleName="moduleName"
            :apiPath="apiPath"
            @startAdding="getAddFormat"
            :addFormat="addFormat"
            @addItem="addToLyricsList"
        >
            <template v-if="addFormat" v-slot:formAddArea>
                <v-col cols="12">
                    <v-autocomplete label="バージョン" required color="maccha"
                        :items="lyricsVersionsList" item-text="title" item-value="id"
                        item-color="maccha" v-model="addFormat.lyrics_version.id"
                        :search-input.sync="keyword" :loading="searchLoading" 
                        no-data-text="歌詞未登録のバージョンがありません、先にバージョンを作成してください"
                    >
                        <template v-slot:item="data">
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{data.item.artist}} - {{data.item.title}}
                                </v-list-item-title>
                                <v-list-item-subtitle>{{data.item.language}}</v-list-item-subtitle>
                            </v-list-item-content>
                        </template>
                    </v-autocomplete>
                </v-col>
                <v-col cols="12">
                    <v-textarea label="歌詞" required color="maccha"
                        v-model="addFormat.lyric.body"
                    ></v-textarea>
                </v-col>
            </template>
        </AddButton>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'music-box'"
            :items="lyrics"

            @destroyItem="destroyFromLyricsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateLyricsList"
        >
            <template v-slot:contentArea="{item}">
                <v-progress-circular v-if="isLoading" indeterminate color="maccha"></v-progress-circular>
                <v-list-item-title class="black--text">{{item.lyrics_version.song.title}}</v-list-item-title>
                <v-list-item-subtitle>歌詞：{{item.lyric.body}}</v-list-item-subtitle>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        v-model="editFormat.song.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="ソース" required color="maccha"
                        v-model="editFormat.lyrics_version.source"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-select label="言語" required color="maccha" item-color="maccha"
                        :items="languages" item-text="text" item-value="value"
                        v-model="editFormat.language.name"
                    ></v-select>
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
        name: "CallLyrics",
        data() {
            return {
                apiPath: "/api/admin/lyrics",
                addFormat: null,
                editFormat: null,
                lyrics: [],
                keyword: "",
                searchLoading: false,
                lyricsVersionsList: [],
                moduleName: "歌詞",
                isLoading: false,
            }
        },
        components: {
            AddButton,
            List,
            },
        watch: {
            keyword(value){
                if (value && value.trim()) {
                    this.searchLoading = true;
                    axios.get(`${this.apiPath}/search_versions`, {params: {keyword: value}})
                    .then(res => {
                        this.lyricsVersionsList = res.data;
                        this.searchLoading = false;
                    })
                } else {
                    this.lyricsVersionsList = [];
                }
            },
        },
        methods: {
            getAddFormat(){
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToLyricsList(){},
            destroyFromLyricsList(){},
            getEditFormat(){},
            updateLyricsList(){},
        },
        mounted() {
            this.isLoading = true
            axios.get(this.apiPath)
            .then(res => {
                this.lyrics = res.data
                this.isLoading = false
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
