<template>
   <v-app>
      <TextUI />
      <subtitle />
      <TextInput />
   </v-app>
</template>
<script setup>
import { ref, shallowRef, onMounted, onUnmounted } from "vue";
import { useGlobalStore } from "./stores/global";
import TextUI from "./modules/textUi/textui.vue";
import subtitle from "./modules/subtitle/subtitle.vue";
import TextInput from "./modules/textInput/textInput.vue";
const globalStore = useGlobalStore();

const handlers = {
   textUI: (itemData) => {
      if (itemData.show == true) {
         globalStore.$state.textUI.isVisible = itemData.show
         globalStore.$state.textUI.position = itemData.position
         globalStore.$state.textUI.text = itemData.text
      } else if (itemData.show == false) {
         globalStore.$state.textUI.isVisible = itemData.show
      }
   },
   subtitle: (itemData) => {
      if (itemData.show == true) {
         globalStore.$state.subtitle.isVisible = true;
         globalStore.$state.subtitle.text = itemData.text;
      } else {
         globalStore.$state.subtitle.isVisible = false;
      }
   },

   textInput: (itemData) => {
      globalStore.$state.textInput.isVisible = true;
      globalStore.$state.textInput.title = itemData.data.title;
      globalStore.$state.textInput.placeholder = itemData.data.placeholder;
      globalStore.$state.textInput.value = itemData.data.value;
      globalStore.$state.textInput.type = itemData.data.type;
   },
};

const handleMessageListener = (event) => {
   const itemData = event?.data;
   if (handlers[itemData.module]) handlers[itemData.module](itemData);
};

onMounted(() => {
   window.addEventListener("message", handleMessageListener);
});

onUnmounted(() => {
   window.removeEventListener("message", handleMessageListener);
});
</script>
<style>
@import "./assets/main.css";

::-webkit-scrollbar {
   width: 0;
   display: inline !important;
}

.v-application {
   background: transparent !important;
}

:root {
   color-scheme: none !important;
}
</style>
