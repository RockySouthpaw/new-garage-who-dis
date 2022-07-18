<script setup>
import { ref } from 'vue'
defineProps({
  slide: {
    type: Number,
    default: 0,
  },
})
</script>

<template>
  <div class="h-[34em] bg-[#333333E6] shadow w-80 rounded-xl overflow-hidden flex flex-col justify-evenly items-center">
    <img class="w-full mt-1" src="https://th.bing.com/th/id/OIP.X9M_lhLSvfjaOOf2XbN7aAHaEK?pid=ImgDet&rs=1" alt="Vehicle image">
    <div class="grid grid-rows-3 grid-cols-2 mt-2 text-lg">
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Model</span>
        <span class="font-light">Turismo R</span>
      </div>
      <div class="font-medium flex flex-col text-start ml-6">
        <span class="text-neutral-400">Garage</span>
        <span class="font-light">Pink Cage</span>
      </div>
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Class</span>
        <span class="font-light">Sports</span>
      </div>
      <div class="font-medium flex flex-col text-start ml-6">
        <span class="text-neutral-400">License Plate</span>
        <span class="font-light">47ZUV509</span>
      </div>
      <div class="font-medium flex flex-col text-start">
        <span class="text-neutral-400">Engine State</span>
        <span class="font-light">Severe</span>
      </div>
      <div class="font-medium flex flex-col text-start ml-6">
        <span class="text-neutral-400">Body State</span>
        <span class="font-light">Severe</span>
      </div>
    </div>
    <div class="text-xl text-neutral-400 w-4/5 font-medium">Purchased on Thursday, March 5th</div>
    <div class="flex justify-center mb-2 mt-2 w-full font-semibold flex-wrap">
      <button class="w-2/5 h-10 mr-1 bg-[#5E1515] shadow rounded duration-150 hover:bg-[#6E1515]">Sell Vehicle</button>
      <button class="w-2/5 h-10 ml-2 bg-[#0F501E] shadow rounded duration-150 hover:bg-[#0F601E]">New Photo</button>
      <button class="w-5/6 h-10 mt-2 bg-[#0F1650] shadow rounded duration-150 font-bold hover:bg-[#0F1660]">Spawn Vehicle</button>
    </div>
  </div>
</template>

<style>

</style>