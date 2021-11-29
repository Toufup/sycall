<template>
    <v-container id="songs-group">
        <AddButton
            :moduleName="moduleName"
            :inputValue="inputAddValue"
            @addItem="addToSongsList"
            :apiPath="'/api/admin/songs'"
            :paramsType="'song'"
        >
            <template v-slot:formAddArea>
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        v-model="inputAddValue.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="アーティスト" required color="maccha"
                        v-model="inputAddValue.artistName"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="BPM（任意）" color="maccha"
                        v-model="inputAddValue.bpm"
                    ></v-text-field>
                </v-col>
            </template>
        </AddButton>
        <List
            :moduleName="moduleName"
            :iconName="'account-music'"
            :items="songs"

            :apiPath="'/api/admin/songs'"
            @destroyItem="destroyFromSongsList"

            :paramsType="'song'"
            :inputValue="this.inputEditValue"
            @updateItem="updateSongsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.title}}</v-list-item-title>
                <v-list-item-subtitle>アーティスト：{{item.artistName}}</v-list-item-subtitle>
                <v-list-item-subtitle>BPM：{{item.bpm}}</v-list-item-subtitle>
            </template>
            <template v-slot:formEditArea="{itemToEdit}">
                <v-col cols="12">
                    <v-text-field label="曲名" required color="maccha"
                        v-model="itemToEdit.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="アーティスト" required color="maccha"
                        v-model="itemToEdit.artistName"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="BPM（任意）" color="maccha"
                        v-model="itemToEdit.name"
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
                inputAddValue: {
                    title: "",
                    artistName: "",
                    bpm: "",
                },
                inputEditValue: "",
                songs: [],
                moduleName: "曲",
            }
        },
        components: {
            AddButton,
            List,
        },
        methods: {
            addToSongsList(value){
                this.songs.push({
                    id: this.songs.slice(-1)[0].id + 1,
                    title: value.title,
                    artistName: value.artistName,
                    bpm: value.bpm,
                })
                this.inputAddValue = {
                    title: "",
                    artistName: "",
                    bpm: "",
                };
            },
            destroyFromSongsList(id){
                this.songs = this.songs.filter((e) => {
                    return e.id !== id;
                });
            },
            // updateSongsList(id, itemToEdit){
            //     this.songs.find((e) => e.id === id).name = itemToEdit.name;
            // }
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
