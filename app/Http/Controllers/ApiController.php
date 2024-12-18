<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{Department, Role, Permission, User, Task};
use App\Mail\{ContactMail, ReplyMail};
use Mail;

class ApiController extends Controller
{
    public function getAllNotification() {
        return response()->json(auth('api')->user()->notifications);
    }

    public function getUnreadNotification() {
        return response()->json(auth('api')->user()->unreadNotifications);
    }

    public function markNotificationAsRead() {
        $id = \Request::get('unread');
        if ($id != 0) {
            auth('api')->user()->notifications->where('id', $id)->markAsRead();
        } else {
            auth('api')->user()->notifications->markAsRead();
        }
        return response()->json('success');
    }

    public function clearAllNotification() {
        auth('api')->user()->notifications()->delete();
        return response()->json('success');
    }

    public function getAllDepartment() {
        return response()->json(Department::all());
    }

    public function getAllRoles() {
        return response()->json(Role::all());
    }

    public function getAllPermissions() {
        return response()->json(Permission::all());
    }

    public function getAllUser() {
        return response()->json(User::with('department')->with('roles')->with('permissions')->get());
    }

    public function getBarChartData($year) {
        $user_role = auth('api')->user()->hasRole('admin');

        $months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
        $numeric_months = ['01','02','03','04','05','06','07','08','09','10','11','12'];

        $tasks_array = [];
        $other_completed_array = [];
        $own_completed_array = [];

        foreach ($numeric_months as $nm) {
            $tasks = !$user_role ? Task::where('user_id', auth('api')->user()->id)->whereMonth('created_at','=', $nm)
            ->whereYear('created_at','=', $year)->get()
            : Task::whereMonth('created_at','=', $nm)->whereYear('created_at','=', $year)->get();
            array_push($tasks_array, $tasks->count());
        }

        foreach ($numeric_months as $nm) {
            $tasks = !$user_role
            ? Task::where('user_id', auth('api')->user()->id)->where('status','1')->whereMonth('created_at','=', $nm)->whereYear('created_at','=', $year)->get()
            : Task::where('status','1')->whereMonth('created_at','=', $nm)->whereYear('created_at','=', $year)->get();
            array_push($other_completed_array, $tasks->count());
        }

        foreach ($numeric_months as $nm) {
            $tasks = !$user_role
            ? auth('api')->user()->tasks()->where('status','1')->whereMonth('created_at','=', $nm)
            ->whereYear('created_at','=', $year)->get()
            : Task::where('status','1')->whereMonth('created_at','=', $nm)
            ->whereYear('created_at','=', $year)->get()
            ;
            array_push($own_completed_array, $tasks->count());
        }

        return response()->json([
            'year'=>$year,
            'months'=>$months,
            'tasks_array'=>$tasks_array,
            'other_completed_array'=>$other_completed_array,
            'own_completed_array'=>$own_completed_array,
        ]);
    }

    public function storeContact(Request $request) {
        $request->validate([
            'name'=>['required'],
            'email'=>['required'],
            'message'=>['required']
        ]);
        $data = array(
            'name'=>$request->name,
            'email'=>$request->email,
            'message'=>$request->message
        );
        Mail::to('admin@app.com')->send(new ContactMail($data));
        Mail::to($data['email'])->send(new ReplyMail($data));
        return response()->json('success');
    }

    public function exportExcel(Request $request) {
        $user_role = auth('api')->user()->hasRole('admin');
        $request->validate([
            'type'=>'required',
            'start_date'=>'required',
            'end_date'=>'required',
        ]);

        $type = $request->type;
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        if ($type == 'assigned') {
            $tasks = !$user_role
            ? Task::where('user_id', auth('api')->user()->id)->where('parent_id','0')
            ->whereBetween('created_at', [$start_date, $end_date])->with('users')->with('performed_by_user')->latest()
            ->get()
            : Task::where('parent_id','0')
            ->whereBetween('created_at', [$start_date, $end_date])->with('users')->with('performed_by_user')->latest()
            ->get();
        }
        if ($type == 'other_completed') {
            $tasks = !$user_role
            ? Task::where('user_id', auth('api')->user()->id)->where('parent_id','0')->where('status','1')
            ->whereBetween('created_at', [$start_date, $end_date])->with('users')->with('performed_by_user')->latest()
            ->get()
            : Task::where('parent_id','0')->where('status','1')
            ->whereBetween('created_at', [$start_date, $end_date])->with('users')->with('performed_by_user')->latest()
            ->get();
        }
        if ($type == 'all_inbox') {
            $tasks = auth('api')->user()->tasks()->whereBetween('created_at', [$start_date, $end_date])->latest()->get();
        }
        if ($type == 'completed_inbox') {
            $tasks = auth('api')->user()->tasks()->whereBetween('created_at', [$start_date, $end_date])
            ->where('status','1')->latest()->get();
        }
        return response()->json($tasks);
    }
}
