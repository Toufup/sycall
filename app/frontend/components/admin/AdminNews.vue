<template>
    <v-container id="news-group">
        <v-row>
            <v-col cols="auto" align-self="center">
                <AddButton
                    :moduleName="moduleName"
                    :apiPath="apiPath"
                    @startAdding="getAddFormat"
                    :addFormat="addFormat"
                    @addItem="addToNewsList"
                >
                    <template v-if="addFormat" v-slot:formAddArea>
                        <v-col cols="12">
                            <v-text-field label="タイトル" required color="maccha"
                                clearable rounded outlined
                                v-model="addFormat.title"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-textarea label="本文" required color="maccha"
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
                    @keydown.enter="getNews(1); pageNum = 1"
                ></v-text-field>
            </v-col>
        </v-row>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'information'"
            :items="news"

            @destroyItem="destroyFromNewsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateNewsList"
        >
            <template v-slot:contentArea="{item}">
                <v-list-item-title class="black--text">{{item.title}}</v-list-item-title>
                <v-list-item-subtitle>公開日：{{item.createdAt}}</v-list-item-subtitle>
            </template>
            <template v-if="editFormat" v-slot:formEditArea>
                <v-col cols="12">
                    <v-card outlined class="rounded-xl">
                        <v-list-item>
                            <v-list-item-content>
                                <v-list-item-title>
                                    公開日：{{editFormat.createdAt}}
                                </v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                    </v-card>
                </v-col>
                <v-col cols="12">
                    <v-select label="タグ" required color="maccha" item-color="maccha"
                        clearable rounded outlined
                        :items="tags" item-text="text" item-value="value"
                        v-model="editFormat.tag"
                    ></v-select>
                </v-col>
                <v-col cols="12">
                    <v-text-field label="タイトル" required color="maccha"
                        clearable rounded outlined
                        v-model="editFormat.title"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-textarea label="本文" required color="maccha"
                        rounded outlined
                        v-model="editFormat.body"
                    ></v-textarea>
                </v-col>
            </template>
        </List>
        <v-pagination
            circle color="maccha" :length="pageLength" v-model="pageNum"
            @input="getNews(pageNum)" @next="getNews(pageNum)" @previous="getNews(pageNum)"
        ></v-pagination>
    </v-container>
</template>

<script>
    import AddButton from './AddButton.vue'
    import List from './List.vue'
    import axios from 'axios'
    export default {
        name: "AdminNews",
        components: {
            AddButton,
            List,
        },
        data() {
            return {
                apiPath: "/api/admin/news",
                addFormat: null,
                editFormat: null,
                news: [],
                pageLength: null,
                pageNum: 1,
                tags: [
                    {text: "公開", value: "published"},
                    {text: "アーカイブ", value: "archived"},
                ],
                moduleName: "お知らせ",
                indexKeyword: null,
            }
        },
        methods: {
            getNews(pageNum){
                axios.get(this.apiPath, {params:{page_num: pageNum, keyword: this.indexKeyword}})
                .then(res => {
                    this.news = res.data.news
                    this.pageLength = res.data.pageLength
                })
            },
            getAddFormat(){
                axios.get(`${this.apiPath}/new`)
                .then((res) => {
                    this.addFormat = res.data
                })
            },
            addToNewsList(obj){
                const addObj = obj
                this.news.unshift(addObj)
                this.addFormat = null;
            },
            destroyFromNewsList(id){
                this.news = this.news.filter((e) => {
                    return e.id !== id;
                });
            },
            getEditFormat(id){
                axios.get(`${this.apiPath}/${id}/edit`,{id: id})
                .then(res => {
                    this.editFormat = res.data
                })
            },
            updateNewsList(obj){
                Object.assign(this.news.find((e) => e.id === obj.id), obj)
                this.editFormat = null;
            }
        },
        mounted() {
            document.title = "お知らせ管理 | Sycall"
            this.getNews(1)
        },
    }
</script>
