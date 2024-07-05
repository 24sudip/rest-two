//
import axios from "axios";

export default {
    state: {
        users: [],
    },
    getters: {
        users(state) {
            return state.users;
        },
    },
    mutations: {
        set_user: (state, data) => {
            state.users = data;
        },
    },
    actions: {
        getUser: (context) => {
            axios.get(`${window.url}api/getUser`).then((response) => {
                context.commit("set_user", response.data);
                console.log(response.data);
            });
        },
        storeUser: (context, userData) => {
            userData.post(window.url + "api/storeUser").then((response) => {
                context.dispatch("getUser");
                $("#exampleModal").modal("hide");
            });
        },
        updateUser: (context, userData) => {
            userData
                .post(window.url + "api/updateUser/" + userData.id)
                .then((response) => {
                    context.dispatch("getUser");
                    $("#exampleModal").modal("hide");
                });
        },
        deleteUser: (context, userData) => {
            if (confirm("Are you sure you wanna delete the user!")) {
                axios
                    .post(window.url + "api/deleteUser/" + userData.id)
                    .then(() => {
                        context.dispatch("getUser");
                    });
            }
        },
    },
};
