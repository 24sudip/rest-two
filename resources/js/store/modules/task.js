//
import axios from "axios";

export default {
    state: {
        tasks: {},
        taskLinks: [],
        inbox_tasks: {},
        inboxTaskLinks: [],
    },
    getters: {
        tasks(state) {
            return state.tasks;
        },
        taskLinks(state) {
            return state.taskLinks;
        },
        inbox_tasks(state) {
            return state.inbox_tasks;
        },
        inboxTaskLinks(state) {
            return state.inboxTaskLinks;
        },
    },
    mutations: {
        set_tasks: (state, data) => {
            state.tasks = data;
            state.taskLinks = [];
            for (let i = 0; i < data.links.length; i++) {
                if (
                    i === 1 ||
                    i === Number(data.links.length - 2) ||
                    data.links[i].active ||
                    isNaN(data.links[i].label) ||
                    Number(data.links[i].label) ===
                        Number(data.current_page + 1) ||
                    Number(data.links[i].label) ===
                        Number(data.current_page - 1)
                ) {
                    state.taskLinks.push(data.links[i]);
                }
            }
        },
        set_inbox_tasks: (state, data) => {
            state.inbox_tasks = data;
            state.inboxTaskLinks = [];
            for (let i = 0; i < data.links.length; i++) {
                if (
                    i === 1 ||
                    i === Number(data.links.length - 2) ||
                    data.links[i].active ||
                    isNaN(data.links[i].label) ||
                    Number(data.links[i].label) ===
                        Number(data.current_page + 1) ||
                    Number(data.links[i].label) ===
                        Number(data.current_page - 1)
                ) {
                    state.inboxTaskLinks.push(data.links[i]);
                }
            }
        },
    },
    actions: {
        // searchDepartment: (context, searchData) => {
        //     setTimeout(function () {
        //         axios
        //             .get(
        //                 `${window.url}api/searchDepartment?${searchData.search_type}=${searchData.search_value}`
        //             )
        //             .then((response) => {
        //                 context.commit("set_department", response.data);
        //             })
        //             .catch((err) => {
        //                 console.log(err);
        //             });
        //     });
        // },
        getTaskResult: (context, link) => {
            axios.get(link.url).then((response) => {
                context.commit("set_tasks", response.data);
            });
        },
        getInboxTaskResult: (context, link) => {
            axios.get(link.url).then((response) => {
                context.commit("set_inbox_tasks", response.data);
            });
        },
        getTask: (context) => {
            axios.get(`${window.url}api/getTask`).then((response) => {
                context.commit("set_tasks", response.data);
            });
        },
        getInboxTask: (context) => {
            axios.get(`${window.url}api/getInboxTask`).then((response) => {
                context.commit("set_inbox_tasks", response.data);
            });
        },
        storePerformTask: (context, data) => {
            axios.post(
                window.url + "api/storePerformTask",
                data.performTaskData,
                data.config
            )
            .then((response) => {
                context.dispatch("getInboxTask");
                $("#exampleModal").modal("hide");
                $("#task_file").val("");
                window.Toast.fire({
                    icon: "success",
                    title: "Task Performance Stored Successfully",
                });
            });
        },
        storeTask: (context, taskData) => {
            taskData.post(window.url + "api/storeTask").then((response) => {
                context.dispatch("getTask");
                $("#exampleModal").modal("hide");
                window.Toast.fire({
                    icon: "success",
                    title: "Task Created Successfully",
                });
            });
        },
        updateTask: (context, taskData) => {
            taskData
                .post(window.url + "api/updateTask/" + taskData.id)
                .then((response) => {
                    context.dispatch("getTask");
                    $("#exampleModal").modal("hide");
                    window.Toast.fire({
                        icon: "success",
                        title: "Task Updated Successfully",
                    });
                });
        },
        deleteTask: (context, taskData) => {
            axios
                .post(window.url + "api/deleteTask/" + taskData.id)
                .then(() => {
                    context.dispatch("getTask");
                    window.Toast.fire({
                        icon: "success",
                        title: "Task Deleted Successfully",
                    });
                });
        },
    },
};