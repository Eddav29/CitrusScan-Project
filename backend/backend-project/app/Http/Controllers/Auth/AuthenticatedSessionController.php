<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
class AuthenticatedSessionController extends Controller
{
    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request)
    {
        $request->authenticate();
        
        $user = Auth::user();
        $token = $user->createToken('auth_token')->plainTextToken;  

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user,
            'status' => 'Login successful',
        ], 200); // HTTP 200 OK
    }


    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request)
    {
        $user = Auth::guard('sanctum')->user(); // Manually check if user is authenticated

        if (!$user) {
            return response()->json(['error' => 'User not authenticated or token is invalid'], 401);
        }

        // Delete the user's current access token
        $user->currentAccessToken()->delete();

        // Invalidate the session and regenerate CSRF token
        // $request->session()->invalidate();
        // $request->session()->regenerateToken();

        return response()->json(['message' => 'Logout successful']);
    }

    public function profile(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        \Log::info($token);
        $accessToken = PersonalAccessToken::findToken($token);
        \Log::info($accessToken);
        // Periksa apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }
    
        // Ambil pengguna dari token
        $user = $accessToken->tokenable;
    
        return response()->json(['user' => $user], 200);
    }

    public function updateProfile(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        \Log::info($token);
        $accessToken = PersonalAccessToken::findToken($token);
        \Log::info($accessToken);

        // Periksa apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }

        // Ambil pengguna dari token
        $user = $accessToken->tokenable;

        // Validasi input
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $user->getKey() . ',user_id', 
        ]);

        // Update pengguna
        if ($request->has('name')) {
            $user->name = $request->input('name');
        }
        if ($request->has('email')) {
            $user->email = $request->input('email');
        }
        $user->save();

        return response()->json(['user' => $user], 200);
    }

        public function updatePassword(Request $request)
        {
            // Ambil token dari header Authorization
            $token = $request->bearerToken();
            \Log::info("yang diterima ".$token);
            $accessToken = PersonalAccessToken::findToken($token);
            \log::info($accessToken->tokenable);
            // Periksa apakah token valid
            if (!$accessToken || !$accessToken->tokenable) {
                return response()->json(['error' => 'User not authenticated'], 401);
            }

            // Ambil pengguna dari token
            $user = $accessToken->tokenable;

            // Validasi input
            $request->validate([
                'old_password' => 'required',
                'new_password' => 'required|min:8|confirmed',
                'new_password_confirmation' => 'required',
            ]);

            // Periksa apakah password lama benar
            if (!Hash::check($request->old_password, $user->password)) {
                return response()->json(['error' => 'Old password is incorrect'], 400);
            }

            // Update password
            $user->password = Hash::make($request->new_password);
            $user->save();

            return response()->json(['message' => 'Password updated successfully'], 200);
        }
    
    //update profile_picture
    public function updateProfilePicture(Request $request)
    {
        // Ambil token dari header Authorization
    $token = $request->bearerToken();
    $accessToken = PersonalAccessToken::findToken($token);

    // Periksa apakah token valid
    if (!$accessToken || !$accessToken->tokenable) {
        return response()->json(['error' => 'User not authenticated'], 401);
    }

    // Ambil pengguna dari token
    $user = $accessToken->tokenable;

    // Validasi input
    $request->validate([
        'profile_picture' => 'required|image|mimes:jpeg,png,jpg|max:2048',
    ]);

    // Simpan path gambar lama
    $oldProfilePicturePath = $user->profile_picture;

    // Pastikan file yang di-upload adalah gambar yang valid
    $profilePicture = $request->file('profile_picture');
    if ($profilePicture && $profilePicture->isValid()) {
        // Menyimpan gambar baru
        $profilePicturePath = $profilePicture->store('profile_pictures', 'public');
        $user->profile_picture = $profilePicturePath;
        $user->save();

        // Hapus file lama jika ada
        if ($oldProfilePicturePath && Storage::disk('public')->exists($oldProfilePicturePath)) {
            Storage::disk('public')->delete($oldProfilePicturePath);
        }

        return response()->json(['user' => $user], 200);
    } else {
        return response()->json(['error' => 'Invalid image file'], 400);
    }

    }
    
}
