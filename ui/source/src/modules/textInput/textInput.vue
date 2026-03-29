<style src="./textInput.css"></style>
<template>
   <transition name="fade">
      <div class="textInput-container" v-if="globalStore.textInput.isVisible">

         <div class="textInput-input-container">

            <h1 class="textInput-input-container-title">{{ globalStore.textInput.title }}</h1>
            <input
               ref="inputRef"
               class="textInput-input-container-input"
               :type="globalStore.textInput.type"
               :placeholder="globalStore.textInput.placeholder || ''"
               v-model="inputValue"
            />
            <div class="textInput-input-container-actions">
               <div class="textInput-input-container-action-button secondary" @click="handleCancel">
                  <span>Cancel</span>
               </div>
               <div class="textInput-input-container-action-button primary" @click="handleSubmit">
                  <span>Submit</span>
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

const inputValue = ref(globalStore.textInput.value);
const inputRef = ref<HTMLInputElement | null>(null);

const resetAndClose = () => {
   globalStore.textInput.isVisible = false;
   setTimeout(() => {
      inputValue.value = "";
      globalStore.textInput.value = "";
   }, 500);
};

const handleSubmit = async () => {
   try {
      const endpoint = globalStore.textInput.submitEndpoint;
      if (endpoint) {
         await api.post(endpoint, { value: inputValue.value });
      }
   } catch (err) {
      console.error("textInput submit error:", err);
   } finally {
      resetAndClose();
   }
};

const handleCancel = async () => {
   try {
      const endpoint = globalStore.textInput.cancelEndpoint;
      if (endpoint) {
         await api.post(endpoint);
      }
   } catch (err) {
      console.error("textInput cancel error:", err);
   } finally {
      resetAndClose();
   }
};

const handleKeydown = (event: KeyboardEvent) => {
   if (!globalStore.textInput.isVisible) return;

   if (event.key === "Enter") {
      event.preventDefault();
      handleSubmit();
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

watch(
   () => globalStore.textInput.isVisible,
   async (visible) => {
      if (visible) {
         inputValue.value = globalStore.textInput.value || "";
         await nextTick();
         setTimeout(() => {
            if (inputRef.value) {
               inputRef.value.focus();
            }
         }, 0);
      }
   }
);

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
