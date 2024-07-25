import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SharedModule, PostgresDbModule, SharedService, UsersRepository, UserEntity, FriendRequestEntity, FriendRequestsRepository } from '@app/shared';
import { JwtModule } from '@nestjs/jwt';
import { JwtGuard } from './jwt.guard';
import { JwtStrategy } from './jwt.strategy';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: './.env'
    }),

    SharedModule,
    PostgresDbModule,
    TypeOrmModule.forFeature([
      UserEntity,
      FriendRequestEntity,
    ]),

    JwtModule.registerAsync({
      imports: [
        ConfigModule,
      ],
      useFactory: (configService: ConfigService) => ({
        secret: configService.get('JWT_SECRET'),
        signOptions: { expiresIn: '3600s' }, // 2h
      }),
      inject: [ConfigService],
    }),

    // this was comments since we moved DB for shared lib as a new Module
    // TypeOrmModule.forRootAsync({
    //   imports: [ConfigModule],
    //   // without migrations:
    //   // useFactory: (configService: ConfigService) => ({
    //   //   type: 'postgres',
    //   //   url: configService.get('POSTGRES_URI'),
    //   //   autoLoadEntities: true,
    //   //   synchronize: true, // shouldn't be used in prodution = may lose data
    //   // }),

    //   // approuch with migration
    //   useFactory: () => ({
    //     ...dataSourceOptions,
    //     autoLoadEntities: true,
    //     synchronize: true, // shouldn't be used in prodution = may lose data
    //   }),

    //   inject: [ConfigService],
    // }),


  ],
  controllers: [AuthController],
  providers: [
    JwtGuard,
    JwtStrategy,
    {
      provide: 'AuthServiceInterface',
      useClass: AuthService
    },
    {
      provide: 'UserRepositoryInterface',
      useClass: UsersRepository
    },
    {
      provide: 'SharedServiceInterface',
      useClass: SharedService
    },
    {
      provide: 'FriendRequestsRepositoryInterface',
      useClass: FriendRequestsRepository,
    },
  ],
})
export class AuthModule { }
