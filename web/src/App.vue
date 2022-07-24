<script setup>
import {ref, computed, onMounted, onUnmounted} from 'vue'
import VehicleCard from './components/VehicleCard.vue'
import ImpoundCard from './components/ImpoundCard.vue'
import ImageDialog from './components/ImageDialog.vue'
import { Carousel, Slide } from 'vue3-carousel';
import 'vue3-carousel/dist/carousel.css';

const activeDialog = ref(false)
const activeGarage = ref(false)
const myCarousel = ref(null)
const currentClass = ref('all')
const currentData = ref({
  id: 0,
  url: '',
})
const vehicles = ref([])
const classNames = [
  { id: 'all', name: 'All Classes'},
  { id: 0, name: 'Compact'},
  { id: 1, name: 'Coupe'},
  { id: 2, name: 'Muscle'},
  { id: 3, name: 'Off-Road'},
  { id: 4, name: 'Open Wheel'},
  { id: 5, name: 'Sedan'},
  { id: 6, name: 'Sports'},
  { id: 7, name: 'Sports Classic'},
  { id: 8, name: 'Super'},
  { id: 9, name: 'SUV'},
  { id: 10, name: 'Tuner'},
  { id: 11, name: 'Van'},
  { id: 12, name: 'Utility'},
]

// Getters
const getClassName = (classId = undefined) => {
  const className = classNames.find(c => c.id === classId)
  return className ? className.name : 'Unknown'
}

const getVehicles = computed(() => {
  const classId = currentClass.value
  if (classId === 'all') {
    return vehicles
  }
  return vehicles.filter(v => v.class === classId)
})

// Methods
const slide = (right = true) => right ? myCarousel.value.next() : myCarousel.value.prev();

const updateImage = (image) => {
  // Check if the image url is valid
  if (image?.url.length > 0 && image.url.startsWith('https')) {
    currentData.value = image
    activeDialog.value = true
  }
  currentData.value.url = image
  activeDialog.value = false
}

const newImage = () => {
  activeDialog.value = true
}

const cancelImage = () => {
  console.log('test')
  activeDialog.value = false
}

const eventListener = (e) => {
  const data = e.data;
  if (e.data.action === 'openMenu') {
    vehicles.value = data.vehicles
    console.log(JSON.stringify(vehicles.value))
    activeGarage.value = true
  }
}

onMounted(() => window.addEventListener('message', eventListener))
onUnmounted(() => window.removeEventListener('message', eventListener))
</script>

<template>
  <Transition name="fade">
    <ImageDialog v-if="activeDialog" @new="updateImage" @exit="cancelImage"/>
  </Transition>
  <div v-if="activeGarage" class="absolute flex flex-col items-center justify-center mx-auto h-full w-full">
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
        <Slide v-for="(veh, index) in getVehicles" :key="index">
          <VehicleCard v-if="veh.garage !== 'Impound'" @newImage="newImage" :vehicle="veh" :vehicleClass="getClassName(veh.modelClass)"/>
<!--          <ImpoundCard v-else :vehicle="veh" :vehicleClass="getClassName(veh.modelClass)"/>-->
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

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
