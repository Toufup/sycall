<template>
    <v-container id="populars-group">
        <AddButton
            :moduleName="moduleName"
            :apiPath="apiPath"
            @startAdding="getAddFormat"
            :addFormat="addFormat"
            @addItem="addToPopularsList"
        >
            <template v-if="addFormat" v-slot:formAddArea>
                <v-col cols="12">
                    <v-text-field label="ワード" required color="maccha"
                        clearable rounded outlined
                        v-model="addFormat.popular.word"
                    ></v-text-field>
                </v-col>
            </template>
        </AddButton>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'fire'"
            :items="populars"

            @destroyItem="destroyFromPopularsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updatePopularsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.popular.word}}</v-list-item-title>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-text-field label="ワード" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.popular.word"
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
        name: "Populars",
        components: {
            AddButton,
            List,
        },
        data() {
            return {
                apiPath: "/api/admin/populars",
                addFormat: null,
                editFormat: null,
                populars: [],
                moduleName: "人気キーワード",
            }
        },
        methods: {
            getAddFormat(){
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToPopularsList(obj){
                const addObj = obj
                this.populars.push(addObj)
                this.addFormat = null;
            },
            destroyFromPopularsList(id){
                this.populars = this.populars.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                })
            },
            updatePopularsList(obj){
                Object.assign(this.populars.find((e) => e.id === obj.id), obj)
                this.editFormat = null;
            }
        },
        mounted() {
            document.title = "人気キーワード管理 | Sycall"
            axios.get(this.apiPath)
            .then(res => {
                this.populars = res.data
            })
        },
    }
</script>
