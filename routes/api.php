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

Route::group(['middleware', ['forcetojson','auth:api']], function () {
    Route::get('getDepartment', [DepartmentController::class, 'getDepartment']);
    Route::post('storeDepartment', [DepartmentController::class, 'storeDepartment']);
    Route::post('updateDepartment/{id}', [DepartmentController::class, 'updateDepartment']);
    Route::post('deleteDepartment/{id}', [DepartmentController::class, 'deleteDepartment']);

    Route::get('getAllDepartment', [ApiController::class, 'getAllDepartment']);
    Route::get('getAllRoles', [ApiController::class, 'getAllRoles']);
    Route::get('getAllPermissions', [ApiController::class, 'getAllPermissions']);

    Route::get('getUser', [UserController::class, 'getUser']);
    Route::post('storeUser', [UserController::class, 'storeUser']);
    Route::post('updateUser/{id}', [UserController::class, 'updateUser']);
    Route::post('deleteUser/{id}', [UserController::class, 'deleteUser']);
});
