<script setup>
import { ref } from 'vue'
import VehicleCard from './components/VehicleCard.vue'
import { Carousel, Navigation, Slide } from 'vue3-carousel';
import 'vue3-carousel/dist/carousel.css';

const myCarousel = ref(null)
const currentClass = ref('all')
const vehicles = []

const classNames = [
  { id: 'all', name: 'All Classes'},
  { id: '', name: 'Compact'},
  { id: '', name: 'Coupe'},
  { id: '', name: 'Muscle'},
  { id: '', name: 'Off-Road'},
  { id: '', name: 'Open Wheel'},
  { id: '', name: 'Sedan'},
  { id: '', name: 'Sports'},
  { id: '', name: 'Sports Classic'},
  { id: '', name: 'Super'},
  { id: '', name: 'SUV'},
  { id: '', name: 'Tuner'},
  { id: '', name: 'Van'},
  { id: '', name: 'Utility'},
]

const slide = (right = true) => right ? myCarousel.value.next() : myCarousel.value.prev();
</script>

<template>
  <div class="absolute flex flex-col items-center justify-center mx-auto h-full w-full">
    <div class="w-[85%] flex justify-end mb-5">
      <p>
        <select v-model.trim="currentClass" class="arrows bg-[#00000066] pl-4 pr-12 py-2 font-medium text-neutral-400 rounded-md duration-150 hover:bg-[#000000A6] outline-0 shadow">
          <option class="bg-neutral-800 bg-opacity-80 font-light text-medium" :value="vehClass.id" v-for="vehClass in classNames">
            {{ vehClass.name }}
          </option>
        </select>
      </p>
    </div>
    <div class="flex justify-center items-center w-full">
      <i @click="slide(false)" class="cursor-pointer z-10 fas fa-chevron-left text-[#FFFFFF89] text-4xl duration-150 hover:scale-105"></i>
      <Carousel class="w-[90%]" ref="myCarousel" :itemsToShow="4" :itemsToScroll="1" :snapAlign="'start'">
        <Slide v-for="slide in 7" :key="slide">
          <VehicleCard/>
        </Slide>
      </Carousel>
      <i @click="slide" class="cursor-pointer z-10 fas fa-chevron-right text-[#FFFFFF89] text-4xl duration-150 hover:scale-105"></i>

    </div>
  </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap');

select {
  display: inline-block;
  position: relative;

  border: none;

  box-sizing: border-box;
  -webkit-appearance: none;
  -moz-appearance: none;
}

select.arrows {
  background-image: url('https://raw.githubusercontent.com/RockySouthpaw/new-garage-who-dis/e162b2d94612108a1abd5afa2b1daed54997d382/html/img/arrows.png');
  background-position: calc(100% - .50vh), 100% 0;
  background-repeat: no-repeat;
  background-size: 2.5vh;
}
</style>
