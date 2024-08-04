<template>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-dark">
                    <h5 class="float-start text-light">
                        {{ page_type == 'inbox' ? 'Inbox Tasks List' : 'Completed Tasks List' }}
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_type">Search Type</label>
                                <select name="search_type" class="form-control" v-model="searchData.search_type">
                                    <option value="title">Title | Priority | Dates</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="search_value">Search Value</label>
                                <input type="text" class="form-control" name="search_value"
                                v-model="searchData.search_value" @keyup="page_type == 'inbox' ? searchInbox() : searchCompleted()">
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
                                    <th v-if="current_permissions.has('comments-read')">Comments</th>
                                    <th v-if="current_permissions.has('subs-read')">Sub Tasks</th>
                                    <th v-if="page_type == 'inbox' ? current_permissions.has('inbox-update')
                                    : current_permissions.has('completed-update')
                                    ">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(task, index) in (page_type == 'inbox' ? inbox_tasks.data : completed_tasks.data)" :key="index">
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
                                    <td v-if="current_permissions.has('comments-read')">
                                        <button type="button" class="btn btn-secondary" @click="showComment(task)">
                                            <i class="fa fa-comment"></i>
                                        </button>
                                    </td>
                                    <td v-if="current_permissions.has('subs-read')">
                                        <button class="btn btn-secondary mx-1" @click="subTask(task)">
                                            <i class="fa fa-tasks"></i>
                                        </button>
                                    </td>
                                    <td v-if="page_type == 'inbox' ? current_permissions.has('inbox-update')
                                    : current_permissions.has('completed-update')">
                                        <button class="btn btn-success mx-1" @click="performTask(task)">
                                            <i class="fa fa-check"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-center" v-if="page_type == 'inbox' ? inboxTaskLinks.length > 3 : CompletedTaskLinks.length > 3">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li :class="`page-item ${link.active ? 'active' : ''} ${!link.url ? 'disabled' : ''}`"
                                v-for="(link, index) in (page_type == 'inbox' ?  inboxTaskLinks : CompletedTaskLinks)" :key="index"><a class="page-link" href="#"
                                v-html="link.label" @click.prevent="getResult(link)"></a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-xl modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel" v-if="!subTaskMode">
                                        {{ !editMode ? 'Create Task' : 'Perform Task' }}
                                    </h1>
                                    <h1 class="modal-title fs-5" id="exampleModalLabel" v-if="subTaskMode">
                                        Sub Tasks
                                    </h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="row my-2" v-if="!subTaskMode">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header bg-light">
                                                    <h5>Task Information</h5>
                                                </div>
                                                <div class="card-body">
                                                    <Show :taskInfo="taskInfo" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2" v-if="performMode && !subTaskMode">
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
                                                                <input type="file" class="form-control" id="task_file" @change="getPerformTaskFile($event)">
                                                                <span>
                                                                    {{ taskInfo.file ? 'Already Uploaded A File' : 'No File Uploaded Yet' }}
                                                                </span><br>
                                                                <span v-if="taskInfo.file">
                                                                    File Name: {{ taskInfo.file }}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" v-if="subTaskMode">
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
                                    <div class="row" v-if="subTaskMode">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="description">Description</label>
                                                <textarea rows="3" class="form-control" v-model="taskData.description"></textarea>
                                                <div class="text-danger" v-if="taskData.errors.has('description')" v-html="taskData.errors.get('description')"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" v-if="subTaskMode">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="assign_to">Assign To</label>
                                                <multi-select :options="filtered_users" v-model="taskData.assign_to" :searchable="true" mode="tags"></multi-select>
                                                <div class="text-danger" v-if="taskData.errors.has('assign_to')" v-html="taskData.errors.get('assign_to')" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" v-if="subTaskMode">
                                        <div class="col-md-12 text-right">
                                            <button class="btn btn-danger mx-2" v-if="subEditMode" @click="cancelSubTaskEdit">
                                                Cancel
                                            </button>
                                            <button class="btn btn-success" @click="!subEditMode ? storeSubTask() : updateSubTask()">
                                                {{ !subEditMode ? 'Create Sub Task' : 'Save Changes' }}
                                            </button>
                                        </div>
                                    </div>
                                    <div class="row" v-if="subTaskMode">
                                        <div class="col-md-12">
                                            <div class="card mt-3">
                                                <div class="card-header">
                                                    <h5>Sub Tasks List</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="accordion accordion-flush" id="accordionFlushExample">
                                                        <div class="accordion-item" v-for="(sub_task, index) in allSubTask" :key="index">
                                                            <h2 class="accordion-header" :id="`flush-heading${index}`">
                                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" :data-bs-target="`#flush-collapse${index}`" aria-expanded="false" :aria-controls="`flush-collapse${index}`">
                                                                {{ index + 1 + ' - ' + sub_task.title}}
                                                            </button>
                                                            </h2>
                                                            <div :id="`flush-collapse${index}`" class="accordion-collapse collapse" :aria-labelledby="`flush-heading${index}`" data-bs-parent="#accordionFlushExample">
                                                                <div class="accordion-body">
                                                                    <div class="row mb-3">
                                                                        <div class="col-md-12">
                                                                            <a href="#" class="btn btn-success btn-sm me-2"
                                                                            @click.prevent="editSubTask(sub_task)">
                                                                                <i class="fa fa-edit"></i>
                                                                            </a>
                                                                            <a href="#" class="btn btn-danger btn-sm me-2"
                                                                            @click.prevent="deleteSubTask(sub_task)">
                                                                                <i class="fa fa-trash"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                    <Show :taskInfo="sub_task" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="button" @click="storePerformTask" class="btn btn-success" v-if="!subTaskMode">
                                        Save Changes
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <Comment :taskInfo="taskInfo" :comments="comments" />
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Show from './Show.vue';
    import Comment from './Comment.vue';
    import Echo from 'laravel-echo';
    export default {
        components: {
            Show,
            Comment,
        },
        mounted() {
            this.$store.dispatch('getInboxTask');
            this.$store.dispatch('getCompletedTask');
            this.$store.dispatch('getAuthRolesAndPermissions');

            if (this.current_permissions.has('subs-create')) {
                this.$store.dispatch('getAllUser');
            }

            if (window.location.href.indexOf("task/inbox") > -1) {
                this.page_type = 'inbox';
            } else {
                this.page_type = 'completed';
            }
        },
        computed: {
            inboxTaskLinks() {
                return this.$store.getters.inboxTaskLinks;
            },
            CompletedTaskLinks() {
                return this.$store.getters.CompletedTaskLinks;
            },
            inbox_tasks() {
                return this.$store.getters.inbox_tasks;
            },
            completed_tasks() {
                return this.$store.getters.completed_tasks;
            },
            comments() {
                return this.$store.getters.comments;
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
                page_type: '',
                editMode: false,
                performMode: false,
                subTaskMode: false,
                subEditMode: false,
                taskInfo: {},
                performTaskData: {
                    id: '',
                    task_info: {},
                    result: '',
                    progress: 0,
                    file: '',
                },
                taskData: new Form ({
                    id: '',
                    parent_id: '',
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
                allSubTask: {},
            }
        },
        methods: {
            listenToComments(task) {
                window.Echo.channel(`task.${task.id}`).listen('CommentEvent', () => {
                    this.$store.dispatch('getComment', {taskData: task});
                });
            },
            searchInbox() {
                this.$store.dispatch('searchInbox', this.searchData);
            },
            searchCompleted() {
                this.$store.dispatch('searchCompleted', this.searchData);
            },
            getResult(link) {
                if (!link.url || link.active) {
                    return;
                } else {
                    if (this.page_type == 'inbox') {
                        this.$store.dispatch('getInboxTaskResult', link);
                    } else {
                        this.$store.dispatch('getCompletedTaskResult', link);
                    }
                }
            },
            showComment(task) {
                this.taskInfo = task;
                window.emitter.emit("resetCommentData");
                this.$store.dispatch('getComment', {taskData: task});
                this.listenToComments(task);
                $('#commentModal').modal('show');
            },
            subTask(task) {
                this.editMode = false;
                this.performMode = false;
                this.subTaskMode = true;
                this.subEditMode = false;

                this.taskData.reset();
                this.taskData.clear();
                this.taskData.parent_id = task.id;

                this.allSubTask = task.sub_tasks;
                $('#exampleModal').modal('show');
            },
            cancelSubTaskEdit() {
                this.subEditMode = false;
                this.taskData.reset();
                this.taskData.clear();
            },
            editSubTask(sub_task) {
                this.editMode = false;
                this.performMode = false;
                this.subTaskMode = true;
                this.subEditMode = true;

                this.taskData.reset();
                this.taskData.clear();

                this.taskData.id = sub_task.id;
                this.taskData.parent_id = sub_task.parent_id;
                this.taskData.title = sub_task.title;
                this.taskData.priority = sub_task.priority;
                this.taskData.start_date = sub_task.start_date;
                this.taskData.end_date = sub_task.end_date;
                this.taskData.description = sub_task.description;

                sub_task.users.forEach(user => {
                    this.taskData.assign_to.push(user.id);
                });
            },
            updateSubTask() {
                this.$store.dispatch('updateTask', this.taskData);
            },
            deleteSubTask(sub_task) {
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
                        this.$store.dispatch('deleteTask', sub_task);
                    }
                });
            },
            storeSubTask() {
                this.$store.dispatch('storeTask', this.taskData);
            },
            performTask(task) {
                this.editMode = true;
                this.performMode = true;

                this.subTaskMode = false;
                this.subEditMode = false;

                this.taskInfo = task;
                this.performTaskData.result = task.result;
                this.performTaskData.progress = task.progress;
                $('#exampleModal').modal('show');
            },
            getPerformTaskFile(event) {
                this.performTaskData.file = event.target.files[0];
            },
            storePerformTask() {
                const config = {headers : {'content-type': 'multipart/form-data'}};
                let formData = new FormData();
                formData.append('task_id', this.taskInfo.id);
                formData.append('result', this.performTaskData.result);
                formData.append('progress', this.performTaskData.progress);
                formData.append('file', this.performTaskData.file);
                this.$store.dispatch('storePerformTask', {performTaskData: formData, config: config});
            },
        }
    }
</script>
