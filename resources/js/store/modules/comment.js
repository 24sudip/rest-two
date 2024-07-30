//
import axios from "axios";

export default {
    state: {
        comments: {},
    },
    getters: {
        comments(state) {
            return state.comments;
        },
    },
    mutations: {
        set_comments: (state, data) => {
            state.comments = data;
        },
    },
    actions: {
        getComment: (context, data) => {
            axios.get(`${window.url}api/getComment/${data.taskData.id}`)
            .then((response) => {
                context.commit("set_comments", response.data);
            });
        },
        storeComment: (context, commentData) => {
            commentData.post(window.url + "api/storeComment")
            .then((response) => {
                context.dispatch("getComment", {
                    taskData: { id: commentData.task_id },
                });
                window.emitter.emit("resetCommentData");
                window.Toast.fire({
                    icon: "success",
                    title: "Comment Created Successfully",
                });
            });
        },
        updateComment: (context, commentData) => {
            commentData.post(window.url + "api/updateComment/" + commentData.id)
            .then((response) => {
                context.dispatch("getComment", {
                    taskData: { id: commentData.task_id },
                });
                window.emitter.emit("resetCommentData");
                window.Toast.fire({
                    icon: "success",
                    title: "Comment Updated Successfully",
                });
            });
        },
        deleteComment: (context, commentData) => {
            axios.post(window.url + "api/deleteComment/" + commentData.id)
            .then((response) => {
                context.dispatch("getComment", {
                    taskData: { id: commentData.task_id },
                });
                window.Toast.fire({
                    icon: "success",
                    title: "Comment Deleted Successfully",
                });
            });
        },
    },
};
