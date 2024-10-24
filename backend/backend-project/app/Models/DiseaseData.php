<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CitrusData extends Model
{
    use HasFactory;


    protected $table = 'citrus_data';
    protected $primaryKey = 'disease_id';
    protected $fillable = [
        'disease_id',
        'disease_name',
        'description',
        'symptoms',
        'prevention',
    ];

}
