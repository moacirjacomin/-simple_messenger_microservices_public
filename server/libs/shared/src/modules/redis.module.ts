import { CacheModule, Module } from "@nestjs/common";
 

import { RedisService } from "../services/redis.service";
import { redisStore } from "cache-manager-redis-yet";
import { ConfigService } from "@nestjs/config";


@Module({
    imports: [
        CacheModule.registerAsync({
            useFactory: async (configService: ConfigService) => ({
                store: await redisStore({
                    url: configService.get('REDIS_URI'),
                    // ttl: 5000, // 5 seconds
                }),
            }),
            isGlobal: true,
            inject: [ConfigService]
        }),
    ],
    providers: [RedisService],
    exports: [RedisService]
})
export class RedisModule { }