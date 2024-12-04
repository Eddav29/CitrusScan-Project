<?php
namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class DiseaseFactory extends Factory
{
    protected $model = \App\Models\Disease::class;

    public function definition()
    {
        return [
            'disease_id' => Str::uuid(),
            'name' => $this->faker->word,
            'description' => $this->faker->sentence,
            'treatment' => $this->faker->sentence,
        ];
    }
}
