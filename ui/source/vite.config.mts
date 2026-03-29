// Plugins
import Components from "unplugin-vue-components/vite";
import Vue from "@vitejs/plugin-vue";
import Vuetify, { transformAssetUrls } from "vite-plugin-vuetify";
import ViteFonts from "unplugin-fonts/vite";

// Utilities
import { defineConfig } from "vite";
import { fileURLToPath, URL } from "node:url";
import fs from "node:fs";
import path from "node:path";

function copyDir(src: string, dest: string) {
  if (!fs.existsSync(src)) return;

  const stats = fs.statSync(src);
  if (!stats.isDirectory()) return;

  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest, { recursive: true });
  }

  for (const entry of fs.readdirSync(src)) {
    const srcPath = path.join(src, entry);
    const destPath = path.join(dest, entry);
    const entryStats = fs.statSync(srcPath);

    if (entryStats.isDirectory()) {
      copyDir(srcPath, destPath);
    } else if (entryStats.isFile()) {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// https://vitejs.dev/config/
export default defineConfig({
  base: "./",
  plugins: [
    Vue({
      template: { transformAssetUrls },
    }),
    // https://github.com/vuetifyjs/vuetify-loader/tree/master/packages/vite-plugin#readme
    Vuetify(),
    Components(),
    ViteFonts({
      google: {
        families: [
          {
            name: "Montserrat",
            styles: "wght@100;300;400;500;700;900",
          },
        ],
      },
    }),
    {
      name: "copy-icons-to-build",
      apply: "build",
      closeBundle() {
        const projectRoot = fileURLToPath(new URL(".", import.meta.url));
        const srcIcons = path.resolve(projectRoot, "src/assets/icons");
        const outDir = path.resolve(projectRoot, "../build");
        const destIcons = path.resolve(outDir, "icons");

        copyDir(srcIcons, destIcons);
      },
    },
  ],
  define: { "process.env": {} },
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
    extensions: [".js", ".json", ".jsx", ".mjs", ".ts", ".tsx", ".vue"],
  },
  server: {
    port: 3000,
  },
  build: {
    outDir: "../build",
    emptyOutDir: true,
  },
});
