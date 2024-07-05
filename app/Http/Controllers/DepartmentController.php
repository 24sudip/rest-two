<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Department;
use Session;

class DepartmentController extends Controller
{
    // function __construct() {
    //     $this->middleware('auth:api');
    // }

    // below code is related to vue js crud
    public function getDepartment() {
        return response()->json(Department::latest()->get());
    }

    public function storeDepartment(Request $request) {
        $request->validate([
            'name'=>['required'],
        ]);
        Department::create([
            'user_id'=>1,
            'name'=>$request->name,
        ]);
        return response()->json('success');
    }

    public function updateDepartment(Request $request, $id) {
        $request->validate([
            'name'=>['required'],
        ]);
        Department::where('id',$id)->update([
            'name'=>$request->name,
        ]);
        return response()->json('success');
    }

    public function deleteDepartment($id) {
        Department::where('id',$id)->delete();
        return response()->json('success');
    }

    // below code is related to laravel crud
    public function DepartmentIndex() {
        $departments = Department::all();
        return view('management.department.Index', compact('departments'));
    }

    public function DepartmentCreate() {
        return view('management.department.Create');
    }

    public function DepartmentStore(Request $request) {
        // return $request->all();
        $request->validate([
            'name'=>['required'],
        ]);
        Department::create([
            'user_id'=>1,
            'name'=>$request->name,
        ]);
        Session::flash('success_message','Department Created Successfully!');
        return redirect()->route('department.index');
    }

    public function DepartmentEdit($id) {
        // return "<h1>$id</h1>";
        $department = Department::find($id);
        return view('management.department.Edit', compact('department'));
    }

    public function DepartmentUpdate(Request $request, $id) {
        $request->validate([
            'name'=>['required'],
        ]);
        Department::where('id',$id)->update([
            'name'=>$request->name,
        ]);
        Session::flash('success_message','Department Updated Successfully!');
        return redirect()->route('department.index');
    }

    public function DepartmentDelete($id) {
        Department::where('id', $id)->delete();
        Session::flash('success_message','Department Deleted Successfully!');
        return redirect()->route('department.index');
    }
}
