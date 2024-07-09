<!-- Simplicity is the ultimate sophistication. - Leonardo da Vinci -->
@extends('partials.deleteModal', ['loop'=>$loop])

@section('modalText'.$loop->index)
    Are You Sure You Wanna Delete A Role?
@endsection

@section('modalForm'.$loop->index)
    <form action="{{ route('role.delete', $role->id) }}" method="post">
        @csrf
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-danger">Yes</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
        </div>
    </form>
@endsection

