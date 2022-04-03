"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
class UserController {
    constructor() {
        this.path = '/user';
        this.router = express_1.default.Router();
    }
    initializeRoute() {
    }
}
exports.default = UserController;
//# sourceMappingURL=user.controller.js.map