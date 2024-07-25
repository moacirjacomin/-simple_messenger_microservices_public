import { Module } from '@nestjs/common';

import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FriendRequestEntity } from '../entities/friend-request.entity';
import { UserEntity } from '../entities/user.entity';
import { ConversationEntity } from '../entities/conversation.entity';
import { MessageEntity } from '../entities/message.entity';


@Module({
    imports: [
        ConfigModule.forRoot({
            isGlobal: true,
            envFilePath: './.env'
        }),

        TypeOrmModule.forRootAsync({
            imports: [ConfigModule],
            useFactory: (configService: ConfigService) => ({
                type: 'postgres',
                url: configService.get('POSTGRES_URI'),
                autoLoadEntities: true,
                synchronize: true, // shouldn't be used in prodution = may lose data
            }),

            inject: [ConfigService],
        }),

        TypeOrmModule.forFeature([
            UserEntity,
            FriendRequestEntity, 
            ConversationEntity,
            MessageEntity,
        ]),
    ],
})
export class PostgresDbModule { }
