import { NewUserDTO } from "../dtos/new-user.dto";
import { ExistingUserDTO } from "../dtos/existing-user.dto";
import { FriendRequestEntity, UserEntity, UserJwt } from "@app/shared";



export interface AuthServiceInteraface { 
    getUsers(): Promise<UserEntity[]>;

    findUserByEmail(email: string): Promise<UserEntity>;

    hashPassword(password: string): Promise<string> ;

    registerUser(newUser: Readonly<NewUserDTO>): Promise<UserEntity>;

    checkPasswordMatch(password: string, hassedPassword: string): Promise<boolean>;

    validateUser(email: string, password: string): Promise<UserEntity>;

    loginUser(existingUser: Readonly<ExistingUserDTO>) ;

    verifyJwtUser(jwt: string) : Promise<{ user: UserEntity; exp: number }>;

    getUserFromHeader(jwt: string): Promise<UserJwt>;

    addFriend(userId: number, friendId: number): Promise<FriendRequestEntity>;
    
    getFriends(userId: number): Promise<FriendRequestEntity[]>;
}