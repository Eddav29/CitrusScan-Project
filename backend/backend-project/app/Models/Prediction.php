<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Prediction extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'predictions';
    protected $primaryKey = 'prediction_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'prediction_id',
        'disease_id',
        'confidence',
    ];

    public function disease()
    {
        return $this->belongsTo(Disease::class, 'disease_id', 'disease_id');
    }

    public function probabilities()
    {
        return $this->hasMany(AllProbability::class, 'prediction_id', 'prediction_id');
    }

    public function userHistories()
    {
        return $this->hasMany(UserHistory::class, 'prediction_id', 'prediction_id');
    }
}