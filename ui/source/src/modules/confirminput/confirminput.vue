<style src="./confirminput.css"></style>
<template>
   <transition name="fade">
      <div class="confirmInput-container" v-if="globalStore.confirmInput.isVisible">

         <div class="confirmInput-input-container">

            <h1 class="confirmInput-input-container-title">{{ globalStore.confirmInput.title }}</h1>
            <p class="confirmInput-input-container-text">{{ globalStore.confirmInput.text }}</p>
            <div class="confirmInput-input-container-actions">
               <div class="confirmInput-input-container-action-button secondary" @click="handleCancel">
                  <span>{{ globalStore.confirmInput.cancelLabel || 'Cancel' }}</span>
               </div>
               <div class="confirmInput-input-container-action-button primary" @click="handleConfirm">
                  <span>{{ globalStore.confirmInput.confirmLabel || 'Confirm' }}</span>
               </div>
            </div>
         </div>

      </div>
   </transition>
</template>

<script setup lang="ts">
import { ref, watch, nextTick, onMounted, onBeforeUnmount } from "vue";
import { useGlobalStore } from "../../stores/global";
import api from "../../api/axios";

const globalStore = useGlobalStore();

const resetAndClose = () => {
   globalStore.confirmInput.isVisible = false;
   setTimeout(() => {
      globalStore.confirmInput.title = null;
      globalStore.confirmInput.text = null;
      globalStore.confirmInput.confirmLabel = null;
      globalStore.confirmInput.cancelLabel = null;
   }, 500);
};


const handleConfirm = async () => {
   try {
      const endpoint = globalStore.confirmInput.confirmEndpoint;
      if (endpoint) {
         await api.post(endpoint);
      }
   } catch (err) {
      console.error("confirmInput confirm error:", err);
   } finally {
      resetAndClose();
   }
};

const handleCancel = async () => {
   try {
      const endpoint = globalStore.confirmInput.cancelEndpoint;
      if (endpoint) {
         await api.post(endpoint);
      }
   } catch (err) {
      console.error("confirmInput cancel error:", err);
   } finally {
      resetAndClose();
   }
};

const handleKeydown = (event: KeyboardEvent) => {
   if (!globalStore.confirmInput.isVisible) return;

   if (event.key === "Enter") {
      event.preventDefault();
      handleConfirm();
   } else if (event.key === "Escape") {
      event.preventDefault();
      handleCancel();
   }
};

onMounted(() => {
   window.addEventListener("keydown", handleKeydown);
});

onBeforeUnmount(() => {
   window.removeEventListener("keydown", handleKeydown);
});
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
