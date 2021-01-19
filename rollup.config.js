import commonjs from "@rollup/plugin-commonjs";
import { terser } from "rollup-plugin-terser";
import analyze from "rollup-plugin-analyzer";

export default {
  input: "src/Listboxkit.bs.js",
  output: [
    {
      file: "dist/.cjs.js",
      format: "cjs",
    },
    {
      file: "dist/.esm.js",
      format: "esm",
    },
  ],
  plugins: [commonjs(), terser(), analyze()],
};
