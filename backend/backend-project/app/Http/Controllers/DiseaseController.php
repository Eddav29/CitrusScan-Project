<?php

namespace App\Http\Controllers;

use App\Models\DiseaseData;
use Illuminate\Http\Request;
use App\Http\Resources\DiseaseResource;

class DiseaseController extends Controller
{
    public function index()
    {
        $diseases = DiseaseData::all();

        return response()->json([
            'success' => true,
            'message' => 'Diseases fetched successfully',
            'data'    => DiseaseResource::collection($diseases),
        ], 200); // Status 200 OK
    }

    public function show($id)
    {
        $disease = DiseaseData::find($id);

        if ($disease) {
            return response()->json([
                'success' => true,
                'message' => 'Disease found successfully',
                'data'    => new DiseaseResource($disease),
            ], 200); // Status 200 OK
        }

        return response()->json([
            'success' => false,
            'message' => 'Disease not found',
        ], 404); // Status 404 Not Found
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'disease_name'   => 'required|string',
            'description'    => 'required|string',
            'symptoms'       => 'required|string',
            'prevention'     => 'required|string',
        ]);

        $disease = DiseaseData::create($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'Disease created successfully',
            'data'    => new DiseaseResource($disease),
        ], 201); // Status 201 Created
    }

    public function update(Request $request, $id)
    {
        $disease = DiseaseData::find($id);

        if (!$disease) {
            return response()->json([
                'success' => false,
                'message' => 'Disease not found',
            ], 404); // Status 404 Not Found
        }

        $validatedData = $request->validate([
            'disease_name'   => 'sometimes|string',
            'description'    => 'sometimes|string',
            'symptoms'       => 'sometimes|string',
            'prevention'     => 'sometimes|string',
        ]);

        $disease->update($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'Disease updated successfully',
            'data'    => new DiseaseResource($disease),
        ], 200); // Status 200 OK
    }

    public function destroy($id)
    {
        $disease = DiseaseData::find($id);

        if (!$disease) {
            return response()->json([
                'success' => false,
                'message' => 'Disease not found',
            ], 404); // Status 404 Not Found
        }

        $disease->delete();

        return response()->json([
            'success' => true,
            'message' => 'Disease deleted successfully',
        ], 200); // Status 200 OK
    }
}
