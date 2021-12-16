<template>
    <v-dialog max-width="600px" v-model="dialogAdd">
        <template v-slot:activator="{on}">
            <v-btn depressed rounded color="primary" class="black--text mx-2" v-on="on"
                @click="$emit('startAdding')"
            >
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
            addFormat: {
                type: Object,
                required: false,
            },
            apiPath: {
                type: String,
                required: true,
            },
        },
        watch: {
            dialogAdd(bool){
                if (!bool) {
                    this.$emit('handleAddDialogBlur')
                }
            }
        },
        methods: {
            ...mapMutations(["openSnackbar", "closeSnackbar"]),
            add(){
                this.dialogAdd = false;
                axios.post(this.apiPath,this.addFormat)
                .then((res) => {
                    const obj = Object.assign(this.addFormat, res.data)
                    this.$emit("addItem", obj)
                    this.closeSnackbar()
                    this.$nextTick(() => {
                        this.openSnackbar({
                            text: `${this.moduleName}を追加しました`,
                            icon: "plus-circle"
                        })
                    })
                })
            },
        },
    }
</script>
