<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Disease extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'diseases';
    protected $primaryKey = 'disease_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'disease_id',
        'name',
        'description',
        'treatment',
    ];

    public function treatments()
    {
        return $this->hasMany(DiseaseTreatment::class, 'disease_id', 'disease_id');
    }

    public function predictions()
    {
        return $this->hasMany(Prediction::class, 'disease_id', 'disease_id');
    }
}