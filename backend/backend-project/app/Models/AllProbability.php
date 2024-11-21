<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class AllProbability extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'all_probabilities';
    protected $primaryKey = 'all_probabilities_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'all_probabilities_id',
        'prediction_id',
        'disease_id',
        'probability',
    ];

    public function prediction()
    {
        return $this->belongsTo(Prediction::class, 'prediction_id', 'prediction_id');
    }

    public function disease()
    {
        return $this->belongsTo(Disease::class, 'disease_id', 'disease_id');
    }
}