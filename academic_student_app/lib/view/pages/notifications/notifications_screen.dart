import 'package:academic_student/view/pages/notifications/bloc/notifications_bloc.dart';
import 'package:academic_student/view/pages/notifications/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationsBloc>().add(const GetNotifications());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(
            bottom: MediaQuery.of(context).size.shortestSide < 600 ? 50 : 0),
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotificationsInitial) {
              return RefreshIndicator(
                onRefresh: () async => context
                    .read<NotificationsBloc>()
                    .add(const GetNotifications()),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      expandedHeight: 100.0,
                      floating: false,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 1.2,
                        title: Text(
                          "notifications".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        centerTitle: true,
                      ),
                    ),
                    if (state.todayNotifications.isNotEmpty)
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "today".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          );
                        }
                        return NotificationWidget(
                            notification: state.todayNotifications[index - 1]);
                      }, childCount: state.todayNotifications.length + 1)),
                    if (state.yesterdayNotifications.isNotEmpty)
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "yesterday".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          );
                        }
                        return NotificationWidget(
                            notification:
                                state.yesterdayNotifications[index - 1]);
                      }, childCount: state.yesterdayNotifications.length + 1)),
                    if (state.laterNotifications.isNotEmpty)
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "later".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          );
                        }
                        return NotificationWidget(
                            notification: state.laterNotifications[index - 1]);
                      }, childCount: state.laterNotifications.length + 1))
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
