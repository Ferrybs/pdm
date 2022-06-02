import { plainToInstance } from "class-transformer";
import MeasureDTO from "../dto/measure.dto";
import Device from "../entity/device.entity";
import Measure from "../entity/measure.entity";
import TypeMeasure from "../entity/type.measure.entity";
import Services from "./services";

export default class MeasureService extends Services{
    
    public async addMeasure(measureDTO: MeasureDTO): Promise<boolean>{
        const measure = new Measure();
        measure.value = measureDTO.value;
        measure.date = measureDTO.date;
        measure.device = plainToInstance(Device,measureDTO.deviceDTO);
        measure.type = plainToInstance(TypeMeasure,measureDTO.typeDTO);
        const result =  await this.database.insertMeasure(measure);
        if(result){
            return true;
        }
        return false;
    }
}