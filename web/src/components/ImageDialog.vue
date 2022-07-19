<script setup>
import { ref } from 'vue'
const newImage = ref('')
</script>

<template>
  <div class="bg-black bg-opacity-70 w-full h-full absolute grid place-items-center z-50">
    <div class="bg-neutral-800 w-96 rounded bg-opacity-90 flex flex-col justify-evenly shadow border-b-2 border-r-2 border-neutral-900 border-opacity-90">
      <span class="text-neutral-300 font-bold text-xl ml-4 mt-3 text-left">Image URL</span>
      <input type="text" v-model.trim="newImage" class="rounded-sm bg-transparent border-b mt-1 py-1 mx-4 font-extralight text-md text-neutral-400 appearance-none px-2 outline-0" placeholder="https://yourlink.com/image.png"/>
      <div class="flex justify-end items-center gap-2 mr-4 my-2">
        <button @click="$emit('exit')" class="w-8 h-8 bg-[#5E1515] grid place-items-center rounded shadow-sm duration-150 hover:bg-[#6E1515]">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
        <button @click="$emit('new', newImage)" class="w-8 h-8 bg-[#0F501E] grid place-items-center rounded shadow-sm duration-150 hover:bg-[#0F601E]">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>