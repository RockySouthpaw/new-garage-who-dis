<script setup>
import { ref } from 'vue'
defineProps({
  vehicle: {
    type: Object,
    required: true,
  },
  vehicleClass: {
    type: String,
    required: true,
  },
})

const checkImage = (image) => {
  // check if the image is a valid url
  if (image && image.startsWith('https')) {
    return image
  }
  return 'https://media.discordapp.net/attachments/784247486427693057/998683346920030208/noimage.png'
}
</script>

<template>
  <div class="h-[34em] bg-[#1C0000] shadow w-80 rounded-xl overflow-hidden flex flex-col justify-evenly items-center">
    <div class="w-full h-48 relative mt-2">
      <img class="absolute h-full w-full" :src="checkImage(vehicle.image)" alt="Vehicle image">
      <img class="absolute h-full w-full" src="https://cdn.discordapp.com/attachments/784247486427693057/999060015581245631/unknown.png" alt="Impounded">
    </div>
    <div class="grid grid-rows-3 grid-cols-2 mt-2 text-lg">
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Model</span>
        <span class="font-light">{{ vehicle.model }}</span>
      </div>
      <div class="font-medium flex flex-col text-start ml-6">
        <span class="text-neutral-400">Garage</span>
        <span class="font-light">{{ vehicle.garage }}</span>
      </div>
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Class</span>
        <span class="font-light">{{ vehicleClass }}</span>
      </div>
      <div class="font-medium flex flex-col text-start ml-6">
        <span class="text-neutral-400">License Plate</span>
        <span class="font-light">{{ vehicle.licensePlate }}</span>
      </div>
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Engine State</span>
        <span class="font-light">{{ vehicle.engineState }}</span>
      </div>
      <div class="font-medium flex flex-col text-start ml-6">
        <span class="text-neutral-400">Body State</span>
        <span class="font-light">{{ vehicle.bodyState }}</span>
      </div>
    </div>
    <span class="text-xl text-neutral-400 w-4/5 font-medium">Impounded on {{ vehicle.purchased }}</span>
    <div class="flex justify-center mb-2 mt-2 w-full font-semibold flex-wrap">
      <button @click="spawnVehicle(vehicle.id)" class="w-5/6 h-10 mt-2 bg-[#5B1616] shadow rounded duration-150 font-bold hover:bg-[#6B1616]">30 Hours Remaining</button>
      <button @click="spawnVehicle(vehicle.id)" class="w-5/6 h-10 mt-2 bg-[#333333] shadow rounded duration-150 font-bold hover:bg-[#444444]">Release Vehicle</button>
    </div>
  </div>
</template>