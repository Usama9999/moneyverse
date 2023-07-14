import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/extensions/color_extensions.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class WinnerWidget extends StatefulWidget {
  const WinnerWidget({
    super.key,
    required this.contest,
  });

  final ContestModel contest;

  @override
  State<WinnerWidget> createState() => _WinnerWidgetState();
}

class _WinnerWidgetState extends State<WinnerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool opened = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  _toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
      setState(() {
        opened = true;
      });
    } else {
      setState(() {
        opened = false;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        Container(
          padding: EdgeInsets.all(wd(15)),
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          decoration: ContainerProperties.shadowDecoration(
            color: HexColor('#FFDCB3'),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.contest.type.capitalizeFirst!} Contest",
                      style:
                          subHeadingText(color: AppColors.sparkblue, size: 16),
                    ),
                  ),
                  if (widget.contest.isJoined)
                    Text(
                      widget.contest.isJoined ? 'Participated ✔' : '',
                      style: subHeadingText(
                          color: AppColors.colorLogoGreenDark, size: 10),
                    ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                widget.contest.event,
                style: normalText(color: AppColors.textGrey),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Start:  ${widget.contest.getFormatedDate(widget.contest.converttoLocal(widget.contest.startDate))}',
                style: normalText(color: AppColors.primaryColor, size: 11),
              ),
              Text(
                'End:    ${widget.contest.getFormatedDate(widget.contest.converttoLocal(widget.contest.endDate))}',
                style: normalText(color: AppColors.primaryColor, size: 11),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    widget.contest.isWinnerAnnounced
                        ? 'Result Status: Announced'
                        : 'Result Status: Pending',
                    style: normalText(
                        color: widget.contest.isWinnerAnnounced
                            ? AppColors.green
                            : AppColors.red,
                        size: 11),
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      'Total Number of Participents',
                      style: subHeadingText(color: AppColors.primaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 10),
                      child: Text(
                        widget.contest.participents.toString(),
                        style: normalText(),
                      ),
                    ),
                    Text(
                      'Entry Fee',
                      style: subHeadingText(color: AppColors.primaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/ic_coin.png',
                            height: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.contest.entryFee.toString(),
                            style: normalText(),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Prize Distribution',
                      style: subHeadingText(color: AppColors.primaryColor),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/ic_${1}.png',
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/ic_money.png',
                                  height: 15,
                                ),
                                Text(
                                  ' ${((widget.contest.totalPrize / 100) * 50).toDouble().floor()}',
                                  textAlign: TextAlign.center,
                                  style: regularText(size: 18),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/ic_${2}.png',
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/ic_money.png',
                                  height: 15,
                                ),
                                Text(
                                  ' ${((widget.contest.totalPrize / 100) * 30).floor()}',
                                  style: regularText(size: 18),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/ic_${3}.png',
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/ic_money.png',
                                  height: 15,
                                ),
                                Text(
                                  ' ${((widget.contest.totalPrize / 100) * 20).floor()}',
                                  style: regularText(size: 18),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Text(
                      'Winners',
                      style: subHeadingText(color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.contest.winnerList.isEmpty
                        ? Center(
                            child: Lottie.asset('assets/lottie/nodatagrey.json',
                                height: 100))
                        : Column(
                            children: List.generate(
                                widget.contest.winnerList.length, (index) {
                              Winner winner = widget.contest.winnerList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: ht(38),
                                      width: ht(38),
                                      decoration:
                                          ContainerProperties.roundDecoration(),
                                      child: NetworkImageCustom(
                                        image: winner.image,
                                        radius: 100,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        winner.name,
                                        style: normalText(size: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      'assets/images/ic_${winner.rank}.png',
                                      height: 30,
                                    )
                                  ],
                                ),
                              );
                            }),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            right: 15,
            child: SizedBox(
                width: 120,
                child: CustomButton(
                  label: opened ? 'Hide Details' : 'show Details',
                  onPress: _toggleContainer,
                  buttonHight: 40,
                  textSize: 16,
                )))
      ]),
    );
  }
}
