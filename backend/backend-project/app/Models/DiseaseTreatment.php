<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class DiseaseTreatment extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'disease_treatments';
    protected $primaryKey = 'disease_treatments_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'disease_treatments_id',
        'disease_id',
        'description', 
        'symptoms',     
        'solutions',    
        'prevention',   
    ];

    public function disease()
    {
        return $this->belongsTo(Disease::class, 'disease_id', 'disease_id');
    }
}
