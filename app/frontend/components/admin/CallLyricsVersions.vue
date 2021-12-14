<template>
    <v-container id="call-versions-group">
        <v-row>
            <v-col cols="auto" align-self="center">
                <AddButton
                    :moduleName="moduleName"
                    :apiPath="apiPath"
                    @handleAddDialogBlur="isAdding = false"
                    @startAdding="getAddFormat"
                    :addFormat="addFormat"
                    @addItem="addToLyricsVersionsList"
                >
                    <template v-if="addFormat" v-slot:formAddArea>
                        <v-col cols="12">
                            <v-autocomplete v-if="isAdding" label="曲名" required color="maccha"
                                clearable rounded outlined
                                :items="songsList" item-text="title" item-value="id"
                                item-color="maccha" v-model="addFormat.song.id"
                                :search-input.sync="keyword" :loading="searchLoading" cache-items
                                no-data-text="曲名が見つかりません、先に作成してください"
                            >
                                <template v-slot:item="data">
                                    <v-list-item-content>
                                        <v-list-item-title>
                                            {{data.item.artist.name}} - {{data.item.title}}
                                        </v-list-item-title>
                                    </v-list-item-content>
                                </template>
                            </v-autocomplete>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field label="ソース（URL）" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.source"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-select label="言語" required color="maccha" item-color="maccha"
                                clearable rounded outlined
                                :items="languages" item-text="text" item-value="value"
                                v-model="addFormat.language.name"
                            ></v-select>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field label="おすすめMV（URL）" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.video.recommend.url"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field label="応援声付きガイド（URL）" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.video.guide.url"
                            ></v-text-field>
                        </v-col>
                    </template>
                </AddButton>
            </v-col>
            <v-spacer/>
            <v-col cols="auto">
                <v-text-field outlined class="rounded-xl" hide-details dense clearable
                    append-icon="mdi-magnify" color="maccha" v-model="indexKeyword"
                    @keydown.enter="getLyricsVersions(1); pageNum = 1"
                ></v-text-field>
            </v-col>
        </v-row>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'file-document'"
            :items="lyricsVersions"
            @handleEditDialogBlur="isEditing = false"
            @destroyItem="destroyFromLyricsVersionsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateLyricsVersionsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.song.title}}</v-list-item-title>
                <v-list-item-subtitle>ソース：{{item.source}}</v-list-item-subtitle>
                <v-list-item-subtitle>言語：{{item.language.name}}</v-list-item-subtitle>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-autocomplete v-if="isEditing" label="曲名" required color="maccha"
                        clearable rounded outlined
                        :items="songsList" item-text="title" item-value="id"
                        item-color="maccha" v-model="editFormat.song.id"
                        :search-input.sync="keyword" :loading="searchLoading" cache-items
                        no-data-text="曲名が見つかりません、先に作成してください"
                    >
                        <template v-slot:item="data">
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{data.item.artist.name}} - {{data.item.title}}
                                </v-list-item-title>
                            </v-list-item-content>
                        </template>
                    </v-autocomplete>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="ソース" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.source"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-select label="言語" required color="maccha" item-color="maccha"
                        clearable rounded outlined
                        :items="languages" item-text="text" item-value="value"
                        v-model="editFormat.language.name"
                    ></v-select>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="おすすめMV（URL）" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.video.recommend.url"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="応援声付きガイド（URL）" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.video.guide.url"
                    ></v-text-field>
                </v-col>
            </template>
        </List>
        <v-pagination
            circle color="maccha" :length="pageLength" v-model="pageNum"
            @input="getLyricsVersions(pageNum)" @next="getLyricsVersions(pageNum)" @previous="getLyricsVersions(pageNum)"
        ></v-pagination>
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
                pageLength: null,
                pageNum: 1,
                keyword: "",
                isAdding: false,
                isEditing: false,
                searchLoading: false,
                songsList: [],
                languages: [
                    {text: "Japanese", value: "japanese"},
                    {text: "Korean", value: "korean"},
                    {text: "Romanized", value: "romanized"},
                    {text: "English", value: "english"},
                ],
                moduleName: "バージョン",
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
                    axios.get("/api/admin/songs", {params: {keyword: value}})
                    .then(res => {
                        this.songsList = res.data.songs;
                        this.searchLoading = false;
                    })
                } else {
                    this.songsList = [];
                }
            },
        },
        methods: {
            getLyricsVersions(pageNum){
                axios.get(this.apiPath, {params:{page_num: pageNum, keyword: this.indexKeyword}})
                .then(res => {
                    this.lyricsVersions = res.data.lyrics_versions
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
            addToLyricsVersionsList(obj){
                const addObj = obj
                this.lyricsVersions.unshift(addObj)
                this.addFormat = null;
            },
            destroyFromLyricsVersionsList(id){
                this.lyricsVersions = this.lyricsVersions.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                this.isEditing = true
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                    this.keyword = this.editFormat.song.title
                })
            },
            updateLyricsVersionsList(obj){
                Object.assign(this.lyricsVersions.find((e) => e.id === obj.id), obj)
                this.keyword = "";
                this.editFormat = null;
            }
        },
        mounted() {
            this.getLyricsVersions(1)
        },
    }
</script>
