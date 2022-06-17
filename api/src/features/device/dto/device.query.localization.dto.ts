import { Max, Min, MinLength } from "class-validator";

export default class DeviceQueryLocalizationDTO {
    @MinLength(6)
    id?: string;
    @Min(-90)
    @Max(90)
    lat?:number;
    @Min(-180)
    @Max(180)
    long?: number;
    @Min(1)
    distance: number;
}