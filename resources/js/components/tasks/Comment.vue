<template>
    <!-- Modal -->
    <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="commentModalLabel">
                        Comments List For {{ taskInfo.title }}
                    </h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="comment">Comment</label>
                                <textarea rows="3" class="form-control" v-model="commentData.comment"></textarea>
                                <div class="text-danger" v-if="commentData.errors.has('comment')"
                                v-html="commentData.errors.get('comment')" />
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-success" @click="storeComment">Submit Comment</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        props: [
            'taskInfo',
        ],
        mounted() {
            window.emitter.on('resetCommentData', () => {
                this.commentData.reset();
                this.commentData.clear();
            });
        },
        data() {
            return {
                commentData: new Form({
                    id: '',
                    task_id: '',
                    comment: '',
                }),
            };
        },
        methods: {
            storeComment() {
                this.commentData.task_id = this.taskInfo.id;
                this.$store.dispatch('storeComment', this.commentData);
            },
        },
    }
</script>
