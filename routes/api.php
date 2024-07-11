<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{DepartmentController, ApiController, UserController};

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
        Route::get('getAllDepartment', 'getAllDepartment')->middleware('permission:departments-read');
        Route::get('getAllRoles', 'getAllRoles')->middleware('permission:roles-read');
        Route::get('getAllPermissions', 'getAllPermissions')->middleware('permission:permissions-read');
    });

    Route::controller(UserController::class)->group(function () {
        Route::get('searchUser', 'searchUser')->middleware('permission:users-read');
        Route::get('getUser', 'getUser')->middleware('permission:users-read');
        Route::post('storeUser', 'storeUser')->middleware('permission:users-create');
        Route::post('updateUser/{id}', 'updateUser')->middleware('permission:users-update');
        Route::post('deleteUser/{id}', 'deleteUser')->middleware('permission:users-delete');
    });
});
