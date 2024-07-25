import { Controller, UseInterceptors } from '@nestjs/common';
import { Ctx, MessagePattern, Payload, RmqContext } from '@nestjs/microservices';
import { RedisService, SharedService } from '@app/shared';

import { CacheInterceptor } from '@nestjs/cache-manager';
import { PresenceService } from './presence.service';

@Controller()
export class PresenceController {
  constructor(
    private readonly presenceService: PresenceService,
    private readonly sharedService: SharedService,
    private readonly redisService: RedisService,
  ) { }



  @MessagePattern({ cmd: 'get-presence' })
  // @UseInterceptors(CacheInterceptor)
  async getPresence(@Ctx() context: RmqContext) {
    this.sharedService.acknowledgeMessage(context);

    console.log('get-presence CONTROLER');

    const foo = await this.redisService.get('foo');
    
    if(foo){
      console.log('CACHED');
      return foo;
    }

    const f = await this.presenceService.getHello();
    await this.redisService.set('foo', f);

    return f;
  }

  @MessagePattern({ cmd: 'get-active-user' })
  async getActiveUser(
    @Ctx() context: RmqContext,
    @Payload() payload: { id: number },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return await this.presenceService.getActiveUser(payload.id);
  }
  
}
