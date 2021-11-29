<template>
    <v-dialog max-width="600px" v-model="dialogAdd" class="rounded-xl">
        <template v-slot:activator="{on}">
            <v-btn depressed rounded color="primary" class="black--text mx-2" v-on="on">
                <v-icon left color="black">mdi-plus-circle</v-icon>追加
            </v-btn>
        </template>
        <v-card>
            <v-card-title>
                <h3>{{moduleName}}を追加する</h3>
            </v-card-title>
            <v-card-text>
                <v-container>
                    <v-row>
                        <slot name="formAddArea"></slot>
                    </v-row>
                </v-container>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn depressed rounded color="black" class="white--text mx-2" @click="dialogAdd = false">
                    キャンセル
                </v-btn>
                <v-btn depressed rounded color="primary" class="black--text mx-2" @click="add">
                    <v-icon left color="black">mdi-plus-circle</v-icon>追加
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
    import {mapMutations} from 'vuex'
    import axios from 'axios'
    export default {
        name: "AddButton",
        data() {
            return {
                dialogAdd: false,
            }
        },
        props: {
            moduleName: {
                type: String,
                required: true,
            },
            inputValue: {
                type: String | Object,
                required: true,
            },
            apiPath: {
                type: String,
                required: true,
            },
            paramsType: {
                type: String,
                required: true,
            }
        },
        computed: {
            paramsFormat(){
                switch (this.paramsType) {
                    case "artist":
                        return {
                            artist: {
                                name: this.inputValue
                        }}
                        break;
                    case "song":
                        return {
                            song: {
                                title: this.inputValue.title,
                                bpm: this.inputValue.bpm,
                            },
                            artist: {
                                name: this.inputValue.artistName,
                            }
                        }
                        break;
                }
            }
        },
        methods: {
            ...mapMutations(["showSuccessAlert"]),
            add(){
                this.dialogAdd = false;
                axios.post(this.apiPath,this.paramsFormat)
                .then(() => {
                    this.$emit("addItem", this.inputValue)
                    this.showSuccessAlert({
                        action: "追加",
                        flag: true, 
                        type: this.moduleName
                    })
                })
                .catch(err => {
                    console.error(err); 
                })
            },
        },
    }
</script>
