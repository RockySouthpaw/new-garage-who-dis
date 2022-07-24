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

const elImg = ref(null)

const newImage = () => {

}

const sellVehicle = (id) => {
  fetchNui('sell_vehicle', {}).then(() => {
    if (success) {
      console.log('Vehicle sold')
    } else {
      console.log('Vehicle sell failed')
    }
  })
}

const spawnVehicle = (id) => {
  fetchNui('spawn_vehicle', {}).then(() => {
    if (success) {
      console.log('Vehicle spawned')
    } else {
      console.log('Vehicle spawn failed')
    }
  })
}

const checkImage = (image) => {
  // check if the image is a valid url
  if (image && image.startsWith('https')) {
    return image
  }
  return 'https://media.discordapp.net/attachments/784247486427693057/998683346920030208/noimage.png'
}
</script>

<template>
  <div class="h-[34em] bg-[#333333E6] shadow w-80 rounded-xl overflow-hidden flex flex-col justify-evenly items-center">
    <img ref="elImg" class="w-full h-48" :src="checkImage(vehicle.preview)" alt="Vehicle image">
    <div class="grid grid-rows-3 grid-cols-2 mt-2 text-lg">
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Model</span>
        <span class="font-light">{{ vehicle }}</span>
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
        <span class="font-light">{{ vehicle.plate }}</span>
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
    <span class="text-xl text-neutral-400 w-4/5 font-medium">Purchased on {{ vehicle.purchased }}</span>
    <div class="flex justify-center mb-2 mt-2 w-full font-semibold flex-wrap">
      <button @click="sellVehicle(vehicle.id)" class="w-2/5 h-10 mr-1 bg-[#5E1515] shadow rounded duration-150 hover:bg-[#6E1515]">Sell Vehicle</button>
      <button @click="$emit('newImage', vehicle.id)" class="w-2/5 h-10 ml-2 bg-[#0F501E] shadow rounded duration-150 hover:bg-[#0F601E]">New Photo</button>
      <button @click="spawnVehicle(vehicle.id)" class="w-5/6 h-10 mt-2 bg-[#0F1650] shadow rounded duration-150 font-bold hover:bg-[#0F1660]">Spawn Vehicle</button>
    </div>
  </div>
</template>