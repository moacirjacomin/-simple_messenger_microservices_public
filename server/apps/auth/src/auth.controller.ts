import { Controller, Inject, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Ctx, MessagePattern, Payload, RmqContext } from '@nestjs/microservices';
import { SharedService } from '@app/shared';
import { NewUserDTO } from './dtos/new-user.dto';
import { ExistingUserDTO } from './dtos/existing-user.dto';
import { JwtGuard } from './jwt.guard';

@Controller()
export class AuthController {
  constructor(
    @Inject('AuthServiceInterface') private readonly authService: AuthService,
    @Inject('SharedServiceInterface') private readonly sharedService: SharedService,
  ) { }


  @MessagePattern({ cmd: 'get-users' })
  async getUsers(@Ctx() context: RmqContext) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.getUsers();
  }

  @MessagePattern({ cmd: 'get-user' })
  async getUserById(
    @Ctx() context: RmqContext,
    @Payload() user: { id: number },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.getUserById(user.id);
  }

  @MessagePattern({ cmd: 'register-user' })
  async registerUser(@Ctx() context: RmqContext, @Payload() newUser: NewUserDTO) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.registerUser(newUser);
  }

  @MessagePattern({ cmd: 'login-user' })
  async loginUser(@Ctx() context: RmqContext, @Payload() existingUserDTO: ExistingUserDTO) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.loginUser(existingUserDTO);
  }

  @MessagePattern({ cmd: 'verify-jwt-user' })
  @UseGuards(JwtGuard)
  async verifyJwtUser(@Ctx() context: RmqContext, @Payload() payload: { jwt: string }) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.verifyJwtUser(payload.jwt);
  }


  @MessagePattern({ cmd: 'decode-jwt' })
  async decodeJwt(
    @Ctx() context: RmqContext,
    @Payload() payload: { jwt: string },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.getUserFromHeader(payload.jwt);
  }

  @MessagePattern({ cmd: 'add-friend' })
  async addFriend(
    @Ctx() context: RmqContext,
    @Payload() payload: { userId: number; friendId: number },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.addFriend(payload.userId, payload.friendId);
  }

  @MessagePattern({ cmd: 'get-friends' })
  async getFriends(
    @Ctx() context: RmqContext,
    @Payload() payload: { userId: number },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.getFriends(payload.userId);
  }

  @MessagePattern({ cmd: 'get-friends-list' })
  async getFriendsList(
    @Ctx() context: RmqContext,
    @Payload() payload: { userId: number },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.getFriendsList(payload.userId);
  }

  @MessagePattern({ cmd: 'update-profile-allow-notification' })
  async profileUpdateNotification(
    @Ctx() context: RmqContext,
    @Payload() payload: { userId: number, allowNotification: boolean },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.profileUpdateNotification(payload.userId, payload.allowNotification );
  }

  @MessagePattern({ cmd: 'update-profile-push-token-notification' })
  async profileUpdateTokenNotification(
    @Ctx() context: RmqContext,
    @Payload() payload: { userId: number, pushDeviceToken: string },
  ) {
    this.sharedService.acknowledgeMessage(context);

    return this.authService.profileUpdateTokenNotification(payload.userId, payload.pushDeviceToken );
  }


  
}
