import { defineConfig } from "eslint/config";
import js from "@eslint/js";
import nextConfig from "eslint-config-next/core-web-vitals";

export default defineConfig([
  js.configs.recommended,
  ...nextConfig,
  {
    ignores: [
      ".next/**",
      "out/**",
      "build/**",
      "dist/**",
      "node_modules/**",
      ".git/**",
      "public/**",
      "*.log",
      "jest.setup.ts",
      "**/*.test.ts",
      "**/*.test.tsx",
    ],
  },
  {
    files: ["**/*.{js,mjs,cjs,jsx,ts,tsx}"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        React: "readonly",
      },
    },
  },
]);
