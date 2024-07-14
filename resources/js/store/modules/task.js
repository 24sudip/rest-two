//
import axios from "axios";

export default {
    state: {
        tasks: {},
        // departmentLinks: [],
    },
    getters: {
        tasks(state) {
            return state.tasks;
        },
        // departmentLinks(state) {
        //     return state.departmentLinks;
        // },
    },
    mutations: {
        set_tasks: (state, data) => {
            state.tasks = data;
            // state.departmentLinks = [];
            // for (let i = 0; i < data.links.length; i++) {
            //     if (
            //         i === 1 ||
            //         i === Number(data.links.length - 2) ||
            //         data.links[i].active ||
            //         isNaN(data.links[i].label) ||
            //         Number(data.links[i].label) ===
            //             Number(data.current_page + 1) ||
            //         Number(data.links[i].label) ===
            //             Number(data.current_page - 1)
            //     ) {
            //         state.departmentLinks.push(data.links[i]);
            //     }
            // }
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
        // getDepartmentResult: (context, link) => {
        //     axios.get(link.url).then((response) => {
        //         context.commit("set_department", response.data);
        //     });
        // },
        getTask: (context) => {
            axios.get(`${window.url}api/getTask`).then((response) => {
                // this.department = ;
                context.commit("set_tasks", response.data);
            });
        },
        storeTask: (context, taskData) => {
            taskData.post(window.url + "api/storeTask").then((response) => {
                // context.dispatch("getTask");
                $("#exampleModal").modal("hide");
                window.Toast.fire({
                    icon: "success",
                    title: "Task Created Successfully",
                });
            });
        },
        // updateDepartment: (context, departmentData) => {
        //     departmentData
        //         .post(window.url + "api/updateDepartment/" + departmentData.id)
        //         .then((response) => {
        //             context.dispatch("getDepartment");
        //             $("#exampleModal").modal("hide");
        //             window.Toast.fire({
        //                 icon: "success",
        //                 title: "Department Updated Successfully",
        //             });
        //         });
        // },
        // deleteDepartment: (context, departmentData) => {
        //     axios
        //         .post(window.url + "api/deleteDepartment/" + departmentData.id)
        //         .then(() => {
        //             context.dispatch("getDepartment");
        //             window.Toast.fire({
        //                 icon: "success",
        //                 title: "Department Deleted Successfully",
        //             });
        //         });
        // },
    },
};
