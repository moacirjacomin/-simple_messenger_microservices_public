import { BadRequestException, Body, Controller, Get, Inject, Param, Post, Put, Req, UseGuards, UseInterceptors } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { AuthGuard, UserInterceptor, UserRequest } from '@app/shared'; 
import { AllowNotificationDto } from 'apps/auth/src/dtos/allow-notification.dto';


@Controller()
export class AppController {
  constructor( 
    @Inject('AUTH_SERVICE') private authService: ClientProxy,
    @Inject('PRESENCE_SERVICE') private presenceService: ClientProxy
    ) {}

  @Get()
  async getUsers(){
    return this.authService.send({
      cmd: 'get-users'
    },{});
  }

  @UseGuards(AuthGuard)
  @Get('presence')
  async getPresence(){
    console.log('CONTROLER - presence')
    return this.presenceService.send({
      cmd: 'get-presence'
    },{});
  }

  @Post('auth/register')
  async registerUser(
    @Body('firstName') firstName : string, 
    @Body('lastName') lastName : string, 
    @Body('email') email : string, 
    @Body('password') password : string, 
  ){
    return this.authService.send({
      cmd: 'register-user'
    },{
      firstName, lastName, email, password
    });
  }

  @Post('auth/login')
  async loginUser(
    @Body('email') email : string, 
    @Body('password') password : string, 
  ){
    return this.authService.send({
      cmd: 'login-user'
    },{
        email, password
    });
  }

  // ##################################

  // Note: This would be done already from the main Facebook App thus simple end point provided to simplify this process.
  @UseGuards(AuthGuard)
  @UseInterceptors(UserInterceptor)
  @Post('add-friend/:friendId')
  async addFriend(
    @Req() req: UserRequest,
    @Param('friendId') friendId: number,
  ) {
    if (!req?.user) {
      throw new BadRequestException();
    }

    return this.authService.send(
      {
        cmd: 'add-friend',
      },
      {
        userId: req.user.id,
        friendId,
      },
    );
  }

  @UseGuards(AuthGuard)
  @UseInterceptors(UserInterceptor)
  @Get('get-friends')
  async getFriends(@Req() req: UserRequest) {
    if (!req?.user) {
      throw new BadRequestException();
    }

    return this.authService.send(
      {
        cmd: 'get-friends',
      },
      {
        userId: req.user.id,
      },
    );
  }

  @UseGuards(AuthGuard)
  @UseInterceptors(UserInterceptor)
  @Put('profile/notification')
  async profileUpdateNotification(@Req() req: UserRequest, @Body('allow_notification') allowNotificationDto: AllowNotificationDto ) {
    if (!req?.user) {
      throw new BadRequestException();
    }

    return this.authService.send(
      {
        cmd: 'update-profile-allow-notification',
      },
      {
        userId: req.user.id,
        allowNotification: allowNotificationDto
      },
    );
  }

  @UseGuards(AuthGuard)
  @UseInterceptors(UserInterceptor)
  @Put('profile/push-token')
  async profileUpdateTokenNotification(@Req() req: UserRequest, @Body('pushDeviceToken') pushDeviceToken: string ) {
    if (!req?.user) {
      throw new BadRequestException();
    }

    return this.authService.send(
      {
        cmd: 'update-profile-push-token-notification',
      },
      {
        userId: req.user.id,
        pushDeviceToken: pushDeviceToken
      },
    );
  }
}
