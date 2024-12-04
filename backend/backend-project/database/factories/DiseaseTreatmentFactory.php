<?php
namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class DiseaseTreatmentFactory extends Factory
{
    protected $model = \App\Models\DiseaseTreatment::class;

    public function definition()
    {
        return [
            'disease_treatments_id' => Str::uuid(),
            'disease_id' => \App\Models\Disease::factory(),
            'step' => $this->faker->numberBetween(1, 10),
            'action' => $this->faker->sentence,
        ];
    }
}
