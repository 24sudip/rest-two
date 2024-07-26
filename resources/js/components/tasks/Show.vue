<template>
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
            <tr>
                <th style="width: 20%;">Status</th>
                <td>
                    <td>
                        <p v-if="taskInfo.progress == 0" class="text-danger">No Progress</p>
                        <p v-if="taskInfo.progress > 0 && taskInfo.progress < 100" class="text-warning">Under Progress</p>
                        <p v-if="taskInfo.progress == 100" class="text-success">Completed</p>
                    </td>
                </td>
            </tr>
            <tr>
                <th style="width: 20%;">Performed By</th>
                <td>
                    <p>{{ taskInfo.performed_by !== 0 ? taskInfo.performed_by_user?.name : '...' }}</p>
                </td>
            </tr>
            <tr>
                <th style="width: 20%;">Progress</th>
                <td>
                    <p>{{ taskInfo.progress }} %</p>
                </td>
            </tr>
            <tr>
                <th style="width: 20%;">Result</th>
                <td>
                    <p>{{ taskInfo.result ? taskInfo.result : 'No Results Yet' }}</p>
                </td>
            </tr>
            <tr>
                <th style="width: 20%;">Task File</th>
                <td>
                    <a :href="`${url}tasks/${taskInfo.file}`" target="_blank" class="btn btn-success" v-if="taskInfo.file">
                        <i class="fa fa-download"></i>
                    </a>
                    <p v-else>No File Uploaded Yet</p>
                </td>
            </tr>
        </table>
    </div>
</template>

<script>
    export default {
        props: ['taskInfo'],
        data() {
            return {
                url: '',
            }
        },
        mounted() {
            this.url = window.url;
        }
    }
</script>
