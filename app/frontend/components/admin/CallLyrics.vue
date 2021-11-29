<template>
    <v-container id="call-lyrics-group">
        <v-dialog max-width="600px" v-model="dialog" class="rounded-xl">
            <template v-slot:activator="{on}">
                <v-btn depressed rounded color="primary" class="black--text" v-on="on">
                    <v-icon left color="black">mdi-plus-circle</v-icon>追加
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <h3>歌詞を追加する</h3>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-autocomplete label="バージョン" required color="maccha"
                                    item-color="maccha"
                                ></v-autocomplete>
                            </v-col>
                            <v-col cols="12">
                                <v-textarea label="歌詞" required color="maccha"></v-textarea>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn depressed rounded color="black" class="white--text mx-2" @click="dialog = false">
                        キャンセル
                    </v-btn>
                    <v-btn depressed rounded color="primary" class="black--text mx-2" @click="dialog = false">
                        <v-icon left color="black">mdi-plus-circle</v-icon>追加
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <List
            :moduleName="moduleName"
            :apiPath="apiPath"
            :iconName="'music-box'"
            :items="lyrics"

            @destroyItem="destroyFromLyricsList"
            @startEditing="getEditFormat"
            :editFormat="editFormat"
            @updateItem="updateLyricsList"
        >
            <template v-slot:contentArea="{item}">
                <v-progress-circular v-if="isLoading" indeterminate color="maccha"></v-progress-circular>
                <v-list-item-title class="black--text">{{item.lyrics_version.song.title}}</v-list-item-title>
                <v-list-item-subtitle>ソース：{{item.lyric.body}}</v-list-item-subtitle>
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
        name: "CallLyrics",
        data() {
            return {
                apiPath: "/api/admin/lyrics",
                addFormat: null,
                editFormat: null,
                lyrics: [],
                moduleName: "歌詞",
                isLoading: false,
            }
        },
        components: {
            AddButton,
            List,
        },
        mounted() {
            this.isLoading = true
            axios.get(this.apiPath)
            .then(res => {
                this.lyrics = res.data
                this.isLoading = false
            })
            .catch(err => {
                console.error(err.message); 
            })
        },
    }
</script>
