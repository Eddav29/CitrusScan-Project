<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prediction extends Model
{
    use HasFactory;

    protected $primaryKey = 'prediction_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'prediction_id',
        'disease_id',
        'second_best_disease',
        'confidence',
        'second_best_disease_confidence',
    ];
}
