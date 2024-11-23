<?php

use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\DiseaseController;
use App\Http\Controllers\PredictionController;
use Illuminate\Support\Facades\Route;

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

// Route untuk mengupdate profil pengguna yang sedang login
Route::put('/profile', [AuthenticatedSessionController::class, 'updateProfile']);

// Route untuk mengupdate password pengguna yang sedang login
Route::put('/update-password', [AuthenticatedSessionController::class, 'updatePassword']);

// Route untuk mengambil data penyakit
Route::get('/diseases', [DiseaseController::class, 'index']);
Route::get('/diseases/{id}', [DiseaseController::class, 'show']);

Route::post('/predict', [PredictionController::class, 'predict']);