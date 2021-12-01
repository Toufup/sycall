<template>
    <v-container fluid id="login-body">
        <v-row justify="center">
            <v-sheet class="mainColor rounded-xl mx-16" min-width="600" max-width="900">
                <v-container px-16 py-8>
                    <v-row justify="center" class="my-4">
                        <h1>ようこそ、Sycallへ</h1>
                    </v-row>
                    <v-col cols="12">
                        <v-text-field label="メールアドレス" required color="maccha" background-color="white"
                            clearable rounded outlined
                            v-model="email"
                        ></v-text-field>
                    </v-col>
                    <v-col cols="12">
                        <v-text-field label="パスワード" required color="maccha" background-color="white"
                            clearable rounded outlined
                            v-model="password" type="password"
                        ></v-text-field>
                    </v-col>
                    <v-row justify="center">
                        <v-btn depressed x-large rounded color="primary" class="ml-2 black--text"
                            @click="login"
                        >ログイン</v-btn>
                    </v-row>
                </v-container>
            </v-sheet>
        </v-row>
    </v-container>
</template>

<script>
    import axios from 'axios'
    export default {
        name: "Login",
        data() {
            return {
                email: "",
                password: "",
            }
        },
        methods: {
            login(){
                axios.post("/users/sign_in",{
                    user: {
                        email: this.email,
                        password: this.password
                    }}
                )
                .then(res => {
                    console.log(res)
                })
                .catch(err => {
                    console.error(err); 
                })
            }
        },
    }
</script>
