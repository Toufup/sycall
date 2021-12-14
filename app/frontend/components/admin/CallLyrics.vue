<template>
    <v-container id="call-lyrics-group">
        <v-row>
            <v-col cols="auto" align-self="center">
                <AddButton
                    :moduleName="moduleName"
                    :apiPath="apiPath"
                    @handleAddDialogBlur="isAdding = false"
                    @startAdding="getAddFormat"
                    :addFormat="addFormat"
                    @addItem="addToLyricsList"
                >
                    <template v-if="addFormat" v-slot:formAddArea>
                        <v-col cols="12">
                            <v-autocomplete v-if="isAdding" label="バージョン" required color="maccha"
                                clearable rounded outlined
                                :items="lyricsVersionsList" item-text="song.title" item-value="id"
                                item-color="maccha" v-model="addFormat.lyrics_version.id"
                                :search-input.sync="keyword" :loading="searchLoading" cache-items
                                no-data-text="歌詞未登録のバージョンがありません、先にバージョンを作成してください"
                            >
                                <template v-slot:item="data">
                                    <v-list-item-content>
                                        <v-list-item-title>
                                            {{data.item.song.artist.name}} - {{data.item.song.title}}
                                        </v-list-item-title>
                                        <v-list-item-subtitle>{{data.item.language.name}}</v-list-item-subtitle>
                                    </v-list-item-content>
                                </template>
                            </v-autocomplete>
                        </v-col>
                        <v-col cols="12">
                            <v-textarea label="歌詞" required color="maccha"
                                rounded outlined
                                v-model="addFormat.body"
                            ></v-textarea>
                        </v-col>
                    </template>
                </AddButton>
            </v-col>
            <v-spacer/>
            <v-col cols="auto">
                <v-text-field outlined class="rounded-xl" hide-details dense clearable
                    append-icon="mdi-magnify" color="maccha" v-model="indexKeyword"
                    @keydown.enter="getLyrics(1, indexKeyword); pageNum = 1"
                ></v-text-field>
            </v-col>
        </v-row>
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
                <v-list-item-title class="black--text">{{item.lyrics_version.song.title}}</v-list-item-title>
                <v-list-item-subtitle>言語：{{item.lyrics_version.language.name}}</v-list-item-subtitle>
                <v-list-item-subtitle>歌詞：{{item.body}}</v-list-item-subtitle>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl">
                        <v-list-item>
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{editFormat.lyrics_version.song.artist.name}} - {{editFormat.lyrics_version.song.title}}
                                </v-list-item-title>
                                <v-list-item-subtitle>{{editFormat.lyrics_version.language.name}}</v-list-item-subtitle>
                            </v-list-item-content>
                        </v-list-item>
                    </v-card>
                </v-col>
                <v-col cols="12">
                    <v-textarea label="歌詞" required color="maccha"
                        rounded outlined
                        v-model="editFormat.body"
                    ></v-textarea>
                </v-col>
            </template>
        </List>
        <v-pagination
            circle color="maccha" :length="pageLength" v-model="pageNum"
            @input="getLyrics(pageNum)" @next="getLyrics(pageNum)" @previous="getLyrics(pageNum)"
        ></v-pagination>
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
                pageLength: null,
                pageNum: 1,
                keyword: "",
                isAdding: false,
                searchLoading: false,
                lyricsVersionsList: [],
                moduleName: "歌詞",
                indexKeyword: null,
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
                    axios.get("/api/admin/lyrics_versions", {params: {keyword: value}})
                    .then(res => {
                        this.lyricsVersionsList = res.data.lyrics_versions;
                        this.searchLoading = false;
                    })
                } else {
                    this.lyricsVersionsList = [];
                }
            },
        },
        methods: {
            getLyrics(pageNum, indexKeyword){
                axios.get(this.apiPath, {params:{page_num: pageNum, keyword: indexKeyword}})
                .then(res => {
                    this.lyrics = res.data.lyrics
                    this.pageLength = res.data.pageLength
                })
            },
            getAddFormat(){
                this.isAdding = true
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToLyricsList(obj){
                const addObj = obj
                addObj.body = addObj.body.slice(0, 50)
                this.lyrics.unshift(addObj)
                this.addFormat = null;
            },
            destroyFromLyricsList(id){
                this.lyrics = this.lyrics.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                })
            },
            updateLyricsList(obj){
                Object.assign(this.lyrics.find((e) => e.id === obj.id), obj)
                this.keyword = "";
                this.editFormat = null;
            }
        },
        mounted() {
            document.title = "歌詞管理 | Sycall"
            this.getLyrics(1)
        },
    }
</script>
