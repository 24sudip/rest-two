<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Permission;
use Session;

class PermissionController extends Controller
{
    public function PermissionIndex() {
        $permissions = Permission::all();
        return view('management.permission.Index', compact('permissions'));
    }

    public function PermissionCreate() {
        return view('management.permission.Create');
    }

    public function PermissionStore(Request $request) {
        // return $request->all();
        if ($request->permission_type == 'basic') {
            $request->validate([
                'name'=>'required',
                'display_name'=>'required',
                'description'=>'required',
            ]);
            Permission::create([
                'name'=>$request->name,
                'display_name'=>$request->display_name,
                'description'=>$request->description,
            ]);
            Session::flash('success_message','Permission Created Successfully!');
        } else if($request->permission_type == 'crud') {
            $request->validate([
                'resource'=>'required',
            ]);
            $crud = $request->crudSelected;
            if (count($crud) > 0) {
                foreach ($crud as $item) {
                    $name = strtolower($request->resource) . '-' . strtolower($item);
                    $display_name = ucwords($request->resource . ' ' . $item);
                    $description = ucwords($request->resource . ' ' . $item);
                    Permission::create([
                        'name'=>$name,
                        'display_name'=>$display_name,
                        'description'=>$description,
                    ]);
                }
            }
            Session::flash('success_message','All Permissions Created Successfully!');
        }
        return redirect()->route('permission.index');
    }

    public function PermissionEdit($id) {
        $permission = Permission::find($id);
        return view('management.permission.Edit', compact('permission'));
    }

    public function PermissionUpdate(Request $request, $id) {
        $request->validate([
            'name'=>'required',
            'display_name'=>'required',
            'description'=>'required',
        ]);
        Permission::where('id', $id)->update([
            'name'=>$request->name,
            'display_name'=>$request->display_name,
            'description'=>$request->description,
        ]);
        Session::flash('success_message','Permission Updated Successfully!');
        return redirect()->route('permission.index');
    }

    public function PermissionDelete($id) {
        Permission::where('id', $id)->delete();
        Session::flash('success_message','Permission Deleted Successfully!');
        return redirect()->route('permission.index');
    }
}
