import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/contest_Manager_controller.dart';
import 'package:talentogram/controllers/mainScreen_controllers/home_screen_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/components/user_post.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/screens/contest_screens/home_contest.dart';
import 'package:talentogram/screens/main_screens/widget/home_app_bar.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeScreenController());
  var contestCont = Get.put(ContestManagerController());

  @override
  void initState() {
    controller.pageController = PageController(initialPage: 0);
    Future.delayed(Duration.zero, () {
      Future.wait([controller.getPosts(), contestCont.getHomeContests()]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<HomeScreenController>(builder: (controller) {
            return controller.postLoader
                ? Center(child: AppViews.showLoading())
                : RefreshIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    onRefresh: () => controller.onRefresh(),
                    child: ListView(
                      padding: const EdgeInsets.only(
                        top: 60,
                      ),
                      children: [
                        const UpcomingOngoingContests(),
                        SizedBox(
                          height: ht(25),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: wd(15)),
                          child: Text(
                            'USER FEED',
                            style: subHeadingText(color: AppColors.textGrey),
                          ),
                        ),
                        controller.foryouPosts.isEmpty
                            ? const Center(
                                child: Text('No posts yet'),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                padding:
                                    EdgeInsets.symmetric(horizontal: wd(15)),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.foryouPosts.length,
                                itemBuilder: (context, index) {
                                  PostModel postModel =
                                      controller.foryouPosts[index];
                                  return UserPost(
                                    onLike: () {
                                      Get.find<HomeScreenController>()
                                          .likePost(postModel);
                                    },
                                    post: postModel,
                                  );
                                }),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  );
          }),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GetBuilder<HomeScreenController>(builder: (value) {
                return Container(
                  color: AppColors.scaffoldBacground,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      homeAppBar(value),
                    ],
                  ),
                );
              })),
        ],
      ),
    );
  }
}
