import { defineStore } from "pinia";

export const useGlobalStore = defineStore("app", {
  state: () => ({
    textUI: {
      isVisible: false,
      text: "Text Here",
      position: "top-left"
    },
    subtitle: {
      isVisible: false,
      text: "Text Here",
    }
  }),
});
