<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Laravel\Socialite\Facades\Socialite;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class GoogleController extends Controller
{
    public function redirectToGoogle()
    {
        

        return Socialite::driver('google')->stateless()->redirect();
    }

    public function handleGoogleCallback()
    {
        try {
            // Mendapatkan user dari Google
            $googleUser = Socialite::driver('google')->stateless()->user();

            // Temukan atau buat pengguna berdasarkan email dari Google
            $user = User::updateOrCreate(
                ['email' => $googleUser->getEmail()],
                [
                    'name' => $googleUser->getName(),
                    'google_id' => $googleUser->getId(),
                    'profile_picture' => $googleUser->getAvatar(),
                    'password' => bcrypt('default_password'), // Tambahkan password default
                ]
            );

            // Buat token untuk user
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'access_token' => $token,
                'token_type' => 'Bearer',
                'user' => $user,
                'status' => 'Login successful'
            ], 200);

        } catch (\Exception $e) {
            \Log::error('Google Authentication Failed:', ['message' => $e->getMessage()]);
            return response()->json(['error' => 'Authentication Failed'], 401);
        }
    }
}
