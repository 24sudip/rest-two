<template>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-dark">
                    <h5 class="float-start text-light">Assigned Tasks List</h5>
                    <button class="btn btn-success float-end" @click="createTask"
                    v-if="current_permissions.has('tasks-create')">New Task</button>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_type">Search Type</label>
                                <select name="search_type" class="form-control" v-model="searchData.search_type">
                                    <option value="title">Title | Priority | Dates</option>
                                    <option value="users">Assigned To</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_value">Search Value</label>
                                <input type="text" class="form-control" name="search_value"
                                v-model="searchData.search_value" @keyup="searchTask">
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover text-center">
                            <thead>
                                <tr>
                                    <th>SL</th>
                                    <th>Title</th>
                                    <th>Priority</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Description</th>
                                    <th>Assign To</th>
                                    <th>Status</th>
                                    <th v-if="current_permissions.has('tasks-update') ||
                                    current_permissions.has('tasks-delete')">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(task, index) in tasks.data" :key="index">
                                    <td>{{ index + 1 }}</td>
                                    <td>{{ task.title }}</td>
                                    <td>
                                        <span :class="`badge ${task.priority == 'Urgent' ? 'badge-danger' : 'badge-success'}`">
                                            {{ task.priority }}
                                        </span>
                                    </td>
                                    <td>{{ task.start_date }}</td>
                                    <td>{{ task.end_date }}</td>
                                    <td>
                                        {{ task.description.length <= 10 ? task.description : task.description.substring(0,10) + '...' }}
                                    </td>
                                    <td>{{ task.users.length }} Staff Members</td>
                                    <td>
                                        <p v-if="task.progress == 0" class="text-danger">No Progress</p>
                                        <p v-if="task.progress > 0 && task.progress < 100" class="text-warning">Under Progress</p>
                                        <p v-if="task.progress == 100" class="text-success">Completed</p>
                                    </td>
                                    <td v-if="current_permissions.has('tasks-update') ||
                                    current_permissions.has('tasks-delete')">
                                        <button class="btn btn-info mx-1" @click="showTask(task)">
                                            <i class="fa fa-info"></i>
                                        </button>
                                        <button class="btn btn-success mx-1" @click="editTask(task)">
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button class="btn btn-danger mx-1" @click="deleteTask(task)">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-center" v-if="taskLinks.length > 3">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li :class="`page-item ${link.active ? 'active' : ''} ${!link.url ? 'disabled' : ''}`"
                                v-for="(link, index) in taskLinks" :key="index"><a class="page-link" href="#"
                                v-html="link.label" @click.prevent="getResult(link)"></a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-xl modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel" v-if="!showMode">
                                        {{ !editMode ? 'Create Task' : 'Update Task' }}
                                    </h1>
                                    <h1 class="modal-title fs-5" id="exampleModalLabel" v-if="showMode">
                                        Show Task
                                    </h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body" v-if="!showMode">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="title">Title</label>
                                                <input type="text" class="form-control" v-model="taskData.title">
                                                <div class="text-danger" v-if="taskData.errors.has('title')" v-html="taskData.errors.get('title')" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="priority">Priority</label>
                                                <select class="form-control" v-model="taskData.priority">
                                                    <option value="Urgent">Urgent</option>
                                                    <option value="Not Urgent">Not Urgent</option>
                                                </select>
                                                <div class="text-danger" v-if="taskData.errors.has('priority')" v-html="taskData.errors.get('priority')" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="start_date">Start Date</label>
                                                <input type="date" class="form-control" v-model="taskData.start_date">
                                                <div class="text-danger" v-if="taskData.errors.has('start_date')" v-html="taskData.errors.get('start_date')" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="end_date">End Date</label>
                                                <input type="date" class="form-control" v-model="taskData.end_date">
                                                <div class="text-danger" v-if="taskData.errors.has('end_date')" v-html="taskData.errors.get('end_date')" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="description">Description</label>
                                                <textarea rows="3" class="form-control" v-model="taskData.description"></textarea>
                                                <div class="text-danger" v-if="taskData.errors.has('description')" v-html="taskData.errors.get('description')"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="assign_to">Assign To</label>
                                                <multi-select :options="filtered_users" v-model="taskData.assign_to" :searchable="true" mode="tags"></multi-select>
                                                <div class="text-danger" v-if="taskData.errors.has('assign_to')" v-html="taskData.errors.get('assign_to')" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-body" v-if="showMode">
                                    <Show :taskInfo="taskInfo" />
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="button" @click="!editMode ? storeTask() : updateTask()" class="btn btn-success" v-if="!showMode">
                                        {{ !editMode ? 'Store' : 'Save Changes' }}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Show from './Show.vue';
    export default {
        components: {
            Show,
        },
        mounted() {
            this.$store.dispatch('getTask');
            this.$store.dispatch('getAllUser');
            this.$store.dispatch('getAuthRolesAndPermissions');
        },
        computed: {
            taskLinks() {
                return this.$store.getters.taskLinks;
            },
            tasks() {
                return this.$store.getters.tasks;
            },
            filtered_users() {
                return this.$store.getters.filtered_users;
            },
            current_roles() {
                return this.$store.getters.current_roles;
            },
            current_permissions() {
                return this.$store.getters.current_permissions;
            },
        },
        data() {
            return {
                editMode: false,
                showMode: false,
                taskInfo: {},
                taskData: new Form ({
                    id: '',
                    title: '',
                    priority: '',
                    start_date: '',
                    end_date: '',
                    description: '',
                    assign_to: [],
                }),
                searchData: {
                    search_type: 'title',
                    search_value: '',
                },
            }
        },
        methods: {
            searchTask() {
                this.$store.dispatch('searchTask', this.searchData);
            },
            getResult(link) {
                if (!link.url || link.active) {
                    return;
                } else {
                    this.$store.dispatch('getTaskResult', link);
                }
            },
            showTask(task) {
                this.showMode = true;
                this.taskInfo = task;
                $('#exampleModal').modal('show');
            },
            createTask() {
                this.editMode = false;
                this.showMode = false;
                this.taskData.reset();
                this.taskData.clear();
                $('#exampleModal').modal('show');
            },
            storeTask() {
                this.$store.dispatch('storeTask', this.taskData);
            },
            editTask(task) {
                this.editMode = true;
                this.showMode = false;
                this.taskData.reset();
                this.taskData.clear();

                this.taskData.id = task.id;
                this.taskData.title = task.title;
                this.taskData.priority = task.priority;
                this.taskData.start_date = task.start_date;
                this.taskData.end_date = task.end_date;
                this.taskData.description = task.description;

                task.users.forEach(user => {
                    this.taskData.assign_to.push(user.id);
                });
                $('#exampleModal').modal('show');
            },
            updateTask() {
                this.$store.dispatch('updateTask', this.taskData);
            },
            deleteTask(task) {
                Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, delete it!"
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.$store.dispatch('deleteTask', task);
                    }
                });
            }
        }
    }
</script>
