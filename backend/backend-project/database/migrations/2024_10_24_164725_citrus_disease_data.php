<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        //
        Schema::create('citrus_disease_data', function (Blueprint $table) {
            $table->uuid('disease_id')->primary();
            $table->string('disease_name');
            $table->text('description');
            $table->string('symptoms');
            $table->string('prevention');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
        Schema::dropIfExists('citrus_disease_data');
    }
};
