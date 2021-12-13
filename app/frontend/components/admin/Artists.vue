<template>
    <v-container id="artists-group">
        <v-row>
            <v-col cols="auto" align-self="center">
                <AddButton
                    :moduleName="moduleName"
                    :apiPath="apiPath"
                    @startAdding="getAddFormat"
                    :addFormat="addFormat"
                    @addItem="addToArtistsList"
                >
                    <template v-if="addFormat" v-slot:formAddArea>
                        <v-col cols="12">
                            <v-text-field label="名前" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.name"
                            ></v-text-field>
                        </v-col>
                    </template>
                </AddButton>
            </v-col>
            <v-spacer/>
            <v-col cols="auto">
                <v-text-field outlined class="rounded-xl" hide-details dense clearable
                    append-icon="mdi-magnify" color="maccha" v-model="indexKeyword"
                    @keydown.enter="getArtists(1); pageNum = 1"
                ></v-text-field>
            </v-col>
        </v-row>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'account-music'"
            :items="artists"

            @destroyItem="destroyFromArtistsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateArtistsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.name}}</v-list-item-title>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-text-field label="名前" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.name"
                    ></v-text-field>
                </v-col>
            </template>
        </List>
        <v-pagination
            circle color="maccha" :length="pageLength" v-model="pageNum"
            @input="getArtists(pageNum)" @next="getArtists(pageNum)" @previous="getArtists(pageNum)"
        ></v-pagination>
    </v-container>
</template>

<script>
    import AddButton from './AddButton.vue'
    import List from './List.vue'
    import axios from 'axios'
    export default {
        name: "Artists",
        components: {
            AddButton,
            List,
        },
        data() {
            return {
                apiPath: "/api/admin/artists",
                addFormat: null,
                editFormat: null,
                artists: [],
                pageLength: null,
                pageNum: 1,
                moduleName: "アーティスト",
                indexKeyword: null,
            }
        },
        methods: {
            getArtists(pageNum){
                axios.get(this.apiPath, {params:{page_num: pageNum, keyword: this.indexKeyword}})
                .then(res => {
                    this.artists = res.data.artists
                    this.pageLength = res.data.pageLength
                })
            },
            getAddFormat(){
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToArtistsList(obj){
                const addObj = obj
                this.artists.unshift(addObj)
                this.addFormat = null;
            },
            destroyFromArtistsList(id){
                this.artists = this.artists.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                })
            },
            updateArtistsList(obj){
                Object.assign(this.artists.find((e) => e.id === obj.id), obj)
                this.editFormat = null;
            }
        },
        mounted() {
            this.getArtists({pageNum : 1})
        },
    }
</script>
