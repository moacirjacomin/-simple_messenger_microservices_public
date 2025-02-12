import { DynamicModule, Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { ClientProxyFactory, Transport } from '@nestjs/microservices';
import { SharedService } from '../services/shared.service';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: './.env'
    }),
  ],
  providers: [SharedService],
  exports: [SharedService],
})
export class SharedModule {
  static registerRmq(service: string, queue: string): DynamicModule {

    const providers = [
      {
        provide: service,
        useFactory:
          (configService: ConfigService) => {
            const USER = configService.get('RABBITMQ_USER');
            const PASS = configService.get('RABBITMQ_PASS');
            const HOST = configService.get('RABBITMQ_HOST');

            return ClientProxyFactory.create({
              transport: Transport.RMQ,
              options: {
                urls: [`amqp://${USER}:${PASS}@${HOST}`],
                queue: queue,
                queueOptions: {
                  durable: true,
                }
              },
            });
          },
        inject: [ConfigService]
      },
    ];

    return {
      module: SharedModule,
      providers: providers,
      exports: providers,
    };
  }
}
