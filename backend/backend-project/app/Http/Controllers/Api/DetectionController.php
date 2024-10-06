<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\detections;
use App\Http\Resources\DetectionResource;
use Illuminate\Support\Facades\Validator;

class DetectionController extends Controller
{
    //
    public function index()
    {
        $detections = Detections::all();
        return new DetectionResource(true, 'Detections retrieved successfully', $detections);
    }

    //insert
    public function store(){
        
        $user_id=auth()->user()->user_id;
        $validator = Validator::make(request()->all(), [
            'user_id' => 'required',
            'image' => 'required',
            'result' => 'required',
        ]);
        
        if($validator->fails()){
            return new DetectionResource(false, $validator->errors(), null);
        }

        $image = $request->file('image');
        $image->storeAs('public/images', $image->hashName());

        $detection = new Detections();
        $detection->user_id = request('user_id');
        $detection->image = $image->hashName();
        $detection->result = request('result');
        $detection->save();

        return new DetectionResource(true, 'Detection saved successfully', $detection);
    }
}
