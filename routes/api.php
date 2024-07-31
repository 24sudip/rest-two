<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{DepartmentController, ApiController, UserController, TaskController, CommentController};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware(['forcetojson','auth:api'])->group(function () {
    Route::controller(DepartmentController::class)->group(function () {
        Route::get('searchDepartment', 'searchDepartment')->middleware('permission:departments-read');
        Route::get('getDepartment', 'getDepartment')->middleware('permission:departments-read');
        Route::post('storeDepartment', 'storeDepartment')->middleware('permission:departments-create');
        Route::post('updateDepartment/{id}', 'updateDepartment')->middleware('permission:departments-update');
        Route::post('deleteDepartment/{id}', 'deleteDepartment')->middleware('permission:departments-delete');
    });

    Route::controller(ApiController::class)->group(function () {
        Route::get('getUnreadNotification', 'getUnreadNotification');
        Route::get('markNotificationAsRead', 'markNotificationAsRead');
        Route::get('getAllDepartment', 'getAllDepartment')->middleware('permission:departments-read');
        Route::get('getAllRoles', 'getAllRoles')->middleware('permission:roles-read');
        Route::get('getAllPermissions', 'getAllPermissions')->middleware('permission:permissions-read');
        Route::get('getAllUser', 'getAllUser')->middleware('permission:tasks-create');
    });

    Route::controller(UserController::class)->group(function () {
        Route::get('searchUser', 'searchUser')->middleware('permission:users-read');
        Route::get('getUser', 'getUser')->middleware('permission:users-read');
        Route::post('storeUser', 'storeUser')->middleware('permission:users-create');
        Route::post('updateUser/{id}', 'updateUser')->middleware('permission:users-update');
        Route::post('deleteUser/{id}', 'deleteUser')->middleware('permission:users-delete');
    });

    Route::controller(TaskController::class)->group(function () {
        Route::get('searchTask', 'searchTask')->middleware('permission:tasks-read');
        Route::get('getTask', 'getTask')->middleware('permission:tasks-read');
        Route::post('storeTask', 'storeTask')->middleware('permission:tasks-create');
        Route::post('updateTask/{id}', 'updateTask')->middleware('permission:tasks-update');
        Route::post('deleteTask/{id}', 'deleteTask')->middleware('permission:tasks-delete');

        Route::get('searchInbox', 'searchInbox')->middleware('permission:inbox-read');
        Route::get('getInboxTask', 'getInboxTask')->middleware('permission:inbox-read');
        Route::get('searchCompleted', 'searchCompleted')->middleware('permission:completed-read');
        Route::get('getCompletedTask', 'getCompletedTask')->middleware('permission:completed-read');
        Route::post('storePerformTask', 'storePerformTask')->middleware('permission:inbox-update');
    });

    Route::controller(CommentController::class)->group(function () {
        Route::get('getComment/{id}', 'getComment')->middleware('permission:comments-read');
        Route::post('storeComment', 'storeComment')->middleware('permission:comments-create');
        Route::post('updateComment/{id}', 'updateComment')->middleware('permission:comments-update');
        Route::post('deleteComment/{id}', 'deleteComment')->middleware('permission:comments-delete');
    });
});
