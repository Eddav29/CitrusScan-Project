<?php
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\DiseaseController;
use App\Http\Controllers\DetectionsController;
use App\Http\Controllers\HistoryController;
use App\Http\Controllers\Auth\GoogleController;
Route::get('/test-connection', function () {
    return response()->json([
        'message' => 'API Connection successful!',
        'status' => 200,
        'timestamp' => now()
    ]);
});

// Route untuk registrasi
Route::post('/register', [RegisteredUserController::class, 'store']);
// Route untuk login
Route::post('/login', [AuthenticatedSessionController::class, 'store']);
// Route untuk logout
Route::post('/logout', [AuthenticatedSessionController::class, 'destroy']);

// Route untuk mengambil profil pengguna yang sedang login
Route::get('/profile', [AuthenticatedSessionController::class, 'profile']);


Route::get('google', [GoogleController::class, 'redirectToGoogle']);
Route::get('google/callback', [GoogleController::class, 'handleGoogleCallback']);

Route::apiResource('users', UserController::class);
Route::apiResource('disease', DiseaseController::class);
Route::apiResource('detection', DetectionsController::class);
Route::apiResource('history', HistoryController::class);