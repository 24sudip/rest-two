//
import axios from "axios";

export default {
    state: {
        users: [],
        userLinks: [],
    },
    getters: {
        users(state) {
            return state.users;
        },
        userLinks(state) {
            return state.userLinks;
        },
    },
    mutations: {
        set_user: (state, data) => {
            state.users = data;
            state.userLinks = [];
            for (let i = 0; i < data.links.length; i++) {
                if (i === 1
                    || i === Number(data.links.length - 2)
                    || data.links[i].active
                    || isNaN(data.links[i].label)
                    || Number(data.links[i].label) === Number(data.current_page + 1)
                    || Number(data.links[i].label) === Number(data.current_page - 1)
                ) {
                    state.userLinks.push(data.links[i]);
                }
            }
        },
    },
    actions: {
        getUserResult: (context, link) => {
            axios.get(link.url).then((response) => {
                context.commit("set_user", response.data);
            });
        },
        getUser: (context) => {
            axios.get(`${window.url}api/getUser`).then((response) => {
                context.commit("set_user", response.data);
            });
        },
        storeUser: (context, userData) => {
            userData.post(window.url + "api/storeUser").then((response) => {
                context.dispatch("getUser");
                $("#exampleModal").modal("hide");
                window.Toast.fire({
                    icon: "success",
                    title: "User Created Successfully",
                });
            });
        },
        updateUser: (context, userData) => {
            userData
                .post(window.url + "api/updateUser/" + userData.id)
                .then((response) => {
                    context.dispatch("getUser");
                    $("#exampleModal").modal("hide");
                    window.Toast.fire({
                        icon: "success",
                        title: "User Updated Successfully",
                    });
                });
        },
        deleteUser: (context, userData) => {
            axios
            .post(window.url + "api/deleteUser/" + userData.id)
            .then(() => {
                context.dispatch("getUser");
                window.Toast.fire({
                    icon: "success",
                    title: "User Deleted Successfully",
                });
            });
        },
    },
};
