<?php

use Illuminate\Auth\Middleware\Authenticate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
//users
use App\Http\Controllers\AuthController;

// POST /api/register: Untuk mendaftarkan user baru
// POST /api/login: Untuk login dan mendapatkan JWT token
// POST /api/logout: Untuk logout (dengan menyertakan token)
// GET /api/me: Untuk mendapatkan data user yang sedang login (dengan menyertakan token)

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);

// Protected routes (using JWT middleware)
Route::middleware('auth:api')->group(function () {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::get('me', [AuthController::class, 'me']);
});




//detection
Route::apiResource('/detections', App\Http\Controllers\Api\DetectionController::class);
//history
Route::apiResource('/history', App\Http\Controllers\Api\HistoryController::class);


