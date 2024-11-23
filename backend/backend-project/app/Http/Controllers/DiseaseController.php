<?php

namespace App\Http\Controllers;

use App\Models\Disease;
use App\Models\DiseaseTreatment;
use Illuminate\Http\Request;

class DiseaseController extends Controller
{
    // 1. Menampilkan daftar nama penyakit saja
    public function index()
    {
        $diseases = Disease::all(['disease_id', 'name','created_at','updated_at']);
        return response()->json($diseases, 200);
    }

    // 2. Menampilkan detail penyakit beserta langkah perawatannya
    public function show($id)
{
    $disease = Disease::with('treatments')->find($id);

    if (!$disease) {
        return response()->json(['message' => 'Disease not found'], 404);
    }

    

    return response()->json([
        'name' => $disease->name,
        'description' => $disease->description,
        'treatment' => $disease->treatment,
        'steps' => $disease->treatments->map(function ($treatment) {
            return [
                'step' => $treatment->step,
                'action' => $treatment->action,
            ];
        }),
    ]);
}

}
