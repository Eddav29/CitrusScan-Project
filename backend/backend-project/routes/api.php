<?php

use Illuminate\Auth\Middleware\Authenticate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware(Authenticate::using('sanctum'));

//users
Route::apiResource('/users', App\Http\Controllers\Api\UsersController::class);
//detection
Route::apiResource('/detections', App\Http\Controllers\Api\DetectionController::class);
//history
Route::apiResource('/history', App\Http\Controllers\Api\HistoryController::class);
