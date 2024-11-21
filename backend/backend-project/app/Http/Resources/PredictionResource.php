<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class PredictionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        Carbon::setLocale('id'); // Set locale to Indonesian

        return [
            'prediction_id' => $this->prediction_id,
            'disease_id' => $this->disease_id,
            'confidence' => $this->confidence,
            'created_at' => Carbon::parse($this->created_at)->translatedFormat('d F Y'),
            'updated_at' => Carbon::parse($this->updated_at)->translatedFormat('d F Y'),
        ];
    }
}