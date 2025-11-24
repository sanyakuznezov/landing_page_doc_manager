part of '../home.dart';


class HomeStarter extends StatelessWidget {
  const HomeStarter({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
  });
  final String id, title, subtitle;



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
              padding: const EdgeInsets.all(Constants.spacing),
              child: Row(
                mainAxisSize: MainAxisSize.max,
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
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Constants.spacing),
                  Expanded(
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
      Container(
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
            Seo.text(
              text: subtitle,
              style: TextTagStyle.p,
              child: Text(
                'Последняя версия для Windows',
                semanticsLabel: subtitle,
                style: context.text.bodyMedium?.copyWith(
                    fontSize: 18
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            DButton.text(
              onTap: () => _downloadFile('https://document-manager-865ad.firebaseapp.com/updates/com.cdm-win-Setup.exe'),
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
          ..rotateZ(3.14 * 0.15)
          ..scale(1.25),
        alignment: Alignment.center,
        child: Semantics(
          label: 'Flutter Landing Page Thumbnail',
          image: true,
          child: Seo.image(
              alt: 'Flutter Landing Page Thumbnail',
              src: '/assets/assets/image/thumbnail.png',
              child: const DImage(source: 'assets/image/thumbnail.png')),
        ),
      ),
    );
  }
}
