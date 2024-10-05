<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\detections;
use App\Http\Resources\DetectionResource;

class DetectionController extends Controller
{
    //
    public function index()
    {
        $detections = Detections::all();
        return new DetectionResource(true, 'Detections retrieved successfully', $detections);
    }
}
