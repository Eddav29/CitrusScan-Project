<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class DiseaseResource extends JsonResource
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
            'disease_id' => $this->disease_id,
            'name' => $this->name,
            'description' => $this->description,
            'treatment' => $this->treatment,
            'created_at' => Carbon::parse($this->created_at)->translatedFormat('d F Y'),
            'updated_at' => Carbon::parse($this->updated_at)->translatedFormat('d F Y'),
        ];
    }
}