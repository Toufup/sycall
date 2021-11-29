<template>
    <v-container id="artists-group">
        <AddButton
            :moduleName="moduleName"
            :inputValue="inputAddValue"
            @addItem="addToArtistsList"
            :apiPath="'/api/admin/artists'"
            :paramsType="'artist'"
        >
            <template v-slot:formAddArea>
                <v-col cols="12">
                    <v-text-field label="名前" required color="maccha"
                        v-model="inputAddValue"
                    ></v-text-field>
                </v-col>
            </template>
        </AddButton>
        <List
            :moduleName="moduleName"
            :iconName="'account-music'"
            :items="artists"

            :apiPath="'/api/admin/artists'"
            @destroyItem="destroyFromArtistsList"

            :paramsType="'artist'"
            :inputValue="this.inputEditValue"
            @updateItem="updateArtistsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.name}}</v-list-item-title>
            </template>
            <template v-slot:formEditArea="{itemToEdit}">
                <v-col cols="12">
                    <v-text-field label="名前" required color="maccha"
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
        name: "Artists",
        components: {
            AddButton,
            List,
        },
        data() {
            return {
                inputAddValue: "",
                inputEditValue: "",
                artists: [],
                moduleName: "アーティスト",
            }
        },
        methods: {
            addToArtistsList(value){
                this.artists.push({
                    id: this.artists.slice(-1)[0].id + 1,
                    name: value
                })
                this.inputAddValue = "";
            },
            destroyFromArtistsList(id){
                this.artists = this.artists.filter((e) => {
                    return e.id !== id;
                });
            },
            updateArtistsList(id, itemToEdit){
                this.artists.find((e) => e.id === id).name = itemToEdit.name;
            }
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
