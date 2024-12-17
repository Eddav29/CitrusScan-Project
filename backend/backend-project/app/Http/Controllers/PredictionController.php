<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Prediction;
use App\Models\UserHistory;
use App\Models\User;
use App\Models\Disease; // Pastikan model Disease di-import

class PredictionController extends Controller
{
    public function predict(Request $request)
    {
        // Validasi input (file gambar wajib)
        $request->validate([
            'file' => 'required|image|mimes:jpeg,png,jpg|max:2048',
            'user_id' => 'required|uuid',
        ]);

        // Simpan gambar ke folder storage/app/public/uploads
        $imagePath = $request->file('file')->store('uploads', 'public');
        $response = Http::attach(
            'file', file_get_contents(storage_path('app/public/' . $imagePath)), $request->file('file')->getClientOriginalName()
        )->post('http://127.0.0.1:5001/predict');
        
        if ($response->failed()) {
            return response()->json([
                'message' => 'Failed to connect to the model API',
                'details' => $response->body() ?: 'No response body'
            ], 404);
        }

        //jika bukan daun jeruk
        if ($response->json()['predicted_class'] == 'Non-Daun') {
            return response()->json([
                'message' => 'Prediction successful',
                'data' => [
                    'prediction_id' => \Str::uuid(),
                    'disease_id' => $this->getDiseaseIdByName($response->json()['predicted_class']),
                    'disease' => 'Not Citrus Leaf',
                    'confidence' => 1,
                    'second_best' => null,
                    'image_path' => asset('storage/' . $imagePath),
                ],
            ], 200);
        } else {
            // Kirim gambar ke API model
            $response = Http::attach(
                'file', file_get_contents(storage_path('app/public/' . $imagePath)), $request->file('file')->getClientOriginalName()
            )->post('http://127.0.0.1:5000/predict');
            
            if ($response->failed()) {
                return response()->json([
                    'message' => 'Failed to connect to the model API',
                    'details' => $response->body() ?: 'No response body'
                ], 404);
            }

            $responseData = $response->json();

            // Ambil data prediksi
            $prediction = $responseData['predictions']['predicted_class'] ?? null;
            $confidence = $responseData['predictions']['confidence'] ?? null;
            $allProbabilities = $responseData['predictions']['all_probabilities'] ?? [];

            // Ambil penyakit dengan probabilitas tertinggi kedua
            $secondBest = collect($allProbabilities)
                ->sortDesc()
                ->skip(1)
                ->map(function ($value, $key) {
                    return ['name' => $key, 'confidence' => $value];
                })
                ->first();

            // Simpan data ke tabel predictions
            $predictionRecord = Prediction::create([
                'prediction_id' => \Str::uuid(),
                'disease_id' => $this->getDiseaseIdByName($prediction),
                'confidence' => $confidence,
                'second_best_disease' => $this->getDiseaseIdByName($secondBest['name'] ?? null),
                'second_best_disease_confidence' => $secondBest['confidence'] ?? null,
            ]);

            // Mengambil data penyakit berdasarkan prediction_id
            $disease = Disease::with('treatments')->find($predictionRecord->disease_id);

            // Menambahkan informasi treatment pada response
            $treatmentData = $disease ? $disease->treatments->map(function ($treatment) {
                return [
                    'description' => $treatment->description,
                    'symptoms' => $treatment->symptoms,
                    'solutions' => $treatment->solutions,
                    'prevention' => $treatment->prevention,
                ];
            }) : [];

            $user = User::find($request->user_id);

            if (!$user) {
                return response()->json(['message' => 'User not found'], 404);
            }

            // Simpan riwayat pengguna
            UserHistory::create([
                'user_histories_id' => \Str::uuid(),
                'user_id' => $request->user_id,
                'prediction_id' => $predictionRecord->prediction_id,
                'image_path' => $imagePath,
                'created_at' => now(),
            ]);

            return response()->json([
                'message' => 'Prediction successful',
                'data' => [
                    'prediction_id' => $predictionRecord->prediction_id,
                    'disease_id' => $predictionRecord->disease_id,
                    'disease' => $prediction,
                    'confidence' => $confidence,
                    'second_best' => $secondBest,
                    'image_path' => asset('storage/' . $imagePath),
                    'treatment' => $treatmentData, // Tambahkan informasi treatment
                ],
            ], 200);
        }
    }

    // Helper function untuk mendapatkan disease_id dari nama penyakit
    private function getDiseaseIdByName($diseaseName)
    {
        // Pemetaan nama penyakit dari API ke tabel diseases
        $diseaseMapping = [
            'Canker' => 'Canker',
            'Greening' => 'Greening',
            'Black spot' => 'Black Spot',
            'Melanose' => 'Melanose',
            'Healthy' => "Healthy",
            'Non-Daun' => 'Not Citrus Leaf',
        ];

        // Ganti nama penyakit sesuai dengan tabel, jika ada
        $normalizedDiseaseName = $diseaseMapping[$diseaseName] ?? $diseaseName;

        $diseaseId = \DB::table('diseases')->where('name', $normalizedDiseaseName)->value('disease_id');

        return $diseaseId;
    }
}

