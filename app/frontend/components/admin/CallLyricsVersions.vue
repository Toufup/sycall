<template>
    <v-container id="call-versions-group">
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
                <v-progress-circular v-if="isLoading" indeterminate color="maccha"></v-progress-circular>
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
            getEditFormat(id){
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                })
            },
            updateLyricsVersionsList(id, obj){
                Object.assign(this.lyricsVersions.find((e) => e.id === id), obj)
                this.editFormat = null;
            }
        },
        mounted() {
            this.isLoading = true
            axios.get(this.apiPath)
            .then(res => {
                this.lyricsVersions = res.data
                this.isLoading = false
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
