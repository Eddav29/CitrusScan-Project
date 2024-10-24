<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class History extends Model
{
    use HasFactory;

    protected $table = 'history';
    protected $primaryKey = 'history_id';
    protected $fillable = [
        'user_id',
        'detection_id',
        'saved_at',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function detection()
    {
        return $this->belongsTo(Detection::class, 'detection_id', 'detection_id');
    }
}
