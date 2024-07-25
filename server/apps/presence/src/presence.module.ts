import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { RedisModule, SharedModule } from '@app/shared';

import { CacheModule } from '@nestjs/cache-manager';

import { PresenceController } from './presence.controller';
import { PresenceService } from './presence.service';
import { PresenceGateway } from './presence.gateway';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: './.env'
    }),

    CacheModule.register(),
    SharedModule.registerRmq('AUTH_SERVICE', process.env.RABBITMQ_AUTH_QUEUE),

    SharedModule,
    RedisModule
  ],
  controllers: [PresenceController],
  providers: [PresenceService, PresenceGateway],
})
export class PresenceModule { }
