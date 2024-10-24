<?php
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;

// Route untuk registrasi
Route::post('/register', [RegisteredUserController::class, 'store']);

// Route untuk login
Route::post('/login', [AuthenticatedSessionController::class, 'store']);

// Route untuk logout
// Route::post('/logout', [AuthenticatedSessionController::class, 'destroy'])
//      ->middleware('auth:sanctum'); // Jika menggunakan Sanctum

Route::post('/logout', [AuthenticatedSessionController::class, 'destroy']);
// routes/api.php
Route::get('/test-connection', function () {
    return response()->json([
        'message' => 'API Connection successful!',
        'status' => 200,
        'timestamp' => now()
    ]);
});


// routes User
Route::get('/users', [UserController::class, 'index']);
Route::get('/users/{id}', [UserController::class, 'show']);
Route::post('/users', [UserController::class, 'store']);
Route::put('/users/{id}', [UserController::class, 'update']);
Route::delete('/users/{id}', [UserController::class, 'destroy']);


// routes DiseaseData