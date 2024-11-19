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
        // Tabel untuk data penyakit
        Schema::create('diseases', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->text('description')->nullable();
            $table->text('treatment')->nullable();
            $table->timestamps();
        });

        // Tabel untuk langkah perawatan penyakit
        Schema::create('disease_treatments', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('disease_id');
            $table->integer('step'); // Urutan langkah
            $table->text('action'); // Deskripsi langkah
            $table->timestamps();

            // Relasi ke tabel diseases
            $table->foreign('disease_id')->references('id')->on('diseases')->onDelete('cascade');
        });

        // Tabel untuk prediksi penyakit
        Schema::create('predictions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('predicted_class'); // Nama penyakit hasil prediksi
            $table->float('confidence'); // Confidence level
            $table->timestamps();
        });

        // Tabel untuk probabilitas prediksi penyakit
        Schema::create('all_probabilities', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('prediction_id'); // Relasi ke prediksi
            $table->string('disease_name'); // Nama penyakit
            $table->float('probability'); // Probabilitas
            $table->timestamps();

            // Relasi ke tabel predictions
            $table->foreign('prediction_id')->references('id')->on('predictions')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Drop tables in reverse order to avoid foreign key constraint issues
        Schema::dropIfExists('all_probabilities');
        Schema::dropIfExists('predictions');
        Schema::dropIfExists('disease_treatments');
        Schema::dropIfExists('diseases');
    }
};
