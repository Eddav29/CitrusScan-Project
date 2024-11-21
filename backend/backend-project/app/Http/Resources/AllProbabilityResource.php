<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class AllProbabilityResource extends JsonResource
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
            'all_probabilities_id' => $this->all_probabilities_id,
            'prediction_id' => $this->prediction_id,
            'disease_id' => $this->disease_id,
            'probability' => $this->probability,
            'created_at' => Carbon::parse($this->created_at)->translatedFormat('d F Y'),
            'updated_at' => Carbon::parse($this->updated_at)->translatedFormat('d F Y'),
        ];
    }
}