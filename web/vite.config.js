import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  // mark the path "vue" as external
  build: {
    outDir: "../dist",
    assetsDir: "./",
    rollupOptions: {
      output: {
        entryFileNames: `[name].js`,
        chunkFileNames: `[name].js`,
        assetFileNames: `[name].[ext]`,
        manualChunks(id, { getModuleInfo }) {
          const match = /.*\.strings\.(\w+)\.js/.exec(id);
          if (match) {
            const language = match[1]; // e.g. "en"
            const dependentEntryPoints = [];

            // we use a Set here so we handle each module at most once. This
            // prevents infinite loops in case of circular dependencies
            const idsToHandle = new Set(getModuleInfo(id).dynamicImporters);

            for (const moduleId of idsToHandle) {
              const { isEntry, dynamicImporters, importers } = getModuleInfo(moduleId);
              if (isEntry || dynamicImporters.length > 0) dependentEntryPoints.push(moduleId);

              // The Set iterator is intelligent enough to iterate over elements that
              // are added during iteration
              for (const importerId of importers) idsToHandle.add(importerId);
            }

            // If there is a unique entry, we put it into into a chunk based on the entry name
            if (dependentEntryPoints.length === 1) {
              return `${dependentEntryPoints[0].split('/').slice(-1)[0].split('.')[0]}.strings.${language}`;
            }
            // For multiple entries, we put it into a "shared" chunk
            if (dependentEntryPoints.length > 1) {
              return `shared.strings.${language}`;
            }
          }
        }
      }
    }
  },
})