

part of '../home.dart';


class HomeStarter extends StatelessWidget {
  const HomeStarter({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    this.version,
    this.urlRelease,
  });
  final String id, title, subtitle;
  final String? version;
  final String? urlRelease;



  /// Метод для скачивания файла по ссылке в Flutter Web
 static void _downloadFile(String url, {String? fileName}) {
    final anchor = html.AnchorElement(href: url)
      ..download = fileName ?? url.split('/').last
      ..style.display = 'none';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height - (context.isDesktop ? 0.0 : kToolbarHeight),
      constraints: const BoxConstraints(minHeight: 600.0),
      child: Builder(
        builder: (context) {
          if (context.isDesktop) {
            // For desktop layout
            return Padding(
              padding: const EdgeInsets.all(Constants.spacing+100),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: .center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Animate(
                      effects: const [
                        SlideEffect(
                          begin: Offset(0.0, 0.25),
                          end: Offset.zero,
                          delay: Constants.duration,
                          duration: Duration(milliseconds: 750),
                        ),
                        FadeEffect(
                          delay: Constants.duration,
                          duration: Duration(milliseconds: 750),
                        ),
                      ],
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: HomeStarter.introduction(
                          context,
                          title: title,
                          subtitle: subtitle,
                          version: version,
                          onTap: () {
                            if (urlRelease != null) {
                              _downloadFile(urlRelease!); 
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Constants.spacing),
                  Expanded(
                    flex: 2,
                    child: HomeStarter.thumbnail(),
                  ),
                ],
              ),
            );
          } else {
            // For mobile and tablet layout
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                HomeStarter.thumbnail(),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [
                        context.color.primary,
                        context.color.primary,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(Constants.spacing),
                  child: Animate(
                    effects: const [
                      SlideEffect(
                        begin: Offset(0.0, 0.25),
                        end: Offset.zero,
                        delay: Constants.duration,
                        duration: Duration(milliseconds: 750),
                      ),
                      FadeEffect(
                        delay: Constants.duration,
                        duration: Duration(milliseconds: 750),
                      ),
                    ],
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: HomeStarter.introduction(
                        context,
                        title: title,
                        subtitle: subtitle,
                        version: version,
                        onTap: () {
                          if (urlRelease != null) {
                            _downloadFile(urlRelease!);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  static List<Widget> introduction(
    BuildContext context, {
    required String title,
    required String subtitle,
    String? version,
    VoidCallback? onTap,
  }) {
    return [
      MergeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the title
            Seo.text(
              text: title,
              style: TextTagStyle.h2,
              child: Text(
                title,
                semanticsLabel: title,
                style: context.text.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Display the subtitle
            Seo.text(
              text: subtitle,
              style: TextTagStyle.p,
              child: Text(
                '\n$subtitle',
                semanticsLabel: subtitle,
                style: context.text.bodyMedium?.copyWith(
                  fontSize: 20
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: Constants.spacing+20),
      Visibility(
        visible: version!.isNotEmpty,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: context.color.onBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
          ),
          child: Row(
            mainAxisAlignment: .start,
            spacing: 20,
            mainAxisSize: .min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Seo.text(
                  text: subtitle,
                  style: TextTagStyle.p,
                  child: Text(
                    'Последняя версия\n для Windows ${version}',
                    semanticsLabel: subtitle,
                    style: context.text.bodyMedium?.copyWith(
                        fontSize: 18
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              DButton.text(
                onTap: onTap!,
                text: 'СКАЧАТЬ',
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.spacing,
                  vertical: Constants.spacing * 0.7,
                ),
                style: context.text.bodyMedium?.copyWith(
                  color: context.color.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
                borderRadius:
                BorderRadius.circular(Constants.spacing * 0.25),
              ),
            ],
          ),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(Constants.spacing),
      //   child: Wrap(
      //     runSpacing: Constants.spacing * 0.5,
      //     spacing: Constants.spacing * 0.5,
      //     runAlignment: WrapAlignment.center,
      //     alignment: WrapAlignment.center,
      //     crossAxisAlignment: WrapCrossAlignment.center,
      //     verticalDirection: VerticalDirection.down,
      //     children: [
      //       // Display email input area
      //       Semantics(
      //         label: 'Enter Your Email Address to Join the Waitlist',
      //         textField: true,
      //         child: ExcludeSemantics(
      //           excluding: true,
      //           child: DTextArea(
      //             isDense: false,
      //             textAlign: TextAlign.start,
      //             cursorColor: context.color.background,
      //             borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
      //             borderSideIdle: BorderSide.none,
      //             backgroundColor: context.color.onBackground.withOpacity(0.5),
      //             hintText: 'Enter Your Email Adress              ',
      //             contentPadding: const EdgeInsets.symmetric(
      //               horizontal: Constants.spacing,
      //             ),
      //             textStyle: context.text.bodySmall?.copyWith(
      //               fontWeight: FontWeight.w500,
      //               color: context.color.surface,
      //             ),
      //             hintStyle: context.text.bodySmall?.copyWith(
      //               fontWeight: FontWeight.w500,
      //               color: context.color.surface.withOpacity(0.5),
      //             ),
      //             borderSideActive: BorderSide(
      //               color: context.color.background.withOpacity(0.75),
      //             ),
      //             placeholder: DButton.text(
      //               text:
      //                   'Enter Your Email Adress                        | Join Waitlist',
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: Constants.spacing,
      //                 vertical: Constants.spacing * 0.75,
      //               ),
      //               style: context.text.bodySmall
      //                   ?.copyWith(fontWeight: FontWeight.w500),
      //               onTap: () {},
      //             ),
      //
      //             // Display "Join Waitlist" button
      //             suffixIcon: DButton.text(
      //               onTap: () => context.go('/dashboard'),
      //               text: 'Join Waitlist',
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: Constants.spacing,
      //                 vertical: Constants.spacing * 0.7,
      //               ),
      //               style: context.text.bodyMedium?.copyWith(
      //                 color: context.color.primary,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 12.0,
      //               ),
      //               borderRadius:
      //                   BorderRadius.circular(Constants.spacing * 0.25),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    ];
  }



  static Widget thumbnail() {
    return Animate(
      effects: const [
        // Slide in animation effect
        SlideEffect(
          begin: Offset(0.0, -0.25),
          end: Offset.zero,
          delay: Constants.duration,
          duration: Duration(milliseconds: 750),
        ),

        // Fade in animation effect
        FadeEffect(
          delay: Constants.duration,
          duration: Duration(milliseconds: 750),
        ),
      ],
      child: Transform(
        transform: Matrix4.identity()
          //..rotateZ(3.14 * 0.15)
          ..scale(0.8),
        alignment: Alignment.center,
        child: const AppPresentationSlider(screenshots: [
          'assets/image/img_guide/scr1.webp',
          'assets/image/img_guide/scr3.webp',
          'assets/image/img_guide/scr2.webp',
          'assets/image/img_guide/scr4.webp'
        ])

      ),
    );
  }
}




class AppPresentationSlider extends StatefulWidget {
  final List<String> screenshots;
  final bool autoPlay;

  const AppPresentationSlider({
    super.key,
    required this.screenshots,
    this.autoPlay = true,
  });

  @override
  State<AppPresentationSlider> createState() => _AppPresentationSliderState();
}

class _AppPresentationSliderState extends State<AppPresentationSlider> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    if (widget.autoPlay) _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < widget.screenshots.length - 1) {
        _animateToPage(_currentPage + 1);
      } else {
        _animateToPage(0); // Зацикливание
      }
    });
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _handleManualNavigation(int direction) {
    _timer?.cancel(); // Останавливаем автоплей при ручном вмешательстве
    final targetPage = _currentPage + direction;
    if (targetPage >= 0 && targetPage < widget.screenshots.length) {
      _animateToPage(targetPage);
    }
    if (widget.autoPlay) _startTimer(); // Перезапуск таймера
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Основной слайдер
            SizedBox(
              height: 650,
              child:
              PageView.builder(
                controller: _pageController,
                itemCount: widget.screenshots.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (context, index) => _buildImageCard(index, colors),
              ),
            ),

            // Кнопка НАЗАД
            Positioned(
              left: 10,
              child: _buildNavButton(
                icon: Icons.chevron_left,
                onPressed: _currentPage > 0 ? () => _handleManualNavigation(-1) : null,
                colors: colors,
              ),
            ),

            // Кнопка ВПЕРЕД
            Positioned(
              right: 10,
              child: _buildNavButton(
                icon: Icons.chevron_right,
                onPressed: _currentPage < widget.screenshots.length - 1
                    ? () => _handleManualNavigation(1)
                    : null,
                colors: colors,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildIndicators(colors),
      ],
    );
  }

  Widget _buildNavButton({required IconData icon, VoidCallback? onPressed, required ColorScheme colors}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: onPressed == null ? 0.0 : 1.0, // Скрываем, если нельзя нажать
      child: IconButton.filledTonal(
        onPressed: onPressed,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          backgroundColor: colors.secondaryContainer.withOpacity(0.8),
          foregroundColor: colors.onSecondaryContainer,
        ),
      ),
    );
  }

  Widget _buildImageCard(int index, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        elevation: 4,
        shadowColor: colors.shadow.withOpacity(0.2),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Image.asset(
          widget.screenshots[index],
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildIndicators(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.screenshots.length, (index) {
        final active = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: active ? 24 : 8,
          decoration: BoxDecoration(
            color: active ? colors.primary : colors.outlineVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
}







