import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import {
  ConversationEntity,
  ConversationsRepository,
  FriendRequestEntity,
  MessageEntity,
  MessagesRepository,
  PostgresDbModule,
  PushNotificationModule,
  RedisModule,
  SharedModule,
  UserEntity
} from '@app/shared';

import { ChatController } from './chat.controller';
import { ChatService } from './chat.service';
import { ChatGateway } from './chat.gateway';

@Module({
  imports: [
    PostgresDbModule,
    RedisModule,
    SharedModule.registerRmq('AUTH_SERVICE', process.env.RABBITMQ_AUTH_QUEUE),
    SharedModule.registerRmq('PRESENCE_SERVICE', process.env.RABBITMQ_PRESENCE_QUEUE),
    TypeOrmModule.forFeature([
      UserEntity,
      FriendRequestEntity,
      ConversationEntity,
      MessageEntity,
    ]),
    PushNotificationModule,
  ],
  controllers: [ChatController],
  providers: [
    ChatService,
    ChatGateway,
    {
      provide: 'ConversationsRepositoryInterface',
      useClass: ConversationsRepository,
    },
    {
      provide: 'MessagesRepositoryInterface',
      useClass: MessagesRepository,
    },
  ],
})
export class ChatModule { }
