<!-- Well begun is half done. - Aristotle -->
@extends('partials.deleteModal', ['loop'=>$loop])

@section('modalText'.$loop->index)
    Are You Sure You Wanna Delete A Permission?
@endsection

@section('modalForm'.$loop->index)
    <form action="{{ route('permission.delete', $permission->id) }}" method="post">
        @csrf
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-danger">Yes</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
        </div>
    </form>
@endsection

