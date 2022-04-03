"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const envalid_1 = require("envalid");
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const validateEnv = (0, envalid_1.cleanEnv)(process.env, {
    PORT: (0, envalid_1.port)()
});
exports.default = validateEnv;
//# sourceMappingURL=validateEnv.js.map