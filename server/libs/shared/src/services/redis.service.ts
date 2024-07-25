import { Injectable, Inject, CACHE_MANAGER } from "@nestjs/common";
import { Cache } from "cache-manager";


@Injectable()
export class RedisService {
    constructor(
        @Inject(CACHE_MANAGER) private readonly cache: Cache
    ) { }

    async get(key: string) {
        const data = await this.cache.get(key);
        console.log(`GET ${key} from REDIS: ${JSON.stringify(data)} `);
        return data;
    }

    async set(key: string, value: unknown, ttl = 0) {
        console.log(`SET ${key} from REDIS: ${JSON.stringify(value)}`);
        return await this.cache.set(key, value, ttl);
    }

    async del(key: string) {
        console.log(`del ${key} from REDIS`);
        return await this.cache.del(key);
    }

    async reset() {
        await this.cache.reset();
    }
}