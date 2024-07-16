<template>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-dark">
                    <h5 class="float-start text-light">Inbox Tasks List</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_type">Search Type</label>
                                <select name="search_type" class="form-control" v-model="searchData.search_type">
                                    <option value="name">Name</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_value">Search Value</label>
                                <input type="text" class="form-control" name="search_value"
                                v-model="searchData.search_value" @keyup="searchDepartment">
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
                                    <th v-if="current_permissions.has('inbox-update')">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(task, index) in inbox_tasks.data" :key="index">
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
                                    <td v-if="current_permissions.has('inbox-update')">
                                        <button class="btn btn-success mx-1" @click="performTask(task)">
                                            <i class="fa fa-check"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-center" v-if="inboxTaskLinks.length > 3">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li :class="`page-item ${link.active ? 'active' : ''} ${!link.url ? 'disabled' : ''}`"
                                v-for="(link, index) in inboxTaskLinks" :key="index"><a class="page-link" href="#"
                                v-html="link.label" @click.prevent="getResult(link)"></a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-xl modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">
                                        {{ !editMode ? 'Create Task' : 'Perform Task' }}
                                    </h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="row my-2">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header bg-light">
                                                    <h5>Task Information</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table class="table">
                                                            <tr>
                                                                <th style="width: 20%;">Title</th>
                                                                <td>{{ taskInfo.title }}</td>
                                                            </tr>
                                                            <tr>
                                                                <th style="width: 20%;">Priority</th>
                                                                <td>
                                                                    <span :class="`text-light badge ${taskInfo.priority == 'Urgent' ? 'bg-danger' : 'bg-success'}`">
                                                                        {{ taskInfo.priority }}
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th style="width: 20%;">Start Date</th>
                                                                <td>{{ taskInfo.start_date }}</td>
                                                            </tr>
                                                            <tr>
                                                                <th style="width: 20%;">End Date</th>
                                                                <td>{{ taskInfo.end_date }}</td>
                                                            </tr>
                                                            <tr>
                                                                <th style="width: 20%;">Description</th>
                                                                <td>{{ taskInfo.description }}</td>
                                                            </tr>
                                                            <tr>
                                                                <th style="width: 20%;">Assign To</th>
                                                                <td>
                                                                    <span :class="`text-light badge bg-dark mx-1`" v-for="(user, index) in taskInfo.users" :key="index">
                                                                        {{ user.name }}
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2" v-if="performMode">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header bg-light">
                                                    <h5>Perform Task</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label for="result">Result</label>
                                                                <textarea class="form-control" rows="3" v-model="performTaskData.result"></textarea>
                                                                <div class="text-danger" v-if="performTaskData.errors.has('result')" v-html="performTaskData.errors.get('result')" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-7">
                                                            <div class="form-group">
                                                                <label for="progress">Progress</label><br>
                                                                <input type="range" class="taskRange" min="0" max="100" v-model="performTaskData.progress">
                                                                <span class="rangeValue">{{ performTaskData.progress }}</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <label for="status">Status</label>
                                                            <p v-if="performTaskData.progress == 0">No Progress</p>
                                                            <p v-if="performTaskData.progress > 0 && performTaskData.progress < 100">Under Progress</p>
                                                            <p v-if="performTaskData.progress == 100">Completed</p>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="file">File</label>
                                                                <input type="file" class="form-control" @change="getPerformTaskFile($event)">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- <div class="row">
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
                                    </div> -->
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="button" @click="!editMode ? storeTask() : updateTask()" class="btn btn-success">
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
    export default {
        mounted() {
            this.$store.dispatch('getInboxTask');
            this.$store.dispatch('getAuthRolesAndPermissions');
        },
        computed: {
            inboxTaskLinks() {
                return this.$store.getters.inboxTaskLinks;
            },
            inbox_tasks() {
                return this.$store.getters.inbox_tasks;
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
                performMode: false,
                taskInfo: {},
                performTaskData: new Form ({
                    id: '',
                    task_info: {},
                    result: '',
                    progress: '',
                    file: '',
                }),
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
                    search_type: 'name',
                    search_value: '',
                },
            }
        },
        methods: {
            getResult(link) {
                if (!link.url || link.active) {
                    return;
                } else {
                    this.$store.dispatch('getInboxTaskResult', link);
                }
            },
            performTask(task) {
                this.editMode = true;
                this.performMode = true;
                this.taskInfo = task;
                $('#exampleModal').modal('show');
            },
            getPerformTaskFile(event) {

            },
        }
    }
</script>
