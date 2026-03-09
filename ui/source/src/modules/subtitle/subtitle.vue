<style src="./subtitle.css"></style>

<template>
   <transition name="fade">
      <div class="subtitle-container" v-if="globalStore.subtitle.isVisible">

         <div class="subtitle-content">
            <span>{{ displayedText }}</span>
         </div>

      </div>
   </transition>
</template>

<script setup>
import { ref, watch } from "vue";
import { useGlobalStore } from "../../stores/global";

const globalStore = useGlobalStore();
const displayedText = ref("");
let typingInterval = null;

const hideSubtitle = () => {
   globalStore.subtitle.isVisible = false;
};

const startTyping = () => {
   displayedText.value = "";
   clearInterval(typingInterval);

   if (!globalStore.subtitle.isVisible) return;

   const fullText = globalStore.subtitle.text || "";
   let currentIndex = 0;

   typingInterval = setInterval(() => {
      if (currentIndex < fullText.length) {
         displayedText.value += fullText[currentIndex];
         currentIndex++;
      } else {
         clearInterval(typingInterval);
      }
   }, 30);
};

watch(() => globalStore.subtitle.isVisible, startTyping);
watch(() => globalStore.subtitle.text, startTyping);
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
