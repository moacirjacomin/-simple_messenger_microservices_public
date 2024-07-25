import { BadRequestException, ConflictException, Inject, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

import { ExistingUserDTO } from './dtos/existing-user.dto';
import { NewUserDTO } from './dtos/new-user.dto';

import { FriendRequestEntity, FriendRequestsRepository, UserEntity, UserJwt, UserRepositoryInterface } from '@app/shared';

import * as bcrypt from "bcrypt";
// import * as bcrypt from "bcryptjs";

@Injectable()
export class AuthService {
  constructor(
    // @InjectRepository(UserEntity) private readonly userRepository: Repository<UserEntity>, // old way, without a data layer 
    @Inject('UserRepositoryInterface') private readonly userRepository: UserRepositoryInterface,
    @Inject('FriendRequestsRepositoryInterface') private readonly friendRequestsRepository: FriendRequestsRepository,
    private readonly jwtService: JwtService,
  ) { }


  async getUsers(): Promise<UserEntity[]> {
    return this.userRepository.findAll();
  }

  async getUserById(id: number): Promise<UserEntity> {
    return await this.userRepository.findOneById(id);
  }

  async findUserByEmail(email: string): Promise<UserEntity> {
    return this.userRepository.findByCondition({
      where: { email },
      select: ['id', 'firstName', 'lastName', 'email', 'password', 'allow_notification', 'pushDeviceToken']
    });
  }


  async findById(id: number): Promise<UserEntity> {
    return this.userRepository.findOneById(id);
  }


  async hashPassword(password: string): Promise<string> {
    return bcrypt.hash(password, 12);
  }


  async registerUser(newUser: Readonly<NewUserDTO>): Promise<UserEntity> {

    const { firstName, lastName, email, password, pushDeviceToken } = newUser;

    // 1. check if user is not already created
    const checkExistingUser = await this.findUserByEmail(email);
    if (checkExistingUser) {
      throw new ConflictException('An account with that wmail already exists');
    }

    // 2. create a encrypted version of the password, to be safe to save into our database
    const hassedPassword = await this.hashPassword(password);

    const savedUSer = await this.userRepository.save({
      firstName, lastName, email, password: hassedPassword, pushDeviceToken: pushDeviceToken
    });

    // 3. remove password info from response
    delete savedUSer.password;
    return savedUSer;
  }


  async checkPasswordMatch(password: string, hassedPassword: string): Promise<boolean> {
    return bcrypt.compare(password, hassedPassword);
  }


  async validateUser(email: string, password: string): Promise<UserEntity> {

    const user = await this.findUserByEmail(email);
    const doesUserExist = !!user;

    if (!doesUserExist) return null;

    const doesPasswordMatch = await this.checkPasswordMatch(password, user.password);

    if (!doesPasswordMatch) return null

    return user;
  }


  async loginUser(existingUser: Readonly<ExistingUserDTO>) {

    // 1. check is user is valid and password is correct
    const { email, password } = existingUser;

    const user = await this.validateUser(email, password);

    if (!user) throw new UnauthorizedException('');

 
    // 2. prepare a jwt token to be used in the response 
    const jwtToken = await this.jwtService.signAsync({
      user
    });

    delete user.password;

    return {
      token: jwtToken, user
    }
  }


  async verifyJwtUser(jwt: string): Promise<{ user: UserEntity; exp: number }> {

    console.log(`verifyJwtUser jwt=${jwt} `)

    if (!jwt) {
      throw new UnauthorizedException();
    }

    try {
      const { user, exp } = await this.jwtService.verifyAsync(jwt);

      console.log(`verifyJwtUser exp=${exp} user=${JSON.stringify(user)} `)

      return { user, exp };
    } catch (error) {
      throw new UnauthorizedException();
    }
  }

 
  async getUserFromHeader(jwt: string): Promise<UserJwt> {
    if (!jwt) return;

    try {
      return this.jwtService.decode(jwt) as UserJwt;
    } catch (error) {
      throw new BadRequestException();
    }
  }

  async addFriend(
    userId: number,
    friendId: number,
  ): Promise<FriendRequestEntity> {
    const creator = await this.findById(userId);
    const receiver = await this.findById(friendId);

    return await this.friendRequestsRepository.save({ creator, receiver });
  }

  async getFriends(userId: number): Promise<FriendRequestEntity[]> {
    const creator = await this.findById(userId);

    return await this.friendRequestsRepository.findWithRelations({
      where: [{ creator }, { receiver: creator }],
      relations: ['creator', 'receiver'],
    });
  }

  async getFriendsList(userId: number) {
    const friendRequests = await this.getFriends(userId);

    if (!friendRequests) return [];

    const friends = friendRequests.map((friendRequest) => {
      const isUserCreator = userId === friendRequest.creator.id;
      const friendDetails = isUserCreator
        ? friendRequest.receiver
        : friendRequest.creator;

      const { id, firstName, lastName, email } = friendDetails;

      return {
        id,
        email,
        firstName,
        lastName,
      };
    });

    return friends;
  }

  async profileUpdateNotification(userId: number, allowNotification: boolean ){
    const userToUpdate = await this.findById(userId);
    userToUpdate.allow_notification = allowNotification;
    
    return this.userRepository.save(userToUpdate);
  }

  async profileUpdateTokenNotification(userId: number, pushDeviceToken: string ){
    const userToUpdate = await this.findById(userId);
    userToUpdate.pushDeviceToken = pushDeviceToken;
    
    return this.userRepository.save(userToUpdate);
  }

}
