import { Injectable } from '@nestjs/common';
import { RedisService } from '@app/shared';
import { ActiveUser } from './interfaces/ActiveUser.interface';

@Injectable()
export class PresenceService {
  constructor(private readonly cache: RedisService) {}

  getHello(): any {
    console.log('NOT CACHED ')
    return { foo: 'bar'};
  }

  async getActiveUser(id: number) {
    const user = await this.cache.get(`user ${id}`);

    return user as ActiveUser | undefined;
  }
}
