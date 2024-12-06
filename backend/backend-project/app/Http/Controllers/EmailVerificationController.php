<?php
use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Verified;
use Illuminate\Http\Request;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Support\Facades\Log; // Tambahkan ini

class EmailVerificationController extends Controller
{
    /**
     * Send a new email verification notification.
     */
    public function sendVerificationNotification(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        Log::info($token); // Gunakan Log yang benar
        $accessToken = PersonalAccessToken::findToken($token);
        Log::info($accessToken);

        // Validasi apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['message' => 'User not authenticated'], 401);
        }

        // Ambil user dari token
        $user = $accessToken->tokenable;

        // Periksa apakah email sudah terverifikasi
        if ($user->email_verified_at !== null) {
            return response()->json(['message' => 'Email already verified'], 200);
        }

        // Kirim notifikasi verifikasi email
        $user->sendEmailVerificationNotification();

        return response()->json(['message' => 'Verification link sent'], 200);
    }

    /**
     * Mark the authenticated user's email address as verified.
     */
    public function verifyEmail(Request $request)
    {
        // Ambil token dari header Authorization
        $token = $request->bearerToken();
        Log::info($token); // Gunakan Log yang benar
        $accessToken = PersonalAccessToken::findToken($token);
        Log::info($accessToken);

        // Validasi apakah token valid
        if (!$accessToken || !$accessToken->tokenable) {
            return response()->json(['message' => 'User not authenticated'], 401);
        }

        // Ambil user dari token
        $user = $accessToken->tokenable;

        // Periksa apakah email sudah terverifikasi
        if ($user->hasVerifiedEmail()) {
            return response()->json(['message' => 'Email already verified'], 200);
        }

        // Tandai email sebagai terverifikasi
        if ($user->markEmailAsVerified()) {
            event(new Verified($user));
        }

        return response()->json(['message' => 'Email has been verified'], 200);
    }
}
