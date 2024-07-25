import { Injectable } from '@nestjs/common';
import admin from '@app/shared/firebase.config';


@Injectable()
export class PushNotificationService {
  async sendPushNotification(deviceToken: string, payload: any): Promise<void> {
    try {
      await admin.messaging().sendToDevice(deviceToken, { data: payload });
    } catch (error) {
      console.error('Error sending push notification:', error);
    }
  }
}