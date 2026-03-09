<style src="./textui.css"></style>

<template>
   <transition name="fade">
      <div class="textUI-container" :class="globalStore.textUI.position" v-if="globalStore.textUI.isVisible">
         <div class="textUI-content">
            <span v-html="globalStore.textUI.text"></span>
         </div>
      </div>
   </transition>
</template>

<script setup>
import { useGlobalStore } from "../../stores/global";
const globalStore = useGlobalStore();
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
   transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
   opacity: 0;
}
</style>
