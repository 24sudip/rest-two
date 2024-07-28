//
import axios from "axios";

export default {
    state: {
        tasks: {},
        taskLinks: [],
        inbox_tasks: {},
        inboxTaskLinks: [],
        completed_tasks: {},
        CompletedTaskLinks: [],
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
        completed_tasks(state) {
            return state.completed_tasks;
        },
        CompletedTaskLinks(state) {
            return state.CompletedTaskLinks;
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
        set_completed_tasks: (state, data) => {
            state.completed_tasks = data;
            state.CompletedTaskLinks = [];
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
                    state.CompletedTaskLinks.push(data.links[i]);
                }
            }
        },
    },
    actions: {
        searchTask: (context, searchData) => {
            setTimeout(function () {
                axios
                    .get(
                        `${window.url}api/searchTask?${searchData.search_type}=${searchData.search_value}`
                    )
                    .then((response) => {
                        context.commit("set_tasks", response.data);
                    })
                    .catch((err) => {
                        console.log(err);
                    });
            });
        },
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
        getCompletedTaskResult: (context, link) => {
            axios.get(link.url).then((response) => {
                context.commit("set_completed_tasks", response.data);
            });
        },
        getTask: (context) => {
            axios.get(`${window.url}api/getTask`).then((response) => {
                context.commit("set_tasks", response.data);
            });
        },
        searchInbox: (context, searchData) => {
            setTimeout(function () {
                axios
                    .get(
                        `${window.url}api/searchInbox?${searchData.search_type}=${searchData.search_value}`
                    )
                    .then((response) => {
                        context.commit("set_inbox_tasks", response.data);
                    })
                    .catch((err) => {
                        console.log(err);
                    });
            });
        },
        getInboxTask: (context) => {
            axios.get(`${window.url}api/getInboxTask`).then((response) => {
                context.commit("set_inbox_tasks", response.data);
            });
        },
        searchCompleted: (context, searchData) => {
            setTimeout(function () {
                axios
                    .get(
                        `${window.url}api/searchCompleted?${searchData.search_type}=${searchData.search_value}`
                    )
                    .then((response) => {
                        context.commit("set_completed_tasks", response.data);
                    })
                    .catch((err) => {
                        console.log(err);
                    });
            });
        },
        getCompletedTask: (context) => {
            axios.get(`${window.url}api/getCompletedTask`).then((response) => {
                context.commit("set_completed_tasks", response.data);
            });
        },
        storePerformTask: (context, data) => {
            axios
                .post(
                    window.url + "api/storePerformTask",
                    data.performTaskData,
                    data.config
                )
                .then((response) => {
                    if (window.location.href.indexOf("task/inbox") > -1) {
                        context.dispatch("getInboxTask");
                    } else {
                        context.dispatch("getCompletedTask");
                    }
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
                if (window.location.href.indexOf("task/index") > -1) {
                    context.dispatch("getTask");
                } else {
                    context.dispatch("getInboxTask");
                }
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
                    if (window.location.href.indexOf("task/index") > -1) {
                        context.dispatch("getTask");
                    } else {
                        context.dispatch("getInboxTask");
                    }
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
                    if (window.location.href.indexOf("task/index") > -1) {
                        context.dispatch("getTask");
                    } else {
                        context.dispatch("getInboxTask");
                        $("#exampleModal").modal("hide");
                    }
                    window.Toast.fire({
                        icon: "success",
                        title: "Task Deleted Successfully",
                    });
                });
        },
    },
};
