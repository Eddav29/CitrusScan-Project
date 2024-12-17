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
            $table->uuid('disease_id')->primary();
            $table->string('name');
            $table->text('treatment')->nullable();
            $table->string('disease_image')->nullable();
            $table->timestamps();
        });

        // Tabel untuk langkah perawatan penyakit
        Schema::create('disease_treatments', function (Blueprint $table) {
            $table->uuid('disease_treatments_id')->primary();
            $table->uuid('disease_id');
            $table->text('description'); // Deskripsi langkah perawatan
            $table->text('symptoms'); // Gejala penyakit
            $table->text('solutions'); // Solusi perawatan
            $table->text('prevention'); // Pencegahan penyakit
            $table->timestamps();

            // Relasi ke tabel diseases
            $table->foreign('disease_id')->references('disease_id')->on('diseases')->onDelete('cascade');
        });


        // Tabel untuk prediksi penyakit
        Schema::create('predictions', function (Blueprint $table) {
            $table->uuid('prediction_id')->primary();
            $table->uuid('disease_id')->nullable(); // Penyakit dengan probabilitas tertinggi
            $table->uuid('second_best_disease')->nullable(); // Penyakit kedua (opsional)
            $table->float('confidence'); // Probabilitas tertinggi
            $table->uuid('second_best_disease_confidence'); // Probabilitas kedua (opsional)
            $table->timestamps();

            // Relasi ke tabel diseases
            $table->foreign('disease_id')->references('disease_id')->on('diseases')->onDelete('set null');
            $table->foreign('second_best_disease')->references('disease_id')->on('diseases')->onDelete('set null');
        });

        // Tabel untuk riwayat pengguna
        Schema::create('user_histories', function (Blueprint $table) {
            $table->uuid('user_histories_id')->primary(); // ID unik untuk riwayat
            $table->uuid('user_id'); // Referensi ke tabel users
            $table->uuid('prediction_id'); // Referensi ke tabel predictions
            $table->text('image_path'); // Lokasi gambar yang diunggah pengguna
            $table->timestamp('created_at');// Waktu unggah gambar
            $table->timestamp('updated_at')->nullable();
            // Foreign keys
            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
            $table->foreign('prediction_id')->references('prediction_id')->on('predictions')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Drop tables in reverse order to avoid foreign key constraint issues
        Schema::dropIfExists('user_histories');
        Schema::dropIfExists('predictions');
        Schema::dropIfExists('disease_treatments');
        Schema::dropIfExists('diseases');
    }
};
