import { Max, Min, MinLength } from "class-validator";

export default class DeviceQueryLocalizationDTO {
    @MinLength(6)
    id?: string;
    @Min(-90)
    @Max(90)
    latitude?:number;
    @Min(-180)
    @Max(180)
    longitude?: number;
    @Min(1)
    distance: number;
}