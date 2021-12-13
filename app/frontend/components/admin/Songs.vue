<template>
    <v-container id="songs-group">
        <v-row>
            <v-col cols="auto" align-self="center">
                <AddButton
                    :moduleName="moduleName"
                    :apiPath="apiPath"
                    @handleAddDialogBlur="isAdding = false"
                    @startAdding="getAddFormat"
                    :addFormat="addFormat"
                    @addItem="addToSongsList"
                >
                    <template v-if="addFormat" v-slot:formAddArea>
                        <v-col cols="12">
                            <v-autocomplete v-if="isAdding" label="アーティスト" required color="maccha"
                                clearable rounded outlined
                                :items="artistsList" item-text="name" item-value="id"
                                item-color="maccha" v-model="addFormat.artist.id"
                                :search-input.sync="keyword" :loading="searchLoading" cache-items
                                no-data-text="アーティストが見つかりません、先に作成してください"
                            >
                            </v-autocomplete>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field label="曲名" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.title"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field label="BPM" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.bpm"
                            ></v-text-field>
                        </v-col>
                    </template>
                </AddButton>
            </v-col>
            <v-spacer/>
            <v-col cols="auto">
                <v-text-field outlined class="rounded-xl" hide-details dense clearable
                    append-icon="mdi-magnify" color="maccha" v-model="indexKeyword"
                    @keydown.enter="getSongs(1); pageNum = 1"
                ></v-text-field>
            </v-col>
        </v-row>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'account-music'"
            :items="songs"
            @handleEditDialogBlur="isEditing = false"
            @destroyItem="destroyFromSongsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateSongsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.title}}</v-list-item-title>
                <v-list-item-subtitle>アーティスト：{{item.artist.name}}</v-list-item-subtitle>
                <v-list-item-subtitle>BPM：{{item.bpm}}</v-list-item-subtitle>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-autocomplete v-if="isEditing" label="アーティスト" required color="maccha"
                        clearable rounded outlined
                        :items="artistsList" item-text="name" item-value="id"
                        item-color="maccha" v-model="editFormat.artist.id"
                        :search-input.sync="keyword" :loading="searchLoading" cache-items
                        no-data-text="アーティストが見つかりません、先に作成してください"
                    >
                    </v-autocomplete>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="BPM" color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.bpm"
                    ></v-text-field>
                </v-col>
            </template>
        </List>
        <v-pagination
            circle color="maccha" :length="pageLength" v-model="pageNum"
            @input="getSongs(pageNum)" @next="getSongs(pageNum)" @previous="getSongs(pageNum)"
        ></v-pagination>
    </v-container>
</template>

<script>
    import AddButton from './AddButton.vue'
    import List from './List.vue'
    import axios from 'axios'
    export default {
        name: "Songs",
        data() {
            return {
                apiPath: "/api/admin/songs",
                addFormat: null,
                editFormat: null,
                songs: [],
                pageLength: null,
                pageNum: 1,
                keyword: "",
                isAdding: false,
                isEditing: false,
                searchLoading: false,
                artistsList: [],
                moduleName: "曲",
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
                    axios.get("/api/admin/artists", {params: {keyword: value}})
                    .then(res => {
                        this.artistsList = res.data.artists;
                        this.searchLoading = false;
                    })
                } else {
                    this.artistsList = [];
                }
            },
        },
        methods: {
            getSongs(pageNum){
                axios.get(this.apiPath, {params:{page_num: pageNum, keyword: this.indexKeyword}})
                .then(res => {
                    this.songs = res.data.songs
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
            addToSongsList(obj){
                const addObj = obj
                this.songs.unshift(addObj)
                this.addFormat = null;
            },
            destroyFromSongsList(id){
                this.songs = this.songs.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                this.isEditing = true
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                    this.keyword = this.editFormat.artist.name
                })
            },
            updateSongsList(obj){
                Object.assign(this.songs.find((e) => e.id === obj.id), obj)
                this.keyword = "";
                this.editFormat = null;
            }
        },
        mounted() {
            this.getSongs({pageNum : 1})
        },
    }
</script>
