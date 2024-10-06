<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\history;
use App\Http\Resources\HistoryResource;

class HistoryController extends Controller
{
    //
    public function index()
    {
        $histories = history::latest()->pagination(5);
        return new HistoryResource(true, 'Histories retrieved successfully', $histories);
    }

    
}
