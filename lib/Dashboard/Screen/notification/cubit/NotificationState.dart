
abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class NotificationFetchingState extends NotificationState{}

class NotificationFetchedState extends NotificationState{}

class NotificationErrorState extends NotificationState {

  NotificationErrorState ();
}