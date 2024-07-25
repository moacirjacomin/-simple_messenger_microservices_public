import { CacheModule, Module } from "@nestjs/common";
 
import { PushNotificationService } from "../services/push-notification.service";


@Module({
    imports: [
      
    ],
    providers: [PushNotificationService],
    exports: [PushNotificationService]
})
export class PushNotificationModule { }