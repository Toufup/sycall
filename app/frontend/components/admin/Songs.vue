<template>
    <v-container id="songs-group">
        <AddButton
            :moduleName="moduleName"
            :apiPath="apiPath"
            @startAdding="getAddFormat"
            :addFormat="addFormat"
            @addItem="addToSongsList"
        >
            <template v-if="addFormat" v-slot:formAddArea>
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        v-model="addFormat.song.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="アーティスト" required color="maccha"
                        v-model="addFormat.artist.name"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="BPM" required color="maccha"
                        v-model="addFormat.song.bpm"
                    ></v-text-field>
                </v-col>
            </template>
        </AddButton>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'account-music'"
            :items="songs"

            @destroyItem="destroyFromSongsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateSongsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.song.title}}</v-list-item-title>
                <v-list-item-subtitle>アーティスト：{{item.artist.name}}</v-list-item-subtitle>
                <v-list-item-subtitle>BPM：{{item.song.bpm}}</v-list-item-subtitle>
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
        name: "Songs",
        data() {
            return {
                apiPath: "/api/admin/songs",
                addFormat: null,
                editFormat: null,
                songs: [],
                moduleName: "曲",
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
            addToSongsList(obj){
                const addObj = obj
                addObj.id = this.songs.slice(-1)[0].id + 1
                this.songs.push(addObj)
                this.addFormat = null;
            },
            destroyFromSongsList(id){
                this.songs = this.songs.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                })
            },
            updateSongsList(id, obj){
                Object.assign(this.songs.find((e) => e.id === id), obj)
                this.editFormat = null;
            }
        },
        mounted() {
            axios.get("/api/admin/songs")
            .then(res => {
                this.songs = res.data
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
