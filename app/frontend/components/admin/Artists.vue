<template>
    <v-container id="artists-group">
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
                        v-model="addFormat.artist.name"
                    ></v-text-field>
                </v-col>
            </template>
        </AddButton>
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
                <v-progress-circular v-if="isLoading" indeterminate color="maccha"></v-progress-circular>
                <v-list-item-title class="black--text">{{item.artist.name}}</v-list-item-title>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-text-field label="名前" required color="maccha"
                        v-model="editFormat.artist.name"
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
                moduleName: "アーティスト",
                isLoading: false,
            }
        },
        methods: {
            getAddFormat(){
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToArtistsList(obj){
                const addObj = obj
                addObj.id = this.artists.slice(-1)[0].id + 1
                this.artists.push(addObj)
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
            updateArtistsList(id, obj){
                Object.assign(this.artists.find((e) => e.id === id), obj)
                this.editFormat = null;
            }
        },
        mounted() {
            this.isLoading = true
            axios.get(this.apiPath)
            .then(res => {
                this.artists = res.data
                this.isLoading = false
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
