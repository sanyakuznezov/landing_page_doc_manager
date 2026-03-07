

part of '../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Widget floatingButton() {
    return ValueListenableBuilder(
      valueListenable: GRouter.controller,
      builder: (_, value, child) {
        return TweenAnimationBuilder(
          tween: Tween(end: value == GRouter.navigations.last.id ? 0.0 : 1.0),
          duration: Constants.duration,
          builder: (_, value, child) {
            return Transform.translate(
              offset: Offset(0.0, value * kToolbarHeight * 2.0),
              child: child,
            );
          },
          child: child,
        );
      },
      child: Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () => GRouter.controller.onTap(
                  context,
                  id: GRouter.navigations.first.id,
                ),
                child: Seo.link(
                  anchor: 'Go back to top',
                  href: '/?section=${GRouter.navigations.first.id}',
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    semanticLabel: 'Go back to top',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  String _urlRelease = '';
  String _version = '';
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      final snapshot = await FirebaseFirestore.instance
          .collection('release')
          .doc('windows')
          .get();
      if (snapshot.exists) {
        setState(() {
          _urlRelease = snapshot.data()?['urlRelease'];
          _version = snapshot.data()?['version'];
        });
      } else {
        throw 'Release information not found.';
      }
    } catch (e) {
      setState(() {
        _error = 'Ошибка получения данных о версии программы: $e';
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_error)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  ScrollContent scrollContent(
      int index,
      NavigationModel item,
      ) {
    return ScrollContent(
        id: item.id,
        child: [
          // HomeStarter Section: Introduction
          HomeStarter(
            id: item.id,
            title: "Программное обеспечение для паспортистов. Документы оформляются сами — вы только управляете процессом!",
            subtitle:
            "Программа для быстрого и удобного оформления регистрации и убытия по месту жительства и временного пребывния",
            version: _version,
            urlRelease: _urlRelease,
          ),

          const HorizontalInstallGuide(),
          // HomeFeatures Section: Key Features
          HomeFeatures(
            id: item.id,
            title: 'Ключевые функции',
            subtitle:
            'Узнайте, почему наш продукт — идеальное решение для ваших нужд',
            cards: const [
              CardModel(
                source: 'assets/image/icon_inactive_faq.svg',
                title: "📂 База данных граждан",
                subtitle:
                'Создавайте и храните полные профили граждан.\n'
                    'Удобный поиск и фильтрация по ключевым параметрам.\n'
                    'Надёжное хранение данных с акцентом на безопасность.🚀'
                    '',
              ),
              CardModel(
                source: 'assets/image/icon_inactive_features.svg',
                title: '📝 Генерация пакета документов',
                subtitle:
                'Автоматическое формирование всех необходимых форм:\n'
                    '- Регистрация по месту жительства\n'
                    '- Регистрация временного пребывания\n'
                    '- Убытие с места пребывания\n'
                    '- Убытие с места жительства 🎨'
                ,
              ),
              CardModel(
                source: 'assets/image/icon_inactive_pricing.svg',
                title: '⚡ Экономия времени и сил',
                subtitle:
                'Сокращение времени оформления в несколько раз.\n'
                    'Минимизация ошибок за счёт автоматизации.\n'
                    'Простая работа даже для начинающих пользователей.\n'
                    '👉 «Программа, которая работает так же надёжно, как и вы!» 🍰',
              ),
              CardModel(
                source: 'assets/image/icon_inactive_faq.svg',
                title: '🖥️ Оптимизация для Windows',
                subtitle:
                'Полная совместимость с Windows-системами.\n'
                    'Лёгкая установка и обновления.\n'
                    'Дружелюбный интерфейс для ежедневной работы. 🏸\n'
                    '👉 «Ваш незаменимый помощник в документообороте!»',
              ),
              CardModel(
                source: 'assets/image/icon_inactive_features.svg',
                title: '🎯 Преимущества для пользователей',
                subtitle:
                'Скорость — оформление документов за минуты.\n'
                    'Удобство — всё в одном месте, без лишних файлов.\n'
                    'Профессионализм — программа создана специально для специалистов.🏔\n'

              ),

            ],
          ),

          // HomePricing Section: Pricing Plans
          HomePricing(
            id: item.id,
            title: 'Стоимость пользования нашим продуктом',
            subtitle:
            'Прозрачные условия — максимум возможностей',
            plans: const [
              // HomePricingModel items representing pricing plans
              HomePricingModel(
                title: 'Базовый план',
                price: 35,
                benefits:
                "Поддержка 24/7 — всегда на связи, чтобы помочь вам в любой ситуации.\n"
                    "Регулярные обновления — новые функции и улучшения без лишних хлопот.",
                type: HomePricingType.month,
              ),

            ],
          ),

        ][index]);
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Background.parallax(
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: GRouter.controller.node,
          onKey: GRouter.controller.onKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: NavigationHeader(),
            drawer: NavigationDrawer.of(context),
            body: _isLoading
                ?  Center(child: CircularProgressIndicator(color: context.color.background,))
                : InteractiveScrollViewer(
              scrollToId: GRouter.controller.instance,
              scrollDirection: Axis.vertical,
              children: [
                ...GRouter.navigations.to((index, item) => scrollContent(index, item)),
                ScrollContent(
                  id: 'footer',
                  child: const NavigationFooter(),
                )
              ],
            ),
            floatingActionButton: HomePage.floatingButton(),
          ),
        ),
      ),
    );
  }
}